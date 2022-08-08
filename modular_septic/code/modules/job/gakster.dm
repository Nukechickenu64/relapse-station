/datum/job/gakster
	title = "Gakster Scavenger"
	department_head = list("Head of Personnel")
	faction = list("neutral", "swarmer")
	supervisors = "no-one"
	selection_color = "#303234"

	outfit = /datum/outfit/gakster

/datum/outfit/gakster
	name = "Gakster uniform"

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

/datum/job/gakster/hacker
	title = "Hacker Gakster Scavenger"

	outfit = /datum/outfit/gakster/hacker

/datum/outfit/gakster/hacker
	name = "Gakster uniform"

	id = /obj/item/cellphone/hacker
	l_pocket = null
