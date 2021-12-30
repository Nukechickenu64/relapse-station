/datum/element/embed/checkEmbed(obj/item/weapon, mob/living/carbon/victim, hit_zone, datum/thrownthing/throwingdatum, forced=FALSE, silent=FALSE)
	if(!istype(victim) || HAS_TRAIT(victim, TRAIT_PIERCEIMMUNE))
		return

	var/flying_speed = throwingdatum?.speed || weapon.throw_speed

	if(!forced && (flying_speed < EMBED_THROWSPEED_THRESHOLD) && !ignore_throwspeed_threshold) // check if it's a forced embed, and if not, if it's going fast enough to proc embedding
		return

	var/actual_chance = embed_chance
	var/penetrative_behaviour = 1 //Keep this above 1, as it is a multiplier for the pen_mod for determining actual embed chance.
	if(weapon.weak_against_armour)
		penetrative_behaviour = ARMOR_WEAKENED_MULTIPLIER

	if(throwingdatum?.speed > weapon.throw_speed)
		actual_chance += (throwingdatum.speed - weapon.throw_speed) * EMBED_CHANCE_SPEED_BONUS

	if(!weapon.isEmbedHarmless()) // all the armor in the world won't save you from a kick me sign
		var/armor = max(victim.run_armor_check(hit_zone, BULLET, silent=TRUE), victim.run_armor_check(hit_zone, BOMB, silent=TRUE)) * 0.5 // we'll be nice and take the better of bullet and bomb armor, halved

		if(armor) // we only care about armor penetration if there's actually armor to penetrate
			var/pen_mod = -(armor * penetrative_behaviour) // if our shrapnel is weak into armor, then we restore our armor to the full value.
			actual_chance += pen_mod // doing the armor pen as a separate calc just in case this ever gets expanded on
			if(actual_chance <= 0)
				if(!silent)
					victim.visible_message(span_danger("[weapon] bounces off [victim]'s armor, unable to embed!"), span_notice("[weapon] bounces off your armor, unable to embed!"), vision_distance = COMBAT_MESSAGE_RANGE)
				return

	if(!prob(actual_chance))
		return

	var/obj/item/bodypart/limb = victim.get_bodypart(hit_zone) || pick(victim.bodyparts)
	var/supply_injury = limb.last_injury
	if(!weapon.isEmbedHarmless() && (!limb.last_injury || !(limb.last_injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE))) )
		supply_injury = limb.create_injury(WOUND_PIERCE, weapon.w_class * 4)

	victim.AddComponent(/datum/component/embedded,\
		weapon,\
		throwingdatum,\
		part = limb,\
		embed_chance = embed_chance,\
		fall_chance = fall_chance,\
		pain_chance = pain_chance,\
		pain_mult = pain_mult,\
		remove_pain_mult = remove_pain_mult,\
		rip_time = rip_time,\
		ignore_throwspeed_threshold = ignore_throwspeed_threshold,\
		jostle_chance = jostle_chance,\
		jostle_pain_mult = jostle_pain_mult,\
		pain_stam_pct = pain_stam_pct,\
		supplied_injury = supply_injury,\
		silence_message = silent, \
		)

	return TRUE

/datum/element/embed/tryForceEmbed(obj/item/embedder, atom/target, hit_zone, forced=FALSE, silent=FALSE)
	SIGNAL_HANDLER

	var/obj/item/bodypart/limb
	var/mob/living/carbon/limb_owner

	if(!forced && !prob(embed_chance))
		return

	if(iscarbon(target))
		limb_owner = target
		if(!hit_zone)
			limb = pick(limb_owner.bodyparts)
			hit_zone = limb.body_zone
	else if(isbodypart(target))
		limb = target
		hit_zone = limb.body_zone
		limb_owner = limb.owner

	return checkEmbed(embedder, limb_owner, hit_zone, forced=TRUE, silent=TRUE)

/datum/element/embed/proc/projectile_posthit(obj/projectile/projectile, atom/movable/firer, atom/hit, result, mode)
	SIGNAL_HANDLER

	if(!iscarbon(hit) || (result != BULLET_ACT_HIT) || (mode != PROJECTILE_PIERCE_NONE))
		return

	var/obj/item/payload = new payload_type(get_turf(hit))
	if(istype(payload, /obj/item/shrapnel/bullet))
		payload.name = "[projectile.name] shrapnel"
	payload.embedding = projectile.embedding
	payload.updateEmbedding()
	var/mob/living/carbon/carbon_hit = hit
	var/obj/item/bodypart/limb = carbon_hit.get_bodypart(projectile.def_zone)
	//Oh no
	if(!limb)
		return

	// at this point we've created our shrapnel baby and set them up to embed in the target, we can now die in peace as they handle their embed try on their own
	if(payload.tryEmbed(limb, silent = TRUE))
		SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_EMBEDDED, limb)
	else
		SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_WENT_THROUGH, limb)
	Detach(projectile)
