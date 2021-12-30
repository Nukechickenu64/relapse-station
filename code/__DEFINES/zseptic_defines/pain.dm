// ~pain levels when using the custom_pain proc and shit
#define PAIN_EMOTE_MINIMUM 10
#define PAIN_LEVEL_1 0
#define PAIN_LEVEL_2 10
#define PAIN_LEVEL_3 40
#define PAIN_LEVEL_4 70

// ~shock stages
#define SHOCK_STAGE_1 10
#define SHOCK_STAGE_2 30
#define SHOCK_STAGE_3 40
#define SHOCK_STAGE_4 60 // "Softcrit"
#define SHOCK_STAGE_5 80
#define SHOCK_STAGE_6 120 // "Hardcrit"
#define SHOCK_STAGE_7 150
#define SHOCK_STAGE_8 200
#define SHOCK_STAGE_MAX SHOCK_STAGE_8

// ~shock modifiers
#define SHOCK_MOD_BRUTE 0.7
#define SHOCK_MOD_BURN 0.8
#define SHOCK_MOD_TOXIN 1
#define SHOCK_MOD_CLONE 1.1

/// Above or equal this pain, we give in
#define PAIN_GIVES_IN 75
/// Above or equal to this amount of pain, we can only speak in whispers
#define PAIN_NO_SPEAK 120
/// Above or equal this pain, we cannot sleep intentionally
#define PAIN_NO_SLEEP 50
