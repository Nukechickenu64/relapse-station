/datum/preferences
	var/client/parent

	// doohickeys for savefiles
	var/path
	var/default_slot = 1 //Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 10

	// clickity clack sounds
	var/static/sound/resetsound = sound('modular_septic/sound/effects/reset.ogg', FALSE, FALSE, CHANNEL_CLICKITY_CLACK, 60)
	var/static/sound/savesound = sound('modular_septic/sound/effects/save.ogg', FALSE, FALSE, CHANNEL_CLICKITY_CLACK, 60)
	var/static/sound/undosound = sound('modular_septic/sound/effects/undo.ogg', FALSE, FALSE, CHANNEL_CLICKITY_CLACK, 60)
	var/static/sound/clicksound = sound('modular_septic/sound/effects/tablettap.wav', FALSE, FALSE, CHANNEL_CLICKITY_CLACK, 60)

	// non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id

	// game-preferences
	var/lastchangelog = "" //Saved changlog filesize to detect if there was a change
	var/ooccolor = "#97006a"
	var/asaycolor = "#ff9633" //This won't change the color for current admins, only incoming ones.

	/// If we spawn an ERT as an admin and choose to spawn as the briefing officer, we'll be given this outfit
	var/brief_outfit = /datum/outfit/centcom/commander
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds

	// Antag preferences
	var/list/be_special = list() //Special role selection
	var/tmp/old_be_special = 0 //Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.
	var/be_antag = TRUE //Does this player wish to be an antag this round?

	var/UI_style = null
	var/buttons_locked = FALSE
	var/hotkeys = TRUE

	/// Runechat preference. If true, certain messages will be displayed on the map, not ust on the chat area. Boolean.
	var/chat_on_map = TRUE
	/// Limit preference on the size of the message. Requires chat_on_map to have effect.
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	/// Whether non-mob messages will be displayed, such as machine vendor announcements. Requires chat_on_map to have effect. Boolean.
	var/see_chat_non_mob = TRUE
	/// Whether emotes will be displayed on runechat. Requires chat_on_map to have effect. Boolean.
	var/see_rc_emotes = TRUE

	// Custom Keybindings
	var/list/key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = FALSE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null
	var/pda_style = MONO
	var/pda_color = "#538569" //codec pda
	var/uses_glasses_colour = 0

	//character preferences
	var/slot_randomized //keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/real_name //our character's name
	var/gender = MALE //gender of character (well duh)
	var/body_type /// Agendered spessmen can(not) choose whether to have a male or female bodytype
	var/genitals = "Male" //list of genitals our character has, can be one of GLOB.genital_sets
	var/age = 30 //age of character
	var/underwear = "Nude" //underwear type
	var/underwear_color = "FFF" //underwear color
	var/undershirt = "Nude" //undershirt type
	var/undershirt_color = "FFF" //underwear color
	var/socks = "Nude" //socks type
	var/socks_color = "FFF"			//underwear color
	var/backpack = DBACKPACK //backpack type
	var/jumpsuit_style = PREF_SUIT //suit/skirt
	var/hairstyle = "Bald" //Hair type
	var/hair_color = "000000" //Hair color
	var/facial_hairstyle = "Shaved" //Face hair type
	var/facial_hair_color = "000000" //Facial hair color
	var/skin_tone = "caucasian1" //Skin color
	var/left_eye_color = "000000" //Left eye color
	var/right_eye_color = "000000" //Right eye color
	var/datum/species/pref_species = new /datum/species/human()	//Species
	// Has to include all information that extra organs from mutant bodyparts would need (so far only genitals now)
	var/list/features = MANDATORY_FEATURE_LIST
	var/list/randomise = list(RANDOM_BACKPACK = TRUE, RANDOM_JUMPSUIT_STYLE = TRUE, RANDOM_HAIRSTYLE = TRUE, RANDOM_HAIR_COLOR = TRUE, RANDOM_FACIAL_HAIRSTYLE = TRUE, RANDOM_FACIAL_HAIR_COLOR = TRUE, RANDOM_SKIN_TONE = TRUE, RANDOM_EYE_COLOR = TRUE, RANDOM_FEATURES = TRUE)
	var/phobia = "spiders"
	var/list/foodlikes = list()
	var/list/fooddislikes = list()
	var/max_foodlikes = 3
	var/max_fooddislikes = 6

	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/prefered_security_department = SEC_DEPT_NONE

	// Quirk list
	var/list/all_quirks = list()

	// Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

	// Want randomjob if preferences already filled - Donkie
	var/joblessrole = BERANDOMJOB  //defaults to 1 for fewer assistants

	// 0 = character settings, 1 = game preferences
	var/current_tab = PREF_TAB_CHARSETTINGS

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 40

	var/parallax

	/// Do we show screentips, if so, how big?
	var/screentip_pref = TRUE
	/// Color of screentips at top of screen
	var/screentip_color = "#ffd391"
	/// Do we show item hover outlines?
	var/itemoutline_pref = TRUE

	var/ambientocclusion = TRUE
	/// Should we automatically fit the viewport?
	var/auto_fit_viewport = FALSE
	/// Should we be in the widescreen mode set by the config?
	var/widescreenpref = TRUE
	/// Yeah
	var/darkened_flash = FALSE
	/// What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	/// What scaling method should we use? Distort means nearest neighbor
	var/scaling_method = SCALING_METHOD_DISTORT
	var/uplink_spawn_loc = UPLINK_PDA
	/// The playtime_reward_cloak variable can be set to TRUE from the prefs menu only once the user has gained over 5K playtime hours. If true, it allows the user to get a cool looking roundstart cloak.
	var/playtime_reward_cloak = FALSE

	var/list/exp = list()
	var/list/menuoptions

	var/action_buttons_screen_locs = list()

	/// This var stores the amount of points the owner will get for making it out alive.
	var/hardcore_survival_score = 0

	/// Someone thought we were nice! We get a little heart in OOC until we join the server past the below time (we can keep it until the end of the round otherwise)
	var/hearted
	/// If we have a hearted commendations, we honor it every time the player loads preferences until this time has been passed
	var/hearted_until
	/// If we have persistent scars enabled
	var/persistent_scars = TRUE
	/// If we want to broadcast deadchat connect/disconnect messages
	var/broadcast_login_logout = FALSE
	/// What outfit typepaths we've favorited in the SelectEquipment menu
	var/list/favorite_outfits = list()
	/// Will the person see accessories not meant for their species to choose from
	var/mismatched_customization = FALSE
	var/allow_advanced_colors = FALSE
	var/list/list/mutant_bodyparts = list()
	var/list/list/body_markings = list()

	var/character_settings_tab = 0

	/// How many loadout points we've got remaining
	var/loadout_points = LOADOUT_POINTS_MAX
	/// Loadout items, this is an associative list stored as [name] = "info". Info can be either colors or styles for the loadout items
	var/loadout = list()

	var/loadout_category = ""
	var/loadout_subcategory = ""

	var/preview_pref = PREVIEW_PREF_JOB
	var/preview_bg = "nothing"
	var/preview_dir = SOUTH
	var/static/list/bg_options = list("nothing", "whitetile", "darktile", "plating", "pure_white", "pure_black", "gmod")

	// BACKGROUND STUFF
	var/general_record = ""
	var/security_record = ""
	var/medical_record = ""
	var/background_info = ""
	var/exploitable_info = ""

	/// Whether the system should have to update the sprite. This is set to TRUE whenever anything appearance changing is set
	var/needs_update = TRUE
	/// List of chosen augmentations. It's an associative list with key name of the slot, pointing to a typepath of an augment define
	var/augments = list()
	/// List of chosen preferred styles for limb replacements
	var/augment_limb_styles = list()
	/// Which augment slot we currently have chosen, this is for UI display
	var/chosen_augment_slot
	/// Whether the user wants to see body size being shown in the preview
	var/show_body_size = FALSE
	/// The arousal state of the previewed character, can be toggled by the user
	var/arousal_preview = AROUSAL_NONE
	/// The current volume setting for announcements
	var/announcement_volume = 60

	// Chosen cultural informations
	var/pref_birthsign = /datum/cultural_info/birthsign/starless

	// Whether someone wishes to see more information regarding either of those
	var/birthsign_more_info = FALSE

	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()

	/// Our character's dominant hand
	var/handedness = RIGHT_HANDED
	/// Our character's blood type
	var/blood_type = "Random"

	/// Fullscreen and other crap
	var/septictoggles = SEPTICTOGGLES_DEFAULT

/datum/preferences/New(client/C)
	parent = C

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots = 20
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			return
	//default to every role enabled
	be_special = GLOB.special_roles.Copy()
	//we couldn't load character data so just randomize the character appearance + name
	set_new_species(/datum/species/human)
	randomise_appearance_prefs() //let's create a random character then - rather than a fat, bald and naked man.
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C?.set_macros()
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character() //let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='15%'>"
#define MAX_MUTANT_ROWS 5

