/obj/item/digit/toe
	name = "toe"
	desc = "I stubbed my toe."
	icon_state = "toe"
	base_icon_state = "toe"

/obj/item/digit/toe/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/kidnamedtoe.jpg', user, format = "jpg", sourceonly = TRUE)
	. += "<img src='[image_src]' width=160 height=90>"
