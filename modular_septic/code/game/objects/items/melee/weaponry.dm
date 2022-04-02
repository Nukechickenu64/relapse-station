/obj/item/knife
	skill_melee = SKILL_KNIFE
	carry_weight = 0.4

/obj/item/knife/combat
	carry_weight = 0.8

//Horrible
/obj/item/knife/combat/zhunter
	name = "z-hunter brand knife"
	desc = "Illegal in the Separated Kingdom, this surplus knife is barely able to cut through skin. It can, however, hunt many Z's."
	icon = 'modular_septic/icons/obj/items/melee/knife.dmi'
	icon_state = "zhunter"
	min_force = 3
	force = 10
	min_force_strength = 0
	force_strength = 0
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
	min_force = 3
	force = 5
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 3
	bare_wound_bonus = 0
	carry_weight = 2.5
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_IMPACT_WEAPON

/obj/item/melee/truncheon/black
	name = "black truncheon"
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon_black"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon_black"

/obj/item/lead_pipe/afterattack(atom/target, mob/user, proximity_flag, params)
	. = ..()
	if(ishuman(target) && proximity_flag && (user.zone_selected == BODY_ZONE_HEAD))
		user.client?.give_award(/datum/award/achievement/misc/leadpipe, user)

/obj/item/fireaxe
	parring_modifier = 0
	skill_melee = SKILL_POLEARM
	min_force = 7
	force = 10
	min_force_strength = 1
	force_strength = 1.5

/obj/item/melee/sabre
	parrying_modifier = 0
	skill_melee = SKILL_RAPIER

/obj/item/melee/chainofcommand
	parrying_modifier = -4
	skill_melee = SKILL_FLAIL

/obj/item/melee/curator_whip
	parrying_modifier = -4
	skill_melee = SKILL_FLAIL

/obj/item/claymore
	parrying_modifier = 0
	skill_melee = SKILL_LONGSWORD

/obj/item/claymore/cutlass
	parrying_modifier = 0
	skill_melee = SKILL_SHORTSWORD

/obj/item/katana
	parrying_modifier = 0
	skill_melee = SKILL_LONGSWORD

/obj/item/switchblade
	parrying_modifier = -2
	skill_melee = SKILL_KNIFE

/obj/item/mounted_chainsaw
	parrying_modifier = -1
	skill_melee = SKILL_POLEARM

/obj/item/chainsaw
	parrying_modifier = -1
	skill_melee = SKILL_POLEARM

/obj/item/melee/baseball_bat
	parrying_modifier = 0
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED

/obj/item/gohei
	parrying_modifier = 0
	skill_melee = SKILL_STAFF

/obj/item/vibro_weapon
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/melee/moonlight_greatsword
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/spear
	parrying_modifier = 0
	skill_melee = SKILL_SPEAR

/obj/item/singularityhammer
	parrying_modifier = -2
	skill_melee = SKILL_POLEARM

/obj/item/mjollnir
	parrying_modifier = -1
	skill_melee = SKILL_POLEARM

/obj/item/pitchfork
	parrying_modifier = -1
	skill_melee = SKILL_SPEAR

/obj/item/melee/energy
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/dualsaber
	parrying_modifier = 2
	skill_melee = SKILL_FORCESWORD
