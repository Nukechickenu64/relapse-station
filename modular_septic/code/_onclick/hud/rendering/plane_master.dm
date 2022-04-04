/// Small openspace blur
/atom/movable/screen/plane_master/openspace/Initialize(mapload)
	. = ..()
	add_filter("fourth_stage_openspace", 1, gauss_blur_filter(size = 1))

/// Openspace backdrop awesome
/atom/movable/screen/plane_master/openspace_backdrop
	blend_mode = BLEND_MULTIPLY
	blend_mode_override = BLEND_MULTIPLY

/atom/movable/screen/plane_master/game_world/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	remove_filter("AO2")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, GENERAL_AMBIENT_OCCLUSION1)
		add_filter("AO2", 2, GENERAL_AMBIENT_OCCLUSION2)

/atom/movable/screen/plane_master/game_world_fov_hidden
	name = "game world fov hidden plane master"
	plane = GAME_PLANE_FOV_HIDDEN
	render_relay_plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world_fov_hidden/Initialize()
	. = ..()
	add_filter("VC", 100, alpha_mask_filter(render_source=FIELD_OF_VISION_MASK_RENDER_TARGET, flags=MASK_INVERSE))

/atom/movable/screen/plane_master/game_world_upper
	name = "upper game world plane master"
	plane = GAME_PLANE_UPPER
	render_relay_plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world_upper_fov_hidden
	name = "upper game world fov hidden plane master"
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	render_relay_plane = GAME_PLANE_FOV_HIDDEN
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world_above
	name = "above game world plane master"
	plane = ABOVE_GAME_PLANE
	render_relay_plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/wall
	name = "wall plane master"
	plane = WALL_PLANE
	render_target = WALL_PLANE_RENDER_TARGET
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/// Contains object permanence images for FoV
/atom/movable/screen/plane_master/game_world/object_permanence
	name = "object permanence plane master"
	plane = OBJECT_PERMANENCE_PLANE

/atom/movable/screen/plane_master/game_world/object_permanence/Initialize(mapload)
	. = ..()
	// only render images inside the FOV mask
	add_filter("VC", 100, alpha_mask_filter(render_source=FIELD_OF_VISION_MASK_RENDER_TARGET))

/// Contains pollution blockers, for effects like fog
/atom/movable/screen/plane_master/pollution_blocker
	name = "pollution blocker plane master"
	plane = POLLUTION_BLOCKER_PLANE
	render_target = POLLUTION_BLOCKER_RENDER_TARGET
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = null

/// Contains pollution effects, which should display above mobs and objects
/atom/movable/screen/plane_master/pollution
	name = "pollution plane master"
	plane = POLLUTION_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/pollution/backdrop(mob/mymob)
	. = ..()
	// Don't render pollution when the player is near, etc
	add_filter("pollution_blocker", 10, alpha_mask_filter(render_source=POLLUTION_BLOCKER_RENDER_TARGET, flags = MASK_INVERSE))

/// Used to display the owner and its adjacent surroundings through the FoV plane mask.
/atom/movable/screen/plane_master/field_of_vision_blocker
	name = "field of vision blocker plane master"
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	render_target = FIELD_OF_VISION_BLOCKER_RENDER_TARGET
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = null

/// Contains all shadow cone masks, whose image overrides are displayed only to their respective owners.
/atom/movable/screen/plane_master/field_of_vision_mask
	name = "field of vision mask plane master"
	plane = FIELD_OF_VISION_MASK_PLANE
	render_target = FIELD_OF_VISION_MASK_RENDER_TARGET
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = null

/atom/movable/screen/plane_master/field_of_vision_mask/Initialize()
	. = ..()
	add_filter("VC", 100, alpha_mask_filter(render_source=FIELD_OF_VISION_BLOCKER_RENDER_TARGET, flags=MASK_INVERSE))

/// Stores the visible FoV shadow cone
/atom/movable/screen/plane_master/field_of_vision_visual
	name = "field of vision visual plane master"
	plane = FIELD_OF_VISION_VISUAL_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/shadowcasting
	name = "shadowcasting plane"
	plane = SHADOWCASTING_PLANE
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/shadowcasting/backdrop(mob/mymob)
	. = ..()
	add_filter("wall_blocker", 1, alpha_mask_filter(render_source=WALL_PLANE_RENDER_TARGET, flags=MASK_INVERSE))
	add_filter("blur", 2, gauss_blur_filter(size = 2))

/atom/movable/screen/plane_master/runechat/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	remove_filter("AO2")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, GENERAL_AMBIENT_OCCLUSION1)
		add_filter("AO2", 2, GENERAL_AMBIENT_OCCLUSION2)

/atom/movable/screen/plane_master/sound_hint
	name = "sound hint plane"
	plane = SOUND_HINT_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_NON_GAME

/atom/movable/screen/plane_master/noise
	name = "noise filter plane"
	plane = NOISE_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_NON_GAME
