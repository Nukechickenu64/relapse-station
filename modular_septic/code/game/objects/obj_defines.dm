/obj
	/// Damage can vary from min_force to force, when attacking
	var/min_force
	/// Damage we gain (or lose) from 0 strength
	var/strength_force_minimum = 0
	/// Damage we gain (or lose) from 20 strength
	var/strength_force_maximum = 0
	/// How good a given object is at causing organ damage on carbons. Higher values equal better shots at creating serious organ damage.
	var/organ_bonus = 0
	/// If this attacks a human with no organ armor on the affected body part, add this to the organ mod. Some attacks may be significantly worse at organ damage if there's even a slight layer of armor to absorb some of it vs bare flesh.
	var/bare_organ_bonus = 0