/datum/preferences/proc/ShowChoices(mob/user)
	if(!user || !user.client)
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	if(needs_update)
		update_preview_icon()
		needs_update = FALSE
	var/list/dat = list()

	dat += "<center>"
	dat += "<style>span.color_holder_box{display: inline-block; width: 20px; height: 8px; border:1px solid #000; padding: 0px;}</style>"

	dat += "<a href='?_src_=prefs;preference=tab;tab=[PREF_TAB_CHARSETTINGS]' [current_tab == PREF_TAB_CHARSETTINGS ? "class='linkOn'" : ""]>Character Settings</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[PREF_TAB_GAME]' [current_tab == PREF_TAB_GAME ? "class='linkOn'" : ""]>Game Preferences</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[PREF_TAB_OOC]' [current_tab == PREF_TAB_OOC ? "class='linkOn'" : ""]>OOC Preferences</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[PREF_TAB_KEYBINDINGS]' [current_tab == PREF_TAB_KEYBINDINGS ? "class='linkOn'" : ""]>Custom Keybindings</a>"

	if(!path)
		dat += "<div class='notice'>Please create an account to save your preferences</div>"

	dat += "</center>"

	dat += "<hr>"

	switch(current_tab)
		if (PREF_TAB_CHARSETTINGS) // Character Settings
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots >= 5)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"

			dat += "<hr>"

			dat += "<center>"
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_GENERAL]' [character_settings_tab == PREF_SUBTAB_GENERAL ? "class='linkOn'" : ""]>General</a>"
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_APPEARANCE]' [character_settings_tab == PREF_SUBTAB_APPEARANCE ? "class='linkOn'" : ""]>Appearance</a>"
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_MARKINGS]' [character_settings_tab == PREF_SUBTAB_MARKINGS ? "class='linkOn'" : ""]>Markings</a>"
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_AUGMENT]' [character_settings_tab == PREF_SUBTAB_AUGMENT ? "class='linkOn'" : ""]>Augmentation</a>"
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_BACKGROUND]' [character_settings_tab == PREF_SUBTAB_BACKGROUND ? "class='linkOn'" : ""]>Background</a>"
			/* Inactive until loadout items are added
			dat += "<a href='?_src_=prefs;preference=character_tab;tab=[PREF_SUBTAB_LOADOUT]' [character_settings_tab == PREF_SUBTAB_LOADOUT ? "class='linkOn'" : ""]>Loadout</a>"
			*/
			dat += "</center>"

			dat += "<hr>"
			switch(character_settings_tab)
				if(PREF_SUBTAB_LOADOUT) //Loadout
					dat += "<center>"
					dat += "<table width='100%'>"
					dat += "<tr>"
					dat += "<td style='padding-left: 5%; padding-right: 5%'>"
					dat += "<b>Remaining loadout points: [loadout_points]</b>"
					dat += "</td>"
					dat += "<td style='padding-right: 5%'>"
					dat += "<a href='?_src_=prefs;preference=reset_loadout'>Reset Loadout</a>"
					dat += "</td>"
					dat += "</tr>"
					dat += "</table>"
					dat += "</center>"
					dat += "<hr>"
				if(PREF_SUBTAB_AUGMENT) //Augments
					dat += "<center>"
					dat += "<table width='100%'>"
					dat += "<tr>"
					dat += "<td style='padding-left: 5%; padding-right: 5%'>"
					if(!(!SSquirks || !SSquirks.quirks.len))
						dat += "<b>Remaining quirk points: [GetQuirkBalance()]</b>"
					dat += "</td>"
					dat += "</tr>"
					dat += "</table>"
					dat += "</center>"
					dat += "<hr>"
				if(PREF_SUBTAB_APPEARANCE, PREF_SUBTAB_MARKINGS) //Appearance or markings
					dat += "<center>"
					dat += "<table width='100%'>"
					dat += "<tr>"
					dat += "<td style='padding-left: 5%; padding-right: 5%'>"
					dat += "<b>Mismatched parts:</b> <a href='?_src_=prefs;preference=mismatch'>[(mismatched_customization) ? "Enabled" : "Disabled"]</a>"
					dat += "</td>"
					dat += "<td>"
					dat += "<b>Color customization:</b> <a href='?_src_=prefs;preference=adv_colors'>[(allow_advanced_colors) ? "Enabled" : "Disabled"]</a>"
					if(allow_advanced_colors)
						dat += "<a href='?_src_=prefs;preference=reset_all_colors;task=change_bodypart'>Reset colors</a><BR>"
					dat += "</td>"
					dat += "</tr>"
					dat += "</table>"
					dat += "</center>"
					dat += "<hr>"
			switch(character_settings_tab)
				if(PREF_SUBTAB_GENERAL) //General
					dat += "<h2>Occupation Choices</h2>"
					dat += "<a href='?_src_=prefs;preference=job;task=menu'>Set Occupation Preferences</a>"
					dat += "<br>"
					dat += "<table width='100%'><tr>"
					dat += "<td width='75%' valign='top'>"
					dat += "<h2>Identity</h2>"
					if(is_banned_from(user.ckey, "Appearance"))
						dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"
					//dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME]'>Always Random Name: [(randomise[RANDOM_NAME]) ? "Yes" : "No"]</a>"
					//dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME_ANTAG]'>When Antagonist: [(randomise[RANDOM_NAME_ANTAG]) ? "Yes" : "No"]</a>"
					/*if(user.client.get_exp_living(TRUE) >= PLAYTIME_HARDCORE_RANDOM)
						dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HARDCORE]'>Hardcore Random: [(randomise[RANDOM_HARDCORE]) ? "Yes" : "No"]</a>"*/
					dat += "<b>Name:</b> "
					dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a> "
					dat += "<a href='?_src_=prefs;preference=name;task=random'>Random Name</a>"

					if(!(AGENDER in pref_species.species_traits))
						var/dispGender
						if(gender == MALE)
							dispGender = "Male"
						else if(gender == FEMALE)
							dispGender = "Female"
						else
							dispGender = "Other"
						dat += "<br><b>Gender:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a>"
						dat += "<br><b>Genitals:</b> <a href='?_src_=prefs;preference=genitals'>[genitals]</a>"

					dat += "<br><b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a>"
					dat += "<br><b>Handedness:</b> <a href='?_src_=prefs;preference=dominant_hand;task=input'>[parse_handedness(handedness)]</a>"
					dat += "<br><b>Blood type:</b> <a href='?_src_=prefs;preference=blood_type;task=input'>[blood_type]</a>"

					dat += "<h2>Special Names</h2>"
					var/old_group
					for(var/custom_name_id in GLOB.preferences_custom_names)
						var/namedata = GLOB.preferences_custom_names[custom_name_id]
						if(!old_group)
							old_group = namedata["group"]
						else if(old_group != namedata["group"])
							old_group = namedata["group"]
							dat += "<br>"
						dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
					dat += "<br><br>"

					dat += "<h3>Job Preferences</h3>"
					dat += "<a href='?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"
					dat += "<a href='?_src_=prefs;preference=sec_dept;task=input'><b>Preferred Security Department:</b> [prefered_security_department]</a><br>"
					//Adds a thing to select which phobia because I can't be assed to put that in the quirks window
					if("Phobia" in all_quirks)
						dat += "<h3>Phobia</h3>"
						dat += "<a href='?_src_=prefs;preference=phobia;task=input'>[phobia]</a><br>"
					dat += "</td>"

					//character preview
					dat += "<td valign='top' halign='right' width='20%' max-width='20%'>"
					dat += "<center>"
					dat += "<h3>Preview</h3>"
					dat += "<div style='background-color: #13171C; border: 2px solid #001a33;'>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_JOB]' [preview_pref == PREVIEW_PREF_JOB ? "class='linkOn'" : ""]>[PREVIEW_PREF_JOB]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_LOADOUT]' [preview_pref == PREVIEW_PREF_LOADOUT ? "class='linkOn'" : ""]>[PREVIEW_PREF_LOADOUT]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_NAKED]' [preview_pref == PREVIEW_PREF_NAKED ? "class='linkOn'" : ""]>[PREVIEW_PREF_NAKED]</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_background'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_background'>Background</a>"
					dat += "<a href='?_src_=prefs;preference=next_background'>&gt;</a>"
					dat += "<br>"
					dat += "<img src='previewicon[preview_dir].gif' width=96 height=96>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=reload_preview'>Reload Preview</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_preview_dir'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_preview_dir'>Direction</a>"
					dat += "<a href='?_src_=prefs;preference=next_preview_dir'>&gt;</a>"
					dat += "</center>"
					dat += "</div>"
					dat += "</td>"

					dat += "</tr></table>"

				if(PREF_SUBTAB_APPEARANCE) //Appearance
					dat += "<table width='100%'>"
					dat += "<tr>"
					dat += APPEARANCE_CATEGORY_COLUMN
					dat += "<h2>Body</h2>"
					dat += "<a href='?_src_=prefs;preference=all;task=random'>Random Body</A> "
					dat += "<h3>Species</h3>"
					dat += "<a href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><br>"
					dat += "<h3>Backpack style</h3>"
					dat += "<a href ='?_src_=prefs;preference=bag;task=input'>[backpack]</a><br>"
					dat += "<h3>Uplink Spawn Location</h3>"
					dat += "<a href ='?_src_=prefs;preference=uplink_loc;task=input'>[uplink_spawn_loc]</a><br>"
					if (user.client.get_exp_living(TRUE) >= PLAYTIME_VETERAN)
						dat += "<h3>Gamer Cloak</h3>"
						dat += "<a href ='?_src_=prefs;preference=playtime_reward_cloak'>[(playtime_reward_cloak) ? "Enabled" : "Disabled"]</a><br>"
					dat += "</td>"

					dat += APPEARANCE_CATEGORY_COLUMN
					var/use_skintones = pref_species.use_skintones
					if(use_skintones)
						dat += "<h3>Skin Tone</h3>"

						dat += "<a href='?_src_=prefs;preference=s_tone;task=input'>[skin_tone]</a><br>"

					dat += "<h3>Primary Color</h3>"
					dat += "<a href='?_src_=prefs;preference=mutant_color;task=input'><span class='color_holder_box' style='background-color:#[features["mcolor"]]'></span></a><br>"

					dat += "<h3>Secondary Color</h3>"
					dat += "<a href='?_src_=prefs;preference=mutant_color2;task=input'><span class='color_holder_box' style='background-color:#[features["mcolor2"]]'></span></a><br>"

					dat += "<h3>Tertiary Color</h3>"
					dat += "<a href='?_src_=prefs;preference=mutant_color3;task=input'><span class='color_holder_box' style='background-color:#[features["mcolor3"]]'></span></a><br>"

					if(istype(pref_species, /datum/species/ethereal)) //not the best thing to do tbf but I dont know whats better.

						dat += "<h3>Ethereal Color</h3>"

						dat += "<a href='?_src_=prefs;preference=color_ethereal;task=input'><span class='color_holder_box' style='background-color:#[features["ethcolor"]]'></span></a><br>"

					if((EYECOLOR in pref_species.species_traits) && !(NOEYESPRITES in pref_species.species_traits))
						dat += "<h3>Eye Color</h3>"
						dat += "R<a href='?_src_=prefs;preference=right_eye;task=input'><span class='color_holder_box' style='background-color:#[right_eye_color]'></span></a>"
						dat += "L<a href='?_src_=prefs;preference=left_eye;task=input'><span class='color_holder_box' style='background-color:#[left_eye_color]'></span></a><br>"
						dat += "</td>"

					if(HAIR in pref_species.species_traits)
						dat += APPEARANCE_CATEGORY_COLUMN

						dat += "<h3>Hairstyle</h3>"

						dat += "<a href='?_src_=prefs;preference=hairstyle;task=input'>[hairstyle]</a>"
						dat += "<a href='?_src_=prefs;preference=previous_hairstyle;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hairstyle;task=input'>&gt;</a><br>"
						dat += "<a href='?_src_=prefs;preference=hair;task=input'><span class='color_holder_box' style='background-color:#[hair_color]'></span></a><br>"

						dat += "<h3>Facial Hairstyle</h3>"

						dat += "<a href='?_src_=prefs;preference=facial_hairstyle;task=input'>[facial_hairstyle]</a>"
						dat += "<a href='?_src_=prefs;preference=previous_facehairstyle;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_facehairstyle;task=input'>&gt;</a><br>"
						dat += "<br><a href='?_src_=prefs;preference=facial;task=input'><span class='color_holder_box' style='background-color:#[facial_hair_color]'></span></a><br>"
						dat += "</td>"

					//Mutant stuff
					var/mutant_category = 0

					var/list/generic_cache = GLOB.generic_accessories
					for(var/key in mutant_bodyparts)
						if(!generic_cache[key]) //This means that we have a mutant bodypart that shouldnt be bundled here (genitals)
							continue
						if(!mutant_category)
							dat += APPEARANCE_CATEGORY_COLUMN

						dat += "<h3>[generic_cache[key]]</h3>"

						dat += print_bodypart_change_line(key)

						dat += "<BR>"

						mutant_category++
						if(mutant_category >= MAX_MUTANT_ROWS)
							dat += "</td>"
							mutant_category = 0

					if(mutant_category)
						dat += "</td>"
						mutant_category = 0

					//character preview
					dat += "<td valign='top' halign='right' width='20%' max-width='20%'>"
					dat += "<center>"
					dat += "<h3>Preview</h3>"
					dat += "<div style='background-color: #13171C; border: 2px solid #001a33;'>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_JOB]' [preview_pref == PREVIEW_PREF_JOB ? "class='linkOn'" : ""]>[PREVIEW_PREF_JOB]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_LOADOUT]' [preview_pref == PREVIEW_PREF_LOADOUT ? "class='linkOn'" : ""]>[PREVIEW_PREF_LOADOUT]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_NAKED]' [preview_pref == PREVIEW_PREF_NAKED ? "class='linkOn'" : ""]>[PREVIEW_PREF_NAKED]</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_background'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_background'>Background</a>"
					dat += "<a href='?_src_=prefs;preference=next_background'>&gt;</a>"
					dat += "<br>"
					dat += "<img src='previewicon[preview_dir].gif' width=96 height=96>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=reload_preview'>Reload Preview</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_preview_dir'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_preview_dir'>Direction</a>"
					dat += "<a href='?_src_=prefs;preference=next_preview_dir'>&gt;</a>"
					dat += "</center>"
					dat += "</div>"
					//genitals
					if(ORGAN_SLOT_PENIS in GLOB.genital_sets[genitals])
						dat += "<h3>Penis</h3>"
						dat += print_bodypart_change_line("penis")
						var/penis_name = LAZYACCESSASSOC(mutant_bodyparts, "penis", MUTANT_INDEX_NAME)
						if(penis_name != "None")
							dat += "<br><b>Length:</b> <a href='?_src_=prefs;key=["penis"];preference=penis_size;task=change_genitals'>[features["penis_size"]]</a>cm."
							dat += "<br><b>Girth:</b> <a href='?_src_=prefs;key=["penis"];preference=penis_girth;task=change_genitals'>[features["penis_girth"]]</a>cm circumference."
							dat += "<br><b>Sheath:</b> <a href='?_src_=prefs;key=["penis"];preference=penis_sheath;task=change_genitals'>[features["penis_sheath"]]</a>"
					if(ORGAN_SLOT_TESTICLES in GLOB.genital_sets[genitals])
						dat += "<h3>Testicles</h3>"
						dat += print_bodypart_change_line("testicles")
						var/balls_name = LAZYACCESSASSOC(mutant_bodyparts, "testicles", MUTANT_INDEX_NAME)
						if(balls_name != "None")
							var/named_size = translate_bollock_size(features["balls_size"])
							dat += "<br><b>Size:</b> <a href='?_src_=prefs;key=["testicles"];preference=balls_size;task=change_genitals'>[named_size]</a>"
					if(ORGAN_SLOT_VAGINA in GLOB.genital_sets[genitals])
						dat += "<h3>Vagina</h3>"
						dat += print_bodypart_change_line("vagina")
					if(ORGAN_SLOT_BREASTS in GLOB.genital_sets[genitals])
						dat += "<h3>Breasts</h3>"
						dat += print_bodypart_change_line("breasts")
						var/breasts_name = LAZYACCESSASSOC(mutant_bodyparts, "breasts", MUTANT_INDEX_NAME)
						if(breasts_name != "None")
							var/named_size = translate_jug_size(features["breasts_size"])
							var/named_lactation = (features["breasts_lactation"]) ? "Yes" : "No"
							dat += "<br><b>Size:</b> <a href='?_src_=prefs;key=["breasts"];preference=breasts_size;task=change_genitals'>[named_size]</a>"
							dat += "<br><b>Can Lactate:</b> <a href='?_src_=prefs;key=["breasts"];preference=breasts_lactation;task=change_genitals'>[named_lactation]</a>"
					if(ORGAN_SLOT_WOMB in GLOB.genital_sets[genitals])
						dat += "<h3>Womb</h3>"
						dat += print_bodypart_change_line("womb")
					dat += "</td>"

					dat += "</tr></table>"

				if(PREF_SUBTAB_MARKINGS) //Markings
					dat += "Use a <b>markings preset</b>: <a href='?_src_=prefs;preference=use_preset;task=change_marking'>Choose</a>  "
					dat += "<table width='100%' align='center'>"
					dat += " Primary:<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a>"
					dat += " Secondary:<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color2;task=input'>Change</a>"
					dat += " Tertiary:<span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color3;task=input'>Change</a>"
					dat += "</table>"
					dat += "<table width='100%'>"
					dat += "<td valign='top' width='20%'>"
					var/iterated_markings = 0
					for(var/zone in GLOB.marking_zones)
						var/named_zone = capitalize_like_old_man(parse_zone(zone))
						dat += "<center><h3>[named_zone]</h3></center>"
						dat += "<table align='center'; width='100%'; height='100px'; style='background-color:#13171C;border: 2px solid #001a33;'>"
						dat += "<tr style='vertical-align:top'>"
						dat += "<td width=10%><font size=2> </font></td>"
						dat += "<td width=6%><font size=2> </font></td>"
						dat += "<td width=25%><font size=2> </font></td>"
						dat += "<td width=44%><font size=2> </font></td>"
						dat += "<td width=15%><font size=2> </font></td>"
						dat += "</tr>"

						if(body_markings[zone])
							for(var/key in body_markings[zone])
								var/datum/body_marking/BD = GLOB.body_markings[key]
								var/can_move_up = " "
								var/can_move_down = " "
								var/color_line = " "
								var/current_index = LAZYFIND(body_markings[zone], key)
								if(BD.always_color_customizable || allow_advanced_colors)
									var/color = body_markings[zone][key]
									color_line = "<a href='?_src_=prefs;name=[key];key=[zone];preference=reset_color;task=change_marking'>R</a>"
									color_line += "<a href='?_src_=prefs;name=[key];key=[zone];preference=change_color;task=change_marking'><span class='color_holder_box' style='background-color:["#[color]"]'></span></a>"
								if(current_index < length(body_markings[zone]))
									can_move_down = "<a href='?_src_=prefs;name=[key];key=[zone];preference=marking_move_down;task=change_marking'>Down</a>"
								if(current_index > 1)
									can_move_up = "<a href='?_src_=prefs;name=[key];key=[zone];preference=marking_move_up;task=change_marking'>Up</a>"
								dat += "<tr style='vertical-align:top;'>"
								dat += "<td>[can_move_up]</td>"
								dat += "<td>[can_move_down]</td>"
								dat += "<td><a href='?_src_=prefs;name=[key];key=[zone];preference=change_marking;task=change_marking'>[key]</a></td>"
								dat += "<td>[color_line]</td>"
								dat += "<td><a href='?_src_=prefs;name=[key];key=[zone];preference=remove_marking;task=change_marking'>Remove</a></td>"
								dat += "</tr>"

						if(!(body_markings[zone]) || body_markings[zone].len < MAXIMUM_MARKINGS_PER_LIMB)
							dat += "<tr style='vertical-align:top;'>"
							dat += "<td> </td>"
							dat += "<td> </td>"
							dat += "<td> </td>"
							dat += "<td> </td>"
							dat += "<td><a href='?_src_=prefs;key=[zone];preference=add_marking;task=change_marking'>Add</a></td>"
							dat += "</tr>"

						dat += "</table>"

						iterated_markings += 1
						if(iterated_markings >= 3)
							dat += "</td>"
							dat += "<td valign='top' width='20%'>"
							iterated_markings = 0

					if(iterated_markings != 0)
						dat += "</td>"
						iterated_markings = 0

					//character preview
					dat += "<td valign='top' halign='right' width='20%' max-width='20%'>"
					dat += "<center>"
					dat += "<h3>Preview</h3>"
					dat += "<div style='background-color: #13171C; border: 2px solid #001a33;'>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_JOB]' [preview_pref == PREVIEW_PREF_JOB ? "class='linkOn'" : ""]>[PREVIEW_PREF_JOB]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_LOADOUT]' [preview_pref == PREVIEW_PREF_LOADOUT ? "class='linkOn'" : ""]>[PREVIEW_PREF_LOADOUT]</a>"
					dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_NAKED]' [preview_pref == PREVIEW_PREF_NAKED ? "class='linkOn'" : ""]>[PREVIEW_PREF_NAKED]</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_background'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_background'>Background</a>"
					dat += "<a href='?_src_=prefs;preference=next_background'>&gt;</a>"
					dat += "<br>"
					dat += "<img src='previewicon[preview_dir].gif' width=96 height=96>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=reload_preview'>Reload Preview</a>"
					dat += "<br>"
					dat += "<a href='?_src_=prefs;preference=previous_preview_dir'>&lt;</a>"
					dat += "<a href='?_src_=prefs;preference=select_preview_dir'>Direction</a>"
					dat += "<a href='?_src_=prefs;preference=next_preview_dir'>&gt;</a>"
					dat += "</center>"
					dat += "</div>"
					dat += "</td>"

					dat += "</tr></table>"
				if(PREF_SUBTAB_BACKGROUND) //Background
					dat += "<table width='100%'>"
					dat += "<tr>"
					dat += "<td width='21%'></td>"
					dat += "<td width='70%'></td>"
					dat += "<td width='9%'></td>"
					dat += "</tr>"
					var/even = FALSE
					for(var/cultural_thing in ALL_CULTURE_TYPES)
						even = !even
						var/datum/cultural_info/cult
						var/prefix
						var/more = FALSE
						switch(cultural_thing)
							if(CULTURE_BIRTHSIGN)
								cult = GLOB.culture_birthsigns[pref_birthsign]
								prefix = "Birthsign"
								more = birthsign_more_info
						var/cult_desc
						if(more || length(cult.description) <= 157)
							cult_desc = cult.description
						else
							cult_desc = "[copytext(cult.description, 1, 157)]..."
						dat += "<tr style='background-color:[even ? "#13171C" : "#19232C"];border: 2px solid #001a33;'>"
						dat += "<td valign='top'><b>[prefix]:</b> <a href='?_src_=prefs;preference=cultural_info_change;info=[cultural_thing];task=input'>[cult.name]</a><span style='color: #AAAAAA;'><b>[cult.get_extra_desc(more)]</b></span></td>"
						dat += "<td><i>[cult_desc]</i></td>"
						dat += "<td valign='top'><a href='?_src_=prefs;preference=cultural_info_toggle;info=[cultural_thing];task=input'>[more ? "Show Less" : "Show More"]</a></td>"
						dat += "</tr>"
					dat += "</table>"
					dat += "<table width='100%'><tr>"
					dat += "<td valign='top' width=33%>"
					dat += "<center><h2>Languages</h2></center>"
					dat += "<b>Linguistic points: [get_linguistic_points()]</b>"
					for(var/language_path in languages)
						var/datum/language/lang_datum = language_path
						dat += "<br>[initial(lang_datum.name)] - [languages[language_path] == LANGUAGE_SPOKEN ? "Spoken" : "Understood" ]"
					dat += "<br><a href='?_src_=prefs;preference=language_button;task=input'>Change Languages...</a>"
					dat += "<center><h2>Foods</h2></center>"
					dat += "<b>Current Likings ([LAZYLEN(foodlikes)]/[max_foodlikes]):</b> [LAZYLEN(foodlikes) ? foodlikes.Join(", ") : "None"]"
					dat += "<br><b>Current Dislikings ([LAZYLEN(fooddislikes)]/[max_fooddislikes]):</b> [LAZYLEN(fooddislikes) ? fooddislikes.Join(", ") : "None"]"
					dat += "<br><a href='?_src_=prefs;preference=food;task=menu'>Configure Foods</a>"
					if(CONFIG_GET(flag/roundstart_traits))
						dat += "<center><h2>Quirks</h2></center>"
						dat += "<b>Current Quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]"
						dat += "<br><a href='?_src_=prefs;preference=trait;task=menu'>Configure Quirks</a>"
					dat += "</td>"
					dat += "<td valign='top' width=33%>"
					dat += "<center><h2>Records</h2></center>"
					dat += "<h2>General</h2>"
					dat += "<a href='?_src_=prefs;preference=general_record;task=input'><b>Set general record</b></a><br>"
					if(length(general_record) <= 40)
						if(!length(general_record))
							dat += "\[...\]"
						else
							dat += "[html_encode(general_record)]"
					else
						dat += "[copytext(html_encode(general_record), 1, 40)]..."
					dat += "<br>"


					dat += "<h2>Medical</h2>"
					dat += "<a href='?_src_=prefs;preference=medical_record;task=input'><b>Set medical record</b></a><br>"
					if(length(medical_record) <= 40)
						if(!length(medical_record))
							dat += "\[...\]"
						else
							dat += "[html_encode(medical_record)]"
					else
						dat += "[copytext(html_encode(medical_record), 1, 40)]..."
					dat += "<br>"


					dat += "<h2>Security</h2>"
					dat += "<a href='?_src_=prefs;preference=security_record;task=input'><b>Set security record</b></a><br>"
					if(length(security_record) <= 40)
						if(!length(security_record))
							dat += "\[...\]"
						else
							dat += "[html_encode(security_record)]"
					else
						dat += "[copytext(html_encode(security_record), 1, 40)]..."
					dat += "<br>"
					dat += "</td>"


					dat += "<td valign='top' width=33%>"
					dat += "<center><h2>Information</h2></center>"
					dat += "<h2>Background</h2>"
					dat += "<a href='?_src_=prefs;preference=background_info;task=input'><b>Set background information</b></a><br>"
					if(length(background_info) <= 40)
						if(!length(background_info))
							dat += "\[...\]"
						else
							dat += "[html_encode(background_info)]"
					else
						dat += "[copytext(html_encode(background_info), 1, 40)]..."
					dat += "<h2>Exploitable</h2>"
					dat += "<a href='?_src_=prefs;preference=exploitable_info;task=input'><b>Set exploitable information</b></a><br>"
					if(length(exploitable_info) <= 40)
						if(!length(exploitable_info))
							dat += "\[...\]"
						else
							dat += "[html_encode(exploitable_info)]"
					else
						dat += "[copytext(html_encode(exploitable_info), 1, 40)]..."
					dat += "</td>"
					dat += "</tr></table>"
				if(PREF_SUBTAB_LOADOUT) //Loadout
					dat += "<center>"
					for(var/category in GLOB.loadout_category_to_subcategory_to_items)
						dat += "<a href='?_src_=prefs;preference=loadout_cat;tab=[category]' [loadout_category == category ? "class='linkOn'" : ""]>[category]</a> "
					dat += "</center>"
					dat += "<hr>"
					if(loadout_category != "")
						dat += "<center>"
						for(var/subcategory in GLOB.loadout_category_to_subcategory_to_items[loadout_category])
							dat += "<a href='?_src_=prefs;preference=loadout_subcat;tab=[subcategory]' [loadout_subcategory == subcategory ? "class='linkOn'" : ""]>[subcategory]</a> "
						dat += "</center>"
						dat += "<hr>"
						if(loadout_subcategory != "")
							var/list/item_names = GLOB.loadout_category_to_subcategory_to_items[loadout_category][loadout_subcategory]

							dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C;;border: 2px solid #001a33;'>"
							dat += "<tr style='vertical-align:top'>"
							dat += "<td width=18%><font size=2><b>Name</b></font></td>"
							dat += "<td width=20%><font size=2> </font></td>"
							dat += "<td width=40%><font size=2><b>Description</b></font></td>"
							dat += "<td width=17%><font size=2><b>Restrictions</b></font></td>"
							dat += "<td width=5%><font size=2><center><b>Cost</b></center></font></td>"
							dat += "</tr>"
							var/even = FALSE
							for(var/path in item_names)
								var/datum/loadout_item/LI = GLOB.loadout_items[path]
								if(LI.ckeywhitelist && !(user.ckey in LI.ckeywhitelist))
									continue
								var/background_cl = "#23273C"
								if(even)
									background_cl = "#17191C"
								even = !even
								var/loadout_button_class
								var/customization_button = ""
								if(loadout[LI.path]) //We have this item purchased, but we can sell it
									loadout_button_class = "href='?_src_=prefs;task=change_loadout;item=[path]' class='linkOn'"
									var/custom_info = loadout[LI.path]
									switch(LI.extra_info)
										if(LOADOUT_INFO_ONE_COLOR)
											customization_button = "<center><span style='border: 1px solid #161616; background-color: ["#[custom_info]"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;task=change_loadout_customization;item=[path]'>Change</a></center>"
										if(LOADOUT_INFO_THREE_COLOR)
											var/list/color_list = splittext(custom_info, "|")
											if(length(color_list) != 3)
												stack_trace("WARNING! Loadout item information of [LI.name] for ckey [user.ckey] has invalid amount of entries.")
												continue
											customization_button += "<center><span style='border: 1px solid #161616; background-color: ["#[color_list[1]]"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;task=change_loadout_customization;item=[path];color_slot=1'>Change</a></center>"
											customization_button += "<center><span style='border: 1px solid #161616; background-color: ["#[color_list[2]]"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;task=change_loadout_customization;item=[path];color_slot=2'>Change</a></center>"
											customization_button += "<center><span style='border: 1px solid #161616; background-color: ["#[color_list[3]]"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;task=change_loadout_customization;item=[path];color_slot=3'>Change</a></center>"
										if(LOADOUT_INFO_STYLE)
											customization_button = "" //TODO
								//We check for whether the item is donator only, and if the person isn't donator, then check cost
								else if(LI.cost > loadout_points) //We cannot afford this item
									loadout_button_class = "class='linkOff'"
								else //We can buy it
									loadout_button_class = "href='?_src_=prefs;task=change_loadout;item=[path]'"
								if(!loadout[LI.path]) //Let the user know if something is colorable, so we can avoid mentioning it in the titles
									switch(LI.extra_info)
										if(LOADOUT_INFO_ONE_COLOR)
											customization_button = "<i>Colorable</i>"
										if(LOADOUT_INFO_THREE_COLOR)
											customization_button += "<i>Polychromic</i>"
										if(LOADOUT_INFO_STYLE)
											customization_button = "" //TODO
								dat += "<tr style='vertical-align:top; background-color: [background_cl];'>"
								dat += "<td><font size=2><a [loadout_button_class]>[LI.name]</a></font></td>"
								dat += "<td><font size=2>[customization_button]</font></td>"
								dat += "<td><font size=2><i>[LI.description]</i></font></td>"
								dat += "<td><font size=2><i>[LI.restricted_desc]</i></font></td>"
								dat += "<td><font size=2><center>[LI.cost]</center></font></td>"
								dat += "</tr>"

							dat += "</table>"
				if(PREF_SUBTAB_AUGMENT) //Augmentations
					if(!pref_species.can_augmentation)
						dat += "Sorry, but your species doesn't support augmentations!"
					else if(!SSquirks || !SSquirks.quirks.len)
						dat += "The quirk subsystem is still initializing! Try again in a minute."
					else
						dat += "<table width='100%'>"
						dat += "<tr>"
						for(var/category_name in GLOB.augment_categories_to_slots)
							dat += "<td valign='top' width='25%'>"
							dat += "<h2>[category_name]:</h2>"
							var/list/slot_list = GLOB.augment_categories_to_slots[category_name]
							for(var/slot_name in slot_list)
								var/link = "href='?_src_=prefs;task=augment_slot;slot=[slot_name]'"
								var/datum/augment_item/chosen_item
								if(augments[slot_name])
									chosen_item = GLOB.augment_items[augments[slot_name]]
								if(chosen_augment_slot && chosen_augment_slot == slot_name)
									link = "class='linkOn'"
								var/print_name = ""
								if(chosen_item)
									print_name = chosen_item.name
									var/font_color = "#AAAAFF"
									if(chosen_item.cost != 0)
										font_color = chosen_item.cost > 0 ? "#AAFFAA" : "#FFAAAA"
									print_name = "<span style='color: [font_color];'>[print_name]</span>"
								dat += "<table align='center'; width='100%'; height='100px'; style='background-color:#13171C'>"
								dat += "<tr style='vertical-align:top'><td width='100%' style='background-color:#23273C'>"
								dat += "<a [link]>[slot_name]</a>: [print_name]"
								dat += "</td></tr>"
								if(category_name == AUGMENT_CATEGORY_LIMBS && chosen_item)
									var/datum/augment_item/limb/chosen_limb = chosen_item
									var/print_style = "<span style='color: #999999;'>None</font>"
									if(augment_limb_styles[slot_name])
										print_style = augment_limb_styles[slot_name]
									if(chosen_limb.uses_robotic_styles)
										dat += "<tr style='vertical-align:top'><td width='100%' style='background-color: #16274C'>"
										dat += "<a href='?_src_=prefs;task=augment_style;slot=[slot_name]'>Style</a>: [print_style]"
										dat += "</td></tr>"
								dat += "<tr style='vertical-align:top'><td width='100%' height='100%'>"
								dat += "[chosen_item ? "<i>[chosen_item.description]</i>" : ""]"
								dat += "</td></tr>"
								dat += "</table>"
							dat += "</td>"

						dat += "<td valign='top' width='25%'>"
						if(chosen_augment_slot)
							var/list/augment_list = GLOB.augment_slot_to_items[chosen_augment_slot]
							if(augment_list)
								dat += "<table width=100%; style='background-color:#13171C'>"
								dat += "<h2>[chosen_augment_slot]</h2>"
								dat += "<tr style='vertical-align:top;background-color:#23273C'>"
								dat += "<td width=33%><b>Name</b></td>"
								dat += "<td width=7%><b>Cost</b></td>"
								dat += "<td width=60%><b>Description</b></td>"
								dat += "</tr>"
								var/even = FALSE
								for(var/type_thing in augment_list)
									var/datum/augment_item/aug_datum = GLOB.augment_items[type_thing]
									var/datum/augment_item/current
									even = !even
									if(augments[chosen_augment_slot])
										current = GLOB.augment_items[augments[chosen_augment_slot]]
									var/aug_link = "class='linkOff'"
									var/name_print = aug_datum.name
									if(current == aug_datum)
										aug_link = "class='linkOn' href='?_src_=prefs;task=set_augment;type=[type_thing]'"
										name_print = "[name_print] (Remove)"
									else if(CanBuyAugment(aug_datum, current))
										aug_link = "href='?_src_=prefs;task=set_augment;type=[type_thing]'"
									dat += "<tr style='background-color:[even ? "#13171C" : "#19232C"]'>"
									dat += "<td><b><a [aug_link]>[name_print]</a></b></td>"
									var/font_color = "#AAAAFF"
									if(aug_datum.cost != 0)
										font_color = aug_datum.cost > 0 ? "#AAFFAA" : "#FFAAAA"
									dat += "<td><center><span style='color: [font_color];'>[aug_datum.cost]</font></center></td>"
									dat += "<td><i>[aug_datum.description]</i></td>"
									dat += "</tr>"
								dat += "</table>"
						dat += "</td>"

						//character preview
						dat += "<td valign='top' halign='right' width='20%' max-width='20%'>"
						dat += "<center>"
						dat += "<h3>Preview</h3>"
						dat += "<div style='background-color: #13171C; border: 2px solid #001a33;'>"
						dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_JOB]' [preview_pref == PREVIEW_PREF_JOB ? "class='linkOn'" : ""]>[PREVIEW_PREF_JOB]</a>"
						dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_LOADOUT]' [preview_pref == PREVIEW_PREF_LOADOUT ? "class='linkOn'" : ""]>[PREVIEW_PREF_LOADOUT]</a>"
						dat += "<a href='?_src_=prefs;preference=character_preview;tab=[PREVIEW_PREF_NAKED]' [preview_pref == PREVIEW_PREF_NAKED ? "class='linkOn'" : ""]>[PREVIEW_PREF_NAKED]</a>"
						dat += "<br>"
						dat += "<a href='?_src_=prefs;preference=previous_background'>&lt;</a>"
						dat += "<a href='?_src_=prefs;preference=select_background'>Background</a>"
						dat += "<a href='?_src_=prefs;preference=next_background'>&gt;</a>"
						dat += "<br>"
						dat += "<img src='previewicon[preview_dir].gif' width=96 height=96>"
						dat += "<br>"
						dat += "<a href='?_src_=prefs;preference=reload_preview'>Reload Preview</a>"
						dat += "<br>"
						dat += "<a href='?_src_=prefs;preference=previous_preview_dir'>&lt;</a>"
						dat += "<a href='?_src_=prefs;preference=select_preview_dir'>Direction</a>"
						dat += "<a href='?_src_=prefs;preference=next_preview_dir'>&gt;</a>"
						dat += "</center>"
						dat += "</div>"
						dat += "</td>"

						dat += "</tr></table>"

		if (PREF_TAB_GAME) // Game Preferences
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>General Settings</h2>"
			dat += "<b>UI Style:</b> <a href='?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
			dat += "<b>tgui Window Mode:</b> <a href='?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy (default)" : "Compatible (slower)"]</a><br>"
			dat += "<b>tgui Window Placement:</b> <a href='?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary monitor" : "Free (default)"]</a><br>"
			dat += "<b>Show Runechat Chat Bubbles:</b> <a href='?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Runechat message char limit:</b> <a href='?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
			dat += "<b>See Runechat for non-mobs:</b> <a href='?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>See Runechat emotes:</b> <a href='?_src_=prefs;preference=see_rc_emotes'>[see_rc_emotes ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Action Buttons:</b> <a href='?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
			dat += "<b>Hotkey mode:</b> <a href='?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Default"]</a><br>"
			dat += "<br>"
			dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
			dat += "<b>PDA Style:</b> <a href='?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
			dat += "<br>"
			dat += "<b>Ghost Ears:</b> <a href='?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Radio:</b> <a href='?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
			dat += "<b>Ghost Sight:</b> <a href='?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Whispers:</b> <a href='?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost PDA:</b> <a href='?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Law Changes:</b> <a href='?_src_=prefs;preference=ghost_laws'>[(chat_toggles & CHAT_GHOSTLAWS) ? "All Law Changes" : "No Law Changes"]</a><br>"

			if(unlock_content)
				dat += "<b>Ghost Form:</b> <a href='?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
				dat += "<B>Ghost Orbit: </B> <a href='?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"

			var/button_name = "If you see this something went wrong."
			switch(ghost_accs)
				if(GHOST_ACCS_FULL)
					button_name = GHOST_ACCS_FULL_NAME
				if(GHOST_ACCS_DIR)
					button_name = GHOST_ACCS_DIR_NAME
				if(GHOST_ACCS_NONE)
					button_name = GHOST_ACCS_NONE_NAME

			dat += "<b>Ghost Accessories:</b> <a href='?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"

			switch(ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING)
					button_name = GHOST_OTHERS_THEIR_SETTING_NAME
				if(GHOST_OTHERS_DEFAULT_SPRITE)
					button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
				if(GHOST_OTHERS_SIMPLE)
					button_name = GHOST_OTHERS_SIMPLE_NAME

			dat += "<b>Ghosts of Others:</b> <a href='?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
			dat += "<br>"

			dat += "<b>Broadcast Login/Logout:</b> <a href='?_src_=prefs;preference=broadcast_login_logout'>[broadcast_login_logout ? "Broadcast" : "Silent"]</a><br>"
			dat += "<b>See Login/Logout Messages:</b> <a href='?_src_=prefs;preference=hear_login_logout'>[(chat_toggles & CHAT_LOGIN_LOGOUT) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"

			dat += "<b>Income Updates:</b> <a href='?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"

			dat += "<b>FPS:</b> <a href='?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"

			dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
			switch (parallax)
				if (PARALLAX_LOW)
					dat += "Low"
				if (PARALLAX_MED)
					dat += "Medium"
				if (PARALLAX_INSANE)
					dat += "Insane"
				if (PARALLAX_DISABLE)
					dat += "Disabled"
				else
					dat += "High"
			dat += "</a><br>"

			dat += "<b>Set screentip mode:</b> <a href='?_src_=prefs;preference=screentipmode'>[screentip_pref ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Item Hover Outlines:</b> <a href='?_src_=prefs;preference=itemoutline_pref'>[itemoutline_pref ? "Enabled" : "Disabled"]</a><br>"

			dat += "<b>Ambient Occlusion:</b> <a href='?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Fit Viewport:</b> <a href='?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
			if (CONFIG_GET(string/default_view) != CONFIG_GET(string/default_view_square))
				dat += "<b>Widescreen:</b> <a href='?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled ([CONFIG_GET(string/default_view_square)])"]</a><br>"

			button_name = pixel_size
			dat += "<b>Pixel Scaling:</b> <a href='?_src_=prefs;preference=pixel_size'>[(button_name) ? "Pixel Perfect [button_name]x" : "Stretch to fit"]</a><br>"

			switch(scaling_method)
				if(SCALING_METHOD_DISTORT)
					button_name = "Nearest Neighbor"
				if(SCALING_METHOD_NORMAL)
					button_name = "Point Sampling"
				if(SCALING_METHOD_BLUR)
					button_name = "Bilinear"
			dat += "<b>Scaling Method:</b> <a href='?_src_=prefs;preference=scaling_method'>[button_name]</a><br>"

			if (CONFIG_GET(flag/maprotation))
				var/p_map = preferred_map
				if (!p_map)
					p_map = "Default"
					if (config.defaultmap)
						p_map += " ([config.defaultmap.map_name])"
				else
					if (p_map in config.maplist)
						var/datum/map_config/VM = config.maplist[p_map]
						if (!VM)
							p_map += " (No longer exists)"
						else
							p_map = VM.map_name
					else
						p_map += " (No longer exists)"
				if(CONFIG_GET(flag/preference_map_voting))
					dat += "<b>Preferred Map:</b> <a href='?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"

			dat += "</td><td width='300px' height='300px' valign='top'>"

			dat += "<h2>Special Role Settings</h2>"

			if(is_banned_from(user.ckey, ROLE_SYNDICATE))
				dat += "<font color=red><b>You are banned from antagonist roles.</b></font><br>"
				src.be_special = list()


			for (var/special_role  in GLOB.special_roles)
				if(is_banned_from(user.ckey, special_role))
					dat += "<b>Be [capitalize(special_role)]:</b> <a href='?_src_=prefs;bancheck=[special_role]'>BANNED</a><br>"
				else
					var/days_remaining = null
					if(CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
						var/days_needed = GLOB.special_roles[special_role]
						days_remaining = user.client?.get_remaining_days(days_needed)
					if(days_remaining)
						dat += "<b>Be [capitalize(special_role)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
					else
						dat += "<b>Be [capitalize(special_role)]:</b> <a href='?_src_=prefs;preference=be_special;be_special_type=[special_role]'>[(special_role in be_special) ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Midround Antagonist:</b> <a href='?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"
			dat += "</td></tr></table>"
		if(PREF_TAB_OOC) //OOC Preferences
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>OOC Settings</h2>"
			dat += "<b>Window Flashing:</b> <a href='?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Play Admin MIDIs:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play End of Round Sounds:</b> <a href='?_src_=prefs;preference=endofround_sounds'>[(toggles & SOUND_ENDOFROUND) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Combat Mode Sounds:</b> <a href='?_src_=prefs;preference=combat_mode_sound'>[(toggles & SOUND_COMBATMODE) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Announcement Sound Volume:</b> <a href='?_src_=prefs;preference=announcement_volume_level'>[announcement_volume]</a><br>"
			dat += "<b>See Pull Requests:</b> <a href='?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"

			if(user.client)
				if(unlock_content)
					dat += "<b>BYOND Membership Publicity:</b> <a href='?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"

				if(unlock_content || check_rights_for(user.client, R_ADMIN))
					dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"
				if(hearted_until)
					dat += "<a href='?_src_=prefs;preference=clear_heart'>Clear OOC Commend Heart</a><br>"

			dat += "</td>"

			if(user.client.holder)
				dat +="<td width='300px' height='300px' valign='top'>"

				dat += "<h2>Admin Settings</h2>"

				dat += "<b>Adminhelp Sounds:</b> <a href='?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Prayer Sounds:</b> <a href = '?_src_=prefs;preference=hear_prayers'>[(toggles & SOUND_PRAYERS)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Announce Login:</b> <a href='?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
				dat += "<br>"
				dat += "<b>Combo HUD Lighting:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
				dat += "<br>"
				dat += "<b>Hide Dead Chat:</b> <a href = '?_src_=prefs;preference=toggle_dead_chat'>[(chat_toggles & CHAT_DEAD)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Radio Messages:</b> <a href = '?_src_=prefs;preference=toggle_radio_chatter'>[(chat_toggles & CHAT_RADIO)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Prayers:</b> <a href = '?_src_=prefs;preference=toggle_prayers'>[(chat_toggles & CHAT_PRAYER)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Split Admin Tabs:</b> <a href = '?_src_=prefs;preference=toggle_split_admin_tabs'>[(toggles & SPLIT_ADMIN_TABS)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Ignore Being Summoned as Cult Ghost:</b> <a href = '?_src_=prefs;preference=toggle_ignore_cult_ghost'>[(toggles & ADMIN_IGNORE_CULT_GHOST)?"Don't Allow Being Summoned":"Allow Being Summoned"]</a><br>"
				dat += "<b>Briefing Officer Outfit:</b> <a href = '?_src_=prefs;preference=briefoutfit;task=input'>[brief_outfit]</a><br>"
				if(CONFIG_GET(flag/allow_admin_asaycolor))
					dat += "<br>"
					dat += "<b>ASAY Color:</b> <span style='border: 1px solid #161616; background-color: [asaycolor ? asaycolor : "#FF4500"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=asaycolor;task=input'>Change</a><br>"

				//deadmin
				dat += "<h2>Deadmin While Playing</h2>"
				var/timegate = CONFIG_GET(number/auto_deadmin_timegate)
				if(timegate)
					dat += "<b>Noted roles will automatically deadmin during the first [FLOOR(timegate / 600, 1)] minutes of the round, and will defer to individual preferences after.</b><br>"

				if(CONFIG_GET(flag/auto_deadmin_players) && !timegate)
					dat += "<b>Always Deadmin:</b> FORCED</a><br>"
				else
					dat += "<b>Always Deadmin:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_always'>[(toggles & DEADMIN_ALWAYS)?"Enabled":"Disabled"]</a><br>"
					if(!(toggles & DEADMIN_ALWAYS))
						dat += "<br>"
						if(!CONFIG_GET(flag/auto_deadmin_antagonists) || (CONFIG_GET(flag/auto_deadmin_antagonists) && !timegate))
							dat += "<b>As Antag:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_antag'>[(toggles & DEADMIN_ANTAGONIST)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Antag:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_heads) || (CONFIG_GET(flag/auto_deadmin_heads) && !timegate))
							dat += "<b>As Command:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_head'>[(toggles & DEADMIN_POSITION_HEAD)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Command:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_security) || (CONFIG_GET(flag/auto_deadmin_security) && !timegate))
							dat += "<b>As Security:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_security'>[(toggles & DEADMIN_POSITION_SECURITY)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Security:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_silicons) || (CONFIG_GET(flag/auto_deadmin_silicons) && !timegate))
							dat += "<b>As Silicon:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_silicon'>[(toggles & DEADMIN_POSITION_SILICON)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Silicon:</b> FORCED<br>"

				dat += "</td>"
			dat += "</tr></table>"
		if(PREF_TAB_KEYBINDINGS) // Custom keybindings
			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

			for (var/category in kb_categories)
				dat += "<h3>[category]</h3>"
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					if(!length(user_binds[kb.name]) || user_binds[kb.name][1] == "Unbound")
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybindings_reset'>\[Reset to default\]</a>"
			dat += "</body>"

	if(current_tab != PREF_TAB_LOBBY)
		dat += "<hr><center>"

		if(!IsGuestKey(user.key))
			dat += "<a href='?_src_=prefs;preference=load'>Undo</a> "
			dat += "<a href='?_src_=prefs;preference=save'>Save Setup</a> "

		dat += "<a href='?_src_=prefs;preference=reset_all'>Reset Setup</a>"
		dat += "</center>"

	winshow(user, "preferences_window", TRUE)
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Setup</div>", 640, 770)
	popup.set_content(dat.Join())
	popup.add_stylesheet("playeroptions", 'html/browser/playeroptions.css')
	popup.open(FALSE)
	if(isnewplayer(user))
		onclose(user, "lobbybrowser", src)
	else
		onclose(user, "preferences_window", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user, limit = 17, list/splitJobs = list("Chief Engineer"), widthPerColumn = 295, height = 620)
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(SSjob.joinable_occupations.len <= 0)
		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
	else
		HTML += "<b>Choose occupation chances</b><br>"
		HTML += "<div align='center'>Left-click to raise an occupation preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob
		var/datum/job/job
		for(var/thing in SSjob.joinable_occupations)
			job = thing
			if(!istype(job) || (!job.total_positions && !job.spawn_positions))
				continue
			index += 1
			if((index >= limit) || (job.title in splitJobs))
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			HTML += "<tr bgcolor='[job.selection_color]'><td width='60%' align='right'>"
			var/rank = job.title
			var/display_rank = job.title
			lastJob = job
			if(is_banned_from(user.ckey, rank))
				HTML += "<font color=red>[display_rank]</font></td><td><a href='?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining)
				HTML += "<font color=red>[display_rank]</font></td><td><font color=red> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \] </font></td></tr>"
				continue
			if(!job.player_old_enough(user.client))
				var/available_in_days = job.available_in_days(user.client)
				HTML += "<font color=red>[display_rank]</font></td><td><font color=red> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			if(job.has_banned_quirk(src))
				HTML += "<font color=red>[display_rank]</font></td><td><font color=red> \[BAD QUIRKS\]</font></td></tr>"
				continue
			if(job.has_banned_species(src))
				HTML += "<font color=red>[display_rank]</font></td><td><font color=red> \[BAD SPECIES\]</font></td></tr>"
				continue
			if(!job.has_required_languages(src))
				HTML += "<font color=red>[display_rank]</font></td><td><font color=red> \[BAD LANGS\]</font></td></tr>"
				continue
			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
				HTML += "<font color=orange>[display_rank]</font></td><td></td></tr>"
				continue
			if(job.job_flags & JOB_BOLD_SELECT_TEXT)//Bold head jobs
				HTML += "<b><span class='dark'>[display_rank]</span></b>"
			else
				HTML += "<span class='dark'>[display_rank]</span>"

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

			if(rank == SSjob.overflow_role)//Overflow is special
				if(job_preferences[SSjob.overflow_role] == JP_LOW)
					HTML += "<font color=green>Yes</font>"
				else
					HTML += "<font color=red>No</font>"
				HTML += "</a></td></tr>"
				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table>"

		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
		if(joblessrole == BERANDOMJOB)
			message = "Get random job if preferences unavailable"
		else if(joblessrole == RETURNTOLOBBY)
			message = "Return to lobby if preferences unavailable"
		HTML += "<center><br><a href='?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=reset'>Reset Preferences</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Occupation Preferences</div>", width, height)
	popup.set_window_options("can_close=0")
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.joinable_occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		ShowChoices(user)
		return

	if (!isnum(desiredLvl))
		to_chat(user, "<span class='danger'>UpdateJobPreference - desired level was not a number. Please notify coders!</span>")
		ShowChoices(user)
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(role == SSjob.overflow_role)
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			jpval = JP_LOW

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs()
	job_preferences = list()

