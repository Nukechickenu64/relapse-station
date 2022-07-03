/obj/machinery/computer/exports
	name = "\improper RobinHood"
	desc = "A terminal used to keep up to date with the ever changing capitalist universe.\n\
			<i>Buy high, sell low!</i>"
	icon_screen = "supply"
	light_color = COLOR_BRIGHT_ORANGE

/obj/machinery/computer/exports/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	SSmarket.market_consoles += src

/obj/machinery/computer/exports/Destroy()
	. = ..()
	SSmarket.market_consoles -= src

/obj/machinery/computer/exports/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Exports")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/exports/ui_static_data(mob/user)
	var/list/data = list()

	var/list/export_information = list()
	for(var/datum/export/export as anything in GLOB.exports_list)
		if(!export.unit_name || export.secret)
			continue
		var/list/this_export = list()

		this_export["unit_name"] = capitalize(export.unit_name)
		this_export["cost"] = export.cost
		this_export["previous_cost"] = export.previous_cost
		this_export["initial_cost"] = export.init_cost

		export_information += list(this_export)
	data["exports"] = export_information

	return data
