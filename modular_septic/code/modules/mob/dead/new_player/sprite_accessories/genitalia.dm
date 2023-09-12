/datum/sprite_accessory/genital
	special_render_case = TRUE
	var/uses_skintones = FALSE
	var/associated_organ_slot

/datum/sprite_accessory/genital/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering)
		return TRUE
	if(H.dna?.species?.id == SPECIES_MONKEY)
		return TRUE
	var/obj/item/organ/genital/pener = H.getorganslot(associated_organ_slot)
	if(!pener)
		return TRUE
	if(!pener.is_visible())
		return TRUE

/datum/sprite_accessory/genital/get_special_render_state(mob/living/carbon/human/H)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		if(gen.greyscale_colors == gen.skintoned_colors)
			return  "[gen.sprite_suffix]_s"
		else
			return  "[gen.sprite_suffix]"
	else
		return null

/datum/sprite_accessory/genital/penis
	icon = 'modular_septic/icons/mob/human/sprite_accessory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = "penis"
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	if(H.underwear && H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	return ..()

/datum/sprite_accessory/genital/penis/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 'modular_septic/icons/mob/human/sprite_accessory/genitals/taur_penis_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/penis/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/penis/human
	icon_state = "human"
	name = "Human"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY
	uses_skintones = TRUE
	can_have_sheath = FALSE

/datum/sprite_accessory/genital/penis/knotted
	icon_state = "knotted"
	name = "Knotted"

/datum/sprite_accessory/genital/penis/flared
	icon_state = "flared"
	name = "Flared"

/datum/sprite_accessory/genital/penis/barbknot
	icon_state = "barbknot"
	name = "Barbed, Knotted"

/datum/sprite_accessory/genital/penis/tapered
	icon_state = "tapered"
	name = "Tapered"

/datum/sprite_accessory/genital/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled"

/datum/sprite_accessory/genital/penis/hemi
	icon_state = "hemi"
	name = "Hemi"

/datum/sprite_accessory/genital/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi"

/datum/sprite_accessory/genital/testicles
	icon = 'modular_septic/icons/mob/human/sprite_accessory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = "testicles"
	always_color_customizable = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevant_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	return ..()

/datum/sprite_accessory/genital/testicles/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 'modular_septic/icons/mob/human/sprite_accessory/genitals/taur_testicles_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/testicles/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair"
	icon_state = "pair"
	uses_skintones = TRUE

/datum/sprite_accessory/genital/testicles/internal
	name = "Internal"
	icon_state = "none"
	color_src = null
	has_size = FALSE

/datum/sprite_accessory/genital/vagina
	icon = 'modular_septic/icons/mob/human/sprite_accessory/genitals/vagina_onmob.dmi'
	organ_type = /obj/item/organ/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = "vagina"
	always_color_customizable = TRUE
	default_color = "FFCCCC"
	relevant_layers = list(BODY_FRONT_LAYER)
	genetic = TRUE
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	return ..()

/datum/sprite_accessory/genital/vagina/get_special_render_state(mob/living/carbon/human/H)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return "[gen.sprite_suffix]"
	else
		return null

/datum/sprite_accessory/genital/vagina/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/vagina/human
	icon_state = "human"
	name = "Human"

/datum/sprite_accessory/genital/vagina/tentacles
	icon_state = "tentacle"
	name = "Tentacle"

/datum/sprite_accessory/genital/vagina/dentata
	icon_state = "dentata"
	name = "Dentata"

/datum/sprite_accessory/genital/vagina/hairy
	icon_state = "hairy"
	name = "Hairy"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/spade
	icon_state = "spade"
	name = "Spade"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/furred
	icon_state = "furred"
	name = "Furred"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/gaping
	icon_state = "gaping"
	name = "Gaping"

/datum/sprite_accessory/genital/vagina/cloaca
	icon_state = "cloaca"
	name = "Cloaca"

/datum/sprite_accessory/genital/womb
	organ_type = /obj/item/organ/genital/womb
	associated_organ_slot = ORGAN_SLOT_WOMB
	key = "womb"

/datum/sprite_accessory/genital/womb/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/womb/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_septic/icons/mob/human/sprite_accessory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = "breasts"
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	uses_skintones = TRUE
	genetic = TRUE

/datum/sprite_accessory/genital/breasts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	if(H.undershirt != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
		return TRUE
	return ..()

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts/pair
	icon_state = "pair"
	name = "Pair"

/datum/sprite_accessory/genital/breasts/quad
	icon_state = "quad"
	name = "Quad"

/datum/sprite_accessory/genital/breasts/sextuple
	icon_state = "sextuple"
	name = "Sextuple"

/datum/sprite_accessory/genital/anus
	organ_type = /obj/item/organ/genital/anus
	associated_organ_slot = ORGAN_SLOT_ANUS
	key = "anus"

/datum/sprite_accessory/genital/anus/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	return ..()

/datum/sprite_accessory/genital/anus/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/anus/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/anus/normal/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return TRUE
