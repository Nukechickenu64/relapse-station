/mob/living/carbon/human/get_total_tint()
	. = 0
	if(isclothing(head))
		. += head.tint
	if(isclothing(wear_mask))
		. += wear_mask.tint
	if(isclothing(glasses))
		. += glasses.tint

	var/obj/item/bodypart/left_eyesocket = LAZYACCESS(eye_bodyparts, 1)
	var/obj/item/bodypart/right_eyesocket = LAZYACCESS(eye_bodyparts, 2)
	var/obj/item/organ/eyes/LE
	var/obj/item/organ/eyes/RE
	for(var/obj/item/organ/eyes/eye in left_eyesocket?.get_organs())
		LE = eye
		break
	for(var/obj/item/organ/eyes/eye in right_eyesocket?.get_organs())
		RE = eye
		break

	if(!RE && !LE)
		return INFINITY //we blind
