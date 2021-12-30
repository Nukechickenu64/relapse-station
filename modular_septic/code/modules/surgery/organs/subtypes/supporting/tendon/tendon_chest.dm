/obj/item/organ/tendon/chest
	name = "rectus abdominis"
	zone = BODY_ZONE_CHEST

/obj/item/organ/tendon/chest/robot
	name = "cyborg rectus abdominis"
	icon_state = "tendon-c"
	base_icon_state = "tendon-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE

/obj/item/organ/tendon/chest/robot/get_wound_resistance(wounding_type = WOUND_BLUNT)
	if(wounding_type == WOUND_TENDON)
		return -5
