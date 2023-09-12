/turf
	vis_flags = VIS_INHERIT_PLANE
	inspect_icon_state = "floor"
	bullet_bounce_sound = list(
		'modular_septic/sound/bullet/casing_bounce1.wav',
		'modular_septic/sound/bullet/casing_bounce2.wav',
		'modular_septic/sound/bullet/casing_bounce3.wav',
	)
	/// Should this turf get the clingable element?
	var/clingable = FALSE
	/// If we are clingable, this var stores which sound we make when clung to
	var/clinging_sound = 'modular_septic/sound/effects/clung.wav'
	/// Used by shadowcasting component
	var/list/shadowcasting_overlays
