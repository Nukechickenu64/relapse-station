
///Z level traits for nevado surface
#define ZTRAITS_PLANETARY_SURFACE list(ZTRAIT_LINKAGE = CROSSLINKED_SURFACE, ZTRAIT_NEVADO = TRUE, ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/snow/nevado_surface)
///Z level traits for nevado caves
#define ZTRAITS_PLANETARY_CAVE list(ZTRAIT_LINKAGE = CROSSLINKED_CAVE, ZTRAIT_NEVADO = TRUE, ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/nevado_caves)

// enum - how space transitions should affect this level
	// CROSSLINKED_SURFACE - mixed in with the cross-linked surface pool
	#define CROSSLINKED_SURFACE "Surface"
	// CROSSLINKED_CAVE - mixed in with the cross-linked cave pool
	#define CROSSLINKED_CAVE "Cave"
