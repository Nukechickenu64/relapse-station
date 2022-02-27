// APC electronics status:
/// There are no electronics in the APC.
#define APC_ELECTRONICS_MISSING 0
/// The electronics are installed but not secured.
#define APC_ELECTRONICS_INSTALLED 1
/// The electronics are installed and secured.
#define APC_ELECTRONICS_SECURED 2

// APC cover status:
/// The APCs cover is closed.
#define APC_COVER_CLOSED 0
/// The APCs cover is open.
#define APC_COVER_OPENED 1
/// The APCs cover is missing.
#define APC_COVER_REMOVED 2

// APC charging status:
/// The APC is not charging.
#define APC_NOT_CHARGING 0
/// The APC is charging.
#define APC_CHARGING 1
/// The APC is fully charged.
#define APC_FULLY_CHARGED 2

// APC channel status:
/// The APCs power channel is manually set off.
#define APC_CHANNEL_OFF 0
/// The APCs power channel is automatically off.
#define APC_CHANNEL_AUTO_OFF 1
/// The APCs power channel is manually set on.
#define APC_CHANNEL_ON 2
/// The APCs power channel is automatically on.
#define APC_CHANNEL_AUTO_ON 3

#define APC_CHANNEL_IS_ON(channel) (channel >= APC_CHANNEL_ON)

// APC autoset enums:
/// The APC turns automated and manual power channels off.
#define AUTOSET_FORCE_OFF 0
/// The APC turns automated power channels off.
#define AUTOSET_OFF 2
/// The APC turns automated power channels on.
#define AUTOSET_ON 1

// External power status:
/// The APC either isn't attached to a powernet or there is no power on the external powernet.
#define APC_NO_POWER 0
/// The APCs external powernet does not have enough power to charge the APC.
#define APC_LOW_POWER 1
/// The APCs external powernet has enough power to charge the APC.
#define APC_HAS_POWER 2

// Ethereals:
/// How long it takes an ethereal to drain or charge APCs. Also used as a spam limiter.
#define APC_DRAIN_TIME (7.5 SECONDS)
/// How much power ethereals gain/drain from APCs.
#define APC_POWER_GAIN 200

// Wires & EMPs:
/// The wire value used to reset the APCs wires after one's EMPed.
#define APC_RESET_EMP "emp"

// update_state
// Bitshifts: (If you change the status values to be something other than an int or able to exceed 3 you will need to change these too)
/// The bit shift for the APCs cover status.
#define UPSTATE_COVER_SHIFT (0)
	/// The bitflag representing the APCs cover being open for icon purposes.
	#define UPSTATE_OPENED1 (APC_COVER_OPENED << UPSTATE_COVER_SHIFT)
	/// The bitflag representing the APCs cover being missing for icon purposes.
	#define UPSTATE_OPENED2 (APC_COVER_REMOVED << UPSTATE_COVER_SHIFT)

// Bitflags:
/// The APC has a power cell.
#define UPSTATE_CELL_IN (1<<2)
/// The APC is broken or damaged.
#define UPSTATE_BROKE (1<<3)
/// The APC is undergoing maintenance.
#define UPSTATE_MAINT (1<<4)
/// The APC is emagged or malfed.
#define UPSTATE_BLUESCREEN (1<<5)
/// The APCs wires are exposed.
#define UPSTATE_WIREEXP (1<<6)

// update_overlay
// Bitflags:
/// Bitflag indicating that the APCs operating status overlay should be shown.
#define UPOVERLAY_OPERATING (1<<0)
/// Bitflag indicating that the APCs locked status overlay should be shown.
#define UPOVERLAY_LOCKED (1<<1)

// Bitshifts: (If you change the status values to be something other than an int or able to exceed 3 you will need to change these too)
/// Bit shift for the charging status of the APC.
#define UPOVERLAY_CHARGING_SHIFT (2)
/// Bit shift for the equipment status of the APC.
#define UPOVERLAY_EQUIPMENT_SHIFT (4)
/// Bit shift for the lighting channel status of the APC.
#define UPOVERLAY_LIGHTING_SHIFT (6)
/// Bit shift for the environment channel status of the APC.
#define UPOVERLAY_ENVIRON_SHIFT (8)

