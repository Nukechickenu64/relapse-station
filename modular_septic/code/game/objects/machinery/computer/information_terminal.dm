/obj/machinery/computer/information_terminal
	name = "\improper Publicitarium"
	desc = "A touchscreen terminal used to handle banking and information sharing."
	icon = 'modular_septic/icons/obj/machinery/telescreen.dmi'
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

/obj/machinery/computer/information_terminal/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(inserted_data && user.put_in_hands(inserted_data))
		to_chat(user, span_notice("I pull [inserted_data] from [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_desert.wav', 70, FALSE)
		inserted_data = null
		return
	if(inserted_id && user.put_in_hands(inserted_id))
		to_chat(user, span_notice("I pull [inserted_id] from [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_desert.wav', 70, FALSE)
		inserted_id = null
		if(ui_page == "banking")
			ui_page = initial(ui_page)
			update_static_data(user)

/obj/machinery/computer/information_terminal/attackby(obj/item/weapon, mob/user, params)
	if(!inserted_id && istype(weapon, /obj/item/card/id) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s ID card slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_insert.wav', 70, FALSE)
		inserted_id = weapon
		if(ui_page == "banking")
			ui_page = initial(ui_page)
			update_static_data(user)
		return TRUE
	if(!inserted_data && istype(weapon, /obj/item/computer_hardware/hard_drive/portable) && user.transferItemToLoc(weapon, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [weapon] into [src]'s data slot."))
		playsound(src, 'modular_septic/sound/machinery/cardreader_insert.wav', 70, FALSE)
		inserted_data = weapon
		return TRUE
	if(ismoney(weapon))
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
	if(ui_page == "index" && LAZYLEN(GLOB.data_core.birthday_boys))
		data["birthday_boys"] = english_list(GLOB.data_core.birthday_boys)

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
			var/amount = min(params["amount"], inserted_id?.registered_account?.account_balance)
			if(amount <= 0)
				to_chat(usr, span_warning("[fail_msg()] I'm broke."))
				return
			withdraw_money(amount, usr)

/obj/machinery/computer/information_terminal/proc/insert_money(obj/item/money, mob/user)
	if(!inserted_id)
		var/insert_amount = money.get_item_credit_value()
		if(insert_amount)
			var/datum/bank_account/master_account = SSeconomy.get_dep_account(DEPARTMENT_COMMAND)
			if(!master_account)
				return
			qdel(money)
			master_account.adjust_money(insert_amount)
			to_chat(user, span_danger("[fail_msg()] I'm fucking stupid!"))
		return
	else if(!inserted_id.registered_account)
		to_chat(user, span_warning("[inserted_id] doesn't have a linked account to deposit [money] into!"))
		return

	var/insert_amount = money.get_item_credit_value()
	if(!insert_amount)
		to_chat(user, span_warning("[money] isn't worth anything!"))
		return
	qdel(money)

	inserted_id.registered_account.adjust_money(insert_amount)
	to_chat(user, span_notice("I insert [money] into [src], adding $[insert_amount] to the \"[inserted_id.registered_account.account_holder]\" account."))
	log_econ("$[insert_amount] were inserted into [inserted_id] owned by [inserted_id.registered_name]")
	SSblackbox.record_feedback("amount", "credits_inserted", insert_amount)

/obj/machinery/computer/information_terminal/proc/withdraw_money(amount, mob/user)
	if(!inserted_id.registered_account.adjust_money(-amount))
		return

	var/static/list/money_to_value = list(
		/obj/item/money/note/value20 = 20 DOLLARS,
		/obj/item/money/note/value10 = 10 DOLLARS,
		/obj/item/money/note/value5 = 5 DOLLARS,
		/obj/item/money/coin/dollar = 1 DOLLARS,
	)

	var/remaining_amount = amount
	var/list/money_items = list()
	for(var/money_type in money_to_value)
		if(remaining_amount <= 0)
			break
		var/bill_value = money_to_value[money_type]
		var/bills = round(remaining_amount, bill_value) //total value of bills
		remaining_amount -= bills
		bills /= bill_value //amount of bills
		for(var/i in 1 to bills)
			money_items += new money_type(loc)
	var/money_length = length(money_items)
	if(!money_length)
		return

	var/obj/item/money/final_handout
	if(money_length > 1)
		final_handout = new /obj/item/money/stack(loc)
		for(var/obj/item/money as anything in money_items)
			final_handout.stack_money(money, TRUE)
	else
		final_handout = money_items[1]
	user.put_in_hands(final_handout)

	to_chat(user, span_notice("I withdraw $[amount] from [src]."))
	log_econ("$[amount] were removed from [inserted_id] owned by [inserted_id.registered_name]")
	SSblackbox.record_feedback("amount", "credits_removed", amount)

/obj/machinery/computer/information_terminal/directional/north
	pixel_y = 32

/obj/machinery/computer/information_terminal/directional/south
	pixel_y = -28

/obj/machinery/computer/information_terminal/directional/east
	pixel_x = 28

/obj/machinery/computer/information_terminal/directional/west
	pixel_x = -28
