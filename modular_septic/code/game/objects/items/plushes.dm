/obj/item/toy/plush/chipraps
	name = "chipraps plushie"
	desc = "A plushie depicting a polish schizo. Capable of detecting niggers miles away."
	icon = 'modular_septic/icons/obj/items/plushes.dmi'
	icon_state = "chipraps"
	attack_verb_continuous = list("rapes", "murders")
	attack_verb_simple = list("rape", "murder")
	squeak_override = list('modular_septic/sound/memeshit/niggers.ogg'=1,
						'modular_septic/sound/memeshit/nigger.ogg'=3)
	force = 5
	COOLDOWN_DECLARE(nigger_alarm)

/obj/item/toy/plush/chipraps/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/toy/plush/chipraps/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/toy/plush/chipraps/pre_attack(atom/A, mob/living/user, params)
	. = ..()
	if(ishuman(A))
		var/mob/living/carbon/human/nigger = A
		if((nigger.dna?.species?.id == SPECIES_HUMAN) && findtext(nigger.dna.features["skin_tone"], "african"))
			force = (initial(force)*4)
		else
			force = initial(force)
	else
		force = initial(force)

/obj/item/toy/plush/chipraps/process(delta_time)
	. = ..()
	if(!COOLDOWN_FINISHED(src, nigger_alarm))
		return
	for(var/mob/living/carbon/human/nigger in view(4, src))
		if((nigger.dna?.species?.id == SPECIES_HUMAN) && findtext(nigger.dna.features["skin_tone"], "african"))
			nigger_alarm()
			break

/obj/item/toy/plush/chipraps/proc/nigger_alarm(mob/living/carbon/human/nigger)
	say("OHH, OHH, NIGGER ALARM!!!!!!!!")
	if(nigger)
		point_at(nigger)
	playsound(src, 'modular_septic/sound/memeshit/nigger_alarm.ogg', 65, FALSE)
	COOLDOWN_START(src, nigger_alarm, 1 MINUTES)
