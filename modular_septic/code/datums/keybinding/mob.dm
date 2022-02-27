/datum/keybinding/mob/toggle_move_intent
	hotkey_keys = list("Unbound")

/datum/keybinding/mob/stop_pulling
	hotkey_keys = list("N", "Delete")

/datum/keybinding/mob/swap_hands
	hotkey_keys = list("Space")

/datum/keybinding/mob/target_left_arm
	full_name = "Target: Left Arm"

/datum/keybinding/mob/target_r_arm
	full_name = "Target: Right Arm"

/datum/keybinding/mob/target_left_leg
	full_name = "Target: Left Leg"

/datum/keybinding/mob/target_right_leg
	full_name = "Target: Right Leg"

/datum/keybinding/mob/inspect
	hotkey_keys = list("L")

/datum/keybinding/mob/inspect/down(client/user)
	. = ..()
	user.mob.inspect_front()
