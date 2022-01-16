/obj/item/ammo_casing/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if(!loaded_projectile)
		return
	loaded_projectile.original = target
	loaded_projectile.firer = user
	loaded_projectile.fired_from = fired_from
	loaded_projectile.hit_prone_targets = user.combat_mode
	loaded_projectile.suppressed = quiet
	loaded_projectile.diceroll_modifier += diceroll_modifier
	if(target_specific_diceroll)
		LAZYOR(loaded_projectile.target_specific_diceroll, target_specific_diceroll)
	if(isgun(fired_from))
		var/obj/item/gun/gun = fired_from
		loaded_projectile.damage *= gun.projectile_damage_multiplier
		loaded_projectile.stamina *= gun.projectile_damage_multiplier
		loaded_projectile.diceroll_modifier += gun.diceroll_modifier
		loaded_projectile.skill_ranged = gun.skill_ranged

	//For chemical darts/bullets
	if(reagents && loaded_projectile.reagents)
		reagents.trans_to(loaded_projectile, reagents.total_volume, transfered_by = user)
		qdel(reagents)

	if(zone_override)
		loaded_projectile.def_zone = zone_override
	else
		loaded_projectile.def_zone = user.zone_selected
		if(istype(user) && user.attributes)
			var/skill_modifier = 0
			if(loaded_projectile.skill_ranged)
				skill_modifier += GET_MOB_SKILL_VALUE(user, loaded_projectile.skill_ranged)
			var/diceroll = user.diceroll(skill_modifier)
			//Change zone on fails
			if(diceroll < DICE_FAILURE)
				loaded_projectile.def_zone = ran_zone(user.zone_selected, 0)
	if(ishuman(user))
		var/distance = get_dist(loaded_projectile.starting, loaded_projectile.original)
		loaded_projectile.decayedRange = distance
		loaded_projectile.range = distance
