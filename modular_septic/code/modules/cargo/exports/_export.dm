/**
 * Code for the commodity price variation was based mostly on this article:
 * https://towardsdatascience.com/how-to-simulate-a-stock-market-with-less-than-10-lines-of-python-code-5de9336114e5
 */
/datum/export
	/// Previous cost, for the sake of checking whether the cost has gone up or down since last update
	var/previous_cost
	/// Maximum price this export can ever reach, set to null to generate automatically
	var/maximum_cost
	/// Minimum price this export can ever reach, 0 or below WILL create infinite money exploits
	var/minimum_cost = 1 CENTS
	/// Standard deviation of price variation, which uses normal distribution
	var/standard_deviation = 0.01
	/// Mean of price variation, which uses normal distribution
	var/mean = 0.001

/datum/export/New()
	. = ..()
	previous_cost = cost
	if(isnull(maximum_cost))
		maximum_cost = cost ** DEFAULT_MAXIMUM_COST_EXPONENT
	minimum_cost = max(1 CENTS, minimum_cost)
	if(k_elasticity || standard_deviation)
		START_PROCESSING(SSmarket, src)

/datum/export/Destroy()
	. = ..()
	STOP_PROCESSING(SSmarket, src)

/datum/export/process(delta_time)
	. = ..()
	previous_cost = cost
	if(k_elasticity)
		cost = min(init_cost, cost * NUM_E**(k_elasticity * (1/30)))
		return
	else if(standard_deviation)
		cost = clamp(round_to_nearest(1+gaussian(mean, standard_deviation), 1 CENTS), minimum_cost, maximum_cost)
		return
	return PROCESS_KILL
