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

/datum/supply_pack/goody/vector
	name = ".45 ACP Chris Kektor"
	desc = "A robust submachine gun with fire-rate exceeding the legal standard, but you can sneak it in for a price."
	cost = 10000 //30000
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/smg/vector,
	)
	crate_name = ".45 ACP Chris Kektor"

/datum/supply_pack/goody/genocidio
	name = "7.62 Inverno Genocídio NK-49 Assault Rifle"
	desc = "Assault Rifle designation, 'Winter Genocide' Special Operations Assault Rifle for Extreme Law Enforcement and Military Use."
	cost = 50000
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/winter,
		/obj/item/ammo_box/magazine/a762winter,
		/obj/item/ammo_box/magazine/a762winter,
	)
	crate_name = "The 13% Destroyer"

/datum/supply_pack/goody/abyss
	name = "AN-94 5.4539 Abyss Assault Rifle"
	desc = "A forgotten piece of firepower that was mass-produced shortly before this facility was constructed. The Brand unknown, The Cartridge used unconventional."
	cost = 45000
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/abyss,
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545,
	)
	crate_name = "Rusted Crate"

/datum/supply_pack/goody/slaughter_goggles
	name = "Slaughter Goggles"
	desc = "A pair of goggles that make the users' aim steadier, and faster"
	cost = 2000
	contains = list(
		/obj/item/clothing/glasses/sunglasses/slaughter,
		/obj/item/clothing/glasses/sunglasses/slaughter,
	)
	crate_name = "Slaughter Gogggles"

/datum/supply_pack/goody/slaughter_masks
	name = "Slaughter Masks"
	desc = "A pair of face-covering masks with slaughter goggles attached that make the users' aim steadier, and faster"
	cost = 4000
	contains = list(
		/obj/item/clothing/mask/gas/ordinator/slaughter,
		/obj/item/clothing/mask/gas/ordinator/slaughter,
	)
	crate_name = "Slaughter Masks"

/datum/supply_pack/goody/glock
	name = "Gunk-17 Duo"
	desc = "A popular brand of nine-milimeter handgun for self-defense and law enforcement. \
		Does not include the Gunk-20, 10mm varient."
	cost = 9000
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17,
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17,
	)
	crate_name = "9mm gunk 17"

/datum/supply_pack/goody/combatmaster
	name = "Tactical Frag Master 2511 Military Handgun Single-Pack"
	desc = "A professional grade .9mm handgun, perfect for those who yearn to be masters at mass murder."
	cost = 6000
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster
	)
	crate_name = ".9mm frag master 2511"

/datum/supply_pack/goody/m1911
	name = "Cold 1911 Single-Pack"
	desc = "A .45 handgun. Comes with a single loaded magazine."
	cost = 4000
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911
	)
	crate_name = ".45 cold 1911"

/datum/supply_pack/goody/solitario
	name = "Solidario e Inseguro R5 submachine gun"
	desc = "A compact and suppressable Ordinator-issue submachine gun."
	cost = 15000
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/smg/solitario,
		/obj/item/ammo_box/magazine/hksmg22lr,
	)
	crate_name = "Purple-rimmed Crate"

/datum/supply_pack/goody/walter
	name = "Walter FT Single-Pack"
	desc = "A .22lr handgun. Comes with a single loaded magazine."
	cost = 1600
	contains = list(
		/obj/item/gun/ballistic/automatic/pistol/remis/ppk
	)
	crate_name = ".22lr Walter"

/datum/supply_pack/goody/g11
	name = "Guloseima 4.92x34mm Prototype Assault Rifle"
	desc = "A prototype firarm firing in an unused cartridge."
	cost = 25000
	contains = list(
		/obj/item/gun/ballistic/automatic/remis/g11,
		/obj/item/ammo_box/magazine/a49234g11,
	)
	crate_name = "4.92x34mm Assault Rifle"

