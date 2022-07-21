/// Small openspace blur
/atom/movable/screen/plane_master/openspace
	render_target = OPENSPACE_PLANE_RENDER_TARGET

/atom/movable/screen/plane_master/openspace/Initialize(mapload)
	. = ..()
	add_filter("first_stage_openspace", 1, drop_shadow_filter(color = "#04080FAA", size = -10))
	add_filter("second_stage_openspace", 2, drop_shadow_filter(color = "#04080FAA", size = -15))
	add_filter("third_stage_openspace", 3, drop_shadow_filter(color = "#04080FAA", size = -20))
	add_filter("fourth_stage_openspace", 4, gauss_blur_filter(size = 1))

/// Openspace backdrop awesome
/atom/movable/screen/plane_master/openspace_backdrop
	blend_mode = BLEND_MULTIPLY
	blend_mode_override = BLEND_MULTIPLY

/// For any transparent multi-z tiles we want to render that are not open spaces
/atom/movable/screen/plane_master/transparent_floor
	name = "transparent floor plane master"
	plane = TRANSPARENT_FLOOR_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/floor
	render_target = FLOOR_RENDER_TARGET

/atom/movable/screen/plane_master/floor_fov_hidden
	name = "floor fov hidden plane master"
	plane = FLOOR_PLANE_FOV_HIDDEN
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = FLOOR_PLANE

/atom/movable/screen/plane_master/floor_fov_hidden/Initialize(mapload)
	. = ..()
	add_filter("vision_cone", 1, alpha_mask_filter(render_source = FIELD_OF_VISION_MASK_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/floor_bloom
	name = "floor bloom plane master"
	plane = FLOOR_PLANE_BLOOM
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = FLOOR_PLANE

/atom/movable/screen/plane_master/floor_bloom/backdrop(mob/mymob)
	. = ..()
	remove_filter("bloom")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/bloom))
		add_filter("bloom", 1, GENERAL_BLOOM)

/atom/movable/screen/plane_master/game_world_effects
	name = "game world effects plane master"
	plane = GAME_PLANE_EFFECTS
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_target = GAME_EFFECTS_RENDER_TARGET
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/game_world_effects/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, GENERAL_AMBIENT_OCCLUSION)

/atom/movable/screen/plane_master/game_world
	name = "game world plane master"
	plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_target = GAME_RENDER_TARGET
	render_relay_plane = GAME_PLANE_EFFECTS

/atom/movable/screen/plane_master/game_world/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	remove_filter("AO2")
	remove_filter("AO3")
	remove_filter("AO4")

/atom/movable/screen/plane_master/game_world_bloom
	name = "game world bloom plane master"
	plane = GAME_PLANE_BLOOM
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/game_world_bloom/backdrop(mob/mymob)
	. = ..()
	remove_filter("bloom")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/bloom))
		add_filter("bloom", 1, GENERAL_BLOOM)

/atom/movable/screen/plane_master/game_world_window
	name = "game world window plane master"
	plane = GAME_PLANE_WINDOW
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE
	alpha = WINDOW_PLANE_ALPHA

/atom/movable/screen/plane_master/game_world_above_window
	name = "game world above window plane master"
	plane = GAME_PLANE_ABOVE_WINDOW
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE

/atom/movable/screen/plane_master/game_world_fov_hidden
	name = "game world fov hidden plane master"
	plane = GAME_PLANE_FOV_HIDDEN
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE

