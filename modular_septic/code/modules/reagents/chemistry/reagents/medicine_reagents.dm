//Powerful painkiller
/datum/reagent/medicine/morphine
	name = "Morphine"
	description = "A powerful yet highly addictive painkiller. Causes drowsyness. Overdosing causes jitteryness and muscle spasms."
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD
	addiction_types = list(/datum/addiction/opiods = 15)

/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 80, "[type]")

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
	switch(current_cycle)
		if(11)
			to_chat(M, span_warning("I start to feel tired...") )
		if(12 to 24)
			M.drowsyness += 1 * REM * delta_time
	return ..()

/datum/reagent/medicine/morphine/overdose_process(mob/living/M, delta_time, times_fired)
	if(DT_PROB(20, delta_time))
		M.drop_all_held_items()
		M.Dizzy(2)
		M.Jitter(2)
	return ..()

//Slight painkiller, stabilizes pulse
/datum/reagent/medicine/inaprovaline
	name = "Inaprovalil"
	description = "Inaprovalil works as a pulse stabilizer and light painkiller. Useful for treating shock. \
				Overdosing causes fatigue and drowsyness."
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/inaprovaline/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 10, "[type]")
	L.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/medicine/inaprovaline/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_STABLE, "[type]")
	L.remove_chem_effect(CE_SPEED, "[type]")

/datum/reagent/medicine/inaprovaline/overdose_start(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_SPEED, -1, "[type]")

/datum/reagent/medicine/inaprovaline/overdose_process(mob/living/M, delta_time, times_fired)
	. = ..()
	if(DT_PROB(3, delta_time))
		M.slurring = max(M.slurring, 10)
	if(DT_PROB(3, delta_time))
		M.drowsyness = max(M.drowsyness, 5)
	return TRUE

//Pulse increase and painkiller
/datum/reagent/determination
	name = "Adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "rush"
	reagent_state = LIQUID
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = "#c8a5dc"

/datum/reagent/determination/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_STIMULANT, 1, "[type]")
	L.add_chem_effect(CE_PULSE, 1, "[type]")
	L.add_chem_effect(CE_PAINKILLER, min(5*holder.get_reagent_amount(/datum/reagent/determination), 25), "[type]")

/datum/reagent/determination/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	M.remove_chem_effect(CE_STIMULANT, "[type]")
	M.remove_chem_effect(CE_PULSE, "[type]")
	M.remove_chem_effect(CE_PAINKILLER, "[type]")

//Pulse increase and painkilelr
/datum/reagent/medicine/epinephrine
	name = "Epinephrine"
	description = "Epinephrine slowly heals damage if a patient is in critical condition, as well as regulating oxygen loss. Overdose causes weakness and toxin damage."
	taste_description = "rush"

/datum/reagent/medicine/epinephrine/on_mob_metabolize(mob/living/carbon/M)
	. = ..()
	M.add_chem_effect(CE_STIMULANT, 1, "[type]")
	M.add_chem_effect(CE_PULSE, 1, "[type]")
	M.add_chem_effect(CE_PAINKILLER, min(5*holder.get_reagent_amount(/datum/reagent/determination), 25), "[type]")

/datum/reagent/medicine/epinephrine/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	M.remove_chem_effect(CE_STIMULANT, "[type]")
	M.remove_chem_effect(CE_PULSE, "[type]")
	M.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/epinephrine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(holder.has_reagent(/datum/reagent/toxin/lexorin))
		holder.remove_reagent(/datum/reagent/toxin/lexorin, 2 * REM * delta_time)
		holder.remove_reagent(/datum/reagent/medicine/epinephrine, 1 * REM * delta_time)
		if(DT_PROB(10, delta_time))
			holder.add_reagent(/datum/reagent/toxin/histamine, 4)
		..()
		return TRUE
	if(M.health <= M.crit_threshold)
		M.adjustToxLoss(-0.5 * REM * delta_time, 0)
		M.adjustBruteLoss(-0.5 * REM * delta_time, 0)
		M.adjustFireLoss(-0.5 * REM * delta_time, 0)
		M.adjustOxyLoss(-0.5 * REM * delta_time, 0)
	if(M.losebreath >= 4)
		M.losebreath -= 2 * REM * delta_time
		M.losebreath = max(0, M.losebreath)
	M.adjustStaminaLoss(-0.5 * REM * delta_time, 0)
	if(DT_PROB(10, delta_time))
		M.AdjustAllImmobility(-20)
	..()
	return TRUE

