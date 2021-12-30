/datum/job/chief_medical_officer
	title = "Hippocrite"
	department_head = list("Doge")
	supervisors = "the doge"

	outfit = /datum/outfit/job/cmo/zoomtech

	//below average but circumcised cock
	min_dicksize = 10
	max_dicksize = 14
	penis_circumcised = TRUE

	//below average lactating breasts
	min_breastsize = 1
	max_breastsize = 3
	breasts_lactating = TRUE

/datum/outfit/job/cmo/zoomtech
	name = "ZoomTech Hippocrite"

	suit = /obj/item/clothing/suit/hooded/medical/cmo
	belt = /obj/item/modular_computer/tablet/preset/cheap
	backpack_contents = list(/obj/item/melee/baton/telescopic=1,
							/obj/item/storage/belt/medical/humorist=1)
	skillchips = null
