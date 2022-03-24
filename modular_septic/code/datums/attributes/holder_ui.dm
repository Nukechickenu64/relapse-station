/datum/attribute_holder
	var/datum/attribute/closely_inspected_attribute = null
	var/show_bad_skills = FALSE

/datum/attribute_holder/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AttributeMenu")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/attribute_holder/ui_state(mob/user)
	return GLOB.always_state

/datum/attribute_holder/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/attributes_big),
		get_asset_datum(/datum/asset/spritesheet/attributes_small),
	)

/datum/attribute_holder/ui_data(mob/user)
	var/list/data = list()

	data["show_bad_skills"] = show_bad_skills
	data["parent"] = parent?.name
	if(istype(closely_inspected_attribute))
		var/list/closely_inspected = list()
		var/raw_value = nulltozero(raw_attribute_list[closely_inspected_attribute.type])
		var/value = nulltozero(attribute_list[closely_inspected_attribute.type])
		closely_inspected["name"] = closely_inspected_attribute.name
		closely_inspected["desc"] = closely_inspected_attribute.desc
		closely_inspected["desc_from_level"] = capitalize_like_old_man(closely_inspected_attribute.description_from_level(attribute_list[closely_inspected_attribute.type]))
		closely_inspected["raw_value"] = raw_value
		closely_inspected["value"] = value
		closely_inspected["icon"] = sanitize_css_class_name(closely_inspected_attribute.name)
		if(istype(closely_inspected_attribute, /datum/attribute/stat))
			var/datum/attribute/stat/closely_inspected_stat = closely_inspected_attribute
			closely_inspected["shorthand"] = closely_inspected_stat.shorthand
		else if(istype(closely_inspected_attribute, /datum/attribute/skill))
			var/datum/attribute/skill/closely_inspected_skill = closely_inspected_attribute
			closely_inspected["difficulty"] = closely_inspected_skill.difficulty
			if(closely_inspected_skill.governing_attribute)
				var/datum/attribute/governing_attribute = GET_ATTRIBUTE_DATUM(closely_inspected_skill.governing_attribute)
				closely_inspected["governing_attribute"] = governing_attribute.name
			if(LAZYLEN(closely_inspected_skill.default_attributes))
				var/list/defaults = list()

				for(var/attribute_type in closely_inspected_skill.default_attributes)
					var/datum/attribute/attribute_datum = GET_ATTRIBUTE_DATUM(attribute_type)
					var/list/this_attribute_default = list()

					this_attribute_default["name"] = attribute_datum.name
					this_attribute_default["desc"] = attribute_datum.desc
					this_attribute_default["icon"] = sanitize_css_class_name(attribute_datum.name)
					this_attribute_default["default_value"] = closely_inspected_skill.default_attributes[attribute_type]

					defaults += list(this_attribute_default)

				closely_inspected["defaults"] = defaults
			else
				closely_inspected["defaults"] = null
		closely_inspected["raw_value"] = GET_MOB_ATTRIBUTE_VALUE_RAW(parent, closely_inspected.type)
		closely_inspected["value"] = GET_MOB_ATTRIBUTE_VALUE(parent, closely_inspected.type)

		data["closely_inspected_attribute"] = closely_inspected

		return data

	var/list/stats = list()
	for(var/stat_type in GLOB.all_stats)
		var/datum/attribute/stat/stat = GET_ATTRIBUTE_DATUM(stat_type)

		var/list/this_stat = list()
		this_stat["name"] = stat.name
		this_stat["desc"] = stat.desc
		this_stat["icon"] = sanitize_css_class_name(stat.name)
		this_stat["shorthand"] = stat.shorthand
		this_stat["raw_value"] = nulltozero(GET_MOB_ATTRIBUTE_VALUE_RAW(parent, stat_type))
		this_stat["value"] = nulltozero(GET_MOB_ATTRIBUTE_VALUE(parent, stat_type))

		stats += list(this_stat)
	var/list/skill_categories = list()
	for(var/category in GLOB.all_skill_categories)
		var/list/this_category = list()
		var/list/this_category_skills = list()

		this_category["name"] = category
		for(var/skill_type in GLOB.all_skill_categories[category])
			var/datum/attribute/skill/skill = GET_ATTRIBUTE_DATUM(skill_type)

			var/list/this_skill = list()
			this_skill["name"] = skill.name
			this_skill["desc"] = skill.desc
			this_skill["icon"] = sanitize_css_class_name(skill.name)
			this_skill["difficulty"] = skill.difficulty
			this_skill["raw_value"] = nulltozero(GET_MOB_ATTRIBUTE_VALUE_RAW(parent, skill_type))
			this_skill["value"] = nulltozero(GET_MOB_ATTRIBUTE_VALUE(parent, skill_type))

			if(!isnull(this_skill[GET_MOB_ATTRIBUTE_VALUE(parent, skill_type)]) || show_bad_skills)
				this_category_skills += list(this_skill)
		this_category["skills"] = this_category_skills

		if(LAZYLEN(this_category["skills"]))
			skill_categories += list(this_category)

	data["stats"] = stats
	data["skills_by_category"] = skill_categories

	return data

/datum/attribute_holder/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("enable_bad_skills")
			show_bad_skills = TRUE
			return TRUE
		if("disable_bad_skills")
			show_bad_skills = FALSE
			return TRUE
		if("inspect_closely")
			var/old_attribute = closely_inspected_attribute
			var/attribute_name = params["attribute_name"]
			if(attribute_name)
				for(var/attribute_type in GLOB.all_attributes)
					var/datum/attribute/attribute_datum = GET_ATTRIBUTE_DATUM(attribute_type)
					if(attribute_datum.name == attribute_name)
						closely_inspected_attribute = attribute_datum
						break
			else
				closely_inspected_attribute = null
			if(old_attribute != closely_inspected_attribute)
				if(ui)
					ui.close()
				ui_interact(usr)
			return FALSE
