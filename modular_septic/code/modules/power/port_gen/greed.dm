/obj/machinery/power/port_gen/greed
	name = "\proper GREED"
	desc = "An anomalous generator capable of burning valuable resources into power. It stares hungrily at you."
	anchored = TRUE
	/// Multiplier of consumption that gets turned into watts
	power_gen = 24000 //should be 6000 eventually
	/**
	 * Power output changes depending on happiness.
	 * Lower power output will still consume credits as if power output was at 1.
	*/
	power_output = 1
	/// Sum of the price of the shit we put inside us
	var/stored_credits = 0
	/// How much to subtract from currently_consuming on a process() call
	var/consumption_per_second = 50
	/**
	 * Our happiness level from 0 to 1000.
	 * Happiness decreases over time while unfed, and increases when items are added to the burner.
	 * The GREED will spawn hellspawn, and burn things around it, when unhappy.
	**/
	var/happiness = 1000

/obj/machinery/power/port_gen/greed/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(W.custom_price && user.transferItemToLoc(src))
		to_chat(user, span_notice("I feed [src] with [W]."))
		stored_credits += W.custom_price
		happiness += W.custom_price
		qdel(W)

/obj/machinery/power/port_gen/greed/process(delta_time)
	var/actual_power_output = CEILING(initial(power_output) * (happiness/initial(happiness)), 0.01)
	if(stored_credits)
		var/consumed = min(stored_credits, consumption_per_second)
		stored_credits -= consumed
		add_avail(power_gen * consumed * actual_power_output)
		return
	happiness = max(0, happiness - delta_time)
