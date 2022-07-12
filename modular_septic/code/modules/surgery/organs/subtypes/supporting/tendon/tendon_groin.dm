/obj/item/organ/tendon/groin
	name = "gluteus maximus"
	desc = "The most treasured muscle of the human body."
	icon_state = "gluteus-greyscale"
	base_icon_state = "gluteus-greyscale"
	zone = BODY_ZONE_PRECISE_GROIN
	greyscale_config = /datum/greyscale_config/gluteus
	greyscale_colors = "#fcccb3"

/obj/item/organ/tendon/groin/build_from_dna(datum/dna/dna_datum, associated_key)
	var/mob/living/carbon/human/human = dna_datum.holder
	if(dna_datum.features["uses_skintones"] && istype(human) && human.skin_tone)
		var/skintoned_color = sanitize_hexcolor(skintone2hex(human.skin_tone), 6, TRUE)
		set_greyscale(skintoned_color)
	else if(dna_datum.features["mcolor"])
		var/mutant_color = sanitize_hexcolor(dna_datum.features["mcolor"], 6, TRUE)
		set_greyscale(mutant_color)

/obj/item/organ/tendon/groin/robot
	name = "cyborg gluteus maximus"
	icon_state = "gluteus-c"
	base_icon_state = "gluteus-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
	greyscale_config = null
	greyscale_colors = ""
