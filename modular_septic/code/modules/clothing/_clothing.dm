/obj/item/clothing
	// Assume that clothing isn't too weighty by default
	carry_weight = 2

/obj/item/clothing/take_damage_zone(def_zone, damage_amount, damage_type, armour_penetration)
	if(!def_zone || !limb_integrity || (initial(body_parts_covered) in GLOB.bitflags)) // the second check sees if we only cover one bodypart anyway and don't need to bother with this
		return
	var/list/covered_limbs = body_parts_covered2organ_names(body_parts_covered) // what do we actually cover?
	if(!(def_zone in covered_limbs))
		return

	var/damage_dealt = take_damage(damage_amount * 0.1, damage_type, armour_penetration, FALSE) * 10 // only deal 10% of the damage to the general integrity damage, then multiply it by 10 so we know how much to deal to limb
	LAZYINITLIST(damage_by_parts)
	damage_by_parts[def_zone] += damage_dealt
	if(damage_by_parts[def_zone] > limb_integrity)
		disable_zone(def_zone, damage_type)

/obj/item/clothing/bristle(mob/living/wearer)
	if(!istype(wearer))
		return
	if(prob(0.2))
		to_chat(wearer, span_warning("The damaged threads on my [src.name] chafe!"))

/obj/item/clothing/Topic(href, href_list)
	. = ..()
	if(href_list["list_armor"])
		var/list/readout = list("<span class='infoplain'><div class='infobox'>")
		readout += span_notice("<center><u><b>PROTECTION CLASSES (I-X)</u></b></center>")
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
