/// Can this limb suffer dismemberment?
/obj/item/bodypart/proc/can_dismember(obj/item/dismemberer)
	return dismemberable

/// Does this limb leave a stump behind, when dismembered?
/obj/item/bodypart/proc/can_stump(obj/item/dismemberer)
	return !(limb_flags & BODYPART_NO_STUMP)

/// Dismember a limb
/obj/item/bodypart/proc/dismember(dam_type = BRUTE, silent = TRUE, destroy = FALSE, wounding_type = WOUND_SLASH)
	if(!owner || !can_dismember())
		return FALSE

	//owner will get nulled
	var/mob/living/carbon/was_owner = owner
	if(was_owner.status_flags & GODMODE)
		return FALSE
	if(HAS_TRAIT(was_owner, TRAIT_NODISMEMBER))
		return FALSE

	var/obj/item/bodypart/affecting = was_owner.get_bodypart(parent_body_zone)
	affecting.receive_damage(clamp(brute_dam/2, 15, 50), clamp(burn_dam/2, 0, 50), wound_bonus=CANT_WOUND) //Damage the parent based on limb's existing damage

	INVOKE_ASYNC(was_owner, /mob/living.proc/death_scream)
	SEND_SIGNAL(was_owner, COMSIG_ADD_MOOD_EVENT, "dismembered", /datum/mood_event/dismembered)
	drop_limb(dismembered = TRUE, destroyed = destroy, wounding_type = wounding_type)
	was_owner.update_equipment_speed_mods() // Update in case speed affecting item unequipped by dismemberment

	if(QDELETED(src)) //Could have dropped into lava/explosion/chasm/whatever
		return TRUE

	add_mob_blood(was_owner)
	was_owner.bleed(rand(10, 20)) // let the arterial bleeding fuck the bastard over
	var/direction = pick(GLOB.cardinals)
	var/t_range = rand(2,max(throw_range/2, 2))
	var/turf/target_turf = get_turf(src)
	for(var/i in 1 to t_range-1)
		var/turf/new_turf = get_step(target_turf, direction)
		if(!new_turf)
			break
		target_turf = new_turf
		if(new_turf.density)
			break
	var/old_throwforce = throwforce
	throwforce = 0
	throw_at(target_turf, throw_range, throw_speed, callback = CALLBACK(src, .proc/dismember_done, old_throwforce))
	return TRUE

/// Resets damage after being dismembered and thrown
/obj/item/bodypart/proc/dismember_done(new_throwforce = initial(throwforce))
	throwforce = new_throwforce

