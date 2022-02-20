/obj/machinery/vending/killbitches
	name = "\improper Atire-Putas"
	desc = "For when you really need to <b>KILL SOME BITHCES.</b>"
	icon_state = "killbitches"
	icon = 'modular_septic/icons/obj/vending.dmi'
	product_slogans = "Vai se foder porra!;GTA San Andreas crackeado SAMP sem virus!;Cria do pinheiro!"
	product_ads = "Mata-mata mundo louco!;Tudo 2!;Meu pau tá duro!"
	vend_reply = "Come back when you need more dead children!"
	panel_type = "panel17"
	onstation = FALSE
	default_price = 0
	extra_price = 0
	products = list(
		/obj/item/storage/firstaid/morango = 30,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 10,
		/obj/item/gun/ballistic/automatic/pistol/combatmaster = 3,
		/obj/item/gun/ballistic/revolver = 2,
		/obj/item/gun/ballistic/revolver/remis/nova = 15,
		/obj/item/ammo_casing/a357 = 65,
		/obj/item/ammo_casing/c38 = 120,
		/obj/item/ammo_box/magazine/combatmaster9mm = 69,
		/obj/item/ammo_box/magazine/m45 = 40,
		/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
		/obj/item/ammo_casing/shotgun/ap = 1, //Better make it count, puta!
		/obj/item/ammo_casing/shotgun/buckshot = 569,
		/obj/item/ammo_casing/shotgun = 420,
		/obj/item/suppressor = 15,
		/obj/item/flashlight/seclite = 15,
		/obj/item/knife/kitchen = 2, //two of them
		/obj/item/melee/truncheon/black = 20,
		/obj/item/katana = 2,
		/obj/item/gun/ballistic/automatic/remis/winter = 5,
		/obj/item/gun/ballistic/automatic/remis/abyss = 5,
		/obj/item/gun/ballistic/automatic/remis/g11 = 6,
		/obj/item/gun/ballistic/automatic/remis/svd = 1,
		/obj/item/gun/ballistic/automatic/remis/g3 = 1,
		/obj/item/ammo_box/magazine/a762g3 = 4,
		/obj/item/ammo_box/magazine/a762svd = 4,
		/obj/item/ammo_box/magazine/a49234g11 = 20,
		/obj/item/ammo_box/magazine/a54539abyss = 18,
		/obj/item/ammo_box/magazine/a762winter = 13,
		/obj/item/gun/ballistic/automatic/remis/smg/bastardo = 8,
		/obj/item/gun/ballistic/automatic/remis/smg/solitario = 20,
		/obj/item/gun/ballistic/automatic/remis/smg/thump = 5,
		/obj/item/ammo_box/magazine/bastardo9mm = 25,
		/obj/item/ammo_box/magazine/hksmg22lr = 40,
		/obj/item/ammo_box/magazine/thump45 = 20,
	)
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 100, BIO = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
	var/list/putalines = list('modular_septic/sound/effects/atireputas.wav', 'modular_septic/sound/effects/atireputas2.wav', 'modular_septic/sound/effects/atireputas3.wav')

/obj/machinery/vending/pelejogador
	name = "\improper Profundo-Pele"
	desc = "Este filho da puta tem o molho."
	icon_state = "pelejogador"
	icon = 'modular_septic/icons/obj/vending.dmi'
	product_slogans = "You wear this to your wedding too?; Such quality ballistic plates, perfect for running from glowies!; Just hope It Isn't 7.62x54R!; These helmets only abuse your scalp a-little bit.; Turning your funeral into an open casket one!"
	product_ads = "Mata-mata mundo louco!;Tudo 2!;Meu pau tá duro!"
	vend_reply = "New Skin!"
	panel_type = "panel17"
	density = FALSE
	onstation = FALSE
	default_price = 0
	extra_price = 0
	slogan_delay = 150
	products = list(
		/obj/item/storage/backpack/satchel/explorer = 30,
		/obj/item/clothing/under/stray = 20,
		/obj/item/clothing/shoes/jackboots = 20,
		/obj/item/clothing/gloves/fingerless = 20,
		/obj/item/clothing/suit/armor/vest/alt/heavy = 20,
		/obj/item/clothing/suit/armor/vest/alt/medium = 20,
		/obj/item/clothing/head/helmet/heavy = 20,
		/obj/item/clothing/head/helmet/medium = 20,
		/obj/item/clothing/mask/gas/ordinator/slaughter = 20,
		/obj/item/storage/belt/military = 20,
	)
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 100, BIO = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF

/obj/machinery/vending/killbitches/build_inventory(list/productlist, list/recordlist, start_empty)
	default_price = round(initial(default_price) * SSeconomy.inflation_value())
	extra_price = round(initial(extra_price) * SSeconomy.inflation_value())
	for(var/typepath in productlist)
		var/amount = productlist[typepath]
		if(isnull(amount))
			amount = 0

		var/obj/item/temp = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		GLOB.vending_products[typepath] = 1
		R.name = initial(temp.name)
		R.product_path = typepath
		if(!start_empty)
			R.amount = amount
		R.max_amount = amount
		///ITS FREE
		R.custom_price = 0
		R.custom_premium_price = 0
		R.age_restricted = initial(temp.age_restricted)
		R.colorable = !!(initial(temp.greyscale_config) && initial(temp.greyscale_colors) && (initial(temp.flags_1) & IS_PLAYER_COLORABLE_1))
		recordlist += R

