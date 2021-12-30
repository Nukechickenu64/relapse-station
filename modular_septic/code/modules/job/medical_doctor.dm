/datum/job/doctor
	title = "Humorist"
	department_head = list("Hippocrite")
	supervisors = "the hippocrite"
	outfit = /datum/outfit/job/doctor/zoomtech

	//okay but circumcised cock
	min_dicksize = 12
	max_dicksize = 16
	penis_circumcised = TRUE

	//okay lactating breasts
	min_breastsize = 2
	max_breastsize = 4
	breasts_lactating = TRUE

/datum/outfit/job/doctor/zoomtech
	name = "ZoomTech Humorist"

	suit = /obj/item/clothing/suit/hooded/medical
	belt = /obj/item/modular_computer/tablet/preset/cheap
	backpack_contents = list(/obj/item/storage/belt/medical/humorist=1)

	skillchips = null