/// Limb removal. The "special" argument is used for swapping a limb with a new one without the effects of losing a limb kicking in.
/obj/item/bodypart/proc/drop_limb(special = FALSE, dismembered = FALSE, ignore_children = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	. = FALSE
	if(!owner)
		return

	var/atom/Tsec = owner.drop_location()
	var/mob/living/carbon/was_owner = owner
	SEND_SIGNAL(was_owner, COMSIG_CARBON_REMOVE_LIMB, src, dismembered)
	update_limb(TRUE, was_owner)
	owner.remove_bodypart(src)

	if(!special)
		if(held_index)
			if(LAZYACCESS(owner.hand_bodyparts, held_index) == src)
				// We only want to do this if the limb being removed is the active hand part.
				// This catches situations where limbs are "hot-swapped" such as augmentations and roundstart prosthetics.
				owner.dropItemToGround(owner.get_item_for_held_index(held_index), TRUE)
				owner.hand_bodyparts[held_index] = null
			if(owner.hud_used)
				var/atom/movable/screen/inventory/hand/hand = was_owner.hud_used.hand_slots["[held_index]"]
				if(hand)
					hand.update_appearance()
			if(!(owner.status_flags & BUILDING_ORGANS))
				owner.update_inv_gloves()
		if(stance_index)
			if(LAZYACCESS(owner.leg_bodyparts, stance_index) == src)
				owner.leg_bodyparts[stance_index] = null
		if(sight_index)
			if(LAZYACCESS(owner.eye_bodyparts, sight_index) == src)
				owner.eye_bodyparts[sight_index] = null

	for(var/citem in cavity_items)
		var/obj/item/cavity_item = citem
		if(istype(Tsec))
			cavity_item.forceMove(Tsec)
		else
			qdel(cavity_item)
		LAZYREMOVE(cavity_items, cavity_item)

	for(var/thing in injuries)
		var/datum/injury/injury = thing
		injury.remove_from_mob()

	for(var/thing in wounds)
		var/datum/wound/wound = thing
		wound.remove_wound(TRUE)

	for(var/thing in scars)
		var/datum/scar/scar = thing
		scar.victim = null
		LAZYREMOVE(owner.all_scars, scar)

	for(var/obj/item/cavity_item in embedded_objects)
		LAZYREMOVE(embedded_objects, cavity_item)
		if(istype(Tsec))
			cavity_item.forceMove(Tsec)
		else
			qdel(cavity_item)

	var/mob/living/carbon/phantom_owner = owner // so we can still refer to the guy who lost their limb after said limb forgets 'em
	set_owner(null)
	limb_flags |= BODYPART_CUT_AWAY

	if(!ignore_children)
		for(var/BP in children_zones)
			var/obj/item/bodypart/bodypart = phantom_owner.get_bodypart(BP)
			if(bodypart)
				//child could have been deleted
				bodypart.transfer_to_limb(src, phantom_owner)

	if(!phantom_owner.has_embedded_objects())
		phantom_owner.clear_alert("embeddedobject")
		SEND_SIGNAL(phantom_owner, COMSIG_CLEAR_MOOD_EVENT, "embedded")

	if(!special)
		if(phantom_owner.dna)
			for(var/X in phantom_owner.dna.mutations) //some mutations require having specific limbs to be kept.
				var/datum/mutation/human/MT = X
				if(MT.limb_req && MT.limb_req == body_zone)
					phantom_owner.dna.force_lose(MT)
		for(var/X in phantom_owner.internal_organs) //internal organs inside the dismembered limb are dropped
			var/obj/item/organ/organ = X
			var/org_zone = check_zone(organ.current_zone)
			if(org_zone != body_zone)
				continue
			organ.transfer_to_limb(src, phantom_owner)
		if(CHECK_BITFIELD(limb_flags, BODYPART_VITAL))
			phantom_owner.death()

	/// Not a clean chopping off, leave a stump behind
	if(!special && dismembered && can_stump())
		var/obj/item/bodypart/parent = phantom_owner.get_bodypart(parent_body_zone)
		if(parent && !parent.is_stump())
			var/obj/item/bodypart/stump/stump  = new(phantom_owner)
			stump.inherit_from_limb(src)
			if(!stump.attach_limb(phantom_owner, FALSE, FALSE))
				qdel(stump)
			//make sure the stump wasn't qdeleted
			if(!QDELETED(stump))
				stump.create_injury(wounding_type, stump.max_damage / 2, FALSE, TRUE)

	cut_away_limb()
	update_icon_dropped()
	if(!(phantom_owner.status_flags & BUILDING_ORGANS))
		phantom_owner.update_health_hud() //update the healthdoll
		phantom_owner.updatehealth()
		phantom_owner.update_body()
		phantom_owner.update_medicine_overlays()
		phantom_owner.update_hair()
	. = TRUE
	// Recover integrity, if we get qdeleted or not it does not matter
	limb_integrity = max_limb_integrity
	if(!QDELETED(src))
		// Tsec = null happens when a "dummy human" used for rendering icons on prefs screen gets its limbs replaced
		if(!istype(Tsec) || destroyed)
			qdel(src)
			return
		else if(is_pseudopart)
			drop_organs(phantom_owner) //Pseudoparts shouldn't have organs, but maybe something funny happened
			qdel(src)
			return
		/// Start processing rotting
		START_PROCESSING(SSobj, src)

		forceMove(Tsec)

/**
 * get_mangled_state() is relevant for flesh and bone bodyparts, and returns whether this bodypart has mangled skin, mangled bone, or both (or neither i guess)
 *
 * Dismemberment for flesh and bone requires the victim to have the skin on their bodypart destroyed (either a critical cut or piercing wound), and at least a hairline fracture
 * (severe bone), at which point we can start rolling for dismembering. The attack must also deal at least 10 damage, and must be a brute attack of some kind (sorry for now, cakehat, maybe later)
 *
 * Returns: BODYPART_MANGLED_NONE if we're fine, BODYPART_MANGLED_FLESH if our skin is broken, BODYPART_MANGLED_BONE if our bone is broken, or BODYPART_MANGLED_BOTH if both are broken and we're up for dismembering
 */
/obj/item/bodypart/proc/get_mangled_state()
	. = BODYPART_MANGLED_NONE
	var/biological_state = BIO_FLESH_BONE
	if(owner)
		biological_state = owner.get_biological_state()
	var/required_bone_severity = WOUND_SEVERITY_SEVERE
	var/required_flesh_severity = WOUND_SEVERITY_SEVERE
	var/required_flesh_damage = min(25, FLOOR(max_damage * 0.5, 1)) //How much cut or pierce damage we need

	if(biological_state == BIO_JUST_BONE)
		if(!HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
			required_bone_severity = WOUND_SEVERITY_CRITICAL

	if(biological_state == BIO_JUST_FLESH)
		if(!HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
			required_flesh_damage = min(max_damage, required_flesh_damage * 2)

	for(var/i in wounds)
		//just return, no point in continuing - if we know we are fucked, we won't get unfucked
		if(. == BODYPART_MANGLED_BOTH)
			return

		var/datum/wound/iter_wound = i
		if((iter_wound.wound_flags & WOUND_MANGLES_BONE) && (iter_wound.severity >= required_bone_severity))
			if(. == BODYPART_MANGLED_FLESH || . == BODYPART_MANGLED_BOTH)
				. = BODYPART_MANGLED_BOTH
			else
				. = BODYPART_MANGLED_BONE
		if((iter_wound.wound_flags & WOUND_MANGLES_FLESH) && (iter_wound.severity >= required_flesh_severity))
			if(. == BODYPART_MANGLED_BONE || . == BODYPART_MANGLED_BOTH)
				. = BODYPART_MANGLED_BOTH
			else
				. = BODYPART_MANGLED_FLESH

	var/flesh_damage = 0
	for(var/i in injuries)
		//just return, no point in continuing - if we know we are fucked, we won't get unfucked
		if(. == BODYPART_MANGLED_BOTH)
			return

		var/datum/injury/IN = i
		if(IN.damage_type in list(WOUND_BLUNT, WOUND_SLASH, WOUND_PIERCE, WOUND_BLUNT))
			if(IN.damage_type == WOUND_BLUNT)
				flesh_damage += (IN.damage * 0.5)
				continue
			flesh_damage += IN.damage

	if(flesh_damage >= required_flesh_damage)
		if(. == BODYPART_MANGLED_BONE || . == BODYPART_MANGLED_BOTH)
			. = BODYPART_MANGLED_BOTH
		else
			. = BODYPART_MANGLED_FLESH

	if(is_tendon_torn() || no_tendon())
		if(. == BODYPART_MANGLED_BONE || . == BODYPART_MANGLED_BOTH)
			. = BODYPART_MANGLED_BOTH
		else
			. = BODYPART_MANGLED_FLESH

	if(required_bone_severity >= WOUND_SEVERITY_CRITICAL)
		if(is_compound_fractured() || no_bone())
			if(. == BODYPART_MANGLED_FLESH || . == BODYPART_MANGLED_BOTH)
				. = BODYPART_MANGLED_BOTH
			else
				. = BODYPART_MANGLED_BONE
	else
		if(is_fractured() || no_bone())
			if(. == BODYPART_MANGLED_FLESH || . == BODYPART_MANGLED_BOTH)
				. = BODYPART_MANGLED_BOTH
			else
				. = BODYPART_MANGLED_BONE

/**
  * damage_integrity() is used, once we've confirmed that a flesh and bone bodypart has both the muscle and bone mangled,
  * to try and damage it's integrity, which once it reaches 0... the bodypart is dismembered or gored.
  *
  * Arguments:
  * * wounding_type: Either WOUND_BLUNT, WOUND_SLASH, or WOUND_PIERCE, basically only matters for the dismember message
  * * wounding_dmg: The damage of the strike that prompted this roll, higher damage = higher integrity loss
  * * wound_bonus: Not actually used right now, but maybe someday
  * * bare_wound_bonus: Ditto above
  */
/obj/item/bodypart/proc/damage_integrity(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)
	if(!owner || (wounding_dmg <= DISMEMBER_MINIMUM_DAMAGE) || (wound_bonus == CANT_WOUND))
		return FALSE

	// If we have a compound fracture, then deal more integrity damage
	if(is_compound_fractured())
		wounding_dmg *= 1.25
	// Endurance affects dismemberment
	var/endurance_modifier = (GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE)-ATTRIBUTE_MIDDLING)*0.05
	wounding_dmg *= max(0, 1 - endurance_modifier)

	if(ishuman(owner) && bare_wound_bonus)
		var/mob/living/carbon/human/human_owner = owner
		for(var/i in human_owner.clothingonpart(src))
			var/obj/item/clothing/clothes_check = i
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	if(wound_bonus == CANT_WOUND)
		return FALSE

	// Damage the integrity with the wounding damage
	limb_integrity = clamp(limb_integrity - (wounding_dmg*incoming_integrity_mult), 0, max_limb_integrity)

/**
 * try_dismember() is used, once we've confirmed that a flesh and bone bodypart has both the skin and bone mangled, to actually roll for it
 *
 * Mangling is described in the above proc, [/obj/item/bodypart/proc/get_mangled_state]. This simply makes the roll for whether we actually dismember or not
 * using how damaged the limb already is, and how much damage this blow was for. If we have a critical bone wound instead of just a severe, we add +10% to the roll.
 * Lastly, we choose which kind of dismember we want based on the wounding type we hit with. Note we don't care about all the normal mods or armor for this
 *
 * Arguments:
 * * wounding_type: Either WOUND_BLUNT, WOUND_SLASH, or WOUND_PIERCE, basically only matters for the dismember message
 * * wounding_dmg: The damage of the strike that prompted this roll, higher damage = higher chance
 * * wound_bonus: Not actually used right now, but maybe someday
 * * bare_wound_bonus: ditto above
 */
/obj/item/bodypart/proc/try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)
	if(!owner)
		return FALSE
	if((limb_integrity > 0) || !can_dismember() || (wounding_dmg < DISMEMBER_MINIMUM_DAMAGE) || (wound_bonus == CANT_WOUND))
		return FALSE

	apply_dismember(wounding_type, TRUE, TRUE)
	return TRUE

/**
 * Applies dismemberment from try_dismember
 */
/obj/item/bodypart/proc/apply_dismember(wounding_type = WOUND_SLASH, silent = FALSE, add_descriptive = TRUE)
	if(!owner || !can_dismember())
		return FALSE

	var/occur_text = "is slashed through the last tissue holding it together, severing it completely"
	switch(wounding_type)
		if(WOUND_BLUNT)
			occur_text = "is shattered into a shower of gore"
			if(status == BODYPART_ROBOTIC)
				occur_text = "is shattered into a shower of sparks"
		if(WOUND_SLASH)
			occur_text = "is slashed through the last bit of tissue holding it together, severing it completely"
			if(status == BODYPART_ROBOTIC)
				occur_text = "is slashed through the last bit of exoskeleton layer holding it together, severing it completely"
		if(WOUND_PIERCE)
			occur_text = "is pierced through the last tissue holding it together, goring it into giblets"
			if(status == BODYPART_ROBOTIC)
				occur_text = "is pierced through the last bit of exoskeleton holding it together, goring it into scrap metal"
		if(WOUND_BURN)
			occur_text = "is completely incinerated, falling to a pile of carbonized remains"
			if(status == BODYPART_ROBOTIC)
				occur_text = "is completely incinerated, falling to a puddle of debris"

	var/mob/living/carbon/was_owner = owner
	if(prob(50))
		was_owner.add_confusion(15)
	if((body_zone == BODY_ZONE_PRECISE_GROIN) && prob(50))
		was_owner.vomit(15, TRUE, TRUE)
	if(prob(80))
		was_owner.death_scream()

	if(!silent)
		was_owner.visible_message(span_danger("<b>[was_owner]</b>'s [name] [occur_text]!"), \
							span_userdanger("My [name] [occur_text]!"))
	if(add_descriptive)
		switch(wounding_type)
			if(WOUND_SLASH)
				SEND_SIGNAL(was_owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_flashingdanger(" <b><i>\The [name] is severed!</i></b>"))
			if(WOUND_PIERCE, WOUND_BLUNT)
				SEND_SIGNAL(was_owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_flashingdanger(" <b><i>\The [name] is gored!</i></b>"))
			if(WOUND_BURN)
				SEND_SIGNAL(was_owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_flashingdanger(" <b><i>\The [name] is incinerated!</i></b>"))

	var/obj/effect/decal/gore
	switch(wounding_type)
		if(WOUND_BURN)
			if(status == BODYPART_ORGANIC)
				gore = new /obj/effect/decal/cleanable/ash(get_turf(owner))
			else if(status == BODYPART_ROBOTIC)
				gore = new /obj/effect/decal/cleanable/robot_debris(get_turf(owner))
		if(WOUND_BLUNT)
			if(status == BODYPART_ORGANIC)
				gore = new /obj/effect/decal/cleanable/blood/gibs(get_turf(owner))
			else if(status == BODYPART_ROBOTIC)
				gore = new /obj/effect/decal/cleanable/oil(get_turf(owner))
	if(gore)
		gore.add_mob_blood(owner)

	//apply the blood gush effect
	if(wounding_type != WOUND_BURN)
		var/direction = owner.dir
		direction = turn(direction, 180)
		var/bodypart_turn = 0 //relative north
		if(body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_L_HAND))
			bodypart_turn = -90 //relative east
		else if(body_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_R_HAND))
			bodypart_turn = 90 //relative west
		var/lying_angle = owner.lying_angle
		bodypart_turn += lying_angle
		direction = turn(direction, bodypart_turn)
		owner.do_hitsplatter(direction, 3, 5, FALSE)

	var/dismember_sound = pick(dismemberment_sounds)
	if(status == BODYPART_ROBOTIC)
		dismember_sound = 'modular_septic/sound/effects/crowbarhit.ogg'
	playsound(owner, dismember_sound, 80, 0)
	dismember(dam_type = (wounding_type == WOUND_BURN ? BURN : BRUTE), silent = TRUE, destroy = (wounding_type != WOUND_SLASH), wounding_type = wounding_type)

