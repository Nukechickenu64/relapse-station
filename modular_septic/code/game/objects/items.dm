//initializing carry weight
/obj/item/Initialize()
	. = ..()
	//we don't want items to have no carry weight - default to (w_class^2)/2
	if(isnull(carry_weight))
		carry_weight = (w_class**2)/4
	//we don't want items with null attack cost
	if(isnull(attack_fatigue_cost))
		attack_fatigue_cost = 1.5*w_class
	if(isnull(skill_blocking))
		skill_blocking = skill_melee
	else if(skill_blocking == 0)
		skill_blocking = null
	if(isnull(skill_parrying))
		skill_parrying = skill_melee
	else if(skill_parrying == 0)
		skill_parrying = null

//organ storage stuff
/obj/item/Destroy()
	if(stored_in)
		stored_in.handle_atom_del(src)
	return ..()

// epic embed failure
/obj/item/tryEmbed(atom/target, forced = FALSE, silent = FALSE)
	if(!isbodypart(target) && !iscarbon(target))
		return COMPONENT_EMBED_FAILURE
	if(!forced && !LAZYLEN(embedding))
		return COMPONENT_EMBED_FAILURE

	var/embed_attempt = SEND_SIGNAL(src, COMSIG_EMBED_TRY_FORCE, target, forced, silent)
	if(embed_attempt & COMPONENT_EMBED_SUCCESS)
		return embed_attempt

	failedEmbed()
	return embed_attempt

// Proper outlines
/obj/item/apply_outline(outline_color = null)
	if(get(src, /mob) != usr || QDELETED(src) || isobserver(usr)) //cancel if the item isn't in an inventory, is being deleted, or if the person hovering is a ghost (so that people spectating you don't randomly make your items glow)
		return
	var/theme = lowertext(usr.client?.prefs?.read_preference(/datum/preference/choiced/ui_style))
	//if we weren't provided with a color, take the theme's color
	if(!outline_color)
		//yeah it kinda has to be this way
		switch(theme)
			if("codec")
				outline_color = COLOR_THEME_CODEC_GREEN
			if("quake")
				outline_color = COLOR_THEME_QUAKE_GREEN
			if("midnight")
				outline_color = COLOR_THEME_MIDNIGHT
			if("plasmafire")
				outline_color = COLOR_THEME_PLASMAFIRE
			if("retro")
				outline_color = COLOR_THEME_RETRO //just as garish as the rest of this theme
			if("slimecore")
				outline_color = COLOR_THEME_SLIMECORE
			if("operative")
				outline_color = COLOR_THEME_OPERATIVE
			if("clockwork")
				outline_color = COLOR_THEME_CLOCKWORK //if you want free gbp go fix the fact that clockwork's tooltip css is glass'
			if("glass")
				outline_color = COLOR_THEME_GLASS
			else //this should never happen, hopefully
				outline_color = COLOR_WHITE

	add_filter("hover_outline", 1, list("type" = "outline", "size" = 1, "color" = outline_color))

//cool throwing animation
/obj/item/on_thrown(mob/living/carbon/user, atom/target)
	if((item_flags & ABSTRACT) || HAS_TRAIT(src, TRAIT_NODROP))
		return
	user.dropItemToGround(src, silent = TRUE)
	if(throwforce && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_notice("I set [src] down gently on the ground."))
		return
	undo_messy()
	do_messy(duration = 4)
	return src

/obj/item/after_throw(datum/callback/callback)
	. = ..()
	sound_hint()
	undo_messy()
	do_messy(duration = 2)

/obj/item/hit_reaction(mob/living/carbon/human/owner, \
					atom/movable/hitby, \
					attack_text = "the attack", \
					damage = 0, \
					attacking_flags = BLOCK_FLAG_MELEE)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, owner, hitby, attack_text, damage, attacking_flags)
	if(signal_return)
		return signal_return

	if(damage && !isnull(blocking_modifier) && CHECK_MULTIPLE_BITFIELDS(blocking_flags, attacking_flags))
		var/skill_modifier = 0
		if(skill_blocking)
			skill_modifier = FLOOR(3 + GET_MOB_SKILL_VALUE(owner, skill_blocking)/2, 1)
		if(owner.diceroll(skill_modifier))
			owner.visible_message(span_danger("<b>[owner]</b> blocks [attack_text] with [src]!"), \
								span_danger("I block [attack_text] with [src]!"), \
								vision_distance = COMBAT_MESSAGE_RANGE)
			return COMPONENT_HIT_REACTION_BLOCK
		return COMPONENT_HIT_REACTION_CANCEL

