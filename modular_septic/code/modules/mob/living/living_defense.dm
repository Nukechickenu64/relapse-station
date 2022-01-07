#define LIVING_UNARMED_ATTACK_BLOCKED(target_atom) (HAS_TRAIT(src, TRAIT_HANDS_BLOCKED) \
	|| (SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, target_atom, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN))

/mob/living/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	var/sharpness = hitting_projectile.get_sharpness()
	var/armor = run_armor_check(def_zone, \
								hitting_projectile.flag,
								"", \
								"", \
								hitting_projectile.armour_penetration, \
								"", \
								FALSE, \
								hitting_projectile.weak_against_armour, \
								sharpness)
	var/subarmor = run_subarmor_check(def_zone, \
								hitting_projectile.flag,
								"", \
								"", \
								hitting_projectile.subtractible_armour_penetration, \
								"", \
								FALSE, \
								hitting_projectile.weak_against_subtractible_armour, \
								sharpness)
	var/edge_protection = get_edge_protection(def_zone)
	var/subarmor_flags = get_subarmor_flags(def_zone)
	var/on_hit_state = hitting_projectile.on_hit(src, armor, piercing_hit)
	if(!hitting_projectile.nodamage && on_hit_state != BULLET_ACT_BLOCK)
		apply_damage(hitting_projectile.damage, \
					hitting_projectile.damage_type, \
					def_zone, \
					armor, \
					wound_bonus = hitting_projectile.wound_bonus, \
					bare_wound_bonus = hitting_projectile.bare_wound_bonus, \
					sharpness = hitting_projectile.sharpness, \
					organ_bonus = hitting_projectile.organ_bonus, \
					bare_organ_bonus = hitting_projectile.bare_organ_bonus, \
					reduced = subarmor, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		if(hitting_projectile.pain)
			apply_damage(hitting_projectile.pain,
						PAIN,
						blocked = armor, \
						reduced = subarmor, \
						edge_protection = edge_protection, \
						subarmor_flags = subarmor_flags)
		apply_effects(stun = hitting_projectile.stun, \
					knockdown = hitting_projectile.knockdown, \
					unconscious = hitting_projectile.unconscious, \
					slur = hitting_projectile.slur, \
					stutter = hitting_projectile.stutter, \
					eyeblur = hitting_projectile.eyeblur, \
					drowsy = hitting_projectile.drowsy, \
					stamina = hitting_projectile.stamina, \
					jitter = hitting_projectile.jitter, \
					paralyze = hitting_projectile.paralyze, \
					immobilize = hitting_projectile.immobilize, \
					blocked = armor)
		if(hitting_projectile.dismemberment)
			check_projectile_dismemberment(hitting_projectile, def_zone)
		hitting_projectile.damage = max(0,  hitting_projectile.damage - (initial(hitting_projectile.damage) * PROJECTILE_DAMAGE_REDUCTION_ON_HIT))
	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/UnarmedHand(atom/attack_target, proximity_flag, list/modifiers)
	if(LIVING_UNARMED_ATTACK_BLOCKED(attack_target))
		return
	attack_target.attack_hand(src, modifiers)

/mob/living/UnarmedFoot(atom/attack_target, proximity_flag, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	attack_target.attack_foot(src, modifiers)

/mob/living/UnarmedJaw(atom/attack_target, proximity_flag, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	attack_target.attack_jaw(src, modifiers)

#undef LIVING_UNARMED_ATTACK_BLOCKED
