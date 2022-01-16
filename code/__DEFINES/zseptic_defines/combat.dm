// ~combat style defines
#define CS_DUAL "dual"
#define CS_GUARD "guard"
#define CS_DEFEND "defend"
#define CS_STRONG "strong"
#define CS_FURY "fury"
#define CS_AIMED "aimed"
#define CS_WEAK "weak"
#define CS_FEINT "feint"
#define CS_NONE "none"
#define CS_DEFAULT CS_NONE

// ~dodge and parry
#define DP_PARRY "parry"
#define DP_DODGE "dodge"

// ~special attacks (kicking, biting and jumping)
#define SPECIAL_ATK_KICK "kick"
#define SPECIAL_ATK_BITE "bite"
#define SPECIAL_ATK_JUMP "jump"
#define SPECIAL_ATK_STEAL "steal"
#define SPECIAL_ATK_NONE "none"

// ~grabbies
#define GM_STAUNCH "staunch"
#define GM_WRENCH "wrench"
#define GM_TEAROFF "tear"
#define GM_STRANGLE "strangle"
#define GM_TAKEDOWN "takedown"
#define GM_EMBEDDED "embedded"

//need at least this strength diff to tear someone's limb off
#define GM_TEAROFF_DIFF 6

// ~combat flags
/// Trying to sprint
#define COMBAT_FLAG_SPRINT_ACTIVE	(1<<0)
/// Sprinting
#define COMBAT_FLAG_SPRINTING		(1<<1)
/// Cannot sprint
#define COMBAT_FLAG_SPRINT_LOCKED	(1<<2)

// ~item readying behavior flags
/// This item tries to become unready after attacking
#define READYING_FLAG_UNREADY_ON_ATTACK (1<<0)
/// This item tries to become unready after blocking
#define READYING_FLAG_UNREADY_ON_BLOCK (1<<1)
/// This item tries to become unready after parrying
#define READYING_FLAG_UNREADY_ON_PARRY (1<<2)

// ~blocking/parrying behavior flags
#define BLOCK_FLAG_MELEE (1<<0)
#define BLOCK_FLAG_UNARMED (1<<1)
#define BLOCK_FLAG_PROJECTILE (1<<2)
#define BLOCK_FLAG_THROWN (1<<3)
#define BLOCK_FLAG_LEAP (1<<4)

#define PAIN_KNOCKOUT_MESSAGE "<span class='flashingdanger'>caves in to the pain!</span>"
#define PAIN_KNOCKOUT_MESSAGE_SELF "<span class='animatedpain'>OH LORD! The PAIN!</span>"

// ~projectile diceroll stuff
/// How much we multiply the initial skills and stats by for the diceroll
#define PROJECTILE_DICEROLL_ATTRIBUTE_MULTIPLIER 1.25
/// How much we exponentiate the distance by to get the negative modifier
#define PROJECTILE_DICEROLL_DISTANCE_EXPONENT 1.75

// ~fatigue mechanics
/// How much stamina someone with 10 endurance will regen, every second
#define FATIGUE_REGEN_FACTOR 1
/// How much to multiply fatigue regen when lying down
#define FATIGUE_REGEN_LYING_MULTIPLIER 2
/// Fatigue will not regenerate if we recently suffered fatigue loss
#define FATIGUE_REGEN_COOLDOWN 2 SECONDS
/// Default maximum fatigue for a mob
#define DEFAULT_MAX_FATIGUE 100
/// This is the lowest fatigue amount we can reach ever
#define FATIGUE_MINIMUM -100
/// Above this point in fatigueloss, we enter fatiguecrit
#define FATIGUE_CRIT_THRESHOLD 100

//click cooldowns, in tenths of a second, used for various combat actions
#undef CLICK_CD_GRABBING
#define CLICK_CD_GRABBING 30
#define CLICK_CD_PULLING 10
#define CLICK_CD_WRENCH 20
#define CLICK_CD_TAKEDOWN 20
#define CLICK_CD_STRANGLE 30
#define CLICK_CD_JUMP 20
#define CLICK_CD_CLING 15
#define CLICK_CD_READY_WEAPON 8