//fov stuff
/obj/item/equipped(mob/user, slot, initial)
	. = ..()
	if((fov_angle || fov_shadow_angle) && (slot & ITEM_SLOT_HEAD | ITEM_SLOT_MASK))
		var/datum/component/field_of_vision/fov = user.GetComponent(/datum/component/field_of_vision)
		if(fov)
			fov.generate_fov_holder(source = user, _angle = fov_angle, _shadow_angle = fov_shadow_angle)

//embedding stuff
/obj/item/embedded(atom/embedded_target, obj/item/bodypart/part)
	SEND_SIGNAL(src, COMSIG_ITEM_EMBEDDED, embedded_target, part)
	return ..()

/obj/item/unembedded(atom/embedded_target, obj/item/bodypart/part)
	SEND_SIGNAL(src, COMSIG_ITEM_UNEMBEDDED, embedded_target, part)
	return ..()

/obj/item/on_exit_storage(datum/component/storage/concrete/master_storage)
	. = ..()
	stored_in =  null

/obj/item/onZImpact(turf/T, levels)
	. = ..()
	undo_messy()
	do_messy(duration = 4)

/obj/item/germ_level_examine(mob/user)
	. = list()
	var/p_They = p_they(TRUE)
	var/p_are = p_are()
	switch(germ_level)
		if(0 to GERM_LEVEL_DIRTY)
			. += "[p_They] [p_are] is clean."
		if(GERM_LEVEL_DIRTY to GERM_LEVEL_FILTHY)
			return "[p_They] [p_are] a bit dirty."
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			return span_warning("[p_They] [p_are] filthy.")
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			return span_warning("[p_They] [p_are] abominably foul.")

/obj/item/examine_chaser(mob/user)
	. = list()
	var/p_They = p_they(TRUE)
	var/p_s = p_s()
	if(isobserver(user))
		. += "[p_They] weigh[p_s] exactly <b>[get_carry_weight()]kg</b>."
	else if(user.is_holding(src))
		. += "[p_They] weigh[p_s] around <b>[FLOOR(get_carry_weight(), 1)]kg</b>."
	if(skill_melee && (isobserver(user) || user.Adjacent(src)))
		var/p_are = p_are()
		var/datum/attribute/skill/skill_used = GET_ATTRIBUTE_DATUM(skill_melee)
		if(istype(skill_used))
			. += "[p_They] [p_are] best used with the <i>[lowertext(skill_used.name)]</i> skill in melee combat."

//cool drop and throw effect
/obj/item/proc/do_messy(pixel_variation = 8, angle_variation = 360, duration = 0)
	if(item_flags & NO_PIXEL_RANDOM_DROP)
		return
	animate(src, pixel_x = (base_pixel_x+rand(-pixel_variation,pixel_variation)), duration)
	animate(src, pixel_y = (base_pixel_y+rand(-pixel_variation,pixel_variation)), duration)
	if(our_angle)
		animate(src, transform = transform.Turn(-our_angle), duration)
		our_angle = 0
	our_angle = rand(0,angle_variation)
	transform = transform.Turn(our_angle)

/obj/item/proc/undo_messy(duration = 0)
	animate(src, pixel_x = base_pixel_x, duration)
	animate(src, pixel_y = base_pixel_y, duration)
	if(our_angle)
		animate(src, transform = transform.Turn(-our_angle), duration)
		our_angle = 0

/obj/item/proc/spread_filth(atom/filthy)
	var/filth = FLOOR(germ_level/10, 1)
	if(filth && filthy)
		filthy.adjust_germ_level(filth)

/obj/item/proc/get_carry_weight()
	. = carry_weight
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	if(storage)
		. += storage.get_carry_weight()

/obj/item/proc/get_item_credit_price()
	return custom_price