/obj/machinery/vending/killbitches/resupply
	name = "\improper Recovery Atire-Putas"
	desc = "For when you really need to <b>RECOVER YOUR BITHC.</b>"
	icon_state = "wallputa"
	icon = 'modular_septic/icons/obj/vending.dmi'
	product_slogans = "Foi estuprado? Aqui pro seu cu!;As vezes, você atira nas putas. Outras vezes, você é a puta...;Perdeu, playboy!; Ferramentas de estuprar putas aqui!"
	product_ads = "Sim..."
	vend_reply = "Come back when you need more dead children!"
	panel_type = "panel-wall"
	verb_say = "violates"
	slogan_delay = 150
	density = FALSE
	onstation = FALSE
	default_price = 0
	extra_price = 0
	products = list(
		/obj/item/reagent_containers/hypospray/medipen/blacktar = 40,
		/obj/item/reagent_containers/hypospray/medipen/antibiotic = 50,
		/obj/item/stack/medical/suture/medicated = 40,
		/obj/item/scalpel = 40,
		/obj/item/stack/medical/ointment = 40,
		/obj/item/stack/medical/gauze = 40,
		/obj/item/storage/pill_bottle/potassiodide = 6,
		/obj/item/stack/medical/splint = 30,
		/obj/item/stack/sheet/cloth/five = 10,
		/obj/item/gun/ballistic/revolver/remis/nova = 1,
		/obj/item/clothing/under/stray = 20,
		/obj/item/clothing/shoes/jackboots = 20,
		/obj/item/clothing/gloves/fingerless = 20,
		/obj/item/clothing/mask/gas/ordinator/slaughter = 20,
		/obj/item/clothing/mask/gas/explorer = 5,
		/obj/item/ammo_casing/c38 = 90,
		/obj/item/ammo_casing/a357 = 65,
		/obj/item/ammo_box/magazine/combatmaster9mm = 69,
		/obj/item/ammo_box/magazine/m45 = 40,
		/obj/item/ammo_casing/shotgun/buckshot = 569,
		/obj/item/ammo_casing/shotgun = 420,
		/obj/item/suppressor = 5,
		/obj/item/flashlight/seclite = 5,
		/obj/item/ammo_box/magazine/a762g3 = 4,
		/obj/item/ammo_box/magazine/a762svd = 4,
		/obj/item/ammo_box/magazine/a49234g11 = 20,
		/obj/item/ammo_box/magazine/a54539abyss = 18,
		/obj/item/ammo_box/magazine/a762winter = 13,
		/obj/item/ammo_box/magazine/bastardo9mm = 25,
		/obj/item/ammo_box/magazine/hksmg22lr = 40,
		/obj/item/ammo_box/magazine/thump45 = 20,
	)
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 100, BIO = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF

/obj/machinery/vending/killbitches/resupply/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/vending/killbitches/resupply/directional/south
	dir = NORTH
	pixel_y = -32

/obj/machinery/vending/killbitches/resupply/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/vending/killbitches/resupply/directional/west
	dir = EAST
	pixel_x = -32

/obj/machinery/vending/killbitches/resupply/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		playsound(src, putalines,  volume, TRUE, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/tiktok
	name = "Tiktok Submissitory"
	desc = "A meta-physical line to a Devious, Godforsaken, and Diabolical Corporation."
	density = FALSE
	onstation = FALSE
	slogan_delay = 150
	icon_state = "tiktok"
	icon = 'modular_septic/icons/obj/vending.dmi'
	product_slogans = "You're licked! You're absolutely licked.;🐿ʙᴏɪ🐿ᴡʜᴀᴛ🐿ᴛʜᴇ🐿ʜᴇʟʟ🐿ʙᴏɪ🐿;Due to a stupid Tik Tok trend kids have been vandalizing our school bathrooms, now we need an escort to pee. Soap dispensers and a hand dryer has been stolen. A stall door was also taken off its hinges and vandalized. My generation can't think for themselves!"
	var/list/tiktoklines = 'modular_septic/sound/effects/singer.ogg'

/obj/machinery/vending/tiktok/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		playsound(src, tiktoklines,  volume, TRUE, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/tiktok/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/vending/tiktok/directional/south
	dir = NORTH
	pixel_y = -32

/obj/machinery/vending/tiktok/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/vending/tiktok/directional/west
	dir = EAST
	pixel_x = -32


/* Notes for Remis
Here's what you've got to do
1: Add Cough Syrup
2: Add Lean
3: Add pill packets and add both copium pill packets and Pep Pill packets.
4: Change the flashlight sprite
5: Finish the map.
6: Host.
*/
