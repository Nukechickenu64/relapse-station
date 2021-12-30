/obj/item/organ/kidneys
	name = "kidney"
	icon_state = "kidneys"
	base_icon_state = "kidney"
	desc = "The organ that hates stoners the most."
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_KIDNEYS = 100)
	w_class = WEIGHT_CLASS_SMALL
	side = RIGHT_SIDE

	organ_volume = 0.5
	max_blood_storage = 7.5
	current_blood = 7.5
	blood_req = 1.5
	oxygen_req = 1.5
	nutriment_req = 1.5
	hydration_req = 2

	/// Toxin damage holding
	var/toxins = 0
	/// How much toxin damage we can hold
	var/max_toxins = KIDNEY_MAX_TOXIN
	/// How much shock a point of toxins causes
	var/toxin_pain_factor = KIDNEY_TOXIN_PAIN_FACTOR

	/// The maximum volume of toxins the kidney will quickly purge
	var/tox_tolerance = KIDNEY_DEFAULT_TOX_TOLERANCE
	/// Scaling factor for how much damage toxins deal to the kidney
	var/tox_lethality = KIDNEY_DEFAULT_TOX_LETHALITY
	/// Whether to filter toxins
	var/filter_toxins = TRUE

/obj/item/organ/kidneys/left
	side = LEFT_SIDE

/obj/item/organ/kidneys/get_availability(datum/species/S)
	return (!(TRAIT_NOMETABOLISM in S.inherent_traits))

/obj/item/organ/kidneys/update_icon_state()
	. = ..()
	if(side == RIGHT_SIDE)
		icon_state = "[base_icon_state]-r"
	else
		icon_state = "[base_icon_state]-l"

/obj/item/organ/kidneys/add_toxins(amount)
	var/last_tox = toxins
	toxins = min(max_toxins, max(0, toxins + amount))
	return (toxins - last_tox)

/obj/item/organ/kidneys/remove_toxins(amount)
	var/last_tox = toxins
	toxins = min(max_toxins, max(0, toxins - amount))
	return (toxins - last_tox)

/obj/item/organ/kidneys/get_toxins()
	if(is_failing())
		return max_toxins
	return toxins

/obj/item/organ/kidneys/can_add_toxins()
	return (toxins < max_toxins)

/obj/item/organ/kidneys/can_remove_toxins()
	return (toxins > 0)

/obj/item/organ/kidneys/get_availability(datum/species/S)
	return !(NOKIDNEYS in S.species_traits)
