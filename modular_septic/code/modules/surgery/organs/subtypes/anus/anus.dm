/obj/item/organ/anus
	name = "asshole"
	desc = "Space asshole. In a truck, flying off a ridge. Space asshole. Smashing through a bridge."
	icon = 'modular_septic/icons/obj/items/genitalia/asshole.dmi'
	icon_state = "anus"
	base_icon_state = "anus"
	organ_efficiency = list(ORGAN_SLOT_ANUS = 100)
	zone = BODY_ZONE_PRECISE_GROIN

/obj/item/organ/anus/get_availability(datum/species/S)
	return !(NOINTESTINES in S.species_traits)
