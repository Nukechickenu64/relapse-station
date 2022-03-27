/// What to connect with by default. Used by /atom/proc/auto_align(). This can be overriden
GLOBAL_LIST_INIT(default_connectables, typecacheof(list(
		/obj/machinery/door/airlock,
		/obj/machinery/door/poddoor,
		/obj/machinery/smartfridge,
		/obj/structure/girder/reinforced,
		/obj/structure/plasticflaps,
		/obj/machinery/power/shieldwallgen,
		/obj/structure/door_assembly,
	)))
/// What to connect with at a lower priority by default. Used for stuff that we want to consider, but only if we don't find anything else
GLOBAL_LIST_INIT(lower_priority_connectables, typecacheof(list(
		/obj/machinery/door/window,
		/obj/structure/table,
		/obj/structure/window,
		/obj/structure/girder,
	)))
