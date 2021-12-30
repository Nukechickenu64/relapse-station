// Atmos types used for planetary airs
/datum/atmosphere/nevado_surface
	id = NEVADO_SURFACE_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=22,
		/datum/gas/nitrogen=80,
	)
	normal_gases = list(
		/datum/gas/nitrogen=1,
		/datum/gas/water_vapor=1,
	)

	//some pretty normal pressures
	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE

	// -5 celsius average
	minimum_temp = T0C-10
	maximum_temp = T0C

/datum/atmosphere/nevado_caves
	id = NEVADO_CAVES_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=20,
		/datum/gas/nitrogen=50,
	)
	normal_gases = list(
		/datum/gas/oxygen=10,
		/datum/gas/nitrogen=25,
		/datum/gas/water_vapor=2,
	)
	restricted_gases = list(
		/datum/gas/miasma=0.2,
		/datum/gas/plasma=0.1,
	)
	restricted_chance = 5

	//some pretty normal pressures
	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE

	minimum_temp = T0C-5 //-5 celsius
	maximum_temp = T20C-10 // 10 celsius