/obj/machinery/power/apc
	/// The crewmembers do get a bit quirky at night
	var/power_outage_sound = 'modular_septic/sound/effects/poweroutage.ogg'
	/// Volume of the power outage sound
	var/power_outage_volume = 100
	/// Extrarange of the power outage sound
	var/power_outage_extrarange = 3

/obj/machinery/power/apc/process()
	if(icon_update_needed)
		update_appearance()
	if(machine_stat & (BROKEN|MAINT))
		return
	if(!area || !area.requires_power)
		return
	if(failure_timer)
		update()
		queue_icon_update()
		failure_timer--
		force_update = TRUE
		return

	//dont use any power from that channel if we shut that power channel off
	lastused_light = APC_CHANNEL_IS_ON(lighting) ? area.power_usage[AREA_USAGE_LIGHT] + area.power_usage[AREA_USAGE_STATIC_LIGHT] : 0
	lastused_equip = APC_CHANNEL_IS_ON(equipment) ? area.power_usage[AREA_USAGE_EQUIP] + area.power_usage[AREA_USAGE_STATIC_EQUIP] : 0
	lastused_environ = APC_CHANNEL_IS_ON(environ) ? area.power_usage[AREA_USAGE_ENVIRON] + area.power_usage[AREA_USAGE_STATIC_ENVIRON] : 0
	area.clear_usage()

	lastused_total = lastused_light + lastused_equip + lastused_environ

	//store states to update icon if any change
	var/last_lt = lighting
	var/last_eq = equipment
	var/last_en = environ
	var/last_ch = charging

	//this is used to track whether or not we should play the freddy fazbear power out sound
	var/was_freddy_fazbeared = ((equipment > APC_CHANNEL_OFF) && (equipment > APC_CHANNEL_OFF) && (equipment > APC_CHANNEL_OFF))

	var/excess = surplus()

	if(!avail())
		main_status = APC_NO_POWER
	else if(excess < 0)
		main_status = APC_LOW_POWER
	else
		main_status = APC_HAS_POWER

	if(cell && !shorted)
		// draw power from cell as before to power the area
		var/cellused = min(cell.charge, lastused_total JOULES) // clamp deduction to a max, amount left in cell
		cell.use(cellused)

		if(excess > lastused_total) // if power excess recharge the cell
										// by the same amount just used
			cell.give(cellused)
			add_load(cellused WATTS) // add the load used to recharge the cell


		else // no excess, and not enough per-apc
			if((cell.charge WATTS + excess) >= lastused_total) // can we draw enough from cell+grid to cover last usage?
				cell.charge = min(cell.maxcharge, cell.charge + excess JOULES) //recharge with what we can
				add_load(excess) // so draw what we can from the grid
				charging = APC_NOT_CHARGING

			else // not enough power available to run the last tick!
				charging = APC_NOT_CHARGING
				chargecount = 0
				// This turns everything off in the case that there is still a charge left on the battery, just not enough to run the room.
				equipment = autoset(equipment, AUTOSET_FORCE_OFF)
				lighting = autoset(lighting, AUTOSET_FORCE_OFF)
				environ = autoset(environ, AUTOSET_FORCE_OFF)


		// set channels depending on how much charge we have left

		// Allow the APC to operate as normal if the cell can charge
		if(charging && longtermpower < 10)
			longtermpower += 1
		else if(longtermpower > -10)
			longtermpower -= 2

		if(cell.charge <= 0) // zero charge, turn all off
			equipment = autoset(equipment, AUTOSET_FORCE_OFF)
			lighting = autoset(lighting, AUTOSET_FORCE_OFF)
			environ = autoset(environ, AUTOSET_FORCE_OFF)
			alarm_manager.send_alarm(ALARM_POWER)
		else if(cell.percent() < 15 && longtermpower < 0) // <15%, turn off lighting & equipment
			equipment = autoset(equipment, AUTOSET_OFF)
			lighting = autoset(lighting, AUTOSET_OFF)
			environ = autoset(environ, AUTOSET_ON)
			alarm_manager.send_alarm(ALARM_POWER)
		else if(cell.percent() < 30 && longtermpower < 0) // <30%, turn off equipment
			equipment = autoset(equipment, AUTOSET_OFF)
			lighting = autoset(lighting, AUTOSET_ON)
			environ = autoset(environ, AUTOSET_ON)
			alarm_manager.send_alarm(ALARM_POWER)
		else // otherwise all can be on
			equipment = autoset(equipment, AUTOSET_ON)
			lighting = autoset(lighting, AUTOSET_ON)
			environ = autoset(environ, AUTOSET_ON)
			if(cell.percent() > 75)
				alarm_manager.clear_alarm(ALARM_POWER)


		// now trickle-charge the cell
		if(chargemode && charging == APC_CHARGING && operating)
			if(excess > 0) // check to make sure we have enough to charge
				// Max charge is capped to % per second constant
				var/ch = min(excess JOULES, cell.maxcharge JOULES)
				add_load(ch WATTS) // Removes the power we're taking from the grid
				cell.give(ch) // actually recharge the cell

			else
				charging = APC_NOT_CHARGING // stop charging
				chargecount = 0

		// show cell as fully charged if so
		if(cell.charge >= cell.maxcharge)
			cell.charge = cell.maxcharge
			charging = APC_FULLY_CHARGED

		if(chargemode)
			if(!charging)
				if(excess > cell.maxcharge*GLOB.CHARGELEVEL)
					chargecount++
				else
					chargecount = 0

				if(chargecount == 10)

					chargecount = 0
					charging = APC_CHARGING

		else // chargemode off
			charging = APC_NOT_CHARGING
			chargecount = 0

	else // no cell, switch everything off

		charging = APC_NOT_CHARGING
		chargecount = 0
		equipment = autoset(equipment, AUTOSET_FORCE_OFF)
		lighting = autoset(lighting, AUTOSET_FORCE_OFF)
		environ = autoset(environ, AUTOSET_FORCE_OFF)
		alarm_manager.send_alarm(ALARM_POWER)

	// play frederick fast bear sound if appropriate
	var/is_freddy_fazbeared = ((equipment > APC_CHANNEL_OFF) && (equipment > APC_CHANNEL_OFF) && (equipment > APC_CHANNEL_OFF))
	if(!was_freddy_fazbeared && is_freddy_fazbeared)
		playsound(src, power_outage_sound, power_outage_volume, FALSE, power_outage_extrarange)

	// update icon & area power if anything changed
	if(last_lt != lighting || last_eq != equipment || last_en != environ || force_update)
		force_update = 0
		queue_icon_update()
		update()
	else if (last_ch != charging)
		queue_icon_update()

