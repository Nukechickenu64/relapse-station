/obj/machinery/computer/cargo
	name = "supply console"
	desc = "Used to order supplies, approve requests, and control the shuttle."
	icon_screen = "supply"
	circuit = /obj/item/circuitboard/computer/cargo
	light_color = COLOR_BRIGHT_ORANGE

/obj/machinery/computer/cargo/attackby(obj/item/weapon, mob/user, params)
	if(ismoney(weapon))
		add_fingerprint(user)
		insert_money(weapon, user)
		return TRUE
	return ..()

/obj/machinery/computer/cargo/proc/insert_money(obj/item/money/money, mob/user)
	if(!can_insert_money(user))
		return

	var/datum/bank_account/cargo_bank = SSeconomy.get_dep_account(DEPARTMENT_CARGO)
	var/obj/item/money/money_stack
	var/obj/item/money/real_money = money
	if(money.is_stack)
		money_stack = money
		real_money = money_stack.contents[1]

	var/insert_amount = real_money.get_item_credit_value()
	if(!insert_amount)
		to_chat(user, span_warning("[real_money] isn't worth anything!"))
		return

	if(real_money.is_coin)
		playsound(src, 'modular_septic/sound/machinery/coin_insert.wav', 60, FALSE)
		TIMER_COOLDOWN_START(src, COOLDOWN_MONEY, coin_cooldown_duration)
	else
		playsound(src, 'modular_septic/sound/machinery/cash_insert.wav', 60, FALSE)
		TIMER_COOLDOWN_START(src, COOLDOWN_MONEY, cash_cooldown_duration)
	qdel(real_money)
	if(money_stack && (length(money_stack.contents) <= 1))
		user.dropItemToGround(money_stack)
		for(var/obj/item/money/cash_money in money_stack)
			cash_money.forceMove(loc)
			user.put_in_hands(cash_money)
		qdel(money_stack)

	cargo_bank.adjust_money(insert_amount)
	to_chat(user, span_notice("I insert [money] into [src], adding $[insert_amount] to the \"[inserted_id.registered_account.account_holder]\" account."))
	log_econ("$[insert_amount] were inserted into [inserted_id] owned by [inserted_id.registered_name]")
	SSblackbox.record_feedback("amount", "credits_inserted", insert_amount)
	if(!QDELETED(money_stack))
		money_stack.update_appearance()

/obj/machinery/computer/cargo/proc/can_insert_money(mob/user)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_MONEY))
		return FALSE
	return TRUE
