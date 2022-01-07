/// Default point at which sharp/pointy/impaling damage becomes blunt, as in (initial_damage) <= (subtractible_armor * threshold/100)
#define BLUNTING_THRESHOLD 100

// ~armor flags
/// The armor is flexible, and suffers mild blunt damage even if no damage penetrates
#define SUBARMOR_FLEXIBLE (1<<0)
