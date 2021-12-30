/obj/item/organ/intestines
	name = "intestines"
	icon_state = "guts"
	desc = "Where food goes to die."
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_PRECISE_GROIN
	organ_efficiency = list(ORGAN_SLOT_INTESTINES = 100)
	attack_verb_continuous = list("gores", "defecates", "shits", "craps")
	attack_verb_simple = list("gore", "defecate", "shit", "crap")

	healing_factor = STANDARD_ORGAN_HEALING

	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, \
					/datum/reagent/water = 5, \
					/datum/reagent/consumable/shit = 5)

	//This is a reagent user and needs more then the 10u from edible component
	reagent_vol = 115 //100u of shit will fill us up

	// Yeah, intestines are large
	organ_volume = 1.5
	max_blood_storage = 15
	current_blood = 15
	blood_req = 3
	oxygen_req = 3
	nutriment_req = 3
	hydration_req = 4

/obj/item/organ/intestines/Initialize()
	. = ..()
	//None edible organs do not get a reagent holder by default
	if(!reagents)
		create_reagents(reagent_vol, REAGENT_HOLDER_ALIVE)
	else
		reagents.flags |= REAGENT_HOLDER_ALIVE

/obj/item/organ/intestines/get_availability(datum/species/S)
	return !(NOINTESTINES in S.species_traits)
