/proc/setup_bones()
	. = list()
	for(var/thing in init_subtypes(/obj/item/organ/bone))
		var/obj/item/organ/bone = thing
		.[bone.type] = bone
	.[/obj/item/organ/bone] = new /obj/item/organ/bone()

/proc/setup_tendons()
	. = list()
	for(var/thing in init_subtypes(/obj/item/organ/tendon))
		var/obj/item/organ/tendon = thing
		.[tendon.type] = tendon
	.[/obj/item/organ/tendon] = new /obj/item/organ/tendon()

/proc/setup_nerves()
	. = list()
	for(var/thing in init_subtypes(/obj/item/organ/nerve))
		var/obj/item/organ/nerve = thing
		.[nerve.type] = nerve
	.[/obj/item/organ/nerve] = new /obj/item/organ/nerve()

/proc/setup_arteries()
	. = list()
	for(var/thing in init_subtypes(/obj/item/organ/artery))
		var/obj/item/organ/artery = thing
		.[artery.type] = artery
	.[/obj/item/organ/artery] = new /obj/item/organ/artery()
