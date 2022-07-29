/obj/machinery/camera
	icon = 'modular_septic/icons/obj/machinery/camera.dmi'
	icon_state = "camera"
	base_icon_state = "camera"
	plane = GAME_PLANE_UPPER

/obj/machinery/camera/Initialize(mapload, obj/structure/camera_assembly/CA)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
