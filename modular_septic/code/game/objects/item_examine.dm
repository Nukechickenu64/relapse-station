// Nice examine stuff
/obj/item/examine_chaser(mob/user)
	. = list()
	var/weight_text = weight_class_to_text(w_class)
	. += "[p_theyre(TRUE)] [prefix_a_or_an(weight_text)] [weight_text] item."

	if(resistance_flags & INDESTRUCTIBLE)
		. += "[src] seem[p_s()] extremely robust! It'll probably withstand anything that could happen to it!"
	else
		if(resistance_flags & LAVA_PROOF)
			. += "[src] [p_are()] made of an extremely heat-resistant material, [p_they()] would probably be able to withstand lava!"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += "[src] look[p_s()] pretty robust! [p_they()] would probably be able to withstand acid!"
		if(resistance_flags & FREEZE_PROOF)
			. += "[src] [p_are()] made of cold-resistant materials."
		if(resistance_flags & FIRE_PROOF)
			. += "[src] [p_are()] made of fire-retardant materials."

	. += ..()
