/obj/item/knife
	carry_weight = 0.4

/obj/item/knife/combat
	carry_weight = 0.8

//Horrible
/obj/item/knife/combat/zhunter
	name = "z-hunter brand knife"
	desc = "Illegal in the Separated Kingdom, this surplus knife is barely able to cut through skin. It can, however, hunt many Z's."
	icon = 'modular_septic/icons/obj/items/melee/knife.dmi'
	icon_state = "zhunter"
	force = 10
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 0
	bare_wound_bonus = 5

//Nice sexy sex
/obj/item/melee/truncheon
	name = "truncheon"
	desc = "A tool to beat the melanin out of criminals."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon"
	force = 15
	wound_bonus = 3
	bare_wound_bonus = 0
	carry_weight = 2.5
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"

/obj/item/melee/truncheon/black
	name = "black truncheon"
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon_black"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon_black"
