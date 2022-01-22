GLOBAL_LIST_INIT(bloodyable, typecacheof(list(/mob/living/carbon/human)))

/datum/component/creamed/blood
	cover_lips = span_bloody("blood")

/datum/component/creamed/blood/return_creamable_list()
	return GLOB.bloodyable

/datum/component/creamed/blood/cream()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, type)
	creamface = mutable_appearance('modular_septic/icons/effects/blood.dmi', "maskblood")
	var/atom/A = parent
	A.add_overlay(creamface)
