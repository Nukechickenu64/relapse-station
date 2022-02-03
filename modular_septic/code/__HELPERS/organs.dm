/proc/setup_bones()
	. = list()
	.[/obj/item/organ/bone] = new /obj/item/organ/bone()
	for(var/thing in init_subtypes(/obj/item/organ/bone))
		var/obj/item/organ/bone = thing
		.[bone.type] = bone

/proc/setup_tendons()
	. = list()
	.[/obj/item/organ/tendon] = new /obj/item/organ/tendon()
	for(var/thing in init_subtypes(/obj/item/organ/tendon))
		var/obj/item/organ/tendon = thing
		.[tendon.type] = tendon

/proc/setup_nerves()
	. = list()
	.[/obj/item/organ/nerve] = new /obj/item/organ/nerve()
	for(var/thing in init_subtypes(/obj/item/organ/nerve))
		var/obj/item/organ/nerve = thing
		.[nerve.type] = nerve

/proc/setup_arteries()
	. = list()
	.[/obj/item/organ/artery] = new /obj/item/organ/artery()
	for(var/thing in init_subtypes(/obj/item/organ/artery))
		var/obj/item/organ/artery = thing
		.[artery.type] = artery