/atom/movable/screen/plane_master/game_world_fov_hidden/Initialize()
	. = ..()
	add_filter("vision_cone", 1, alpha_mask_filter(render_source = FIELD_OF_VISION_MASK_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/game_world_upper
	name = "upper game world plane master"
	plane = GAME_PLANE_UPPER
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE

/atom/movable/screen/plane_master/game_world_upper_bloom
	name = "upper game world bloom plane master"
	plane = GAME_PLANE_UPPER_BLOOM
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE_BLOOM //sadly, relaying to bloom plane didn't work and broke layering a lot, sorry boys

/atom/movable/screen/plane_master/game_world_upper_fov_hidden
	name = "upper game world fov hidden plane master"
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE_FOV_HIDDEN

/// Contains object permanence images for FoV
/atom/movable/screen/plane_master/game_world_object_permanence
	name = "object permanence plane master"
	plane = GAME_PLANE_OBJECT_PERMANENCE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE

/atom/movable/screen/plane_master/game_world_object_permanence/Initialize(mapload)
	. = ..()
	// only render images inside the FOV mask
	add_filter("vision_cone", 1, alpha_mask_filter(render_source = FIELD_OF_VISION_MASK_RENDER_TARGET))

/atom/movable/screen/plane_master/game_world_above
	name = "above game world plane master"
	plane = ABOVE_GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = GAME_PLANE

/// Contains pollution effects, which should display above mobs and objects
/atom/movable/screen/plane_master/pollution
	name = "pollution plane master"
	plane = POLLUTION_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/pollution/backdrop(mob/mymob)
	. = ..()
	// Don't render pollution when the player is near, etc
	add_filter("pollution_blocker", 1, alpha_mask_filter(render_source = POLLUTION_BLOCKER_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/ripple
	name = "riple plane master"
	plane = RIPPLE_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

//frills but for like, windows dude - display below every other frill
/atom/movable/screen/plane_master/frill_window
	name = "frill window plane master"
	plane = FRILL_PLANE_WINDOW
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = FRILL_PLANE
	alpha = WINDOW_PLANE_ALPHA
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

//frills that display below most other frills
/atom/movable/screen/plane_master/frill_low
	name = "low frill plane master"
	plane = FRILL_PLANE_LOW
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = FRILL_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/frill
	name = "frill plane master"
	plane = FRILL_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_target = FRILL_RENDER_TARGET
	render_relay_plane = RENDER_PLANE_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/frill/Initialize(mapload)
	. = ..()
	// Don't render frills when a mob is near, etc
	add_filter("frill_blocker", 1, alpha_mask_filter(render_source = FRILL_BLOCKER_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/frill/backdrop(mob/mymob)
	. = ..()
	remove_filter("frill_blocker_floor")
	remove_filter("frill_blocker_openspace")
	if(istype(mymob) && mymob.client?.prefs && !mymob.client.prefs.read_preference(/datum/preference/toggle/frills_over_floors))
		add_filter("frill_blocker_floor", 2, alpha_mask_filter(render_source = FLOOR_RENDER_TARGET, flags = MASK_INVERSE))
		add_filter("frill_blocker_openspace", 3, alpha_mask_filter(render_source = OPENSPACE_PLANE_RENDER_TARGET, flags = MASK_INVERSE))

//overflow of things under frills
/atom/movable/screen/plane_master/game_world_under_frill
	name = "game world under frill plane master"
	plane = GAME_PLANE_UNDER_FRILL
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR //should use czlient color
	blend_mode = BLEND_OVERLAY
	render_source = GAME_RENDER_TARGET
	render_target = GAME_UNDER_FRILL_RENDER_TARGET
	render_relay_plane = OUTLINE_PLANE
	color = list(0, 0, 0, 0, \
				0, 0, 0, 0, \
				0, 0, 0, 0, \
				1, 1, 1, 1)
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/outline/backdrop(mob/mymob)
	. = ..()
	add_filter("frill_cutter", 1, alpha_mask_filter(render_source = FRILL_RENDER_TARGET))

//outline for things in GAME_PLANE_UNDER_FRILL
/atom/movable/screen/plane_master/outline
	name = "outline plane master"
	plane = OUTLINE_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME
	color = "#97edca"
	alpha = 64
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/outline/backdrop(mob/mymob)
	. = ..()
	color = "#97edca"
	alpha = 64
	if(istype(mymob) && mymob.client?.prefs)
		color = mymob.client.prefs.read_preference(/datum/preference/color/outline_color)
		alpha = mymob.client.prefs.read_preference(/datum/preference/numeric/outline_alpha)

//sometimes, things need to render above wall frills
/atom/movable/screen/plane_master/frill_above
	name = "above frill plane master"
	plane = ABOVE_FRILL_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME

//sometimes, things need to render above wall frills and have bloom too
/atom/movable/screen/plane_master/frill_above_bloom
	name = "above frill bloom plane master"
	plane = ABOVE_FRILL_PLANE_BLOOM
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/frill_above_bloom/backdrop(mob/mymob)
	. = ..()
	remove_filter("bloom")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/bloom))
		add_filter("bloom", 1, GENERAL_BLOOM)

/atom/movable/screen/plane_master/runechat/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, GENERAL_AMBIENT_OCCLUSION)

/atom/movable/screen/plane_master/lighting
	name = "lighting plane master"
	plane = LIGHTING_PLANE
	blend_mode_override = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = LIGHTING_RENDER_TARGET
	render_relay_plane = RENDER_PLANE_GAME

/**
 * Plane master handling byond internal blackness
 * vars are set as to replicate behavior when rendering to other planes
 * do not touch this unless you know what you are doing
 */
/atom/movable/screen/plane_master/blackness
	name = "darkness plane master"
	plane = BLACKNESS_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	color = list(null, null, null, "#0000", "#000f")
	blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR | PIXEL_SCALE
	//byond internal end
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/cybergrid
	name = "cybergrid plane master"
	plane = CYBERGRID_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_OVERLAY
	appearance_flags = PLANE_MASTER //should use client color
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/cybergrid/backdrop(mob/mymob)
	. = ..()
	add_filter("game_mask", 1, alpha_mask_filter(render_source = RENDER_PLANE_GAME_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/sound_hint
	name = "sound hint plane"
	plane = SOUND_HINT_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_NON_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/noise
	name = "noise filter plane"
	plane = NOISE_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_NON_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/hud
	name = "HUD plane"
	plane = HUD_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/above_hud
	name = "above HUD plane"
	plane = ABOVE_HUD_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/peeper
	name = "peeper plane"
	plane = PEEPER_PLANE
	render_relay_plane = RENDER_PLANE_PEEPER

/atom/movable/screen/plane_master/above_peeper
	name = "above peeper plane"
	plane = ABOVE_PEEPER_PLANE
	render_relay_plane = RENDER_PLANE_PEEPER

/atom/movable/screen/plane_master/splashscreen
	name = "splashscreen plane"
	plane = SPLASHSCREEN_PLANE
	render_relay_plane = RENDER_PLANE_NON_GAME
