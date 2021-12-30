/obj/item/organ/ears
	name = "ear"
	icon_state = "ears"
	desc = "There are three parts to the ear. Inner, middle and outer. Only one of these parts should be normally visible."

	dna_block = DNA_EARS_BLOCK
	mutantpart_key = "ears"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR = list("FFFFFF"))

	zone = BODY_ZONE_HEAD
	side = RIGHT_SIDE
	organ_efficiency = list(ORGAN_SLOT_EARS = 50) // normal people have two ears you dolt

	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5 // weaker because we have 2
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.4
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.1

	low_threshold_passed = span_info("Your ear begin to resonate with an internal ring sometimes.")
	low_threshold_cleared = span_info("The ringing in your ear has died down.")
	now_failing = span_warning("You are unable to hear at all!")
	now_fixed = span_info("Noise slowly begins filling your ear once more.")

	// remember that this is normally DOUBLED (2 ears)
	organ_volume = 0.5
	max_blood_storage = 2.5
	current_blood = 2.5
	blood_req = 0.5
	oxygen_req = 0.5
	nutriment_req = 0.25
	hydration_req = 0.25

	// `deaf` measures "ticks" of deafness. While > 0, the person is unable
	// to hear anything.
	var/deaf = 0

	// `damage` in this case measures long term damage to the ears, if too high,
	// the person will not have either `deaf` or `ear_damage` decrease
	// without external aid (earmuffs, drugs)

	// Resistance against loud noises
	var/bang_protect = 0
	// Multiplier for both long term and short term ear damage
	var/ear_damage_multiplier = 1

/obj/item/organ/ears/on_life(delta_time, times_fired)
	. = ..()
	// if we have non-damage related deafness like mutations, quirks or clothing (earmuffs), don't bother processing here - Ear healing from earmuffs or chems happen elsewhere
	if(HAS_TRAIT_NOT_FROM(owner, TRAIT_DEAF, EAR_DAMAGE))
		return

	if(is_failing())
		deaf = max(deaf, 1) // if we're failing we always have at least 1 deaf stack (and thus deafness)
	else // only clear deaf stacks if we're not failing
		applyDeaf(-(0.5 * delta_time))

/obj/item/organ/ears/get_slot_efficiency(slot)
	if((slot == ORGAN_SLOT_EARS) && deaf)
		return 0
	return ..()

/obj/item/organ/ears/proc/adjustEarDamage(ddmg, ddeaf)
	applyOrganDamage(ddmg * ear_damage_multiplier, silent = TRUE)
	applyDeaf(ddeaf * ear_damage_multiplier)

/obj/item/organ/ears/proc/applyDeaf(d, maximum = maxHealth)
	if(!d) //Micro-optimization.
		return
	deaf = clamp(deaf + d, 0, maximum)
