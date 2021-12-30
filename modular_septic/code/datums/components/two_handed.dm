/datum/component/two_handed/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_TWOHANDED_WIELD_CHECK, .proc/wield_check)

/datum/component/two_handed/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_TWOHANDED_WIELD_CHECK)

/datum/component/two_handed/wield(mob/living/carbon/user)
	. = ..()
	if(!istype(user))
		return
	if(wielded)
		user.wield_ui_on()
	else
		user.wield_ui_off()
	var/obj/item/parent_item = parent
	offhand_item?.layer = parent_item.layer - 0.05

/datum/component/two_handed/unwield(mob/living/carbon/user, show_message, can_drop)
	. = ..()
	if(!istype(user))
		return
	if(wielded)
		user.wield_ui_on()
	else
		user.wield_ui_off()

/datum/component/two_handed/proc/wield_check()
	SIGNAL_HANDLER
	return wielded

/obj/item/offhand
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "offhand"
	base_icon_state = "offhand"
	carry_weight = 0
	layer = LOW_ITEM_LAYER

//Outline looks weird on offhand
/obj/item/offhand/apply_outline(outline_color)
	return