/datum/preferences/proc/SetQuirks(mob/user)
	if(!SSquirks)
		to_chat(user, "<span class='danger'>The quirk subsystem is still initializing! Try again in a minute.</span>")
		return

	var/list/dat = list()
	if(!SSquirks.quirks.len)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
		dat += "<center><a href='?_src_=prefs;preference=trait;task=close'>Done</a></center><br>"
	else
		dat += "<center><b>Choose quirk setup</b></center><br>"
		dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
		Quirks are applied at roundstart and cannot normally be removed.</div>"
		dat += "<center><a href='?_src_=prefs;preference=trait;task=close'>Done</a></center>"
		dat += "<hr>"
		dat += "<center><b>Current quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"
		dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\
		<b>Quirk balance remaining:</b> [GetQuirkBalance()]</center><br>"
		for(var/V in SSquirks.quirks)
			var/datum/quirk/T = SSquirks.quirks[V]
			var/quirk_name = initial(T.name)
			var/has_quirk
			var/quirk_cost = initial(T.value) * -1
			var/lock_reason = "This trait is unavailable."
			var/quirk_conflict = FALSE
			for(var/_V in all_quirks)
				if(_V == quirk_name)
					has_quirk = TRUE
			if(initial(T.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
				lock_reason = "Mood is disabled."
				quirk_conflict = TRUE
			if(has_quirk)
				if(quirk_conflict)
					all_quirks -= quirk_name
					has_quirk = FALSE
				else
					quirk_cost *= -1 //invert it back, since we'd be regaining this amount
			if(quirk_cost > 0)
				quirk_cost = "+[quirk_cost]"
			var/font_color = "#AAAAFF"
			if(initial(T.value) != 0)
				font_color = initial(T.value) > 0 ? "#AAFFAA" : "#FFAAAA"
			if(quirk_conflict)
				dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)] \
				<font color='red'><b>LOCKED: [lock_reason]</b></font><br>"
			else
				if(has_quirk)
					dat += "<a href='?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<b><font color='[font_color]'>[quirk_name]</font></b> - [initial(T.desc)]<br>"
				else
					dat += "<a href='?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)]<br>"
		dat += "<br><center><a href='?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Quirk Preferences</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/GetQuirkBalance()
	var/bal = 0
	for(var/V in all_quirks)
		var/datum/quirk/T = SSquirks.quirks[V]
		bal -= initial(T.value)
	for(var/key in augments)
		var/datum/augment_item/aug = GLOB.augment_items[augments[key]]
		bal -= aug.cost
	return bal

