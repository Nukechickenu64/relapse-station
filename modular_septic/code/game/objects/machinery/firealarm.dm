
/obj/machinery/firealarm/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	if(obj_flags & EMAGGED || machine_stat)
		return FALSE
	var/turf/turf_loc = loc
	if(istype(turf_loc) && turf_loc.turf_fire)
		return TRUE
	if(exposed_temperature > T0C + 80 || exposed_temperature < T0C - 10)
		return TRUE
