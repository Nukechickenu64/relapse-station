#define OWNER 0
#define STRANGER 1
/datum/brain_trauma/severe/earfuck
	name = "Earfuck Brain Transfer"
	desc = "There is a neuro tripmine that has detonated in the patient's brain, causing a new conciousness to remotely control it."
	scan_desc = "complete lobe separation"
	gain_text = "<span class='boldwarning'>My mind is violated in every way It's possible to be violated.</span>"
	lose_text = "<span class='boldnotice'>My mind feels like It only has one occupant again.</span>"
	var/current_controller = OWNER
	var/initialized = FALSE //to prevent personalities deleting themselves while we wait for ghosts
	var/control = 100 // the amount of control they have over the body, starts full
	var/mob/living/original_stranger
	var/mob/living/earfuck/stranger_backseat //there's two so they can swap without overwriting
	var/mob/living/earfuck/owner_backseat

/datum/brain_trauma/severe/earfuck/on_gain()
	var/mob/living/M = owner
	if(M.stat == DEAD || !M.client) //No use assigning people to a corpse or braindead
		qdel(src)
		return
	..()
	make_backseats()
	assign_earfucker()

/datum/brain_trauma/severe/earfuck/proc/make_backseats()
	stranger_backseat = new(owner, src)
	owner_backseat = new(owner, src)


/datum/brain_trauma/severe/earfuck/proc/assign_earfucker(mob/living/earfucker)
	stranger_backseat.key = earfucker.key
	to_chat(stranger_backseat, span_notice("I HAVE SUCCESSFULLY ENTERED THEIR MIND. I HAVE A MINUTE UNTIL THEY FIGHT BACK.\n\
	IF I DIE IN THIS BODY, I WON'T BE ABLE TO GET BACK TO MY OLD BODY!"))
	if(!earfucker)
		qdel(src)

/datum/brain_trauma/severe/earfuck/on_life(delta_time, times_fired)
	if(owner.stat == DEAD) //If they're dead, make sure that the intruder gets ghosted.
		if(current_controller != OWNER) // and make it so they automatically switch back to their initial body after the possession is done
			switch_minds(TRUE)
		qdel(src)
	if(control <= 0)
		switch_minds(TRUE)
		original_stranger.key = stranger_backseat.key
		qdel(src)
		return
	if(DT_PROB(2, delta_time))
		control -= 10
		to_chat(owner, span_warning("I am losing control. [control]/100."))
		to_chat(owner_backseat, span_boldwarning("I make progress. Their control is weakening [control]/100"))
		playsound(owner, 'modular_septic/sound/efn/earfuck_losecontrol.ogg', 20, FALSE)
	..()

/datum/brain_trauma/severe/earfuck/on_lose()
	if(current_controller != OWNER) //it would be funny to cure a guy only to be left with the other personality, but it seems too cruel
		to_chat(owner, span_boldwarning("The intruder is forcibly removed!"))
		switch_minds(TRUE)
	QDEL_NULL(stranger_backseat)
	QDEL_NULL(owner_backseat)
	STOP_PROCESSING(SSprocessing, src)
	..()

/datum/brain_trauma/severe/earfuck/Destroy()
	if(stranger_backseat)
		QDEL_NULL(stranger_backseat)
	if(owner_backseat)
		QDEL_NULL(owner_backseat)
	return ..()

/datum/brain_trauma/severe/earfuck/proc/switch_minds(reset_to_owner = FALSE)
	if(QDELETED(owner) || QDELETED(stranger_backseat) || QDELETED(owner_backseat))
		return

	var/mob/living/earfuck/current_backseat
	var/mob/living/earfuck/new_backseat
	if(current_controller == STRANGER || reset_to_owner)
		current_backseat = owner_backseat
		new_backseat = stranger_backseat
	else
		current_backseat = stranger_backseat
		new_backseat = owner_backseat

	if(!current_backseat.client) //Make sure we never switch to a logged off mob.
		return

	to_chat(owner, span_userdanger("MY BODY HAS BEEN SEIZED!"))
	to_chat(current_backseat, span_userdanger("I seize this body."))
	current_backseat.playsound_local(owner.loc, 'modular_septic/sound/efn/earfuck_switch.ogg', 70, FALSE)
	playsound(owner, 'modular_septic/sound/efn/earfuck_laugh.ogg', 65, FALSE, 2)
	owner.emote("custom", message = "makes otherwordly noises as [owner.p_their()] head snaps and switches!")
	START_PROCESSING(SSprocessing, src)

	//Body to backseat

	var/h2b_id = owner.computer_id
	var/h2b_ip= owner.lastKnownIP
	owner.computer_id = null
	owner.lastKnownIP = null

	new_backseat.ckey = owner.ckey

	new_backseat.name = owner.name

	if(owner.mind)
		new_backseat.mind = owner.mind

	if(!new_backseat.computer_id)
		new_backseat.computer_id = h2b_id

	if(!new_backseat.lastKnownIP)
		new_backseat.lastKnownIP = h2b_ip

	if(reset_to_owner && new_backseat.mind)
		new_backseat.ghostize(FALSE)

	//Backseat to body

	var/s2h_id = current_backseat.computer_id
	var/s2h_ip= current_backseat.lastKnownIP
	current_backseat.computer_id = null
	current_backseat.lastKnownIP = null

	owner.ckey = current_backseat.ckey
	owner.mind = current_backseat.mind

	if(!owner.computer_id)
		owner.computer_id = s2h_id

	if(!owner.lastKnownIP)
		owner.lastKnownIP = s2h_ip

	current_controller = !current_controller


/mob/living/earfuck
	name = "earfuck victim"
	real_name = "original mind trapped in an synthetic fate."
	var/mob/living/carbon/body
	var/datum/brain_trauma/severe/earfuck/earfuck

/mob/living/earfuck/Initialize(mapload, _earfuck)
	if(iscarbon(loc))
		body = loc
		name = body.real_name
		real_name = body.real_name
		earfuck = _earfuck
	return ..()

/mob/living/earfuck/Life(delta_time = SSMOBS_DT, times_fired)
	apply_status_effect(/datum/status_effect/earfuck_hud)
	if(QDELETED(body))
		qdel(src) //in case trauma deletion doesn't already do it

	if((body.stat == DEAD && earfuck.owner_backseat == src))
		earfuck.switch_minds()
		qdel(earfuck)

	//if one of the two ghosts, the other one stays permanently
	if(!body.client && earfuck.initialized)
		earfuck.switch_minds()
		qdel(earfuck)

	..()

/mob/living/earfuck/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_boldwarning("I'm regaining my conciousness back from this wretched intruder, everything is unavailable to me, I just have to keep fighting idly until I'm back in my rightful place."))

/mob/living/earfuck/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	to_chat(src, span_bolddanger("Something is controlling MY body, I can't speak using MY mouth."))
	return FALSE

/mob/living/earfuck/emote(act, m_type = null, message = null, intentional = FALSE, force_silence = FALSE)
	return FALSE

#undef OWNER
#undef STRANGER
