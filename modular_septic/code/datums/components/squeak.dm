/datum/component/squeak/Initialize(custom_sounds, volume_override, chance_override, step_delay_override, use_delay_override, extrarange, falloff_exponent, fallof_distance)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_BLOB_ACT, COMSIG_ATOM_HULK_ATTACK, COMSIG_PARENT_ATTACKBY), .proc/play_squeak)
	if(ismovable(parent))
		RegisterSignal(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT, COMSIG_PROJECTILE_BEFORE_FIRE), .proc/play_squeak)

		AddComponent(/datum/component/connect_loc_behalf, parent, item_connections)
		RegisterSignal(parent, COMSIG_MOVABLE_DISPOSING, .proc/disposing_react)
		if(isitem(parent))
			RegisterSignal(parent, list(COMSIG_ITEM_ATTACK, COMSIG_ITEM_ATTACK_OBJ, COMSIG_ITEM_HIT_REACT), .proc/play_squeak)
			RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, .proc/use_squeak)
			RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
			RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)
			if(istype(parent, /obj/item/clothing))
				RegisterSignal(parent, COMSIG_SHOES_STEP_ACTION, .proc/step_squeak)
		else if(isstructure(parent))
			RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, .proc/use_squeak)

	if(istype(parent, /obj/item/organ/liver))
		// Liver squeaking is depending on them functioning like a clown's liver
		RegisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_COMEDY_METABOLISM), .proc/on_comedy_metabolism_removal)

	override_squeak_sounds = custom_sounds
	if(chance_override)
		squeak_chance = chance_override
	if(volume_override)
		volume = volume_override
	if(isnum(step_delay_override))
		step_delay = step_delay_override
	if(isnum(use_delay_override))
		use_delay = use_delay_override
	if(isnum(extrarange))
		sound_extra_range = extrarange
	if(isnum(falloff_exponent))
		sound_falloff_exponent = falloff_exponent
	if(isnum(fallof_distance))
		sound_falloff_distance = fallof_distance