/datum/reagent/medicine/epinephrine/overdose_process(mob/living/M, delta_time, times_fired)
	if(DT_PROB(18, REM * delta_time))
		M.adjustStaminaLoss(2.5, 0)
		M.adjustToxLoss(1, 0)
		M.losebreath++
		..()
		return TRUE
	..()

//Reduces pulse slightly
/datum/reagent/medicine/lisinopril
	name = "Lisinopril"
	description = "Lisinopril is a drug used to reduce blood pressure. It is not processed by the liver and has a very slow metabolization. \
				Overdosing causes arterial blockage."
	ph = 5.1
	metabolization_rate = 0.2 * REAGENTS_METABOLISM //Lisinopril has a very, very slow metabolism IRL
	self_consuming = TRUE //Does not get processed by the liver
	color = "#dbafc0"
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/lisinopril/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, -2, "[type]")

/datum/reagent/medicine/lisinopril/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PULSE, "[type]")
	L.remove_chem_effect(CE_BLOCKAGE, "[type]")

/datum/reagent/medicine/lisinopril/overdose_start(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_BLOCKAGE, 40, "[type]")

//Oxygenation
/datum/reagent/medicine/salbutamol
	name = "Salbutamol"
	description = "Rapidly restores blood oxygenation and dilates the lungs."

/datum/reagent/medicine/salbutamol/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_OXYGENATED, 2, "[type]")

/datum/reagent/medicine/salbutamol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/medicine/salbutamol/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOxyLoss(-3 * REM * delta_time, 0)
	..()
	return TRUE

//Antibiotic
/datum/reagent/medicine/spaceacillin
	name = "Spaceacillin"
	description = "Spaceacillin is a broad spectrum antibiotic and immune response booster. \
				Overdosing weakens immune response instead."
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/spaceacillin/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ANTIBIOTIC, 50, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/carbon_mob = L
		carbon_mob.immunity += 25

/datum/reagent/medicine/spaceacillin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ANTIBIOTIC, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/carbon_mob = L
		carbon_mob.immunity -= 25

/datum/reagent/medicine/spaceacillin/overdose_start(mob/living/M)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/carbon_mob = M
		carbon_mob.immunity -= 75
	M.remove_chem_effect(CE_ANTIBIOTIC, "[type]")

//Copium
/datum/reagent/medicine/copium
	name = "Copium"
	description = "The strongest synthetic painkiller. Highly addictive, easily overdoseable at 15u."
	ph = 6.9
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM
	self_consuming = TRUE //Does not get processed by the liver
	color = "#d364ff"
	overdose_threshold = 15
	addiction_types = list(/datum/addiction/opiods = 30)

/datum/reagent/medicine/copium/overdose_start(mob/living/M)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.set_heartattack(TRUE)
		C.client?.give_award(/datum/award/achievement/misc/copium, C)

/datum/reagent/medicine/copium/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, -2, "[type]")
	L.add_chem_effect(CE_PAINKILLER, 200, "[type]")

/datum/reagent/medicine/copium/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_PULSE, "[type]")

//Radiation sickness medication
/datum/reagent/medicine/potass_iodide
	description = "A chemical used to treat radiation sickness, effectively working as a stopgap while the radiation is being flushed away. \
				Will not work if the patient is in the late stages of radiation sickness."

/datum/reagent/medicine/potass_iodide/on_mob_metabolize(mob/living/L)
	. = ..()
	var/datum/component/irradiated/hisashi_ouchi = L.GetComponent(/datum/component/irradiated)
	if(!hisashi_ouchi || (hisashi_ouchi.radiation_sickness < RADIATION_SICKNESS_UNHEALABLE))
		ADD_TRAIT(L, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/medicine/potass_iodide/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/medicine/potass_iodide/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	var/datum/component/irradiated/hisashi_ouchi = M.GetComponent(/datum/component/irradiated)
	if(hisashi_ouchi && (hisashi_ouchi.radiation_sickness < RADIATION_SICKNESS_UNHEALABLE))
		hisashi_ouchi.radiation_sickness = clamp(CEILING(hisashi_ouchi.radiation_sickness - (delta_time SECONDS), 1), 0, RADIATION_SICKNESS_MAXIMUM)
