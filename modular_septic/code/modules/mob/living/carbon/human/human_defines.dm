/mob/living/carbon/human
	has_field_of_vision = TRUE
	hair_color = "000000"
	facial_hair_color = "000000"
	grad_color = "000000"
	underwear_color = "000000"
	// Eye colors
	var/left_eye_color = "000000"
	var/right_eye_color = "000000"
	/// Flags for showing/hiding underwear, toggleabley by a verb
	var/underwear_visibility = NONE
	/// Render key for mutant bodyparts, utilized to reduce the amount of re-rendering
	var/mutant_renderkey = ""
	/// How horny we are
	var/arousal = AROUSAL_LEVEL_START_MIN
	/// How close we are to cooming
	var/lust = 0
	/// How much shit we have on our hands
	var/shit_in_hands = 0
	/// How much cum we have on our hands
	var/cum_in_hands = 0
	/// How much femcum we have on our hands
	var/femcum_in_hands = 0
