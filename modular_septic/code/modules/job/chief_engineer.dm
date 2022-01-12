/datum/job/chief_engineer
	title = "Foreman"
	department_head = list("Caretakeer")
	supervisors = "the doge"

	//below average cock
	min_dicksize = 10
	max_dicksize = 15

	//below average breasts
	min_breastsize = 1
	max_breastsize = 3

	outfit = /datum/outfit/job/ce/zoomtech

/datum/outfit/job/ce/zoomtech
	name = "ZoomTech Foreman"

	backpack = /obj/item/storage/backpack/leather
	satchel =/obj/item/storage/backpack/leather
	duffelbag = /obj/item/storage/backpack/leather
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		)
	belt = /obj/item/modular_computer/tablet/preset/advanced/command/engineering
	l_pocket = null

	skillchips = null
