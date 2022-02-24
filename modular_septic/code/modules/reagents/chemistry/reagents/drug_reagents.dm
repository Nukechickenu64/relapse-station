/datum/reagent/drug/lean
	name = "lean"
	description = "I LOVE LEAN."
	reagent_state = SOLID
	taste_description = "purple"
	color = "#7E3990"
	overdose_threshold = 35
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 3
	addiction_types = list(/datum/addiction/maintenance_drugs = 20)

/datum/reagent/drug/lean/on_mob_life(mob/living/carbon/lean_monster, delta_time, times_fired)
	. = ..()
	//Chance of Willador Afton
	if(DT_PROB(2, delta_time))
		INVOKE_ASYNC(src, .proc/handle_lean_monster_hallucinations, lean_monster)

/datum/reagent/drug/lean/on_mob_metabolize(mob/living/lean_monster)
	. = ..()
	to_chat(lean_monster, span_love(span_big("Lean... I LOVE LEAAAANNNNNNN!!!")))
	ADD_TRAIT(lean_monster, TRAIT_LEAN, name)
	SEND_SIGNAL(lean_monster, COMSIG_ADD_MOOD_EVENT, "forbidden_sizzup", /datum/mood_event/lean, name)
	SSdroning.area_entered(get_area(lean_monster), lean_monster?.client)
	addtimer(CALLBACK(src, .proc/make_monster_lean, lean_monster), 1 SECONDS) //For making him lean
	lean_monster.playsound_local(lean_monster, 'modular_septic/sound/insanity/leanlaugh.wav', 50)

	if(!lean_monster.hud_used)
		return

	//Chance of Willador Afton
	if(prob(10))
		INVOKE_ASYNC(src, .proc/handle_lean_monster_hallucinations, lean_monster)

	var/atom/movable/screen/plane_master/rendering_plate/filter_plate = lean_monster.hud_used.plane_masters["[RENDER_PLANE_PREMASTER]"]

	var/list/col_filter_full = list(1,0,0,0, 0,1.00,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_twothird = list(1,0,0,0, 0,0.68,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_half = list(1,0,0,0, 0,0.42,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_empty = list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

	filter_plate.add_filter("lean_filter", 100, color_matrix_filter(col_filter_twothird, FILTER_COLOR_HCY))

	animate(filter_plate.get_filter("lean_filter"), loop = -1, color = col_filter_full, time = 4 SECONDS, easing = CIRCULAR_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	animate(color = col_filter_twothird, time = 6 SECONDS, easing = LINEAR_EASING)
	animate(color = col_filter_half, time = 3 SECONDS, easing = LINEAR_EASING)
	animate(color = col_filter_empty, time = 2 SECONDS, easing = CIRCULAR_EASING|EASE_OUT)
	animate(color = col_filter_half, time = 24 SECONDS, easing = CIRCULAR_EASING|EASE_IN)
	animate(color = col_filter_twothird, time = 12 SECONDS, easing = LINEAR_EASING)

	filter_plate.add_filter("lean_blur", 101, list("type" = "radial_blur", "size" = 0))

	animate(filter_plate.get_filter("lean_blur"), loop = -1, size = 0.04, time = 2 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
	animate(size = 0, time = 6 SECONDS, easing = CIRCULAR_EASING|EASE_IN)

/datum/reagent/drug/lean/on_mob_end_metabolize(mob/living/lean_monster)
	. = ..()
	to_chat(lean_monster, span_love(span_big("NOOOO... I NEED MORE LEAN...")))
	if(!lean_monster.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = lean_monster.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	lean_monster.playsound_local(lean_monster, 'modular_septic/sound/insanity/leanend.wav', 50)
	lean_monster.flash_pain(30)

	game_plane_master_controller.remove_filter("lean_filter")
	game_plane_master_controller.remove_filter("lean_blur")
	REMOVE_TRAIT(lean_monster, TRAIT_LEAN, name)
	SSdroning.play_area_sound(get_area(lean_monster), lean_monster?.client)

/datum/reagent/drug/lean/proc/make_monster_lean(mob/living/carbon/lean_monster)
	if(lean_monster.body_position == LYING_DOWN)
		lean_monster.set_lying_angle(lean_monster.lying_angle - 5)
	else
		lean_monster.set_lying_angle(lean_monster.lying_angle + 5)

/datum/reagent/drug/lean/proc/make_monster_unlean(mob/living/carbon/lean_monster)
	if(lean_monster.body_position == LYING_DOWN)
		lean_monster.set_lying_angle(lean_monster.lying_angle + 5)
	else
		lean_monster.set_lying_angle(lean_monster.lying_angle - 5)

/datum/reagent/drug/lean/proc/handle_lean_monster_hallucinations(mob/living/lean_monster)
	if(!lean_monster)
		return
	var/purple_msg = pick("SAVE THEM!", "IT'S ME!", "I AM STILL HERE!", "I ALWAYS COME BACK!")
	var/turf/turfie
	var/list/turf/turfies = list()
	for(var/turf/torf in view(lean_monster))
		turfies += torf
	if(length(turfies))
		turfie = pick(turfies)
	if(!turfie)
		return
	var/image/purple_guy = image('modular_septic/icons/mob/lean.dmi', turfie, "ILOVELEAN", FLOAT_LAYER, get_dir(turfie, lean_monster))
	purple_guy.plane = GAME_PLANE_FOV_HIDDEN
	purple_guy.layer = lean_monster.layer + 10
	lean_monster.client?.images += purple_guy
	to_chat(lean_monster, span_purple(span_big("<span class='big bold'>[purple_msg]</span>")))
	sleep(0.5 SECONDS)
	var/hallsound = 'modular_septic/sound/insanity/purpleappear.ogg'
	var/catchsound = list('modular_septic/sound/insanity/purpelhal1.ogg', 'modular_septic/sound/insanity/purplehal2.ogg')
	lean_monster.playsound_local(get_turf(lean_monster), hallsound, 100, 0)
	var/chase_tiles = 7
	var/chase_wait_per_tile = rand(4,6)
	var/caught_monster = FALSE
	while(chase_tiles > 0)
		turfie = get_step(turfie, get_dir(turfie, lean_monster))
		if(turfie)
			purple_guy.loc = turfie
			if(turfie == get_turf(lean_monster))
				caught_monster = TRUE
				sleep(chase_wait_per_tile)
				break
		chase_tiles--
		sleep(chase_wait_per_tile)
	lean_monster.client?.images -= purple_guy
	if(!QDELETED(purple_guy))
		qdel(purple_guy)
	if(caught_monster)
		lean_monster.playsound_local(lean_monster, catchsound, 100)
		lean_monster.Paralyze(rand(2, 5) SECONDS)
		var/pain_msg = pick("NO!", "HE GOT ME!", "AGH!")
		to_chat(lean_monster, span_userdanger("<b>[pain_msg]</b>"))
		lean_monster.flash_pain_mental(100)
