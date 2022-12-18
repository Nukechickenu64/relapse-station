/obj/item/fireaxe
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	min_force = 5
	force = 7
	min_force_strength = 0.4
	force_strength = 0.8
	wound_bonus = 5
	bare_wound_bonus = 10
	carry_weight = 4.5 KILOGRAMS
	wield_info = /datum/wield_info/fireaxe

/obj/item/fireaxe/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_destructive, "fireaxe", TRUE, TRUE)
