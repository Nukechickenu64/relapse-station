/obj/item/organ/ears/penguin
	name = "penguin ears"
	desc = "The source of a penguin's happy feet."

/obj/item/organ/ears/penguin/Insert(mob/living/carbon/human/new_owner, special = 0, drop_if_replaced = TRUE)
	. = ..()
	if(istype(new_owner))
		to_chat(new_owner, span_notice("I suddenly feel like i've lost my balance."))
		new_owner.AddElement(/datum/element/waddling)

/obj/item/organ/ears/penguin/Remove(mob/living/carbon/human/old_owner,  special = 0)
	. = ..()
	if(istype(old_owner))
		to_chat(old_owner, span_notice("My sense of balance comes back to me."))
		old_owner.RemoveElement(/datum/element/waddling)
