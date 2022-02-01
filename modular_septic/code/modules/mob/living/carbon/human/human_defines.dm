/mob/living/carbon/human
	has_field_of_vision = TRUE
	hair_color = "000000"
	facial_hair_color = "000000"
	grad_color = "000000"
	underwear_color = "000000"
	// Eye colors
	var/left_eye_color = "000000"
	var/right_eye_color = "000000"
	/// Flags for showing/hiding underwear
	var/underwear_visibility = NONE
	/// Render key for mutant bodyparts, utilized to reduce the amount of re-rendering
	var/mutant_renderkey = ""
	/// How much shit we have on our hands
	var/shit_in_hands = 0

	// ~ACTIVE DEFENSE VARIABLES
	/// Last time we tried to block an attack
	COOLDOWN_DECLARE(blocking_cooldown)
	/// Last time we tried to dodge
	COOLDOWN_DECLARE(dodging_cooldown)
	/// Timer for resetting the parrying penalty
	var/parrying_penalty_timer = null
	/// Subtract this from parry sccore
	var/parrying_penalty = 0