/datum/preferences/proc/GetPositiveQuirkCount()
	. = 0
	for(var/q in all_quirks)
		if(SSquirks.quirk_points[q] > 0)
			.++

/datum/preferences/Topic(href, href_list, hsrc) //yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details?.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, "<span class='danger'>You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]</span>")
			return
	//save sound
	if(href_list["preference"] == "save")
		SEND_SOUND(user, savesound)
	//undo sound
	else if(href_list["preference"] == "load")
		SEND_SOUND(user, undosound)
	else if(href_list["preference"] == "reset_all")
		SEND_SOUND(user, resetsound)
	//click clack sound
	else if(href_list["preference"] || href_list["task"])
		SEND_SOUND(user, clicksound)

	if(href_list["preference"] == "job")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			if("reset")
				ResetJobs()
				SetChoices(user)
			if("random")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						if(is_banned_from(user.ckey, SSjob.overflow_role))
							joblessrole = BERANDOMJOB
						else
							joblessrole = BEOVERFLOW
					if(BEOVERFLOW)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = RETURNTOLOBBY
				SetChoices(user)
			if("setJobLevel")
				UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
			else
				SetChoices(user)
		return 1

	else if(href_list["preference"] == "trait")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			if("update")
				var/quirk = href_list["trait"]
				if(!SSquirks.quirks[quirk])
					return
				for(var/V in SSquirks.quirk_blacklist) //V is a list
					var/list/L = V
					if(!(quirk in L))
						continue
					for(var/Q in all_quirks)
						if((Q in L) && !(Q == quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
							to_chat(user, "<span class='danger'>[quirk] is incompatible with [Q].</span>")
							return
				var/value = SSquirks.quirk_points[quirk]
				var/balance = GetQuirkBalance()
				if(quirk in all_quirks)
					if(balance + value < 0)
						to_chat(user, "<span class='warning'>Refunding this would cause you to go below your balance!</span>")
						return
					all_quirks -= quirk
				else
					var/is_positive_quirk = SSquirks.quirk_points[quirk] > 0
					if(is_positive_quirk && GetPositiveQuirkCount() >= MAX_QUIRKS)
						to_chat(user, "<span class='warning'>You can't have more than [MAX_QUIRKS] positive quirks!</span>")
						return
					if(balance - value < 0)
						to_chat(user, "<span class='warning'>You don't have enough balance to gain this quirk!</span>")
						return
					all_quirks += quirk
				SetQuirks(user)
			if("reset")
				all_quirks = list()
				SetQuirks(user)
			else
				SetQuirks(user)
		return TRUE

	else if(href_list["preference"] == "food")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			if("update")
				var/food
				if(href_list["like"])
					food = href_list["like"]
					if(food in GLOB.food_tastes)
						if(!foodlikes[food])
							if(foodlikes.len < max_foodlikes)
								foodlikes[food] = GLOB.food_tastes[food]
							if(fooddislikes[food])
								fooddislikes.Remove(food)
						else
							foodlikes.Remove(food)
				if(href_list["dislike"])
					food = href_list["dislike"]
					if(food in GLOB.food_tastes)
						if(!fooddislikes[food])
							if(fooddislikes.len < max_fooddislikes)
								fooddislikes[food] = GLOB.food_tastes[food]
							if(foodlikes[food])
								foodlikes.Remove(food)
						else
							fooddislikes.Remove(food)
				if(foodlikes.len > max_foodlikes)
					foodlikes.Cut(max_foodlikes+1)
				if(fooddislikes.len > max_fooddislikes)
					foodlikes.Cut(max_foodlikes+1)
				SetFood(user)
			if("reset")
				foodlikes = list()
				fooddislikes = list()
				SetFood(user)
			else
				SetFood(user)
		return TRUE

	switch(href_list["task"])
		if("close_language")
			user << browse(null, "window=culture_lang")
			ShowChoices(user)
		if("augment_style")
			needs_update = TRUE
			var/slot_name = href_list["slot"]
			var/new_style = input(user, "Choose your character's [slot_name] augmentation style:", "Character Preference")  as null|anything in GLOB.robotic_styles_list
			if(new_style)
				if(new_style == "None")
					if(augment_limb_styles[slot_name])
						augment_limb_styles -= slot_name
				else
					augment_limb_styles[slot_name] = new_style
		if("set_augment")
			if(pref_species.can_augmentation)
				needs_update = TRUE
				var/typed_path = text2path(href_list["type"])
				var/datum/augment_item/target_aug = GLOB.augment_items[typed_path]
				var/datum/augment_item/current
				if(augments[target_aug.slot])
					current = GLOB.augment_items[augments[target_aug.slot]]
				if(current == target_aug)
					augments -= target_aug.slot
				else if(CanBuyAugment(target_aug, current))
					augments[target_aug.slot] = typed_path
		if("augment_slot")
			var/slot_name = href_list["slot"]
			chosen_augment_slot = slot_name
		if("change_loadout_customization")
			needs_update = TRUE
			var/path = text2path(href_list["item"])
			if(!loadout[path])
				return
			var/datum/loadout_item/LI = GLOB.loadout_items[path]
			switch(LI.extra_info)
				if(LOADOUT_INFO_ONE_COLOR)
					var/new_color = input(user, "Choose your item's color:", "Character Preference","#[loadout[path]]") as color|null
					if(new_color)
						if(!loadout[path])
							return
						loadout[path] = sanitize_hexcolor(new_color, 6)
				if(LOADOUT_INFO_THREE_COLOR)
					var/color_slot = text2num(href_list["color_slot"])
					if(color_slot)
						var/list/color_list = splittext(loadout[path], "|")
						var/new_color = input(user, "Choose your item's color:", "Character Preference","#[color_list[color_slot]]") as color|null
						if(new_color)
							if(!loadout[path])
								return
							color_list[color_slot] = sanitize_hexcolor(new_color, 6)
							loadout[path] = color_list.Join("|")
				if(LOADOUT_INFO_STYLE)
					return
		if("change_loadout")
			needs_update = TRUE
			var/path = text2path(href_list["item"])
			var/datum/loadout_item/LI = GLOB.loadout_items[path]
			if(loadout[path]) //We sell it!
				loadout -= path
				loadout_points += LI.cost
			else //We attempt to buy it
				if(LI.cost > loadout_points)
					return
				if(LI.ckeywhitelist && !(user.ckey in LI.ckeywhitelist) && !user.client.holder)
					return
				loadout_points -= LI.cost
				loadout[LI.path] = LI.default_customization() //As in "No extra information associated"
		if("change_marking")
			needs_update = TRUE
			switch(href_list["preference"])
				if("use_preset")
					var/action = alert(user, "Are you sure you want to use a preset (This will clear your existing markings)?", "", "Yes", "No")
					if(action && action == "Yes")
						var/list/candidates = GLOB.body_marking_sets.Copy()
						if(!mismatched_customization)
							for(var/name in candidates)
								var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
								if(BMS.recommended_species && !(pref_species.id in BMS.recommended_species))
									candidates -= name
						if(length(candidates) == 0)
							return
						var/desired_set = input(user, "Choose your new body markings:", "Character Preference") as null|anything in candidates
						if(desired_set)
							var/datum/body_marking_set/BMS = GLOB.body_marking_sets[desired_set]
							body_markings = assemble_body_markings_from_set(BMS, features, pref_species)

				if("reset_color")
					var/zone = href_list["key"]
					var/name = href_list["name"]
					if(!body_markings[zone] || !body_markings[zone][name])
						return
					var/datum/body_marking/BM = GLOB.body_markings[name]
					body_markings[zone][name] = BM.get_default_color(features, pref_species)
				if("change_color")
					var/zone = href_list["key"]
					var/name = href_list["name"]
					if(!body_markings[zone] || !body_markings[zone][name])
						return
					var/color = body_markings[zone][name]
					var/new_color = input(user, "Choose your markings color:", "Character Preference","#[color]") as color|null
					if(new_color)
						if(!body_markings[zone] || !body_markings[zone][name])
							return
						body_markings[zone][name] = sanitize_hexcolor(new_color, 6)
				if("marking_move_up")
					var/zone = href_list["key"]
					var/name = href_list["name"]
					var/list/marking_list = LAZYACCESS(body_markings, zone)
					var/current_index = LAZYFIND(marking_list, name)
					if(!current_index || --current_index < 1)
						return
					var/marking_content = marking_list[name]
					marking_list -= name
					marking_list.Insert(current_index, name)
					marking_list[name] = marking_content
				if("marking_move_down")
					var/zone = href_list["key"]
					var/name = href_list["name"]
					var/list/marking_list = LAZYACCESS(body_markings, zone)
					var/current_index = LAZYFIND(marking_list, name)
					if(!current_index || ++current_index > length(marking_list))
						return
					var/marking_content = marking_list[name]
					marking_list -= name
					marking_list.Insert(current_index, name)
					marking_list[name] = marking_content
				if("add_marking")
					var/zone = href_list["key"]
					if(!GLOB.body_markings_per_limb[zone])
						return
					var/list/possible_candidates = GLOB.body_markings_per_limb[zone].Copy()
					if(body_markings[zone])
						//To prevent exploiting hrefs to bypass the marking limit
						if(body_markings[zone].len >= MAXIMUM_MARKINGS_PER_LIMB)
							return
						//Remove already used markings from the candidates
						for(var/list/this_list in body_markings[zone])
							possible_candidates -= this_list[MUTANT_INDEX_NAME]
					if(!mismatched_customization)
						for(var/name in possible_candidates)
							var/datum/body_marking/BD = GLOB.body_markings[name]
							if((BD.recommended_species && !(pref_species.id in BD.recommended_species)))
								possible_candidates -= name

					if(possible_candidates.len == 0)
						return
					var/desired_marking = input(user, "Choose your new marking to add:", "Character Preference") as null|anything in possible_candidates
					if(desired_marking)
						var/datum/body_marking/BD = GLOB.body_markings[desired_marking]
						if(!body_markings[zone])
							body_markings[zone] = list()
						body_markings[zone][BD.name] = BD.get_default_color(features, pref_species)

				if("remove_marking")
					var/zone = href_list["key"]
					var/name = href_list["name"]
					if(!body_markings[zone] || !body_markings[zone][name])
						return
					body_markings[zone] -= name
					if(body_markings[zone].len == 0)
						body_markings -= zone
				if("change_marking")
					var/zone = href_list["key"]
					var/changing_name = href_list["name"]

					var/list/possible_candidates = GLOB.body_markings_per_limb[zone].Copy()
					if(body_markings[zone])
						//Remove already used markings from the candidates
						for(var/keyed_name in body_markings[zone])
							possible_candidates -= keyed_name
					if(!mismatched_customization)
						for(var/name in possible_candidates)
							var/datum/body_marking/BD = GLOB.body_markings[name]
							if(BD.recommended_species && !(pref_species.id in BD.recommended_species))
								possible_candidates -= name
					if(possible_candidates.len == 0)
						return
					var/desired_marking = input(user, "Choose a marking to change the current one to:", "Character Preference") as null|anything in possible_candidates
					if(desired_marking)
						if(!body_markings[zone] || !body_markings[zone][changing_name])
							return
						var/held_index = LAZYFIND(body_markings[zone], changing_name)
						var/datum/body_marking/BD = GLOB.body_markings[desired_marking]
						var/marking_content
						if(allow_advanced_colors)
							marking_content = body_markings[zone][changing_name]
						else
							marking_content = BD.get_default_color(features, pref_species)
						body_markings[zone] -= changing_name
						body_markings[zone].Insert(held_index, desired_marking)
						body_markings[zone][desired_marking] = marking_content
		if("change_genitals")
			needs_update = TRUE
			switch(href_list["preference"])
				if("breasts_size")
					var/new_size = input(user, "Choose your character's breasts size:\n(A - H)", "Character Preference") as null|anything in list("A", "B", "C", "D", "E", "F", "G", "H")
					if(new_size)
						features["breasts_size"] = detranslate_jug_size(new_size)
				if("breasts_lactation")
					features["breasts_lactation"] = !features["breasts_lactation"]
				if("penis_taur_mode")
					features["penis_taur_mode"] = !features["penis_taur_mode"]
				if("penis_size")
					var/new_length = input(user, "Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] in centimeters)", "Character Preference") as num|null
					if(new_length)
						features["penis_size"] = clamp(round(new_length, 1), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
						if(features["penis_girth"] >= new_length)
							features["penis_girth"] = new_length - 2
				if("penis_sheath")
					var/new_sheath = input(user, "Choose your penis sheath", "Character Preference") as null|anything in SHEATH_MODES
					if(new_sheath)
						features["penis_sheath"] = new_sheath
				if("penis_girth")
					var/max_girth = PENIS_MAX_GIRTH
					if(features["penis_size"] >= max_girth)
						max_girth = features["penis_size"]
					var/new_girth = input(user, "Choose your penis girth:\n([PENIS_MIN_GIRTH]-[max_girth] (based on length) in centimeters)", "Character Preference") as num|null
					if(new_girth)
						features["penis_girth"] = clamp(round(new_girth, 1), PENIS_MIN_GIRTH, max_girth)
				if("balls_size")
					var/new_size = input(user, "Choose your character's balls size:\n(Small - Balls of Steel Sized)", "Character Preference") as null|anything in list("Small", "Average Sized", "Big", "Huge", "Balls of Steel Sized")
					if(new_size)
						features["balls_size"] = detranslate_bollock_size(new_size)
		if("change_bodypart")
			needs_update = TRUE
			switch(href_list["preference"])
				if("change_name")
					var/key = href_list["key"]
					if(!LAZYACCESS(mutant_bodyparts, key))
						return
					var/new_name
					if(key in list("penis", "testicles", "breasts", "vagina", "womb"))
						if(mismatched_customization)
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in (accessory_list_of_key_for_species(key, pref_species, TRUE, parent.ckey) - "None")
						else
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in (accessory_list_of_key_for_species(key, pref_species, FALSE, parent.ckey) - "None")
					else
						if(mismatched_customization)
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in accessory_list_of_key_for_species(key, pref_species, TRUE, parent.ckey)
						else
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in accessory_list_of_key_for_species(key, pref_species, FALSE, parent.ckey)
					if(new_name && mutant_bodyparts[key])
						mutant_bodyparts[key][MUTANT_INDEX_NAME] = new_name
						validate_color_keys_for_part(key)
						if(!allow_advanced_colors)
							var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][new_name]
							mutant_bodyparts[key][MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)
				if("change_color")
					var/key = href_list["key"]
					if(!LAZYACCESS(mutant_bodyparts, key))
						return
					var/list/colorlist = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_COLOR)
					var/index = text2num(href_list["color_index"])
					if(colorlist.len < index)
						return
					var/new_color = input(user, "Choose your character's [key] color:", "Character Preference","#[colorlist[index]]") as color|null
					if(new_color)
						colorlist[index] = sanitize_hexcolor(new_color, 6)
				if("reset_color")
					var/key = href_list["key"]
					if(!LAZYACCESS(mutant_bodyparts, key))
						return
					var/datum/sprite_accessory/SA = LAZYACCESSASSOC(GLOB.sprite_accessories, key, mutant_bodyparts[key][MUTANT_INDEX_NAME])
					if(!SA)
						return
					mutant_bodyparts[key][MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)
				if("reset_all_colors")
					var/action = alert(user, "Are you sure you want to reset all colors?", "", "Yes", "No")
					if(action == "Yes")
						reset_colors()

		if("random")
			needs_update = TRUE
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = rand(AGE_MIN, AGE_MAX)
				if("hair")
					hair_color = random_short_color()
				if("hairstyle")
					hairstyle = random_hairstyle(gender)
				if("facial")
					facial_hair_color = random_short_color()
				if("facial_hairstyle")
					facial_hairstyle = random_facial_hairstyle(gender)
				if("underwear")
					underwear = random_underwear(gender)
				if("underwear_color")
					underwear_color = random_short_color()
				if("left_eye")
					left_eye_color = random_eye_color()
				if("right_eye")
					right_eye_color = random_eye_color()
				if("s_tone")
					set_skin_tone(random_skin_tone())
				if("species")
					random_species()
				if("bag")
					backpack = pick(GLOB.backpacklist)
				if("suit")
					jumpsuit_style = pick(GLOB.jumpsuitlist)
				if("all")
					apply_character_randomization_prefs()

		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])


			switch(href_list["preference"])
				if("set_species")
					needs_update = TRUE
					var/species = href_list["selected_species"]
					var/newtype = GLOB.species_list[species]
					if(newtype)
						set_new_species(newtype)
						user << browse(null, "window=species_menu")

				if("close_species")
					user << browse(null, "window=species_menu")

				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("name")
					var/new_name = input(user, "Choose your character's name:", "Character Preference")  as text|null
					if(new_name)
						//kick for shit name
						if(new_name && (config.name_filter && findtext(new_name, config.name_filter) || CHAT_FILTER_CHECK(new_name)))
							parent.bruh_and_kick()
							return
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")

				if("age")
					var/new_age = input(user, "Choose your character's age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference") as num|null
					if(new_age)
						age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)

				if("dominant_hand")
					var/new_dominant = input(user, "Choose your character's handedness", "Dominant Hand", "[parse_handedness(handedness)]") as anything in list("Ambidextrous", "Right Handed", "Left Handed")
					switch(new_dominant)
						if("Right Handed")
							handedness = RIGHT_HANDED
						if("Left Handed")
							handedness = LEFT_HANDED
						if("Ambidextrous")
							handedness = AMBIDEXTROUS

				if("blood_type")
					var/new_blood = input(user, "Choose your character's blood type", "Blood Type", blood_type) as anything in (get_safe_blood("AB+") | "Random")
					if(new_blood)
						blood_type = new_blood

				if("flavor_text")
					var/msg = input(usr, "Set the flavor text in your 'examine' verb. This is for describing what people can tell by looking at your character.", "Flavor Text", features["flavor_text"]) as message|null //Skyrat edit, removed stripped_multiline_input()
					if(!isnull(msg))
						features["flavor_text"] = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("general_record")
					var/msg = input(usr, "Set your general record. This is more or less public information, available from security, medical and command consoles", "General Record", general_record) as message|null
					if(!isnull(msg))
						general_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("medical_record")
					var/msg = input(usr, "Set your medical record. ", "Medical Record", medical_record) as message|null
					if(!isnull(msg))
						medical_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("security_record")
					var/msg = input(usr, "Set your security record. ", "Medical Record", security_record) as message|null
					if(!isnull(msg))
						security_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("background_info")
					var/msg = input(usr, "Set your background information. (Where you come from, which culture were you raised in and why you are working here etc.)", "Background Info", background_info) as message|null
					if(!isnull(msg))
						background_info = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("exploitable_info")
					var/msg = input(usr, "Set your exploitable information. This is sensitive informations that antagonists may get to see, recommended for better roleplay experience", "Exploitable Info", exploitable_info) as message|null
					if(!isnull(msg))
						exploitable_info = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LENGTH)

				if("uses_skintones")
					needs_update = TRUE
					features["uses_skintones"] = !features["uses_skintones"]

				if("change_arousal_preview")
					var/list/gen_arous_trans = list("Not aroused" = AROUSAL_NONE,
						"Partly aroused" = AROUSAL_PARTIAL,
						"Very aroused" = AROUSAL_FULL
						)
					var/new_arousal = input(user, "Choose your character's arousal:", "Character Preference")  as null|anything in gen_arous_trans
					if(new_arousal)
						arousal_preview = gen_arous_trans[new_arousal]
						needs_update = TRUE

				if("hair")
					needs_update = TRUE
					var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
					if(new_hair)
						hair_color = sanitize_hexcolor(new_hair, 6)

				if("hairstyle")
					needs_update = TRUE
					var/new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_list
					if(new_hairstyle)
						hairstyle = new_hairstyle

				if("next_hairstyle")
					needs_update = TRUE
					if (gender == MALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(gender == FEMALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

				if("previous_hairstyle")
					needs_update = TRUE
					if (gender == MALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(gender == FEMALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

				if("facial")
					needs_update = TRUE
					var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
					if(new_facial)
						facial_hair_color = sanitize_hexcolor(new_facial, 6)

				if("facial_hairstyle")
					needs_update = TRUE
					var/new_facial_hairstyle
					if(gender == MALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_male_list
					else if(gender == FEMALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_female_list
					else
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_list
					if(new_facial_hairstyle)
						facial_hairstyle = new_facial_hairstyle

				if("next_facehairstyle")
					needs_update = TRUE
					if (gender == MALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if(gender == FEMALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("previous_facehairstyle")
					needs_update = TRUE
					if (gender == MALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if (gender == FEMALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("underwear")
					var/new_underwear
					if(gender == MALE)
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_m
					else if(gender == FEMALE)
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_f
					else
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_list
					if(new_underwear)
						underwear = new_underwear

				if("underwear_color")
					needs_update = TRUE
					var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
					if(new_underwear_color)
						underwear_color = sanitize_hexcolor(new_underwear_color, 6)

				if("undershirt_color")
					needs_update = TRUE
					var/new_undershirt_color = input(user, "Choose your character's undershirt color:", "Character Preference","#"+undershirt_color) as color|null
					if(new_undershirt_color)
						undershirt_color = sanitize_hexcolor(new_undershirt_color, 6)

				if("socks_color")
					needs_update = TRUE
					var/new_socks_color = input(user, "Choose your character's socks color:", "Character Preference","#"+socks_color) as color|null
					if(new_socks_color)
						socks_color = sanitize_hexcolor(new_socks_color, 6)

				if("undershirt")
					needs_update = TRUE
					var/new_undershirt
					if(gender == MALE)
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_m
					else if(gender == FEMALE)
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_f
					else
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_list
					if(new_undershirt)
						undershirt = new_undershirt

				if("socks")
					needs_update = TRUE
					var/new_socks
					new_socks = input(user, "Choose your character's socks:", "Character Preference") as null|anything in GLOB.socks_list
					if(new_socks)
						socks = new_socks

				if("left_eye")
					needs_update = TRUE
					var/new_eyes = input(user, "Choose your character's left eye colour:", "Character Preference","#"+left_eye_color) as color|null
					if(new_eyes)
						left_eye_color = sanitize_hexcolor(new_eyes, 6)

				if("right_eye")
					needs_update = TRUE
					var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+right_eye_color) as color|null
					if(new_eyes)
						right_eye_color = sanitize_hexcolor(new_eyes, 6)

				if("show_body_size")
					needs_update = TRUE
					show_body_size = !show_body_size

				if("body_size")
					needs_update = TRUE
					var/new_body_size = input(user, "Choose your desired sprite size:\n([BODY_SIZE_MIN*100]%-[BODY_SIZE_MAX*100]%), Warning: May make your character look distorted", "Character Preference", features["body_size"]*100) as num|null
					if(new_body_size)
						new_body_size = clamp(new_body_size * 0.01, BODY_SIZE_MIN, BODY_SIZE_MAX)
						features["body_size"] = new_body_size

				if("species")
					ShowSpeciesMenu(user)
					return TRUE

				if("mutant_color")
					needs_update = TRUE
					var/new_mutantcolor = input(user, "Choose your character's primary color:", "Character Preference","#"+features["mcolor"]) as color|null
					if(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor"] = pref_species.default_color
						else
							features["mcolor"] = sanitize_hexcolor(new_mutantcolor, 6)
						if(!allow_advanced_colors)
							reset_colors()

				if("mutant_color2")
					needs_update = TRUE
					var/new_mutantcolor = input(user, "Choose your character's secondary color:", "Character Preference","#"+features["mcolor2"]) as color|null
					if(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor2"] = pref_species.default_color
						else
							features["mcolor2"] = sanitize_hexcolor(new_mutantcolor, 6)
						if(!allow_advanced_colors)
							reset_colors()

				if("mutant_color3")
					needs_update = TRUE
					var/new_mutantcolor = input(user, "Choose your character's tertiary color:", "Character Preference","#"+features["mcolor3"]) as color|null
					if(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor3"] = pref_species.default_color
						else
							features["mcolor3"] = sanitize_hexcolor(new_mutantcolor, 6)
						if(!allow_advanced_colors)
							reset_colors()

				if("color_ethereal")
					needs_update = TRUE
					var/new_etherealcolor = input(user, "Choose your ethereal color", "Character Preference") as null|anything in GLOB.color_list_ethereal
					if(new_etherealcolor)
						features["ethcolor"] = GLOB.color_list_ethereal[new_etherealcolor]

				if("cultural_info_change")
					var/thing = href_list["info"]
					var/list/choice_list = list()
					var/list/iteration_list
					var/list/siphon_list
					switch(thing)
						if(CULTURE_BIRTHSIGN)
							iteration_list = pref_species.culture_birthsigns
							siphon_list = GLOB.culture_birthsigns
					for(var/cultural_entity in iteration_list)
						var/datum/cultural_info/CINFO = siphon_list[cultural_entity]
						choice_list[CINFO.name] = cultural_entity
					var/new_cultural_thing = input(user, "Choose your character's [thing]:", "Character Preference")  as null|anything in choice_list
					if(new_cultural_thing)
						switch(thing)
							if(CULTURE_BIRTHSIGN)
								pref_birthsign = choice_list[new_cultural_thing]
						validate_languages()

				if("cultural_info_toggle")
					var/thing = href_list["info"]
					switch(thing)
						if(CULTURE_BIRTHSIGN)
							birthsign_more_info = !birthsign_more_info

				if("language")
					var/target_lang = text2path(href_list["lang"])
					var/level = text2num(href_list["level"])
					var/required_lang = get_required_languages()
					if(required_lang[target_lang]) //Can't do anything to a required language
						return TRUE
					var/opt_langs = get_optional_languages()
					if(!opt_langs[target_lang])
						return TRUE
					if(!level)
						languages -= target_lang
					else if(can_buy_language(target_lang, level))
						languages[target_lang] = level
					ShowLangMenu(user)
					return TRUE

				if("language_button")
					ShowLangMenu(user)
					return TRUE


				/*if("tail_lizard")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_lizard
					if(new_tail)
						features["tail_lizard"] = new_tail

				if("tail_human")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_human
					if(new_tail)
						features["tail_human"] = new_tail

				if("snout")
					var/new_snout
					new_snout = input(user, "Choose your character's snout:", "Character Preference") as null|anything in GLOB.snouts_list
					if(new_snout)
						features["snout"] = new_snout

				if("horns")
					var/new_horns
					new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.horns_list
					if(new_horns)
						features["horns"] = new_horns

				if("ears")
					var/new_ears
					new_ears = input(user, "Choose your character's ears:", "Character Preference") as null|anything in GLOB.ears_list
					if(new_ears)
						features["ears"] = new_ears

				if("wings")
					var/new_wings
					new_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.r_wings_list
					if(new_wings)
						features["wings"] = new_wings

				if("frills")
					var/new_frills
					new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.frills_list
					if(new_frills)
						features["frills"] = new_frills

				if("spines")
					var/new_spines
					new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.spines_list
					if(new_spines)
						features["spines"] = new_spines

				if("body_markings")
					var/new_body_markings
					new_body_markings = input(user, "Choose your character's body markings:", "Character Preference") as null|anything in GLOB.body_markings_list
					if(new_body_markings)
						features["body_markings"] = new_body_markings

				if("legs")
					var/new_legs
					new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs

				if("moth_wings")
					var/new_moth_wings
					new_moth_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.moth_wings_list
					if(new_moth_wings)
						features["moth_wings"] = new_moth_wings

				if("moth_antennae")
					var/new_moth_antennae
					new_moth_antennae = input(user, "Choose your character's antennae:", "Character Preference") as null|anything in GLOB.moth_antennae_list
					if(new_moth_antennae)
						features["moth_antennae"] = new_moth_antennae
				if("moth_markings")
					var/new_moth_markings
					new_moth_markings = input(user, "Choose your character's markings:", "Character Preference") as null|anything in GLOB.moth_markings_list
					if(new_moth_markings)
						features["moth_markings"] = new_moth_markings*/

				if("s_tone")
					needs_update = TRUE
					var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference")  as null|anything in GLOB.skin_tones
					if(new_s_tone)
						set_skin_tone(new_s_tone)

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = sanitize_ooccolor(new_ooccolor)

				if("asaycolor")
					var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
					if(new_asaycolor)
						asaycolor = sanitize_ooccolor(new_asaycolor)

				if("briefoutfit")
					var/list/valid_paths = list()
					for(var/datum/outfit/outfit_path as anything in subtypesof(/datum/outfit))
						valid_paths[initial(outfit_path.name)] = outfit_path
					var/new_outfit = input(user, "Choose your briefing officer outfit:", "Game Preference") as null|anything in valid_paths
					new_outfit = valid_paths[new_outfit]
					if(new_outfit)
						brief_outfit = new_outfit

				if("bag")
					var/new_backpack = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack

				if("suit")
					needs_update = TRUE
					if(jumpsuit_style == PREF_SUIT)
						jumpsuit_style = PREF_SKIRT
					else
						jumpsuit_style = PREF_SUIT

				if("uplink_loc")
					var/new_loc = input(user, "Choose your character's traitor uplink spawn location:", "Character Preference") as null|anything in GLOB.uplink_spawn_loc_list
					if(new_loc)
						uplink_spawn_loc = new_loc

				if("playtime_reward_cloak")
					if (user.client.get_exp_living(TRUE) >= PLAYTIME_VETERAN)
						playtime_reward_cloak = !playtime_reward_cloak

				if("ai_core_icon")
					var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens - "Portrait"
					if(ai_core_icon)
						preferred_ai_core_display = ai_core_icon

				if("sec_dept")
					var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
					if(department)
						prefered_security_department = department

				if ("preferred_map")
					var/maplist = list()
					var/default = "Default"
					if (config.defaultmap)
						default += " ([config.defaultmap.map_name])"
					for (var/M in config.maplist)
						var/datum/map_config/VM = config.maplist[M]
						if(!VM.votable)
							continue
						var/friendlyname = "[VM.map_name] "
						if (VM.voteweight <= 0)
							friendlyname += " (disabled)"
						maplist[friendlyname] = VM.map_name
					maplist[default] = null
					var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
					if (pickedmap)
						preferred_map = maplist[pickedmap]

				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = synced with server tick rate (currently:[world.fps]))", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = sanitize_integer(desiredfps, -1, 1000, clientfps)
						parent.fps = (clientfps < 0) ? RECOMMENDED_FPS : clientfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = pickedui
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor

				if("phobia")
					var/phobiaType = input(user, "What are you scared of?", "Character Preference", phobia) as null|anything in SStraumas.phobia_types
					if(phobiaType)
						phobia = phobiaType

				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

		else
			switch(href_list["preference"])
				if("reset_loadout")
					var/action = alert(user, "Are you sure you want to reset your loadout?", "", "Yes", "No")
					if(action && action != "Yes")
						return
					loadout = list()
					loadout_points = initial_loadout_points()

				if("mismatch")
					mismatched_customization = !mismatched_customization

				if("adv_colors")
					if(allow_advanced_colors)
						var/action = alert(user, "Are you sure you want to disable advanced colors (This will reset your colors back to default)?", "", "Yes", "No")
						if(action && action != "Yes")
							return
					allow_advanced_colors = !allow_advanced_colors
					if(!allow_advanced_colors)
						reset_colors()

				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if("gender")
					needs_update = TRUE
					if(gender == MALE)
						gender = FEMALE
						genitals = GENITALS_FEMALE
					else
						gender = MALE
						genitals = GENITALS_MALE
				if("genitals")
					needs_update = TRUE
					var/picked_genitals = input(user, "What are your genitals?", "Character Preference", genitals) as null|anything in GLOB.genital_sets
					if(picked_genitals)
						genitals = picked_genitals
				if("body_type")
					needs_update = TRUE
					if(body_type == MALE)
						body_type = FEMALE
					else
						body_type = MALE
				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_ENABLED]")
					else
						winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_DISABLED]")

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					var/old_key = href_list["old_key"]
					CaptureKeybinding(user, kb, old_key)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user)
						return

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							LAZYADD(key_bindings["Unbound"], kb_name)
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						user.client.set_macros()
						save_preferences()
						ShowChoices(user)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
						key_bindings[full_key] -= kb_name
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					key_bindings[full_key] += list(kb_name)
					key_bindings[full_key] = sortList(key_bindings[full_key])

					user << browse(null, "window=capturekeypress")
					user.client.set_macros()
					save_preferences()

				if("keybindings_reset")
					var/choice = tgui_alert(user, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", list("Hotkey", "Classic", "Cancel"))
					if(choice == "Cancel")
						ShowChoices(user)
						return
					hotkeys = (choice == "Hotkey")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					user.client.set_macros()

				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("see_rc_emotes")
					see_rc_emotes = !see_rc_emotes

				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_dead_chat")
					user.client.deadchat()
				if("toggle_radio_chatter")
					user.client.toggle_hear_radio()
				if("toggle_split_admin_tabs")
					toggles ^= SPLIT_ADMIN_TABS
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD
				if("toggle_deadmin_security")
					toggles ^= DEADMIN_POSITION_SECURITY
				if("toggle_deadmin_silicon")
					toggles ^= DEADMIN_POSITION_SILICON
				if("toggle_ignore_cult_ghost")
					toggles ^= ADMIN_IGNORE_CULT_GHOST


				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("persistent_scars")
					persistent_scars = !persistent_scars

				if("clear_scars")
					var/path = "data/player_saves/[user.ckey[1]]/[user.ckey]/scars.sav"
					fdel(path)
					to_chat(user, "<span class='notice'>All scar slots cleared.</span>")

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("endofround_sounds")
					toggles ^= SOUND_ENDOFROUND

				if("combat_mode_sound")
					toggles ^= SOUND_COMBATMODE

				if("announcement_volume_level")
					var/new_annoumcenent_volume = clamp(input(user, "Please enter the new announcement volume(1-100)", "New volume setting", 0) as num|null, 1, 100)
					if(new_annoumcenent_volume)
						announcement_volume = new_annoumcenent_volume

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("ghost_laws")
					chat_toggles ^= CHAT_GHOSTLAWS

				if("hear_login_logout")
					chat_toggles ^= CHAT_LOGIN_LOGOUT

				if("broadcast_login_logout")
					broadcast_login_logout = !broadcast_login_logout

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("screentipmode")
					screentip_pref = !screentip_pref

				if("screentipcolor")
					var/new_screentipcolor = input(user, "Choose your screentip color:", "Character Preference", screentip_color) as color|null
					if(new_screentipcolor)
						screentip_color = sanitize_ooccolor(new_screentipcolor)

				if("itemoutline_pref")
					itemoutline_pref = !itemoutline_pref

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent?.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
						PM.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.view_size.setDefault(getScreenSize(widescreenpref))

				if("pixel_size")
					switch(pixel_size)
						if(PIXEL_SCALING_AUTO)
							pixel_size = PIXEL_SCALING_1X
						if(PIXEL_SCALING_1X)
							pixel_size = PIXEL_SCALING_1_2X
						if(PIXEL_SCALING_1_2X)
							pixel_size = PIXEL_SCALING_2X
						if(PIXEL_SCALING_2X)
							pixel_size = PIXEL_SCALING_3X
						if(PIXEL_SCALING_3X)
							pixel_size = PIXEL_SCALING_AUTO
					user.client.view_size.apply() //Let's winset() it so it actually works

				if("scaling_method")
					switch(scaling_method)
						if(SCALING_METHOD_NORMAL)
							scaling_method = SCALING_METHOD_DISTORT
						if(SCALING_METHOD_DISTORT)
							scaling_method = SCALING_METHOD_BLUR
						if(SCALING_METHOD_BLUR)
							scaling_method = SCALING_METHOD_NORMAL
					user.client.view_size.setZoomMode()

				if("save")
					save_preferences()
					save_character()

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					if(!load_character(text2num(href_list["num"])))
						randomise_appearance_prefs()
						real_name = random_unique_name(gender)
						save_character()
					else
						needs_update = TRUE

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])

				if("character_preview")
					needs_update = TRUE
					preview_pref = href_list["tab"]

				if("select_background")
					needs_update = TRUE
					preview_bg = input(user, "Choose the the preview background", "Background", preview_bg) as anything in bg_options

				if("next_background")
					needs_update = TRUE
					preview_bg = next_list_item(preview_bg, bg_options)

				if("previous_background")
					needs_update = TRUE
					preview_bg = previous_list_item(preview_bg, bg_options)

				if("reload_preview")
					update_preview_icon()

				if("select_preview_dir")
					var/new_dir = input(user, "Choose the the preview direction", "Direction", "South") as anything in list("South", "North", "West", "East")
					switch(new_dir)
						if("South")
							preview_dir = SOUTH
						if("North")
							preview_dir = NORTH
						if("West")
							preview_dir = WEST
						if("East")
							preview_dir = EAST
						else
							preview_dir = SOUTH

				if("next_preview_dir")
					preview_dir = turn(preview_dir, 90)

				if("previous_preview_dir")
					preview_dir = turn(preview_dir, -90)

				if("character_tab")
					if (href_list["tab"])
						character_settings_tab = text2num(href_list["tab"])
						if(character_settings_tab == 4) //If we click the loadout tab, load in the defaults stuff
							var/list/cats = GLOB.loadout_category_to_subcategory_to_items
							for(var/category in cats)
								loadout_category = category
								break
							var/list/subs = GLOB.loadout_category_to_subcategory_to_items[loadout_category]
							for(var/subcat in subs)
								loadout_subcategory = subcat
								break

				if("loadout_cat")
					if (href_list["tab"])
						loadout_category = href_list["tab"]
						var/list/subs = GLOB.loadout_category_to_subcategory_to_items[loadout_category]
						for(var/subcat in subs)
							loadout_subcategory = subcat
							break

				if("loadout_subcat")
					if (href_list["tab"])
						loadout_subcategory = href_list["tab"]

				if("clear_heart")
					hearted = FALSE
					hearted_until = null
					to_chat(user, "<span class='notice'>OOC Commendation Heart disabled</span>")
					save_preferences()

	ShowChoices(user)
	return 1

/// Sanitization checks to be performed before using these preferences.
/datum/preferences/proc/sanitize_chosen_prefs()
	if(!(pref_species.id in GLOB.roundstart_races) && !(pref_species.id in (CONFIG_GET(keyed_list/roundstart_no_hard_check))))
		pref_species = new /datum/species/human
		save_character()

	if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == SPECIES_HUMAN))
		var/firstspace = findtext(real_name, " ")
		var/name_length = length(real_name)
		if(!firstspace) //we need a surname
			real_name += " [pick(GLOB.last_names)]"
		else if(firstspace == name_length)
			real_name += "[pick(GLOB.last_names)]"

/// Sanitizes the preferences, applies the randomization prefs, and then applies the preference to the human mob.
/datum/preferences/proc/safe_transfer_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	apply_character_randomization_prefs(is_antag)
	sanitize_chosen_prefs()
	apply_prefs_to(character, icon_updates)

/datum/preferences/proc/apply_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE, is_latejoiner = TRUE)
	hardcore_survival_score = 0 //Set to 0 to prevent you getting points from last another time.
	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == SPECIES_HUMAN))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace) //we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.name = character.real_name

	character.gender = gender
	character.age = age
	character.handed_flags = handedness
	if(blood_type != "Random" && !(character.dna.species.exotic_blood) && !(character.dna.species.exotic_bloodtype))
		character.dna.blood_type = blood_type
	if(gender == MALE || gender == FEMALE)
		character.body_type = gender
	else
		character.body_type = body_type
	character.genitals = genitals
	character.left_eye_color = left_eye_color
	character.right_eye_color = right_eye_color
	for(var/obj/item/organ/eyes/organ_eyes in character.internal_organs)
		if(initial(organ_eyes.eye_color))
			continue
		if(organ_eyes.current_zone == BODY_ZONE_PRECISE_L_EYE)
			organ_eyes.eye_color = left_eye_color
			organ_eyes.old_eye_color = left_eye_color
		else
			organ_eyes.eye_color = right_eye_color
			organ_eyes.old_eye_color = right_eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color

	character.skin_tone = skin_tone
	character.hairstyle = hairstyle
	character.facial_hairstyle = facial_hairstyle
	character.undershirt = "None"
	character.underwear = "None"
	character.socks = "None"

	character.backpack = backpack

	character.jumpsuit_style = jumpsuit_style

	var/datum/species/chosen_species
	chosen_species = pref_species.type
	if(roundstart_checks && !(pref_species.id in GLOB.customizable_races))
		chosen_species = /datum/species/human
		set_new_species(chosen_species)
		save_character()

	character.set_species(chosen_species, icon_update = FALSE, pref_load = src)
	if(!character_setup || (character_setup && show_body_size))
		character.dna.update_body_size()
	else //We need to update it to 100% in case they switch back
		character.dna.features["body_size"] = BODY_SIZE_NORMAL
		character.dna.update_body_size()
	if(length(augments))
		for(var/key in augments)
			var/datum/augment_item/aug = GLOB.augment_items[augments[key]]
			aug.apply(character, character_setup, src)
	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts()
		character.update_mutations_overlay()

/// Returns whether the parent mob should have the random hardcore settings enabled. Assumes it has a mind.
/datum/preferences/proc/should_be_random_hardcore(datum/job/job, datum/mind/mind)
	if(!randomise[RANDOM_HARDCORE])
		return FALSE
	if(job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND) //No command staff
		return FALSE
	for(var/datum/antagonist/antag as anything in mind.antag_datums)
		if(antag.get_team()) //No team antags
			return FALSE
	return TRUE


/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("human")
			return random_unique_name()
		if("ai")
			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
		if("clown")
			return pick(GLOB.clown_names)
		if("mime")
			return pick(GLOB.mime_names)
		if("religion")
			return DEFAULT_RELIGION
		if("deity")
			return DEFAULT_DEITY
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z,[namedata["allow_numbers"] ? ",0-9," : ""] -, ' and .</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/datum/preferences/proc/print_bodypart_change_line(key)
	var/acc_name = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_NAME)
	var/datum/sprite_accessory/SA = LAZYACCESSASSOC(GLOB.sprite_accessories, key, acc_name)
	var/shown_colors = 0
	var/dat = ""
	if(!SA)
		return
	if(SA.color_src == USE_MATRIXED_COLORS)
		shown_colors = 3
	else if (SA.color_src == USE_ONE_COLOR)
		shown_colors = 1
	if((allow_advanced_colors || SA.always_color_customizable) && shown_colors)
		dat += "<a href='?_src_=prefs;key=[key];preference=reset_color;task=change_bodypart'>R</a>"
	dat += "<a href='?_src_=prefs;key=[key];preference=change_name;task=change_bodypart'>[acc_name]</a>"
	if(allow_advanced_colors || SA.always_color_customizable)
		if(shown_colors)
			dat += "<br>"
			var/list/colorlist = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_COLOR)
			for(var/i in 1 to shown_colors)
				dat += " <a href='?_src_=prefs;key=[key];color_index=[i];preference=change_color;task=change_bodypart'><span class='color_holder_box' style='background-color:["#[colorlist[i]]"]'></span></a>"
	return dat

