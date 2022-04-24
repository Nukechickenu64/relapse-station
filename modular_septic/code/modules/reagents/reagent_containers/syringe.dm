/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user, proximity)
	. = ..()

	if (!try_syringe(target, user, proximity))
		return

	var/contained = reagents.log_list()
	log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty! Right-click to draw."))
		return

	if(!isliving(target) && !target.is_injectable(user))
		to_chat(user, span_warning("You cannot directly fill [target]!"))
		return

	if(target.reagents.total_volume >= target.reagents.maximum_volume)
		to_chat(user, span_notice("[target] is full."))
		return

	if(isliving(target))
		var/mob/living/living_target = target
		if(!living_target.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
			return
		if(living_target != user)
			living_target.visible_message(span_danger("[user] is trying to inject [living_target]!"), \
									playsound(src, 'modular_septic/sound/effects/syringe_attempt.wav', volume, TRUE, vary = FALSE), \
									span_userdanger("[user] is trying to inject you!"))
			if(!do_mob(user, living_target, CHEM_INTERACT_DELAY(3 SECONDS, user), extra_checks = CALLBACK(living_target, /mob/living/proc/try_inject, user, null, INJECT_TRY_SHOW_ERROR_MESSAGE)))
				return
			if(!reagents.total_volume)
				return
			if(living_target.reagents.total_volume >= living_target.reagents.maximum_volume)
				return
			living_target.visible_message(span_danger("[user] injects [living_target] with the syringe!"), \
							span_userdanger("[user] injects you with the syringe!"))

		if (living_target == user)
			living_target.log_message("injected themselves ([contained]) with [name]", LOG_ATTACK, color="orange")
		else
			log_combat(user, living_target, "injected", src, addition="which had [contained]")
	reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user, methods = INJECT)
	to_chat(user, span_notice("You inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units."))
	playsound(src, 'modular_septic/sound/effects/syringe_success.wav', volume, TRUE, vary = FALSE)

/obj/item/reagent_containers/syringe/multiver
	name = "syringe (charcoal)"
	desc = "Contains charcoal."
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 15)

/obj/item/reagent_containers/syringe/syriniver
	name = "syringe (dylovenal)"
	desc = "Contains dylovenal."
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 15)

/obj/item/reagent_containers/syringe/minoxidil
	name = "syringe (minoxidil)"
	desc = "Contains minoxidil."
	list_reagents = list(/datum/reagent/medicine/c2/penthrite = 15)

/obj/item/reagent_containers/syringe/convermol
	name = "syringe (formoterol)"
	desc = "Contains formoterol."
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 15)

/obj/item/reagent_containers/syringe/tirimol
	name = "syringe (tirimol)"
	desc = "Contains tirimol."
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 15)

/obj/item/reagent_containers/syringe/antiviral
	name = "syringe (penicillin)"
	desc = "Contains a common antibiotic, penicilin."
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 15)

/obj/item/reagent_containers/syringe/copium
	name = "syringe (copium)"
	desc = "Contains copium.\
			\n<b>Do not inject more or equal to 15u at once.</b>"
	custom_premium_price = PAYCHECK_HARD * 3
	list_reagents = list(/datum/reagent/medicine/copium = 15)

/obj/item/reagent_containers/syringe/morphine
	name = "syringe (morphine)"
	desc = "Contains morphine."
	list_reagents = list(/datum/reagent/medicine/morphine = 15)
