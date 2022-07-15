/// Default interaction cooldown, can be changed on each datum
#define INTERACTION_COOLDOWN 0.5 SECONDS

#define INTERACT_SELF "self"
#define INTERACT_OTHER "other"
#define INTERACT_BOTH "both"

// ~interaction flags
/// Respects interaction_cooldown
#define INTERACTION_RESPECT_COOLDOWN (1<<0)
/// Use audible_message instead of visible_message
#define INTERACTION_AUDIBLE (1<<6)
/// User and target must be adjacent
#define INTERACTION_NEEDS_PHYSICAL_CONTACT (1<<7)

// ~interaction categories
#define INTERACTION_CATEGORY_UNFRIENDLY "Unfriendly"
#define INTERACTION_CATEGORY_FRIENDLY "Friendly"
#define INTERACTION_CATEGORY_ROMANTIC "Romantic"

// ~body zone or organ that needs to be exposed on interactions, avoid using this in zones in favor of organs
#define INTERACTION_ZONE_EXISTS (1<<0)
#define INTERACTION_ZONE_COVERED (1<<1)
#define INTERACTION_ZONE_UNCOVERED (1<<1)

#define INTERACTION_CATEGORY_ORDER list(\
			INTERACTION_CATEGORY_UNFRIENDLY, \
			INTERACTION_CATEGORY_FRIENDLY, \
			INTERACTION_CATEGORY_ROMANTIC, \
			)
