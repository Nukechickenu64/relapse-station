/atom/movable/fire
	name = "Fire"
	desc = "I'll take you to burn."
	icon = 'modular_septic/icons/effects/fire/fire.dmi'
	icon_state = "fire_small"
	plane = GAME_PLANE_BLOOM
	layer = TURF_FIRE_LAYER
	anchored = TRUE
	move_resist = INFINITY
	light_range = 1.5
	light_power = 1.5
	light_color = LIGHT_COLOR_FIRE
	/// Is it magical, if it is then it wont interact with atmos, and it will not loose power by itself. Mainly for adminbus events or mapping
	var/magical = FALSE
	/// How much power have we got. This is treated like fuel, be it flamethrower liquid or any random thing you could come up with
	var/fire_power = 20
	/// Visual state of the fire. Kept track to not do too many updates.
	var/current_fire_state
	/// Used for connect_loc element
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)

/atom/movable/fire/Initialize(mapload, power)
	. = ..()
	var/turf/our_turf = loc
	if(our_turf.turf_fire)
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/connect_loc, src, loc_connections)
	our_turf.turf_fire = src
	SSturf_fire.fires[src] = TRUE
	if(power)
		fire_power = min(TURF_FIRE_MAX_POWER, power)
	update_fire_state()
	playsound(loc, 'modular_septic/sound/effects/fire/fire_start.wav', 40, TRUE)

/atom/movable/fire/Destroy()
	var/turf/turf_loc = get_turf(src)
	RemoveElement(/datum/element/connect_loc, src, loc_connections)
	turf_loc?.turf_fire = null
	SSturf_fire.fires -= src
	return ..()

/atom/movable/fire/proc/process_waste()
	if(isclosedturf(loc))
		return TRUE
	var/turf/open/open_turf = loc
	open_turf.pollute_list_turf(list(/datum/pollutant/smoke = 15, /datum/pollutant/carbon_air_pollution = 5))
	if(open_turf.planetary_atmos)
		return TRUE
	var/list/air_gases = open_turf.air?.gases
	if(!air_gases)
		return FALSE
	var/oxy = air_gases[/datum/gas/oxygen] ? air_gases[/datum/gas/oxygen][MOLES] : 0
	if (oxy < 0.5)
		return FALSE
	var/datum/gas_mixture/cached_air = open_turf.air
	var/temperature = cached_air.temperature
	var/old_heat_capacity = cached_air.heat_capacity()
	var/burn_rate = TURF_FIRE_BURN_RATE_BASE + fire_power * TURF_FIRE_BURN_RATE_PER_POWER
	if(burn_rate > oxy)
		burn_rate = oxy
	air_gases[/datum/gas/oxygen][MOLES] = air_gases[/datum/gas/oxygen][MOLES] - burn_rate
	ASSERT_GAS(/datum/gas/carbon_dioxide,cached_air)
	air_gases[/datum/gas/carbon_dioxide][MOLES] += burn_rate * TURF_FIRE_BURN_CARBON_DIOXIDE_MULTIPLIER
	var/new_heat_capacity = cached_air.heat_capacity()
	var/energy_released = burn_rate * TURF_FIRE_ENERGY_PER_BURNED_OXY_MOL
	cached_air.temperature = (temperature * old_heat_capacity + energy_released) / new_heat_capacity
	open_turf.air_update_turf(TRUE)
	return TRUE

