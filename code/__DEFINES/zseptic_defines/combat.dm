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
#define GM_STAUNCH_BLEEDING "staunch_bleeding"
#define GM_WRENCH "wrench"
#define GM_TEAROFF "tear"
#define GM_STRANGLE "strangle"
#define GM_TAKEDOWN "takedown"
#define GM_EMBEDDED "embedded"
#define GM_BITE "bite"

/// Yoou need at least this strength diff (user st - target ed) to tear someone's limb off
#define GM_TEAROFF_DIFF 6

// ~combat flags
/// Trying to sprint
#define COMBAT_FLAG_SPRINT_ACTIVE (1<<0)
/// Sprinting
#define COMBAT_FLAG_SPRINTING (1<<1)
/// Cannot sprint
#define COMBAT_FLAG_SPRINT_LOCKED (1<<2)

// ~item readying behavior flags
/**
 *  This item requires two hands to be used to attack, and does not become unready after attacking.
 * If you have 1.5x the minimum strength, you can use it one handed, but it becomes unready after each attack.
 * If you have 2x the minimum strength, you can use it one handed with no penalty at all.
 */
#define READYING_FLAG_SOFT_TWO_HANDED (1<<0)
/**
 *  This item requires two hands to be used to attack, and becomes unready after attacking.
 * If you have 1.5x the minimum strength, it will not become unready.
 * If you have 3x the minimum strength, you can use it one handed with no penalty at all.
 */
#define READYING_FLAG_HARD_TWO_HANDED (1<<1)
/**
 *  Bows and crossbows have their own ST value that gets used instead of the user's strength.
 * This flag makes sure that behavior happens in ranged combat.
 */
#define READYING_FLAG_BOW_BEHAVIOR (1<<2)

// ~blocking/parrying behavior flags
/// Able to block melee attacks that use items
#define BLOCK_FLAG_MELEE (1<<0)
/// Able to block melee attacks that don't use items
#define BLOCK_FLAG_UNARMED (1<<1)
/// Able to block projectiles of all kinds
#define BLOCK_FLAG_PROJECTILE (1<<2)
/// Able to block thrown things
#define BLOCK_FLAG_THROWN (1<<3)
/// Able to block thrown mobs
#define BLOCK_FLAG_LEAP (1<<4)

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
/// Default maximum fatigue for a mob
#define DEFAULT_MAX_FATIGUE 100
/// This is the lowest fatigue amount we can reach ever
#define FATIGUE_MINIMUM -100
/// Above this point in fatigueloss, we enter fatiguecrit
#define FATIGUE_CRIT_THRESHOLD 100
/// Above this point in fatigueloss, halve basic speed and dodge
#define FATIGUE_HALVE_MOVE 65
