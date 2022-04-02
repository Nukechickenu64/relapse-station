/obj/projectile/bullet/l40mm
	name ="40mm fragmentation grenade"
	desc = "MEU DEUS"
	icon_state= "bolter"
	damage = 60
	embedding = null
	shrapnel_type = null

/obj/projectile/bullet/l40mm/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, devastation_range = -1, light_impact_range = 3, flame_range = 4, flash_range = 1, adminlog = FALSE, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/l40mm/examine(mob/user)
	. = ..()
	user.client?.give_award(/datum/award/achievement/misc/meudeus, user)
