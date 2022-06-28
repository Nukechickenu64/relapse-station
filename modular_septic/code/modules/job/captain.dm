/datum/job/captain
	outfit = /datum/outfit/job/captain/mayor

/datum/job/captain/get_captaincy_announcement(mob/living/captain)
	return "[title] [captain.real_name] on deck!"

/datum/outfit/job/captain/mayor
	name = "ZoomTech Captain"

	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/zoomtech
	gloves = /obj/item/clothing/gloves/combat/zoomtech
	uniform =  /obj/item/clothing/under/rank/captain/zoomtech
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/zoomtech
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/caphat/zoomtech
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	duffelbag = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/melee/baton/telescopic=1, /obj/item/station_charter=1)

	skillchips = null