#undef APC_CHANNEL_OFF
#undef APC_CHANNEL_AUTO_OFF
#undef APC_CHANNEL_ON
#undef APC_CHANNEL_AUTO_ON

#undef AUTOSET_FORCE_OFF
#undef AUTOSET_OFF
#undef AUTOSET_ON

#undef APC_NO_POWER
#undef APC_LOW_POWER
#undef APC_HAS_POWER

#undef APC_ELECTRONICS_MISSING
#undef APC_ELECTRONICS_INSTALLED
#undef APC_ELECTRONICS_SECURED

#undef APC_COVER_CLOSED
#undef APC_COVER_OPENED
#undef APC_COVER_REMOVED

#undef APC_NOT_CHARGING
#undef APC_CHARGING
#undef APC_FULLY_CHARGED

#undef APC_DRAIN_TIME
#undef APC_POWER_GAIN

#undef APC_RESET_EMP

// update_state
#undef UPSTATE_CELL_IN
#undef UPSTATE_COVER_SHIFT
#undef UPSTATE_BROKE
#undef UPSTATE_MAINT
#undef UPSTATE_BLUESCREEN
#undef UPSTATE_WIREEXP

//update_overlay
#undef UPOVERLAY_OPERATING
#undef UPOVERLAY_LOCKED
#undef UPOVERLAY_CHARGING_SHIFT
#undef UPOVERLAY_EQUIPMENT_SHIFT
#undef UPOVERLAY_LIGHTING_SHIFT
#undef UPOVERLAY_ENVIRON_SHIFT
