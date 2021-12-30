
/// depending on the species, it will run the corresponding apply_damage code there
/mob/living/carbon/human/apply_damage(damage, \
							damagetype = BRUTE, \
							def_zone = null, \
							blocked = FALSE, \
							forced = FALSE, \
							spread_damage = FALSE, \
							wound_bonus = 0, \
							bare_wound_bonus = 0, \
							sharpness = NONE, \
							organ_bonus = 0, \
							bare_organ_bonus = 0)
	return dna.species.apply_damage(damage, damagetype, def_zone, blocked, src, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, organ_bonus, bare_organ_bonus)