/datum/preferences/proc/set_skin_tone(new_skin_tone)
	skin_tone = new_skin_tone
	features["skin_color"] = sanitize_hexcolor(skintone2hex(skin_tone), 6)
	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/initial_loadout_points()
	return LOADOUT_POINTS_MAX

/datum/preferences/proc/CanBuyAugment(datum/augment_item/target_aug, datum/augment_item/current_aug)
	//Check biotypes
	if(!(pref_species.inherent_biotypes & target_aug.allowed_biotypes))
		return
	var/quirk_points = GetQuirkBalance()
	var/leverage = 0
	if(current_aug)
		leverage += current_aug.cost
	if((quirk_points+leverage)>= target_aug.cost)
		return TRUE
	else
		return FALSE

/datum/preferences/proc/ShowSpeciesMenu(mob/user)
	var/list/dat = list()
	dat += "<center><b>Choose your character's species:</b></center>"
	dat += "<center><a href='?_src_=prefs;preference=close_species;task=input'>Done</a></center>"
	dat += "<hr>"
	var/list/playables = list()
	var/list/unplayables = list()
	for(var/id in GLOB.customizable_races)
		if(GLOB.roundstart_races[id])
			playables += id
		else
			unplayables += id
	var/even = TRUE
	var/background_cl
	dat += "<table width='100%' align='center'><tr>"
	dat += "<td width=20%></td>"
	dat += "<td width=65%></td>"
	dat += "<td width=15%></td>"
	dat += "</tr>"
	for(var/id in playables)
		even = !even
		var/datum/species/S = GLOB.species_list[id]
		background_cl = (even ? "#13171C" : "#19232C")
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td><b>[initial(S.name)]</b></td>"
		dat += "<td><i>[initial(S.flavor_text)]</i></td>"
		dat += "<td><a href='?_src_=prefs;selected_species=[id];preference=set_species;task=input'>Choose</a></td>"
		dat += "</tr>"
	dat += "<table>"
	dat += "<hr>"
	dat += "<center><b>Below you have species which you cannot play on station</b></center>"
	dat += "<hr>"
	dat += "<table width='100%' align='center'><tr>"
	dat += "<td width=20%></td>"
	dat += "<td width=65%></td>"
	dat += "<td width=15%></td>"
	dat += "</tr>"
	for(var/id in unplayables)
		even = !even
		var/datum/species/S = GLOB.species_list[id]
		background_cl = (even ? "#852119" : "#9c2a21")
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td><b>[initial(S.name)]</b></td>"
		dat += "<td><i>[initial(S.flavor_text)]</i></td>"
		dat += "<td><a href='?_src_=prefs;selected_species=[id];preference=set_species;task=input'>Choose</a></td>"
		dat += "</tr>"
	dat += "<table>"

	var/datum/browser/popup = new(user, "species_menu", "<div align='center'>Species Choice</div>", 900, 600)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

