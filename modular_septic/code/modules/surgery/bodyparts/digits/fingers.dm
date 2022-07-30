/obj/item/digit/finger
	name = "finger"
	desc = "Okay class, today we are going to finger paint."
	icon_state = "finger"
	base_icon_state = "finger"

/obj/item/digit/finger/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/kidnamedfinger.jpg', user, format = "jpg", sourceonly = TRUE)
	. += "<img src='[image_src]' width=160 height=90>"