/atom/movable/fire/process()
	var/turf/turf_loc = loc
	if(!istype(turf_loc)) //This can happen, how I'm not sure
		qdel(src)
		return
	if(isclosedturf(turf_loc))
		if(iswallturf(turf_loc))
			var/turf/closed/wall/wall_loc = turf_loc
			if(!magical)
				if(prob(max(0, fire_power - (100 - wall_loc.hardness)/4)))
					wall_loc.dismantle_wall(FALSE, FALSE)
				if(prob(6))
					playsound(wall_loc, 'modular_septic/sound/effects/fire/fire_loop.wav', 65, TRUE)
		if(!magical)
			reduce_power(1)
		return
	var/turf/open/open_turf = turf_loc
	if(open_turf.active_hotspot) //If we have an active hotspot, let it do the damage instead and lets not loose power
		return
	if(!magical)
		if(!process_waste())
			qdel(src)
			return
		if(open_turf.air.temperature < TURF_FIRE_REQUIRED_TEMP)
			fire_power -= TURF_FIRE_POWER_LOSS_ON_LOW_TEMP
		if(reduce_power(1))
			return
	open_turf.hotspot_expose(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	for(var/A in open_turf)
		var/atom/AT = A
		AT.fire_act(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	if(!magical)
		if(prob(6))
			playsound(open_turf, 'modular_septic/sound/effects/fire/fire_loop.wav', 65, TRUE)
		if(prob(fire_power))
			open_turf.burn_tile()
		if(prob(fire_power))
			var/list/arthur_brown = list()
			for(var/turf/closed/wall/wall_turf in range(1, src))
				if(wall_turf.turf_fire || !wall_turf.flammable)
					continue
				if(prob(100 - wall_turf.hardness))
					arthur_brown += wall_turf
			for(var/turf/open/open_neighbor in range(1, src))
				if(open_neighbor.turf_fire || !open_neighbor.flammable)
					continue
				if(isopenspaceturf(open_neighbor) || isspaceturf(open_neighbor))
					continue
				if(prob(IGNITE_NEIGHBOR_TURF_CHANCE))
					arthur_brown += open_neighbor
			if(length(arthur_brown))
				var/turf/god_of_hellfire = pick(arthur_brown)
				god_of_hellfire.ignite_turf_fire(CEILING(fire_power/2, 1))
				if(reduce_power(FLOOR(fire_power/2, 1)))
					return
		update_fire_state()

/atom/movable/fire/proc/on_entered(datum/source, atom/movable/movable)
	movable.fire_act(TURF_FIRE_TEMP_BASE + (TURF_FIRE_TEMP_INCREMENT_PER_POWER*fire_power), TURF_FIRE_VOLUME)
	if(isliving(movable))
		var/mob/living/living = movable
		living.IgniteMob()

/atom/movable/fire/proc/add_power(power)
	fire_power = clamp(fire_power + power, 0, TURF_FIRE_MAX_POWER)
	update_fire_state()
	if(fire_power <= 0)
		qdel(src)
		return TRUE

/atom/movable/fire/proc/reduce_power(power)
	fire_power = clamp(fire_power - power, 0, TURF_FIRE_MAX_POWER)
	update_fire_state()
	if(fire_power <= 0)
		qdel(src)
		return TRUE

/atom/movable/fire/proc/update_fire_state()
	var/new_state
	switch(fire_power)
		if(0 to 10)
			new_state = TURF_FIRE_STATE_SMALL
		if(11 to 24)
			new_state = TURF_FIRE_STATE_MEDIUM
		if(25 to INFINITY)
			new_state = TURF_FIRE_STATE_LARGE

	if(new_state == current_fire_state)
		return
	current_fire_state = new_state
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	switch(current_fire_state)
		if(TURF_FIRE_STATE_SMALL)
			icon_state = "fire_small"
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/fire/fire_overlays.dmi', "fire_small", LARGE_TURF_FIRE_LAYER, GAME_PLANE_UPPER_BLOOM)
			plane = GAME_PLANE_BLOOM
			layer = TURF_FIRE_LAYER
			set_light_range(1.5)
		if(TURF_FIRE_STATE_MEDIUM)
			icon_state = "fire_medium"
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/fire/fire_overlays.dmi', "fire_medium", LARGE_TURF_FIRE_LAYER, GAME_PLANE_UPPER_BLOOM)
			plane = GAME_PLANE_UPPER_BLOOM
			layer = TURF_FIRE_LAYER
			set_light_range(2.5)
		if(TURF_FIRE_STATE_LARGE)
			icon_state = "fire_big"
			SSvis_overlays.add_vis_overlay(src, 'modular_septic/icons/effects/fire/fire_overlays.dmi', "fire_big", LARGEST_TURF_FIRE_LAYER, GAME_PLANE_UPPER_BLOOM)
			plane = GAME_PLANE_UPPER_BLOOM
			layer = LARGE_TURF_FIRE_LAYER
			set_light_range(3.5)

///All the subtypes are for adminbussery and or mapping
/atom/movable/fire/magical
	magical = TRUE

/atom/movable/fire/small
	fire_power = 10

/atom/movable/fire/small/magical
	magical = TRUE

/atom/movable/fire/inferno
	fire_power = 30

/atom/movable/fire/inferno/magical
	magical = TRUE