// old bobcode copypaste, handle with caution
/datum/preferences/proc/SetFood(mob/user)
	var/list/dat = list()
	dat += "<center><b>Choose food setup</b></center><br>"
	dat += "<div align='center'>Click on \"like\" to add a food type to your likings. Click on \"dislike\" to add it to your dislikings.<br>"
	dat += "Food types cannot be liked and disliked at the same time.<br>"
	dat += "If a food type is already liked or disliked, simply click the appropriate button again to remove it from your like or dislike list.<br>"
	dat += "Having no food preferences means you'll just default your species' standard instead.</div><br>"
	dat += "<center><a href='?_src_=prefs;preference=food;task=close'>Done</a></center>"
	dat += "<hr>"
	dat += "<center><b>Current Likings:</b> [foodlikes.len ? foodlikes.Join(", ") : "None"] ([foodlikes.len]/[max_foodlikes])</center><br>"
	dat += "<center><b>Current Dislikings:</b> [fooddislikes.len ? fooddislikes.Join(", ") : "None"] ([fooddislikes.len]/[max_fooddislikes])</center>"
	dat += "<hr>"
	for(var/food in GLOB.food_tastes)
		var/likes = FALSE
		var/dislikes = FALSE
		if(food in foodlikes)
			likes = TRUE
		if(food in fooddislikes)
			dislikes = TRUE
		var/font_color = "#8686ff"
		if(likes)
			dat += "<center><p style='color: [font_color];'><b>[food]: </p></b>"
			dat += "<a style='background-color: #32c232;' href='?_src_=prefs;preference=food;task=update;like=[food]'>Like</a>"
			dat += "<a href='?_src_=prefs;preference=food;task=update;dislike=[food]'>Dislike</a></center>"
		else if(dislikes)
			dat += "<center><p style='color: [font_color];'><b>[food]: </p></b>"
			dat += "<a href='?_src_=prefs;preference=food;task=update;like=[food]'>Like</a>"
			dat += "<a style='background-color: #ff1a1a;' href='?_src_=prefs;preference=food;task=update;dislike=[food]'>Dislike</a></center>"
		else
			dat += "<center><p style='color: [font_color];'><b>[food]: </p></b>"
			dat += "<a href='?_src_=prefs;preference=food;task=update;like=[food]'>Like</a>"
			dat += "<a href='?_src_=prefs;preference=food;task=update;dislike=[food]'>Dislike</a></center>"
	dat += "<br><center><a href='?_src_=prefs;preference=food;task=reset'>Reset Food Preferences</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Food Preferences</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/validate_quirks()
	if(GetQuirkBalance() < 0)
		all_quirks = list()