/// Stuff you do when you go inside a parent limb that was chopped off
/obj/item/bodypart/proc/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	if(owner)
		drop_limb()
	if(new_limb)
		forceMove(new_limb)
	limb_flags &= ~BODYPART_CUT_AWAY
	return TRUE

/obj/item/bodypart/proc/attach_limb(mob/living/carbon/new_owner, special = FALSE, ignore_parent = FALSE)
	if(SEND_SIGNAL(new_owner, COMSIG_CARBON_ATTACH_LIMB, src, special) & COMPONENT_NO_ATTACH)
		return FALSE
	var/obj/item/bodypart/parent
	if(new_owner && parent_body_zone)
		parent = new_owner.get_bodypart(parent_body_zone)
	if(parent_body_zone && !ignore_parent && (!istype(parent) || parent.is_stump()) )
		return FALSE
	. = TRUE
	moveToNullspace()
	set_owner(new_owner)
	new_owner.add_bodypart(src)
	/// Infection will be handled on on_life() from now on
	STOP_PROCESSING(SSobj, src)

	if(!special)
		if(held_index)
			if(held_index > new_owner.hand_bodyparts.len)
				new_owner.hand_bodyparts.len = held_index
			new_owner.hand_bodyparts[held_index] = src
			if(!(new_owner.status_flags & BUILDING_ORGANS))
				if(new_owner.dna?.species?.mutanthands && !is_pseudopart)
					new_owner.put_in_hand(new new_owner.dna.species.mutanthands(), held_index)
			if(new_owner.hud_used)
				var/atom/movable/screen/inventory/hand/hand = new_owner.hud_used.hand_slots["[held_index]"]
				if(hand)
					hand.update_appearance()
			if(!(new_owner.status_flags & BUILDING_ORGANS))
				new_owner.update_inv_gloves()
		if(stance_index)
			if(stance_index > new_owner.leg_bodyparts.len)
				new_owner.leg_bodyparts.len = stance_index
			new_owner.leg_bodyparts[stance_index] = src
		if(sight_index)
			if(sight_index > new_owner.eye_bodyparts.len)
				new_owner.eye_bodyparts.len = sight_index
			new_owner.eye_bodyparts[sight_index] = src

	//Transfer some appearance vars over
	if(brain)
		if(brainmob)
			brainmob.container = null //Reset brainmob limb var.
			brainmob.forceMove(brain) //Throw mob into brain.
			brain.brainmob = brainmob //Set the brain to use the brainmob
			brainmob = null //Set limb brainmob var to null
		brain.Insert(new_owner) //Now insert the brain proper
		brain = null //No more brain in the limb

	//Stored limbs. in normal circumstances, this will be either nothing or just the children
	for(var/obj/item/bodypart/stored_limb in src)
		if(!(stored_limb.body_zone in children_zones) || !stored_limb.attach_limb(new_owner, special, ignore_parent))
			qdel(stored_limb)

	for(var/obj/item/organ/stored_organ in src)
		stored_organ.Insert(new_owner, FALSE, FALSE)

	for(var/i in wounds)
		var/datum/wound/wound = i
		// we have to remove the wound from the limb wound list first, so that we can reapply it fresh with the new person
		// otherwise the wound thinks it's trying to replace an existing wound of the same type (itself) and fails/deletes itself
		LAZYREMOVE(wounds, wound)
		wound.apply_wound(src, TRUE)

	//Add injuries to the owner's injury list
	for(var/i in injuries)
		var/datum/injury/injury = i
		injury.parent_mob = new_owner
		LAZYADD(new_owner.all_injuries, injury)

	for(var/thing in scars)
		var/datum/scar/scar = thing
		if(scar in new_owner.all_scars) // prevent double scars from happening for whatever reason
			continue
		scar.victim = new_owner
		LAZYADD(new_owner.all_scars, thing)

	if(!(new_owner.status_flags & BUILDING_ORGANS))
		update_bodypart_damage_state()
		update_limb_efficiency()

		new_owner.updatehealth()
		new_owner.update_body()
		new_owner.update_hair()
		new_owner.update_damage_overlays()

