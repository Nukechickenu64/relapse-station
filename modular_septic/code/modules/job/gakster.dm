/datum/job/gakster
	title = "Gakster Scavenger"
	department_head = list("pain")
	supervisors = "no-one"

	outfit = /datum/outfit/gakster
	attribute_sheet = /datum/attribute_holder/sheet/job/gakster

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(ishuman(spawned))
		spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
	if(!prob(10))
		return
	qdel(spawned.get_item_by_slot(ITEM_SLOT_ID))
	qdel(spawned.get_item_by_slot(ITEM_SLOT_LPOCKET))
	spawned.equip_to_slot(new /obj/item/cellphone/hacker(spawned.loc), ITEM_SLOT_ID)

/datum/outfit/gakster
	name = "Gakster Uniform"

	uniform = /obj/item/clothing/under/itobe
	id = /obj/item/cellphone
	belt = /obj/item/crowbar
	l_pocket = /obj/item/simcard
	back = /obj/item/storage/backpack/satchel/itobe
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1,
		/obj/item/flashlight/seclite = 1,
	)
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
