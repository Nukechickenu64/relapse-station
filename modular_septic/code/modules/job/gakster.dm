
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
	id = /obj/item/cellular_phone
	belt = /obj/item/crowbar
	l_pocket = /obj/item/sim_card
	back = /obj/item/storage/backpack/satchel/itobe
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

/datum/job/gakster/hacker
	title = "Hacker Gakster Scavenger"

	outfit = /datum/outfit/gakster/hacker

/datum/outfit/gakster/hacker
	name = "Gakster uniform"

	id = /obj/item/cellular_phone/hacker
	l_pocket = null
