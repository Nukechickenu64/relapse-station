/obj/item/clothing
	// Assume that clothing isn't too weighty by default
	carry_weight = 2

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

/obj/item/clothing/bristle(mob/living/wearer)
	if(!istype(wearer))
		return
	if(prob(0.2))
		to_chat(wearer, span_warning("The damaged threads on my [src.name] chafe!"))

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
