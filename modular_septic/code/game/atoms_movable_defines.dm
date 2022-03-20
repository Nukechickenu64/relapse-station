/atom/movable
	/// Thrown damage can vary from min_throwforce to throwforce when attacking, regardless of stats
	var/min_throwforce
	/// Minimum bound for the throwforce increase we get per point of strength
	var/min_throwforce_strength = 0
	/// Maximum bound for the throwforce increase we get per point of strength
	var/throwforce_strength = 0
	/// Maximum final throwforce we can reach EVER, regardless of stats
	var/max_throwforce = 100
