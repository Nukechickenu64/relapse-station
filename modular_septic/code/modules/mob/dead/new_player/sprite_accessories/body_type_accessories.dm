// Body type accessories (dixel, tits)
/datum/sprite_accessory/body_type
	icon = 'modular_septic/icons/mob/human/sprite_accessory/body_type.dmi'
	relevant_layers = list(BODYPARTS_EXTENSION_BEHIND_LAYER, BODYPARTS_EXTENSION_LAYER)
	default_color = DEFAULT_SKIN_OR_PRIMARY
	special_render_case = TRUE
	genetic = FALSE
	var/color_is_always_default_color = TRUE
	var/list/associated_body_types = list()

/datum/sprite_accessory/body_type/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering || !BP.is_organic_limb())
		return TRUE
	if(!(H.body_type in associated_body_types))
		return TRUE

/datum/sprite_accessory/body_type/get_special_render_state(mob/living/carbon/human/H)
	. = icon_state
	if(H.dna?.species?.use_skintones)
		. += "_s"

/datum/sprite_accessory/body_type/get_special_color(mob/living/carbon/human/H)
	. = LAZYACCESS(H.dna.features, "mcolor")
	if(H.dna.species.use_skintones)
		. = skintone2hex(H.skin_tone)

/datum/sprite_accessory/body_type/dick
	name = "Dick"
	generic = "Dick"
	key = "dick"
	icon_state = "dick"
	body_zone = BODY_ZONE_PRECISE_GROIN
	associated_body_types = list(BODY_TYPE_MASCULINE, BODY_TYPE_FEMBOY)

/datum/sprite_accessory/body_type/tits
	name = "Tits"
	generic = "Tits"
	key = "tits"
	icon_state = "tits"
	body_zone = BODY_ZONE_CHEST
	associated_body_types = list(BODY_TYPE_FEMININE)
