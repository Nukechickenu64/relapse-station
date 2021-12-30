/datum/job/paramedic
	title = "Sanitar"
	department_head = list("Hippocrite")
	supervisors = "the hippocrite"

	//okay but circumcised cock
	min_dicksize = 12
	max_dicksize = 16
	penis_circumcised = TRUE

	//okay lactating breasts
	min_breastsize = 2
	max_breastsize = 4
	breasts_lactating = TRUE

	outfit = /datum/outfit/job/paramedic/zoomtech


/datum/outfit/job/paramedic/zoomtech
	name = "ZoomTech Paramedic"

	belt = /obj/item/storage/belt/medical/paramedic
	backpack_contents = list(
		/obj/item/roller = 1,
		/obj/item/modular_computer/tablet/preset/cheap=1,
		)

	skillchips = null
