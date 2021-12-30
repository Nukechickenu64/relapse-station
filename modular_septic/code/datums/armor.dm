#define ARMORID "armor-[melee]-[bullet]-[laser]-[energy]-[bomb]-[bio]-[fire]-[acid]-[magic]-[wound]-[organ]"

/proc/getArmor(melee = 0, \
			bullet = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	. = locate(ARMORID)
	if (!.)
		. = new /datum/armor(melee, bullet, laser, energy, bomb, bio, fire, acid, magic, wound)

/datum/armor
	var/organ

/datum/armor/New(melee = 0, \
			bullet = 0, \
			laser = 0, \
			energy = 0, \
			bomb = 0, \
			bio = 0, \
			fire = 0, \
			acid = 0, \
			magic = 0, \
			wound = 0, \
			organ = 0)
	src.melee = melee
	src.bullet = bullet
	src.laser = laser
	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.fire = fire
	src.acid = acid
	src.magic = magic
	src.wound = wound
	src.consume = melee
	src.organ = organ
	tag = ARMORID

/datum/armor/modifyRating(melee = 0, \
							bullet = 0, \
							laser = 0, \
							energy = 0, \
							bomb = 0, \
							bio = 0, \
							fire = 0, \
							acid = 0, \
							magic = 0, \
							wound = 0, \
							organ = 0)
	return getArmor(src.melee+melee, \
					src.bullet+bullet, \
					src.laser+laser, \
					src.energy+energy, \
					src.bomb+bomb, \
					src.bio+bio, \
					src.fire+fire, \
					src.acid+acid, \
					src.magic+magic, \
					src.wound+wound, \
					src.organ+organ)

/datum/armor/modifyAllRatings(modifier = 0)
	return getArmor(melee+modifier, \
				bullet+modifier, \
				laser+modifier, \
				energy+modifier, \
				bomb+modifier, \
				bio+modifier, \
				fire+modifier, \
				acid+modifier, \
				magic+modifier, \
				wound+modifier, \
				organ+modifier)

/datum/armor/setRating(melee, bullet, laser, energy, bomb, bio, fire, acid, magic, wound, organ)
	return getArmor((isnull(melee) ? src.melee : melee),\
					(isnull(bullet) ? src.bullet : bullet),\
					(isnull(laser) ? src.laser : laser),\
					(isnull(energy) ? src.energy : energy),\
					(isnull(bomb) ? src.bomb : bomb),\
					(isnull(bio) ? src.bio : bio),\
					(isnull(fire) ? src.fire : fire),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(magic) ? src.magic : magic),\
					(isnull(wound) ? src.wound : wound), \
					(isnull(organ) ? src.organ : organ))

/datum/armor/getList()
	return list(MELEE = melee, \
				BULLET = bullet, \
				LASER = laser, \
				ENERGY = energy, \
				BOMB = bomb, \
				BIO = bio, \
				FIRE = fire, \
				ACID = acid, \
				MAGIC = magic, \
				WOUND = wound, \
				ORGAN = organ)

/datum/armor/attachArmor(datum/armor/AA)
	return getArmor(melee+AA.melee, \
					bullet+AA.bullet, \
					laser+AA.laser, \
					energy+AA.energy, \
					bomb+AA.bomb, \
					bio+AA.bio, \
					fire+AA.fire, \
					acid+AA.acid, \
					magic+AA.magic, \
					wound+AA.wound, \
					organ+AA.organ)

/datum/armor/detachArmor(datum/armor/AA)
	return getArmor(melee-AA.melee, \
					bullet-AA.bullet, \
					laser-AA.laser, \
					energy-AA.energy, \
					bomb-AA.bomb, \
					bio-AA.bio, \
					fire-AA.fire, \
					acid-AA.acid, \
					magic-AA.magic, \
					wound-AA.wound, \
					organ-AA.organ)

/datum/armor/vv_edit_var(var_name, var_value)
	. = ..()
	tag = ARMORID // update tag in case armor values were edited

#undef ARMORID
