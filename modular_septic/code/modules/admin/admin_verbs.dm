/client/proc/toggle_rightclickmenu()
	set name = "Toggle Right Click Menu"
	set category = "Admin.Game"
	set desc = "Allows you to right click."
	if(!holder)
		return

	if(!check_rights_for(src, R_VAREDIT))
		to_chat(src, span_warning("Only niggas with var edit perms can use the right clicking menu."))
		return FALSE

	show_popup_menus = !show_popup_menus
	to_chat(src, span_warning("Right click context menu has been toggled [show_popup_menus ? "on" : "off"]."))

/client/proc/toggle_liquid_debug()
	set category = "Debug"
	set name = "Liquid Groups Color Debug"
	set desc = "Liquid Groups Color Debug."
	if(!holder)
		return
	GLOB.liquid_debug_colors = !GLOB.liquid_debug_colors

/client/proc/spawn_pollution()
	set category = "Admin.Fun"
	set name = "Spawn Pollution"
	set desc = "Spawns an amount of chosen pollutant at your current location."

	var/list/singleton_list = SSpollution.singletons
	var/choice = tgui_input_list(usr, "What type of pollutant would you like to spawn?", "Spawn Pollution", singleton_list)
	if(!choice)
		return
	var/amount_choice = input("Amount of pollution:") as null|num
	if(!amount_choice)
		return
	var/turf/epicenter = get_turf(mob)
	epicenter.pollute_turf(choice, amount_choice)
	message_admins("[ADMIN_LOOKUPFLW(usr)] spawned pollution at [epicenter.loc] ([choice] - [amount_choice]).")
	log_admin("[key_name(usr)] spawned pollution at [epicenter.loc] ([choice] - [amount_choice]).")

/client/proc/add_quote()
	set name = "Save Quote"
	set category = "Admin"
	set desc = "Saves a given quote as a new possible Quote of The Round."

	if(!holder)
		return
	var/quoted_text = input("What's the quote?") as message|null
	if(!quoted_text)
		return

	var/quote_author = input("And the author?") as message|null
	if(!quote_author)
		quote_author = "Unknown"

	var/compiled_text = "\"[quoted_text]\" - [quote_author]"
	if(alert("[compiled_text]\nIs this correct?",, "Yes", "No") == "Yes")
		text2file("\n[compiled_text]", 'modular_septic/strings/quotes.txt')
