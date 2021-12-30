/atom/movable/screen/alert
	layer = 2 //above rack, below actions

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/reorganize_alerts(mob/viewmob)
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return
	var/list/alerts = mymob.alerts
	if(!hud_shown)
		for(var/i = 1, i <= alerts.len, i++)
			screenmob.client.screen -= alerts[alerts[i]]
		return TRUE
	for(var/i = 1, i <= alerts.len, i++)
		var/atom/movable/screen/alert/alert = alerts[alerts[i]]
		if(alert.icon_state == "template")
			alert.icon = ui_style
		switch(i)
			if(1)
				. = ui_alert1
			if(2)
				. = ui_alert2
			if(3)
				. = ui_alert3
			if(4)
				. = ui_alert4
			if(5)
				. = ui_alert5
			if(6)
				. = ui_alert6 // Right now there's 5 slots
			else
				. = ""
		alert.screen_loc = .
		screenmob.client.screen |= alert
	if(!viewmob)
		for(var/observer in mymob.observers)
			reorganize_alerts(observer)
	return TRUE

/atom/movable/screen/alert/buckled
	icon = 'modular_septic/icons/hud/quake/screen_alert.dmi'

/atom/movable/screen/alert/cant_breathe
	name = "Choking"
	desc = "C-Can't... b-breathe..."
	icon_state = "not_enough_oxy"

/atom/movable/screen/alert/too_much_tox //yes we have it already but this is totes different
	name = "Toxic Air"
	desc = "Fuck, my nostrils sting!"
	icon_state = "too_much_tox"
