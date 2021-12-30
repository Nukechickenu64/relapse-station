/obj/machinery/computer/information_terminal
	name = "\improper Publicitarium Terminal"
	desc = "A touchscreen terminal used to handle banking, information sharing, and other crap."
	icon = 'modular_septic/icons/obj/machines/telescreen.dmi'
	icon_state = "telescreen"
	icon_keyboard = null
	icon_screen = "generic"
	density = FALSE
	/// Page the UI is currently set to
	var/ui_page = "index"
	/// ID card currently inserted in the ATM
	var/obj/item/card/id/inserted_id
	/// Data disk currently inserted, for naughty purposes
	var/obj/item/computer_hardware/hard_drive/portable/inserted_data

/obj/machinery/computer/information_terminal/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/machinery/computer/information_terminal/examine(mob/user)
	. = ..()
	if(inserted_id)
		. += span_notice("[inserted_id] is inserted in the ID card slot.")
	if(inserted_data)
		. += span_notice("[inserted_data] is inserted in the data slot.")

/obj/machinery/computer/information_terminal/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if((usr == over) && isliving(usr))
		var/mob/living/user = usr
		add_fingerprint(user)
		if(inserted_data && user.put_in_hands(inserted_data))
			to_chat(user, span_notice("I pull [inserted_data] from [src]'s data slot."))
			inserted_data = null
			return
		if(inserted_id && user.put_in_hands(inserted_id))
			to_chat(user, span_notice("I pull [inserted_id] from [src]'s data slot."))
			inserted_id = null
			if(ui_page == "banking")
				ui_page = initial(ui_page)
				update_static_data(user)

/obj/machinery/computer/information_terminal/attackby(obj/item/weapon, mob/user, params)
	if(!inserted_id && istype(weapon, /obj/item/card/id) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s ID card slot."))
		inserted_id = weapon
		if(ui_page == "banking")
			ui_page = initial(ui_page)
			update_static_data(user)
		return TRUE
	if(!inserted_data && istype(weapon, /obj/item/computer_hardware/hard_drive/portable) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s data slot."))
		inserted_data = weapon
		return TRUE
	if(iscash(weapon))
		add_fingerprint(user)
		insert_money(weapon, user)
		return TRUE
	return ..()

/obj/machinery/computer/information_terminal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InformationTerminal")
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/machinery/computer/information_terminal/ui_data(mob/user)
	var/list/data = list()

	data["current_page"] = ui_page
	if(inserted_id?.registered_account)
		data["account_holder"] = inserted_id.registered_account.account_holder
		data["account_id"] = inserted_id.registered_account.account_id
		data["account_balance"] = inserted_id.registered_account.account_balance

	return data

/obj/machinery/computer/information_terminal/ui_static_data(mob/user)
	var/list/data = list()

	if(ui_page == "information")
		var/list/announcements= list()
		for(var/list/announcement as anything in reverseList(SSstation.station_announcements))
			var/list/this_announcement = list()

			this_announcement["title"] = announcement["title"]
			this_announcement["text"] = announcement["text"]

			announcements += list(this_announcement)
		data["announcements"] = announcements

	return data

/obj/machinery/computer/information_terminal/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("switch_page")
			var/new_page = params["new_page"]
			ui_page = new_page
			if(ui)
				ui.close()
			ui_interact(usr)
		if("withdraw")
			var/withdraw_amount = min(params["amount"], inserted_id?.registered_account?.account_balance)
			if(withdraw_amount <= 0)
				return
			if(inserted_id.registered_account.adjust_money(-withdraw_amount))
				var/obj/item/holochip/holochip = new (usr.drop_location(), withdraw_amount)
				usr.put_in_hands(holochip)
				to_chat(usr, span_notice("I withdraw [withdraw_amount] credits from [src]."))
				SSblackbox.record_feedback("amount", "credits_removed", withdraw_amount)
				log_econ("[withdraw_amount] credits were removed from [inserted_id] owned by [inserted_id.registered_name]")

/obj/machinery/computer/information_terminal/proc/insert_money(obj/item/money, mob/user)
	if(!inserted_id)
		return

	if(!inserted_id.registered_account)
		to_chat(user, span_warning("[inserted_id] doesn't have a linked account to deposit [money] into!"))
		return

	var/insert_amount = money.get_item_credit_value()
	if(!insert_amount)
		to_chat(user, span_warning("[money] isn't worth anything!"))
		return

	inserted_id.registered_account.adjust_money(insert_amount)
	to_chat(user, span_notice("I stuff [money] into [src], adding [insert_amount] cr to the \"[inserted_id.registered_account.account_holder]\" account."))
	SSblackbox.record_feedback("amount", "credits_inserted", insert_amount)
	log_econ("[insert_amount] credits were inserted into [inserted_id] owned by [inserted_id.registered_name]")
	qdel(money)

/obj/machinery/computer/information_terminal/directional/north
	pixel_y = 32

/obj/machinery/computer/information_terminal/directional/south
	pixel_y = -28

/obj/machinery/computer/information_terminal/directional/east
	pixel_x = 28

/obj/machinery/computer/information_terminal/directional/west
	pixel_x = -28
