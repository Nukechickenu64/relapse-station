/obj/machinery/infocom
	name = "Infocom"
	desc = "An information communication machine, a very creative name! It's a device used to dispense information when used, how do you know that? I don't fucking know, click on it to learn how."
	icon = 'modular_septic/icons/obj/machinery/intercom.dmi'
	icon_state = "infocom"
	base_icon_state = "infocom"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	var/radiotune = list('modular_septic/sound/efn/infocom1.ogg', 'modular_septic/sound/efn/infocom2.ogg', 'modular_septic/sound/efn/infocom3.ogg', 'modular_septic/sound/efn/infocom4.ogg')
	var/tip_sound = 'modular_septic/sound/efn/infocom_trigger.ogg'
	var/list/voice_lines = list("This place is damp and dirty, many of the rooms don't make sense but I can help you.", "Find more Infocoms next to things you're curious about, they say different things.", "It'll tell you the location name and what you can find there.", \
	"Avoid everyone! Or kill them, they're out to get your loot and your life.")
	var/tipped = FALSE
	var/voice_delay = 3 SECONDS
	var/cooldown_delay = 5

/obj/machinery/infocom/proc/spit_facts()
	if(prob(50))
		playsound(src, radiotune, 60, FALSE)

/obj/machinery/infocom/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/update_overlays()
	. = ..()
	if(!tipped)
		. += "[icon_state]_beeper"

/obj/machinery/infocom/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(tipped)
		var/explicit = pick("fucking", "goddamn", "goshdarn", "fricking")
		to_chat(user, span_notice("I need to let it [explicit] speak."))
		return
	playsound(src, tip_sound, 65, FALSE)
	tipped = TRUE
	update_overlays()
	INVOKE_ASYNC(src, .proc/start_spitting_fax)

/obj/machinery/infocom/proc/start_spitting_fax(mob/living/user, list/modifiers)
	for(var/line in voice_lines)
		spit_facts()
		say(line)
		sound_hint()
		sleep(voice_delay)
	sleep(cooldown_delay)
	tipped = FALSE
	update_overlays()

/obj/machinery/infocom/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/east
	dir = WEST
	pixel_x = 12

/obj/machinery/infocom/west
	dir = EAST
	pixel_x = -12
