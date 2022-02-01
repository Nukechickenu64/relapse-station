//click cooldowns, in tenths of a second, used for various combat actions
#undef CLICK_CD_GRABBING
#define CLICK_CD_GRABBING 30
#define CLICK_CD_BITING 30
#define CLICK_CD_PULLING 10
#define CLICK_CD_WRENCH 20
#define CLICK_CD_TAKEDOWN 20
#define CLICK_CD_STRANGLE 30
#define CLICK_CD_BITE 20
#define CLICK_CD_JUMP 20
#define CLICK_CD_CLING 15
#define CLICK_CD_READY_WEAPON 10

/// Fatigue will not regenerate if we recently suffered fatigue loss
#define FATIGUE_REGEN_COOLDOWN 2 SECONDS

/// Blocking cooldown (can only try to block once every BLOCKING_COOLDOWN)
#define BLOCKING_COOLDOWN 10
/// Dodging cooldown (can only try to block once every DODGING_COOLDOWN)
#define DODGING_COOLDOWN 10
/// Cooldown before resetting the injury penalty
#define INJURY_PENALTY_COOLDOWN 8 SECONDS
/// Cooldown before resetting the parrying penalty
#define PARRYING_PENALTY_COOLDOWN 4 SECONDS
