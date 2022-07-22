/obj/item/simcard
	name = "\improper sim card"
	desc = "Sim, sim, I agree with your statement"
	icon = 'modular_septic/icons/obj/items/phone.dmi'
	icon_state = "simcard"
	base_icon_state = "simcard"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	/// Username of the sim card, used even when not public
	var/username
	/// Phone number (this is actually a string lol)
	var/phone_number
	/// Whether we are in the public phone list or not
	var/publicity = FALSE
	/// Phone we are inside of
	var/obj/item/cellphone/parent
	/// List of applications we are storing (lazylist)
	var/list/datum/simcard_application/applications
	/**
	 * List of viruses we are storing
	 * Viruses get processed frequently, unlike applications
	 */
	var/list/datum/simcard_virus/viruses

	/**
	 * Firewall health of the simcard
	 * When this is above 0, we can defend ourselves against DoS attacks.
	 */
	var/firewall_health = 0
	/// Maximum firewall health of the simcard
	var/firewall_maxhealth = 0
	/// Sim cards with virus immunity will not get infected by viruses, ever
	var/virus_immunity = FALSE

/obj/item/simcard/Initialize(mapload)
	. = ..()
	generate_phone_number()
	GLOB.simcard_list[phone_number] = src
	if(LAZYLEN(applications))
		var/list/old_apps = applications.Copy()
		applications = list()
		for(var/application in old_apps)
			new application(src)

/obj/item/simcard/Destroy()
	. = ..()
	QDEL_LIST(applications)
	QDEL_LIST(viruses)
	GLOB.active_public_simcard_list -= username
	GLOB.active_simcard_list -= phone_number
	GLOB.simcard_list -= phone_number
	GLOB.simcard_list_by_username -= username

/obj/item/simcard/proc/toggle_publicity()
	publicity = !publicity
	if(publicity && parent && username)
		GLOB.active_public_simcard_list[username] = src
	else
		GLOB.active_public_simcard_list -= username

/obj/item/simcard/proc/generate_phone_number()
	if(phone_number)
		GLOB.simcard_list -= phone_number
	phone_number = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]-[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	GLOB.simcard_list[phone_number] = src
