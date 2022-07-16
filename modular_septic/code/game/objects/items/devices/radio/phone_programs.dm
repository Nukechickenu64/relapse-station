/obj/item/sim_card_program
	name = "sim card program"
	var/health = 10
	var/maxhealth = 60
	var/defence_chance = 20
	var/max_defence_chance = 50
	var/corrupted = FALSE
	var/illegal = FALSE
	var/obj/item/sim_card/host

/obj/item/sim_card_program/proc/execute(mob/user, modifiers)
	if(corrupted)
		to_chat(user, span_dead("The program was corrupted!"))
		host.infect_with_virus()
		playsound(host.owner_phone, firewall_noise, 65, FALSE)
		return

/obj/item/sim_card_program/vantablack
	name = "VANTABLACK SOFTWARE"
	health = 100
	maxhealth = 100
	defence_chance = 50
	max_defence_chance = 100
	illegal = TRUE
