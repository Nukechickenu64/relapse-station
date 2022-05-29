/obj/item/money/coin
	name = "coin"
	desc = "My life is like a videogame, trying hard to beat the stage, all while i am still collecting coins."
	flags_1 = CONDUCT_1
	custom_materials = list(/datum/material/iron = 400)
	is_coin = TRUE
	var/list/sides = list("heads","tails")
	var/side
	COOLDOWN_DECLARE(flip_cooldown)

/obj/item/money/coin/Initialize(mapload)
	. = ..()
	if(LAZYLEN(sides))
		side = pick(sides)
		update_appearance()
