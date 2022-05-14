GLOBAL_LIST_INIT(efn_prize_pool, list(
		/obj/item/ammo_casing/batteries = 1,
		/obj/item/ammo_casing/batteries/bigvolt = 1,
		/obj/item/toothbrush = 2,
		/obj/item/bodypart/head = 1,
		/obj/item/deviouslick/soapdispenser = 0.5,
        /obj/item/book/ccp_propaganda = 3,
        /obj/item/deviouslick/broken_lcd = 3,
        /obj/item/reagent_containers/food/drinks/soda_cans/lean = 0.5))

/obj/machinery/computer/arcade/battle/godforsaken
	name = "godforsaken arcade machine"
	desc = "Does not support Pinball."
	icon = 'modular_septic/icons/obj/machinery/arcade.dmi'
	icon_state = "arcade"
	icon_screen = "godforsaken"
	circuit = /obj/item/circuitboard/computer/arcade/battle
	enemy_name = "Ronaldo"
	var/enemy_hp = 150
	var/enemy_mp = 50
	///Temporary message, for attack messages, etc
	var/temp = "<br><center><h3>Winners don't win.<center><h3>"
    player_hp = 130
	player_mp = 40
	var/list/weapons

/obj/machinery/computer/arcade/battle/godforsaken/Topic(href, href_list)
	if(..())
		return
	var/gamerSkill = 0
    var/mana = list('modular_septic/sound/effects/ronaldo/mana1.wav', 'modular_septic/sound/effects/ronaldo/mana2.wav')
	if(usr?.mind)
		gamerSkill = usr.mind.get_skill_level(/datum/skill/gaming)

	if (!blocked && !gameover)
		var/attackamt = rand(5,7) + rand(0, gamerSkill)

		if(finishing_move) //time to bonk that fucker,cuban pete will sometime survive a finishing move.
			attackamt *= 100

		//light attack suck absolute ass but it doesn't cost any MP so it's pretty good to finish an enemy off
		if (href_list["attack"])
			temp = "<br><center><h3>you do quick jab for [attackamt] of damage!</h3></center>"
			enemy_hp -= attackamt
			arcade_action(usr,"attack",attackamt)

		//defend lets you gain back MP and take less damage from non magical attack.
		else if(href_list["defend"])
			temp = "<br><center><h3>you take a defensive stance and gain back 10 mp!</h3></center>"
			player_mp += 10
			arcade_action(usr,"defend",attackamt)
			playsound(src, mana, 50, TRUE, extrarange = -3)

		//mainly used to counter short temper and their absurd damage, will deal twice the damage the player took of a non magical attack.
		else if(href_list["counter_attack"] && player_mp >= 10)
			temp = "<br><center><h3>you prepare yourself to counter the next attack!</h3></center>"
			player_mp -= 10
			arcade_action(usr,"counter_attack",attackamt)
			playsound(src, mana, 50, TRUE, extrarange = -3)

		else if(href_list["counter_attack"] && player_mp < 10)
			temp = "<br><center><h3>you don't have the mp necessary to counter attack and defend yourself instead</h3></center>"
			player_mp += 10
			arcade_action(usr,"defend",attackamt)
			playsound(src, mana, 50, TRUE, extrarange = -3)

		//power attack deals twice the amount of damage but is really expensive MP wise, mainly used with combos to get weakpoints.
		else if (href_list["power_attack"] && player_mp >= 20)
			temp = "<br><center><h3>You attack [enemy_name] with all your might for [attackamt * 2] damage!</h3></center>"
			enemy_hp -= attackamt * 2
			player_mp -= 20
			arcade_action(usr,"power_attack",attackamt)

		else if(href_list["power_attack"] && player_mp < 20)
			temp = "<br><center><h3>You don't have the mp necessary for a power attack and settle for a light attack!</h3></center>"
			enemy_hp -= attackamt
			arcade_action(usr,"attack",attackamt)

	if (href_list["close"])
		usr.unset_machine()
		usr << browse(null, "window=arcade")

	else if (href_list["newgame"]) //Reset everything
		temp = "<br><center><h3>New Round<center><h3>"

		if(obj_flags & EMAGGED)
			Reset()
			obj_flags &= ~EMAGGED

		enemy_setup(gamerSkill)
		screen_setup(usr)


	add_fingerprint(usr)
	return

/obj/machinery/computer/arcade/battle/godforsaken/arcade_action(mob/user,player_stance,attackamt)
	screen_setup(user)
	blocked = TRUE
    var/weakhit = list('modular_septic/sound/effects/ronaldo/attack1.wav', 'modular_septic/sound/effects/ronaldo/attack2.wav')
    var/stronghit = 'modular_septic/sound/effects/ronaldo/attack3.wav'
	if(player_stance == "attack" || player_stance == "power_attack")
		if(attackamt > 40)
			playsound(src, stronghit, 50, TRUE, extrarange = 0)
		else
			playsound(src, weakhit, 50, TRUE, extrarange = 0)

	timer_id = addtimer(CALLBACK(src, .proc/enemy_action,player_stance,user),1 SECONDS,TIMER_STOPPABLE)
	gameover_check(user)

