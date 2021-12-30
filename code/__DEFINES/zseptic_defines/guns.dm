///Gun has no moving bolt mechanism, it cannot be racked, but can be broken open.
///  Example: Break action shotguns, revolvers
#define BOLT_TYPE_BREAK_ACTION 5

// ~safety flags
#define GUN_SAFETY_HAS_SAFETY (1<<0)
#define GUN_SAFETY_ENABLED (1<<1)
#define GUN_SAFETY_OVERLAY_ENABLED (1<<2)
#define GUN_SAFETY_OVERLAY_DISABLED (1<<3)
#define GUN_SAFETY_FLOGGING_PROOFED (1<<4)

#define GUN_SAFETY_FLAGS_DEFAULT (GUN_SAFETY_HAS_SAFETY|GUN_SAFETY_ENABLED)