/datum/supply_pack/goody/g11_magazine
	name = "Guloseima magazines (4)"
	desc = "Ammunition Shipment for the Guloseima 4.92x34mm Assault Rifle"
	cost = 4000
	contains = list(
		/obj/item/ammo_box/magazine/a49234g11,
		/obj/item/ammo_box/magazine/a49234g11,
		/obj/item/ammo_box/magazine/a49234g11,
		/obj/item/ammo_box/magazine/a49234g11,
	)
	crate_name = "4.92x34mm Guloseima magazines"

/datum/supply_pack/goody/solitario_magazine
	name = "Solidario e Inseguro R5 Magazine (4)"
	desc = "S&I magazine pack of four for the R5 Submachine Gun"
	cost = 4200
	contains = list(
		/obj/item/ammo_box/magazine/hksmg22lr,
		/obj/item/ammo_box/magazine/hksmg22lr,
		/obj/item/ammo_box/magazine/hksmg22lr,
		/obj/item/ammo_box/magazine/hksmg22lr,
	)
	crate_name = "Purple-rimmed Ammunition Crate"

/datum/supply_pack/goody/speedloader_357
	name = ".357 Speedloader Single-Pack"
	desc = "A .357 speedloader with 7 rounds."
	cost = 800
	contains = list(
		/obj/item/ammo_box/a357,
	)
	crate_name = ".357 speedloader"

/datum/supply_pack/goody/walter_magazine
	name = "Walter FT Magazine Single-Pack"
	desc = "A single .22lr magazine. Fits in any Walter FT handgun."
	cost = 400
	contains = list(
		/obj/item/ammo_box/magazine/ppk22lr
	)
	crate_name = ".22lr walter magazine"

/datum/supply_pack/goody/m1911_magazine
	name = "Cold 1911 Magazine Single-Pack"
	desc = "A .45 magazine. Fits in any cold 1911 handgun."
	cost = 800
	contains = list(
		/obj/item/ammo_box/magazine/m45
	)
	crate_name = ".45 cold 1911 magazine"

/datum/supply_pack/goody/combatmaster_magazine
	name = "Tactical Frag Master 2511 Magazine Single-Pack"
	desc = "A loaded 20 round magazine for the frag master handgun. What the hell, you need more than 20 rounds?"
	cost = 1250
	contains = list(
		/obj/item/ammo_box/magazine/combatmaster9mm
	)
	crate_name = ".9mm frag master magazine"

/datum/supply_pack/goody/glock_magazine
	name = "Gunk-17 magazines (4)"
	desc = "Ammunition Shipment for the Gunk-17 Semi-automatic/Burst Fire service pistol"
	cost = 4650
	contains = list(
		/obj/item/ammo_box/magazine/glock9mm,
		/obj/item/ammo_box/magazine/glock9mm,
		/obj/item/ammo_box/magazine/glock9mm,
		/obj/item/ammo_box/magazine/glock9mm,
	)
	crate_name = ".9mm gunk 17 Magazine"

/datum/supply_pack/goody/vector_magazine
	name = "Kektor magazines (4)"
	desc = "Ammunition Shipment for the Chris Kektor .45 ACP Sub Machine Gun."
	cost = 5000
	contains = list(
		/obj/item/ammo_box/magazine/m45vector,
		/obj/item/ammo_box/magazine/m45vector,
		/obj/item/ammo_box/magazine/m45vector,
		/obj/item/ammo_box/magazine/m45vector,
	)
	crate_name = ".45 Chris Kektor magazine"

/datum/supply_pack/goody/abyss_magazine
	name = "AN-94 magazines (4)"
	desc = "Ammunition Shipment for the AN-94 Abyss."
	cost = 8500
	contains = list(
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545,
		/obj/item/ammo_box/magazine/a545,
	)
	crate_name = "Rusted Magazine Crate"

/datum/supply_pack/goody/genocidio_magazine
	name = "Genocídio magazines (4)"
	desc = "Ammunition Shipment for the 7.62 Inverno Gencídio Assault Rifle"
	cost = 10000
	contains = list(
		/obj/item/ammo_box/magazine/a762winter,
		/obj/item/ammo_box/magazine/a762winter,
		/obj/item/ammo_box/magazine/a762winter,
		/obj/item/ammo_box/magazine/a762winter,
	)
	crate_name = "7.62 Inverno Genocídio magazine"