/obj/machinery/computer/arcade/battle/godforsaken/enemy_action(player_stance,mob/user)
	var/list/list_temp = list()

	switch(LAZYLEN(last_three_move)) //we keep the last three action of the player in a list here
		if(0 to 2)
			LAZYADD(last_three_move, player_stance)
		if(3)
			for(var/i in 1 to 2)
				last_three_move[i] = last_three_move[i + 1]
			last_three_move[3] = player_stance

		if(4 to INFINITY)
			last_three_move = null //this shouldn't even happen but we empty the list if it somehow goes above 3

	var/enemy_stance
	var/attack_amount = rand(8,10) //making the attack amount not vary too much so that it's easier to see if the enemy has a shotgun

	if(player_stance == "defend")
		attack_amount -= 5

	//if emagged, cuban pete will set up a bomb acting up as a timer. when it reaches 0 the player fucking dies
	if(obj_flags & EMAGGED)
		switch(bomb_cooldown--)
			if(18)
				list_temp += "<br><center><h3>[enemy_name] takes two valve tank and links them together, what's he planning?<center><h3>"
			if(15)
				list_temp += "<br><center><h3>[enemy_name] adds a remote control to the tan- ho god is that a bomb?<center><h3>"
			if(12)
				list_temp += "<br><center><h3>[enemy_name] throws the bomb next to you, you'r too scared to pick it up. <center><h3>"
			if(6)
				list_temp += "<br><center><h3>[enemy_name]'s hand brushes the remote linked to the bomb, your heart skipped a beat. <center><h3>"
			if(2)
				list_temp += "<br><center><h3>[enemy_name] is going to press the button! It's now or never! <center><h3>"
			if(0)
				player_hp -= attack_amount * 1000 //hey it's a maxcap we might as well go all in

	//yeah I used the shotgun as a passive, you know why? because the shotgun gives +5 attack which is pretty good
	if(LAZYACCESS(enemy_passive, "shotgun"))
		if(weakpoint_check("shotgun","defend","defend","power_attack"))
			list_temp += "<br><center><h3>You manage to disarm [enemy_name] with a surprise power attack and shoot him with his shotgun until it runs out of ammo! <center><h3> "
			enemy_hp -= 10
			chosen_weapon = "empty shotgun"
		else
			attack_amount += 5

	//heccing chonker passive, only gives more HP at the start of a new game but has one of the hardest weakpoint to trigger.
	if(LAZYACCESS(enemy_passive, "chonker"))
		if(weakpoint_check("chonker","power_attack","power_attack","power_attack"))
			list_temp += "<br><center><h3>After a lot of power attacks you manage to tip over [enemy_name] as they fall over their enormous weight<center><h3> "
			enemy_hp -= 30

	//smart passive trait, mainly works in tandem with other traits, makes the enemy unable to be counter_attacked
	if(LAZYACCESS(enemy_passive, "smart"))
		if(weakpoint_check("smart","defend","defend","attack"))
			list_temp += "<br><center><h3>[enemy_name] is confused by your illogical strategy!<center><h3> "
			attack_amount -= 5

		else if(attack_amount >= player_hp)
			player_hp -= attack_amount
			list_temp += "<br><center><h3>[enemy_name] figures out you are really close to death and finishes you off with their [chosen_weapon]!<center><h3>"
			enemy_stance = "attack"

		else if(player_stance == "counter_attack")
			list_temp += "<br><center><h3>[enemy_name] is not taking your bait. <center><h3> "
			if(LAZYACCESS(enemy_passive, "short_temper"))
				list_temp += "However controlling their hatred of you still takes a toll on their mental and physical health!"
				enemy_hp -= 5
				enemy_mp -= 5
			enemy_stance = "defensive"

	//short temper passive trait, gets easily baited into being counter attacked but will bypass your counter when low on HP
	if(LAZYACCESS(enemy_passive, "short_temper"))
		if(weakpoint_check("short_temper","counter_attack","counter_attack","counter_attack"))
			list_temp += "<br><center><h3>[enemy_name] is getting frustrated at all your counter attacks and throws a tantrum!<center><h3>"
			enemy_hp -= attack_amount

		else if(player_stance == "counter_attack")
			if(!(LAZYACCESS(enemy_passive, "smart")) && enemy_hp > 30)
				list_temp += "<br><center><h3>[enemy_name] took the bait and allowed you to counter attack for [attack_amount * 2] damage!<center><h3>"
				player_hp -= attack_amount
				enemy_hp -= attack_amount * 2
				enemy_stance = "attack"

			else if(enemy_hp <= 30) //will break through the counter when low enough on HP even when smart.
				list_temp += "<br><center><h3>[enemy_name] is getting tired of your tricks and breaks through your counter with their [chosen_weapon]!<center><h3>"
				player_hp -= attack_amount
				enemy_stance = "attack"

		else if(!enemy_stance)
			var/added_temp

			if(rand())
				added_temp = "you for [attack_amount + 5] damage!"
				player_hp -= attack_amount + 5
				enemy_stance = "attack"
			else
				added_temp = "the wall, breaking their skull in the process and losing [attack_amount] hp!" //[enemy_name] you have a literal dent in your skull
				enemy_hp -= attack_amount
				enemy_stance = "attack"

			list_temp += "<br><center><h3>[enemy_name] grits their teeth and charge right into [added_temp]<center><h3>"

	//in the case none of the previous passive triggered, Mainly here to set an enemy stance for passives that needs it like the magical passive.
	if(!enemy_stance)
		enemy_stance = pick("attack","defensive")
		if(enemy_stance == "attack")
			player_hp -= attack_amount
			list_temp += "<br><center><h3>[enemy_name] attacks you for [attack_amount] points of damage with their [chosen_weapon]<center><h3>"
			if(player_stance == "counter_attack")
				enemy_hp -= attack_amount * 2
				list_temp += "<br><center><h3>You counter [enemy_name]'s attack and deal [attack_amount * 2] points of damage!<center><h3>"

		if(enemy_stance == "defensive" && enemy_mp < 15)
			list_temp += "<br><center><h3>[enemy_name] take some time to get some mp back!<center><h3> "
			enemy_mp += attack_amount

		else if (enemy_stance == "defensive" && enemy_mp >= 15 && !(LAZYACCESS(enemy_passive, "magical")))
			list_temp += "<br><center><h3>[enemy_name] quickly heal themselves for 5 hp!<center><h3> "
			enemy_mp -= 15
			enemy_hp += 5

	//magical passive trait, recharges MP nearly every turn it's not blasting you with magic.
	if(LAZYACCESS(enemy_passive, "magical"))
		if(player_mp >= 50)
			list_temp += "<br><center><h3>the huge amount of magical energy you have acumulated throws [enemy_name] off balance!<center><h3>"
			enemy_mp = 0
			LAZYREMOVE(enemy_passive, "magical")
			pissed_off++

		else if(LAZYACCESS(enemy_passive, "smart") && player_stance == "counter_attack" && enemy_mp >= 20)
			list_temp += "<br><center><h3>[enemy_name] blasts you with magic from afar for 10 points of damage before you can counter!<center><h3>"
			player_hp -= 10
			enemy_mp -= 20

		else if(enemy_hp >= 20 && enemy_mp >= 40 && enemy_stance == "defensive")
			list_temp += "<br><center><h3>[enemy_name] Blasts you with magic from afar!<center><h3>"
			enemy_mp -= 40
			player_hp -= 30
			enemy_stance = "attack"

		else if(enemy_hp < 20 && enemy_mp >= 20 && enemy_stance == "defensive") //it's a pretty expensive spell so they can't spam it that much
			list_temp += "<br><center><h3>[enemy_name] heal themselves with magic and gain back 20 hp!<center><h3>"
			enemy_hp += 20
			enemy_mp -= 30
		else
			list_temp += "<br><center><h3>[enemy_name]'s magical nature lets them get some mp back!<center><h3>"
			enemy_mp += attack_amount

	//poisonous passive trait, while it's less damage added than the shotgun it acts up even when the enemy doesn't attack at all.
	if(LAZYACCESS(enemy_passive, "poisonous"))
		if(weakpoint_check("poisonous","attack","attack","attack"))
			list_temp += "<br><center><h3>your flurry of attack throws back the poisonnous gas at [enemy_name] and makes them choke on it!<center><h3> "
			enemy_hp -= 5
		else
			list_temp += "<br><center><h3>the stinky breath of [enemy_name] hurts you for 3 hp!<center><h3> "
			player_hp -= 3

	//if all passive's weakpoint have been triggered, set finishing_move to TRUE
	if(pissed_off >= max_passive && !finishing_move)
		list_temp += "<br><center><h3>You have weakened [enemy_name] enough for them to show their weak point, you will do 10 times as much damage with your next attack!<center><h3> "
		finishing_move = TRUE

	playsound(src, 'modular_septic/sound/effects/ronaldo/heal.wav', 50, TRUE, extrarange = -3)

	temp = list_temp.Join()
	gameover_check(user)
	screen_setup(user)
	blocked = FALSE
