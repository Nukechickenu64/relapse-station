PROCESSING_SUBSYSTEM_DEF(market)
	name = "Market"
	flags = SS_NO_INIT
	wait = 30 SECONDS
	var/list/obj/machinery/computer/exports/market_consoles = list()

/datum/controller/subsystem/processing/market/fire(resumed)
	. = ..()
	if(MC_TICK_CHECK)
		return
	// After we process export datums, we update the UI on every market console if necessary
	for(var/obj/machinery/computer/exports/market_console as anything in market_consoles)
		for(var/datum/tgui/window in SStgui.open_uis_by_src[REF(market_console)])
			window.send_full_update()
		if(MC_TICK_CHECK)
			return