//Attach a limb to a human and drop any existing limb of that type.
/obj/item/bodypart/proc/replace_limb(mob/living/carbon/new_owner, special = FALSE, ignore_children = FALSE, ignore_parent = FALSE)
	if(!istype(new_owner))
		return
	var/obj/item/bodypart/old_bp = new_owner.get_bodypart(body_zone) //needs to happen before attach because multiple limbs in same zone breaks helpers
	if(old_bp)
		old_bp.drop_limb(special, FALSE, ignore_children)
	if(!attach_limb(new_owner, special, ignore_parent))
		qdel(src)

//Regenerates all limbs. Returns amount of limbs regenerated
/mob/living/proc/regenerate_limbs(noheal = FALSE, list/excluded_zones = list())
	SEND_SIGNAL(src, COMSIG_LIVING_REGENERATE_LIMBS, noheal, excluded_zones)

/mob/living/carbon/regenerate_limbs(noheal = FALSE, list/excluded_zones = list())
	. = ..()
	var/list/zone_list = ALL_BODYPARTS_ORDERED
	if(length(excluded_zones))
		zone_list -= excluded_zones
	for(var/Z in zone_list)
		. += regenerate_limb(Z, noheal)

/mob/living/proc/regenerate_limb(limb_zone, noheal)
	return

/mob/living/carbon/regenerate_limb(limb_zone, noheal)
	var/obj/item/bodypart/limb = get_bodypart(limb_zone)
	if(istype(limb))
		if(limb.is_stump())
			qdel(limb)
		else
			return FALSE
	limb = newBodyPart(limb_zone, 0, 0)
	if(limb)
		if(!noheal)
			limb.set_brute_dam(0)
			limb.set_burn_dam(0)
			limb.brutestate = 0
			limb.burnstate = 0
		if(dna?.species && (ROBOTIC_LIMBS in dna.species.species_traits))
			limb.change_bodypart_status(BODYPART_ROBOTIC)
			limb.limb_flags |= BODYPART_SYNTHETIC
		if(dna?.species.mutant_bodyparts["legs"] && dna.species.mutant_bodyparts["legs"][MUTANT_INDEX_NAME] == "Digitigrade Legs")
			limb.use_digitigrade = FULL_DIGITIGRADE
		if(!limb.attach_limb(src, TRUE))
			qdel(limb)
			return FALSE
		return TRUE