/datum/preferences/proc/get_linguistic_points()
	var/points = LINGUISTIC_POINTS_DEFAULT
	for(var/langpath in languages)
		points -= languages[langpath]
	return points

/datum/preferences/proc/get_required_languages()
	var/list/lang_list = list()
	for(var/cultural_thing in ALL_CULTURE_TYPES)
		var/datum/cultural_info/cult
		switch(cultural_thing)
			if(CULTURE_BIRTHSIGN)
				cult = GLOB.culture_birthsigns[pref_birthsign]
		if(cult.required_langs)
			for(var/langtype in cult.required_langs)
				lang_list[langtype] = TRUE
	return lang_list

/datum/preferences/proc/get_optional_languages()
	var/list/lang_list = list()
	for(var/lang in pref_species.learnable_languages)
		lang_list[lang] = TRUE
	for(var/cultural_thing in ALL_CULTURE_TYPES)
		var/datum/cultural_info/cult
		switch(cultural_thing)
			if(CULTURE_BIRTHSIGN)
				cult = GLOB.culture_birthsigns[pref_birthsign]
		if(!cult)
			continue
		if(cult.additional_langs)
			for(var/langtype in cult.additional_langs)
				lang_list[langtype] = TRUE
	return lang_list

/datum/preferences/proc/get_available_languages()
	var/list/lang_list = get_required_languages()
	for(var/lang_key in get_optional_languages())
		lang_list[lang_key] = TRUE
	return lang_list

