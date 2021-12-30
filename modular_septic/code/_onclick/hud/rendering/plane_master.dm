/atom/movable/screen/plane_master/game_world/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	remove_filter("AO2")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, GENERAL_AMBIENT_OCCLUSION1)
		add_filter("AO2", 2, GENERAL_AMBIENT_OCCLUSION2)

/// Contains mobs and things that should be rendered along with mobs
/atom/movable/screen/plane_master/game_world/fov_hidden
	name = "game world fov hidden plane master"
	plane = GAME_PLANE_FOV_HIDDEN

/atom/movable/screen/plane_master/game_world/fov_hidden/Initialize(mapload)
	. = ..()
	add_filter("VC", 100, list(type="alpha", render_source=FIELD_OF_VISION_MASK_RENDER_TARGET, flags=MASK_INVERSE))

/// Contains object permanence images for FoV
/atom/movable/screen/plane_master/game_world/object_permanence
	name = "object permanence plane master"
	plane = OBJECT_PERMANENCE_PLANE

/atom/movable/screen/plane_master/game_world/object_permanence/Initialize(mapload)
	. = ..()
	//only render images inside the FOV mask
	add_filter("VC", 100, list(type="alpha", render_source=FIELD_OF_VISION_MASK_RENDER_TARGET))

/atom/movable/screen/plane_master/game_world/above
	name = "above game world plane master"
	plane = ABOVE_GAME_PLANE

/// Contains pollution effects, which should display above mobs and objects
/atom/movable/screen/plane_master/pollution
	name = "pollution plane master"
	plane = POLLUTION_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_GAME
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

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
	add_filter("VC", 100, list(type="alpha", render_source=FIELD_OF_VISION_BLOCKER_RENDER_TARGET, flags=MASK_INVERSE))

/// Stores the visible FoV shadow cone
/atom/movable/screen/plane_master/field_of_vision_visual
	name = "field of vision visual plane master"
	plane = FIELD_OF_VISION_VISUAL_PLANE
	render_target = FIELD_OF_VISION_VISUAL_RENDER_TARGET
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/runechat/backdrop(mob/mymob)
	. = ..()
	remove_filter("AO")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, RUNECHAT_AMBIENT_OCCLUSION1)

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
	render_relay_plane = RENDER_PLANE_NON_GAME
