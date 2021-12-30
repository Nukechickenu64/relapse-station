//This didn't have the arms for some reason
/datum/supply_pack/science/robotics
	desc = "The tools you need to replace those finicky humans with a loyal robot army! \
	Contains four proximity sensors, two empty first aid kits, two health analyzers, two red hardhats, \
	two mechanical toolboxes, four cyborg arms and two cleanbot assemblies! Requires Robotics access to open."
	contains = list(/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/storage/firstaid,
					/obj/item/storage/firstaid,
					/obj/item/healthanalyzer,
					/obj/item/healthanalyzer,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bot_assembly/cleanbot,
					/obj/item/bot_assembly/cleanbot)

/datum/supply_pack/science/cyborg_parts
	name = "Cyborg Parts Crate" //I've peppered the "R­o­b­o­C­o­p" with zero-widths. I'm not taking any risks.
	desc = "Did you lose your arm and can't seem to find it? Was your every limb swallowed by gangrene? Are you just trying to cosplay as­ RoboCop?\
			If you answered yes to any of these questions, this is the pack for you! Contains a set of cyborg arms, legs, a head and a chest.\
			Miscellaneous limbs and organs may be sold seperately. Requires Robotics access to open. No copyright infringement intended."
	cost = 1400
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	contains = list(/obj/item/bodypart/head/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/l_arm/robot,
					/obj/item/bodypart/r_leg/robot,
					/obj/item/bodypart/l_leg/robot,
					/obj/item/bodypart/chest/robot)
	crate_name = "robotics assembly crate"
	crate_type = /obj/structure/closet/crate/secure/science