/datum/preferences/proc/validate_languages()
	var/list/opt_langs = get_optional_languages()
	var/list/req_langs = get_required_languages()
	for(var/langkey in languages)
		if(!opt_langs[langkey] && !req_langs[langkey])
			languages -= langkey
	for(var/req_lang in req_langs)
		if(!languages[req_lang])
			languages[req_lang] = LANGUAGE_SPOKEN
	var/left_points = get_linguistic_points()
	//If we're below 0 points somehow, remove all optional languages
	if(left_points < 0)
		for(var/lang in languages)
			if(!req_langs[lang])
				languages -= lang

/datum/preferences/proc/can_buy_language(language_path, level)
	var/points = get_linguistic_points()
	if(languages[language_path])
		points += languages[language_path]
	if(points < level)
		return FALSE
	return TRUE

//Whenever we switch a species, we'll try to get common if we can to not confuse anyone
/datum/preferences/proc/try_get_common_language()
	var/list/langs = get_available_languages()
	if(langs[/datum/language/common])
		languages[/datum/language/common] = LANGUAGE_SPOKEN

/datum/preferences/proc/ShowLangMenu(mob/user)
	var/list/dat = list()
	dat += "<center><b>Choose your languages:</b></center><br>"
	dat += "Availability of the languages to choose from depends on your background. If you can't unlearn one, it means it is required for your background."
	dat += "<BR><center><a href='?_src_=prefs;task=close_language'>Done</a></center>"
	dat += "<hr>"
	var/current_ling_points = get_linguistic_points()
	dat += "<b>Linguistic Points remaining: [current_ling_points]</b>"
	dat += "<table width='100%' align='center'><tr>"
	dat += "<td width=10%></td>"
	dat += "<td width=60%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "</tr>"
	var/list/avail_langs = get_available_languages()
	var/list/req_langs = get_required_languages()
	var/even = TRUE
	var/background_cl
	var/border_cl
	for(var/lang_path in avail_langs)
		even = !even
		var/datum/language/lang_datum = lang_path
		var/required = (req_langs[lang_path] ? TRUE : FALSE)
		if(even)
			background_cl = (required ? "#7A5A00" : "#17191C")
			border_cl = (required ? "#663a00": "#001120")
		else
			background_cl = (required ? "#856200" : "#23273C")
			border_cl = (required ? "#884d00": "#001a33")
		var/language_skill = 0
		if(languages[lang_path])
			language_skill = languages[lang_path]
		var/unlearn_button
		if(language_skill && !required)
			unlearn_button = "<a href='?_src_=prefs;lang=[lang_path];level=0;preference=language;task=input'>Unlearn</a>"
		else
			unlearn_button = "<span class='linkOff'>Unlearn</span>"
		var/understood_button
		if(languages[lang_path])
			//Has a href in case you want to downgrade from spoken to understood
			understood_button = "<a class='linkOn' href='?_src_=prefs;lang=[lang_path];level=1;preference=language;task=input'>Understood</a>"
		else if(can_buy_language(lang_path, LANGUAGE_UNDERSTOOD))
			understood_button = "<a href='?_src_=prefs;lang=[lang_path];level=1;preference=language;task=input'>Understood</a>"
		else
			understood_button = "<span class='linkOff'>Understood</span>"
		var/spoken_button
		if(languages[lang_path] >= LANGUAGE_SPOKEN)
			spoken_button = "<a class='linkOn' href='?_src_=prefs;lang=[lang_path];level=2;preference=language;task=input'>Spoken</a>"
		else if(can_buy_language(lang_path, LANGUAGE_SPOKEN))
			spoken_button = "<a href='?_src_=prefs;lang=[lang_path];level=2;preference=language;task=input'>Spoken</a>"
		else
			spoken_button = "<span class='linkOff'>Spoken</span>"
		dat += "<tr style='background-color: [background_cl];border: 2px solid [border_cl];'>"
		dat += "<td><b>[initial(lang_datum.name)]</b></td>"
		dat += "<td><i>[initial(lang_datum.desc)]</i></td>"
		dat += "<td>[unlearn_button]</td>"
		dat += "<td>[understood_button]</td>"
		dat += "<td>[spoken_button]</td>"
		dat += "</tr>"
	dat += "<table>"
	var/datum/browser/popup = new(user, "culture_lang", "<div align='center'>Language Choice</div>", 900, 600)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
