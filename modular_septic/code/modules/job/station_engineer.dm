/datum/job/station_engineer
	title = "Mechanist"
	department_head = list("Foreman")
	supervisors = "the foreman"

	total_positions = 0
	spawn_positions = 0

	//decent cock
	min_dicksize = 12
	max_dicksize = 18

	//decent breasts
	min_breastsize = 2
	max_breastsize = 4

	outfit = /datum/outfit/job/engineer/zoomtech

/datum/outfit/job/engineer/zoomtech
	name = "ZoomTech Mechanist"

	backpack = /obj/item/storage/backpack/leather
	satchel =/obj/item/storage/backpack/leather
	duffelbag = /obj/item/storage/backpack/leather
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cheap=1)

	skillchips = null
