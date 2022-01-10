/obj/item/clothing
	// ~DAMAGE SYSTEM VARIABLES
	/// If this is set, then repairing this thing requires this item on the offhand
	var/repairable_by_offhand = null
	/// Sound we do when a zone is damaged
	var/armor_damage_sound
	/// Sound we do when a zone is damaged, to the wearer
	var/armor_damage_sound_local
	/// Sound we do when a zone is broken
	var/armor_broken_sound
	/// Sound we do when a zone is broken, to the wearer
	var/armor_broken_sound_local
	max_integrity = 200
	integrity_failure = 0.5
	limb_integrity = 0
	// Assume that clothing isn't too weighty by default
	carry_weight = 2

/obj/item/clothing/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, repairable_by))
		return ..()

	if(!LAZYACCESS(damage_by_parts, user.zone_selected))
		to_chat(user, span_warning("[src]'s [capitalize(parse_zone(user.zone_selected))] is not broken."))
		return TRUE
	var/obj/item/stack/stack = attacking_item
	if(stack.amount < 1)
		to_chat(user, span_warning("Not enough [stack.name] to repair [src]."))
		return TRUE
	var/obj/item/stack/offhand_stack
	if(repairable_by_offhand)
		offhand_stack = user.get_inactive_held_item()
		var/obj/item/stack/ghost_stack = repairable_by_offhand
		if(!istype(offhand_stack, repairable_by_offhand))
			to_chat(user, span_warning("I also need [initial(ghost_stack.name)] to repair [src]."))
			return TRUE
		if(offhand_stack.amount < 1)
			to_chat(user, span_warning("Not enough [offhand_stack.name] to repair [src]."))
			return TRUE
	to_chat(user, span_notice("I begin fixing the damage on [src] with [stack]..."))
	if(!do_after(user, 5 SECONDS, src) || !stack.use(1) || (offhand_stack && !offhand_stack.use(1)))
		to_chat(user, span_warning(fail_msg()))
		return TRUE

	repair_zone(user, user.zone_selected, params)
	return TRUE

/obj/item/clothing/take_damage_zone(def_zone, damage_amount, damage_type, armour_penetration)
	// the second check sees if we only cover one bodypart anyway and don't need to bother with this
	if(!def_zone || !limb_integrity)
		return FALSE
	// what do we actually cover?
	var/list/covered_limbs = body_parts_covered2organ_names(body_parts_covered)
	if(!(def_zone in covered_limbs))
		return FALSE

	// only deal 10% of the damage to the general integrity damage, then multiply it by 10 so we know how much to deal to limb
	var/damage_dealt = take_damage(damage_amount * 0.1, damage_type, armour_penetration, FALSE) * 10
	LAZYINITLIST(damage_by_parts)
	if(isnull(damage_by_parts[def_zone]))
		damage_by_parts[def_zone] = 0
	var/prev_damage = damage_by_parts[def_zone]
	damage_by_parts[def_zone] += damage_dealt
	if(damage_by_parts[def_zone] >= limb_integrity)
		disable_zone(def_zone, damage_type)
		if(prev_damage < limb_integrity)
			playsound(src, armor_broken_sound, 80, FALSE)
			if(iscarbon(loc))
				var/mob/loc_as_mob = loc
				loc_as_mob.playsound_local(src, armor_broken_sound, 80, FALSE)
	else if(damage_dealt)
		playsound(src, armor_damaged_sound, 80, FALSE)
		if(iscarbon(loc))
			var/mob/loc_as_mob = loc
			loc_as_mob.playsound_local(src, armor_damage_sound_local, 80, FALSE)

	return TRUE

