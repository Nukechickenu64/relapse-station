// This is stupid and inefficient and should be defines, but i don't want to type every argument out, every time
/mob/proc/diceroll(requirement = 0, crit = 10, dice_num = 3, dice_sides = 6, count_modifiers = TRUE, return_difference = FALSE)
	return attributes ? attributes.diceroll(requirement, crit, dice_num, dice_sides, count_modifiers, return_difference) : DICE_FAILURE

/mob/proc/attribute_probability(modifier = ATTRIBUTE_MIDDLING, base_prob = 50, delta_value = ATTRIBUTE_MIDDLING, increment = 5)
	return attributes ? attributes.attribute_probability(modifier, base_prob, delta_value, increment) : base_prob
