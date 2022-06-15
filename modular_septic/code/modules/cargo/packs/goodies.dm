/datum/supply_pack/goody
	goody = FALSE

//UK worst crime pack
/datum/supply_pack/goody/zhunter
	name = "Z-Hunter Surplus"
	desc = "No one wants to buy this junk and it's filling up the warehouse. Comes with 8 Z-Hunter brand knives."
	cost = 800
	contains = list(
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
		/obj/item/knife/combat/zhunter,
	)
	crate_name = "illegal chinesium knives"

/datum/supply_pack/goody/hammer
	name = "Hammer Surplus"
	desc = "Some iron hammers for general nail-striking and small-scale demolition"
	cost = 950
	contains = list(
		/obj/item/hammer,
		/obj/item/hammer,
		/obj/item/hammer
	)
	crate_name = "hammers"

/datum/supply_pack/goody/kukri
	name = "General All-Purpose Kukri"
	desc = "A premium kukri with a sling to fit to any belt, makes clean cuts against both flesh and underbrush, It's not likely you'd encounter the latter."
	cost = 1500
	contains = list(
		/obj/item/kukri
	)
	crate_name = "kukri"
