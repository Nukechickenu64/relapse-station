/datum/job/assistant
	title = "Beggar"
	no_dresscode = TRUE
	blacklist_dresscode_slots = list(ITEM_SLOT_LEAR,ITEM_SLOT_REAR,ITEM_SLOT_BELT,ITEM_SLOT_ID,ITEM_SLOT_BACK) //headset, PDA, ID, backpack are important items
	required_languages = null

	//bums are chad thundercocks
	min_dicksize = 16
	max_dicksize = 25

	//and e-thots
	min_breastsize = 3
	max_breastsize = 6

	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")

/datum/outfit/job/assistant/zoomtech
	name = "ZoomTech Beggar"

	uniform = /obj/item/clothing/under/color/grey/ancient
	id = null
	belt = null

	skillchips = null