/obj/item/clothing/disable_zone(def_zone, damage_type)
	var/list/covered_limbs = body_parts_covered2organ_names(body_parts_covered)
	if(!(def_zone in covered_limbs))
		return

	var/zone_name = parse_zone(def_zone)
	var/break_verb = ((damage_type == BRUTE) ? "torn" : "burnt")

	if(iscarbon(loc))
		var/mob/living/carbon/carbon = loc
		carbon.visible_message(span_danger("The [zone_name] on [carbon]'s [src.name] is [break_verb] away!"), \
							span_userdanger("The [zone_name] on my [src.name] is [break_verb] away!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		RegisterSignal(carbon, COMSIG_MOVABLE_MOVED, .proc/bristle, override = TRUE)

	zones_disabled++
	for(var/bitflag in zone2body_parts_covered(def_zone))
		body_parts_covered &= ~bitflag

	// if there are no more parts to break then the whole thing is kaput
	if(body_parts_covered == NONE)
		// melee/laser is good enough since this only procs from direct attacks anyway and not from fire/bombs
		atom_destruction((damage_type == BRUTE ? MELEE : LASER))
		return

	switch(zones_disabled)
		if(1)
			name = "damaged [initial(name)]"
		if(2)
			name = "mangy [initial(name)]"
		// take better care of your shit, dude
		if(3 to INFINITY)
			name = "battered [initial(name)]"

	update_clothes_damaged_state(CLOTHING_DAMAGED)
	update_appearance()

// this FULLY repairs the clothing
/obj/item/clothing/repair(mob/user, params)
	update_clothes_damaged_state(CLOTHING_PRISTINE)
	atom_integrity = max_integrity
	name = initial(name) // remove "tattered" or "shredded" if there's a prefix
	body_parts_covered = initial(body_parts_covered)
	slot_flags = initial(slot_flags)
	damage_by_parts = null
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("I fix the damage on [src]."))
	update_appearance()

/obj/item/clothing/bristle(mob/living/wearer)
	if(prob(0.2))
		if(!istype(wearer))
			return
		to_chat(wearer, span_warning("The damaged threads on my [src.name] chafe!"))

/obj/item/clothing/examine(mob/user)
	. = ..()

	if(LAZYLEN(armor_list))
		armor_list.Cut()
	if(subarmor.edge_protection)
		armor_list += list("EDGE PROTECTION" = subarmor.edge_protection)
	if(subarmor.crushing)
		armor_list += list("BLUNT" = subarmor.crushing)
	if(subarmor.cutting)
		armor_list += list("SLASHING" = subarmor.cutting)
	if(subarmor.piercing)
		armor_list += list("PIERCING" = subarmor.piercing)
	if(subarmor.impaling)
		armor_list += list("IMPALING" = subarmor.impaling)
	if(subarmor.laser)
		armor_list += list("LASER" = subarmor.laser)
	if(armor.bomb)
		armor_list += list("EXPLOSIVE" = armor.bomb)
	if(armor.energy)
		armor_list += list("ENERGY" = armor.energy)
	if(armor.bio)
		armor_list += list("BIOLOGICAL" = armor.bio)

	if(LAZYLEN(durability_list))
		durability_list.Cut()
	if(armor.fire)
		durability_list += list("FIRE" = armor.fire)
	if(armor.acid)
		durability_list += list("ACID" = armor.acid)

	if(LAZYLEN(armor_list) || LAZYLEN(durability_list))
		. += span_notice("It has a <a href='?src=[REF(src)];list_armor=1'>tag</a> listing its protection classes.")

/obj/item/clothing/Topic(href, href_list)
	. = ..()
	if(href_list["list_armor"])
		var/list/readout = list("<span class='infoplain'><div class='infobox'>")
		readout += span_notice("<center><u><b>PROTECTION CLASSES (I-X)</b></u></center>")
		if(subarmor.subarmor_flags & SUBARMOR_FLEXIBLE)
			readout += span_smallnotice("\n<center><i><b>FLEXIBLE ARMOR</b></i></center>")
		readout += "\n<br><hr class='infohr'>"
		if(LAZYLEN(armor_list))
			readout += span_notice("\n<b>ARMOR</b>")
			for(var/dam_type in armor_list)
				var/armor_amount = armor_list[dam_type]
				readout += span_info("\n[dam_type] [armor_to_protection_class(armor_amount)]") //e.g. BOMB IV
		if(LAZYLEN(durability_list))
			readout += span_notice("\n<b>DURABILITY</b>")
			for(var/dam_type in durability_list)
				var/durability_amount = durability_list[dam_type]
				readout += span_info("\n[dam_type] [armor_to_protection_class(durability_amount)]") //e.g. FIRE II
		readout += "</div></span>" //div infobox

		to_chat(usr, "[readout.Join()]")

/obj/item/clothing/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	if(atom_integrity <= 0)
		return 0
	return ..()

// this FULLY repairs the clothing
/obj/item/clothing/proc/repair_zone(mob/user, def_zone, params)
	if(!def_zone)
		return
	repair_damage(limb_integrity/10)
	zones_disabled = max(0, zones_disabled - 1)
	for(var/bitflag in zone2body_parts_covered(def_zone))
		if(initial(body_parts_covered) & bitflag)
			body_parts_covered |= bitflag
	damage_by_parts -= def_zone
	name = initial(name) // remove "tattered" or "shredded" if there's a prefix
	slot_flags = initial(slot_flags)
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("I fix the damage on [src]'s [parse_zone(def_zone)]."))
	switch(zones_disabled)
		if(1)
			name = "damaged [initial(name)]"
		if(2)
			name = "mangy [initial(name)]"
		// take better care of your shit, dude
		if(3 to INFINITY)
			name = "battered [initial(name)]"
	if(zones_disabled <= 0)
		repair_damage(max_integrity)
		update_clothes_damaged_state(CLOTHING_PRISTINE)
	else
		update_clothes_damaged_state(CLOTHING_DAMAGED)
	update_appearance()
