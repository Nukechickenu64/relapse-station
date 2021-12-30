/obj/projectile/bullet/shotgun_beanbag
	name = "beanbag slug"
	damage = 15
	wound_bonus = 25
	pain = 60
	stamina = 20
	sharpness = NONE

/obj/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = 4
	wound_bonus = 4
	pain = 10
	stamina = 3
	sharpness = NONE

/obj/projectile/bullet/shotgun_slug
	name = "12g slug"
	damage = 60
	wound_bonus = 0
	sharpness = SHARP_POINTY
	embedding = list("embed_chance"=70, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=10, \
					"rip_time"=40)

/obj/projectile/bullet/shotgun_ap
	name = "12g armor-piercing slug"
	damage = 57
	wound_bonus = 0
	sharpness = SHARP_POINTY
	embedding = list("embed_chance"=50, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=10, \
					"rip_time"=40)

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "12g pellet"
	damage = 10
	wound_bonus = 5
	bare_wound_bonus = 5
	wound_falloff_tile = 0
	embedding = list("embed_chance"=95, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=6,
					"rip_time"=25)
	sharpness = SHARP_POINTY

/obj/projectile/bullet/pellet/shotgun_flechette
	name = "12g flechette"
	damage = 6
	wound_bonus = -3
	bare_wound_bonus = 0
	wound_falloff_tile = -1
	embedding = list("embed_chance"=100, \
					"fall_chance"=0, \
					"jostle_chance"=5, \
					"ignore_throwspeed_threshold"=TRUE, \
					"pain_stam_pct"=0.5, \
					"pain_mult"=0, \
					"pain_jostle_mult"=10, \
					"rip_time"=25)
	sharpness = SHARP_POINTY
