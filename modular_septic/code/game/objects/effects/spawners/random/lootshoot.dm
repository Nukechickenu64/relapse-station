/obj/effect/spawner/random/lootshoot
	name = "random combat loot"
	spawn_loot_chance = 75
	spawn_loot_count = 1
	spawn_all_loot = FALSE
	spawn_random_offset = TRUE
	loot = list(
		//Grenades
		/obj/item/grenade/flashbang = 0.5,
		//Pistols
		/obj/item/gun/ballistic/automatic/pistol/remis/ppk = 0.1,
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17 = 0.3,
		/obj/item/gun/ballistic/automatic/pistol/aps = 0.2,
		/obj/item/gun/ballistic/automatic/pistol/remis/combatmaster = 0.2,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 0.2,
		/obj/item/gun/ballistic/revolver/remis/gado = 0.1,
		/obj/item/gun/ballistic/automatic/pistol/remis/john = 0.2,
	)

/obj/effect/spawner/random/lootshoot/rare
	name = "random combat loot"
	loot = list(
		//SMGs
		/obj/item/gun/ballistic/automatic/remis/smg/solitario = 3,
		/obj/item/gun/ballistic/automatic/remis/smg/bastardo = 2,
		/obj/item/gun/ballistic/automatic/remis/smg/thump = 3,
		/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed = 3,
		//Rifles
		/obj/item/gun/ballistic/automatic/remis/g11 = 1,
		/obj/item/gun/ballistic/automatic/remis/svd = 1,
		//Shotgun
		/obj/item/gun/ballistic/shotgun/automatic/combat = 1,
		/obj/item/gun/ballistic/shotgun/automatic/b2000 = 1,
		/obj/item/gun/ballistic/shotgun/automatic/b2021 = 1,
		/obj/item/gun/ballistic/shotgun/bulldog = 1,
		/obj/item/gun/ballistic/shotgun/abyss = 1,
		//Rare
		/obj/item/gun/ballistic/shotgun/bolas = 1,
		/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador = 1,
		/obj/item/gun/energy/remis/bolt_acr = 1,
		/obj/item/gun/energy/remis/siren = 1,
		/obj/item/gun/ballistic/revolver/remis/poppy = 1,
	)

/obj/effect/spawner/random/lootshoot/clothing
	name = "random stuff and clothing loot"
	spawn_loot_chance = 80
	spawn_loot_count = 1
	spawn_all_loot = FALSE
	spawn_random_offset = TRUE
	loot = list(
		//MISC loot
		/obj/item/card/id/advanced/gold/captains_spare = 5,
		/obj/item/wrench = 5,
		/obj/item/hammer = 5, //swag
		/obj/item/melee/energy/sword/kelzad = 1,
		/obj/item/geiger_counter = 5,
		/obj/item/ammo_casing/l40mm = 2,
		/obj/item/ammo_casing/l40mm/inc = 2,
		/obj/item/food/canned/beef = 6,
		/obj/item/food/canned/beans = 6,
		//CLOTHING
		/obj/item/ballistic_mechanisms/visor = 1,
		/obj/item/storage/backpack/satchel/itobe = 10,
		/obj/item/storage/firstaid/morango = 1,
	)

/obj/effect/spawner/random/lootshoot/clothing/rare
	name = "random stuff and clothing loot"
	loot = list(
		//MISC loot
		/obj/item/card/id/advanced/gold/captains_spare = 2,
		/obj/item/wrench = 2,
		/obj/item/hammer = 3, //swag
		/obj/item/melee/energy/sword/kelzad = 1,
		/obj/item/geiger_counter = 2,
		/obj/item/ammo_casing/l40mm = 2,
		/obj/item/ammo_casing/l40mm/inc = 2,
		/obj/item/food/canned/beef = 3,
		/obj/item/food/canned/beans = 2,
		//CLOTHING
		/obj/item/ballistic_mechanisms/visor = 1,
		/obj/item/storage/backpack/satchel/itobe = 10,
		/obj/item/storage/firstaid/morango = 1,
	)
