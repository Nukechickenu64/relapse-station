/datum/crafting_recipe/solitario //SABER
	name = "Solitario-SD \"SABER\" Conversion"
	result = /obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/no_mag
	tool_behaviors = list(TOOL_SCREWDRIVER)
	reqs = list(/obj/item/gun/ballistic/automatic/remis/smg/solitario = 1,
				/obj/item/ballistic_mechanisms/solitario_sd = 1,
				/obj/item/suppressor = 1)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
