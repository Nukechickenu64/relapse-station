/datum/chemical_reaction/benzene
	results = list(/datum/reagent/benzene = 1, /datum/reagent/ash = 1)
	required_reagents = list(/datum/reagent/kerosene = 2)
	required_temp = 400
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/kerosene
	results = list(/datum/reagent/kerosene = 3)
	required_reagents = list(/datum/reagent/ash = 1, /datum/reagent/hydrogen = 1, /datum/reagent/carbon = 1)
	required_temp = T20C
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL
