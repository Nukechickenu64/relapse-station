/datum/wield_info
	/// WIELD_WIELDABLE, WIELD_ALWAYS_TWOHANDED, WIELD_NO_ATTACK_SELF
	var/wield_flags = NONE
	/// The multiplier applied to force when wielded, does not work with force_wielded nor force_unwielded
	var/force_multiplier = null
	/// The force of the item when wielded
	var/force_wielded = null
	/// The force of the item when unwielded
	var/force_unwielded = null
	/// Play this sound when wielded
	var/wield_sound = null
	/// Play this sound when unwielded
	var/unwield_sound = null
	/// Play this sound on attack when wielded
	var/wield_hitsound = null
	/// The inhand icon that will be used when wielded
	var/icon_wielded = null
