/datum/simcard_virus/memz
	name = "Worm.Nokey.Memz"
	var/stage = 0
	var/progress_chance = 8
	var/activated = FALSE
	var/virus_screams = list('modular_septic/sound/efn/virus_scream.ogg', 'modular_septic/sound/efn/virus_scream2.ogg', 'modular_septic/sound/efn/virus_scream3.ogg')

/datum/simcard_virus/memz/install(obj/item/simcard/new_parent)
	. = ..()
	START_PROCESSING(SSobj, src)

/datum/simcard_virus/memz/uninstall(obj/item/simcard/new_parent)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/datum/simcard_virus/memz/proc/hint(hint_chance = 25, delta_time)
	if(DT_PROB(hint_chance, delta_time))
		if(stage <= 2)
			playsound(parent.parent, virus_screams, rand(5, 19), FALSE)
			parent.parent.audible_message(span_danger("[parent.parent] vibrates quietly."))
			return
		else
			playsound(parent.parent, 'modular_septic/sound/efn/virus_acute.ogg', rand(25, 45), FALSE)
			parent.parent.audible_message(span_danger("[parent.parent] vibrates loudly, It's screen blinking and glitching!"))
			return

/datum/simcard_virus/memz/process(delta_time)
	if(!parent.parent)
		return
	if(DT_PROB(2.5, delta_time))
		if(!activated)
			activated = TRUE
			hint(hint_chance = 100, delta_time)
			return
		switch(stage)
			if(0)
				symptom(symptom_type = "mild")
				if(prob(progress_chance))
					progress_virus()
				return
			if(1)
				symptom(symptom_type = "mild")
				if(prob(progress_chance))
					progress_virus()
				return
			if(2)
				symptom(symptom_type = "moderate")
				if(prob(progress_chance))
					progress_virus()
				return
			if(3)
				symptom(symptom_type = "heavy")
				if(prob(progress_chance))
					progress_virus()
				return
			if(4)
				symptom(symptom_type = "acute")
				return

/datum/simcard_virus/memz/proc/symptom(symptom_type = "mild", delta_time)
	switch(symptom_type)
		if("moderate")
			hint(hint_chance = 50, delta_time = delta_time)
		if("heavy")
			hint(hint_chance = 25, delta_time = delta_time)
			parent.parent.start_glitching()
		if("acute")
			hint(hint_chance = 10, delta_time = delta_time)
			parent.parent.begin_selfdestruct()
		else
			hint(hint_chance = 85, delta_time = delta_time)


/datum/simcard_virus/memz/proc/progress_virus()
	progress_chance += 5
	if(stage != 4)
		stage += 1

