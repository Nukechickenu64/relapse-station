
//This should should have a default at some point
GLOBAL_LIST_INIT(master_particle_info, list())

/datum/particles_editor
	var/datum/weakref/target

/datum/particles_editor/New(atom/target)
	src.target = WEAKREF(target)

/datum/particles_editor/ui_state(mob/user)
	return GLOB.admin_state

/datum/particles_editor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ParticleEditor")
		ui.open()

/datum/particles_editor/ui_static_data(mob/user)
	var/list/data = list()

	data["particle_info"] = GLOB.master_particle_info

	return data

/datum/particles_editor/ui_data()
	var/list/data = list()

	var/atom/movable/movable_target = target.resolve()
	if(!movable_target)
		return data

	data["target_name"] = movable_target.name
	data["target_particles"] = get_particle_vars()

	return data

/datum/particles_editor/proc/get_particle_vars()
	var/atom/movable/movable_target = target.resolve()
	if(!movable_target)
		return
	return movable_target.particles ? movable_target.particles.vars : null

//expects an assoc list of name, type, value - type must be in this list
/datum/particles_editor/proc/translate_value(list/L)
	//string/float/int come in as the correct type, so just whack em in
	switch(L["type"])
		if("string")
			return L["value"]
		if("float")
			return L["value"]
		if("int")
			return L["value"]
		if("color")
			return L["value"]
		if("list")
			return string_to_list(L["value"])
		if("numList")
			return string_to_list(L["value"],TRUE)
		if("matrix")
			return list_to_matrix(L["value"])
		if("generator")
			return generateGenerator(L["value"]) // This value should be a new list, if it isn't then we will explode

/datum/particles_editor/proc/generateGenerator(list/L)
	/*
	Generator type | Result | Description
	num            | num    | A random number between A and B.
	vector         | vector | A random vector on a line between A and B.
	box            | vector | A random vector within a box whose corners are at A and B.
	color          | color  | (string) or color matrix	Result type depends on whether A or B are matrices or not. The result is interpolated between A and B; components are not randomized separately.
	circle         | vector | A random XY-only vector in a ring between radius A and B, centered at 0,0.
	sphere         | vector | A random vector in a spherical shell between radius A and B, centered at 0,0,0.
	square         | vector | A random XY-only vector between squares of sizes A and B. (The length of the square is between A*2 and B*2, centered at 0,0.)
	cube           | vector | A random vector between cubes of sizes A and B. (The length of the cube is between A*2 and B*2, centered at 0,0,0.)
	*/

	// I write code like this because I hate myself
	var/a = length(string_to_list(L["a"],TRUE)) > 1 ? string_to_list(L["a"],TRUE) : text2num(L["a"])
	var/b = length(string_to_list(L["b"],TRUE)) > 1 ? string_to_list(L["b"],TRUE) : text2num(L["b"])

	switch(L["genType"])
		if("num")
			return generator(L["genType"], a, b)
		if("vector")
			return generator(L["genType"], a, b)
		if("box")
			return generator(L["genType"], a, b)
		if("color") //Color can be string or matrix
			a = length(a) > 1 ? list_to_matrix(a) : a
			b = length(a) > 1 ? list_to_matrix(b) : b
			return generator(L["genType"], a, b)
		if("circle")
			return generator(L["genType"], a, b)
		if("sphere")
			return generator(L["genType"], a, b)
		if("square")
			return generator(L["genType"], a, b)
		if("cube")
			return generator(L["genType"], a, b)
	return null

/datum/particles_editor/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/atom/movable/movable_target = target.resolve()
	if(!movable_target)
		to_chat(usr, "The target atom is gone. Terrible job, supershit.", confidential = TRUE)
		qdel(src)
		return

	switch(action)
		if("add_particles")
			movable_target.add_particles()
		if("remove_particles")
			movable_target.remove_particles()
		if("modify_particles_value")
			movable_target.modify_particles_value(params["new_data"]["name"], translate_value(params["new_data"]))
		if("modify_color_value")
			var/new_color = input(usr, "Pick new particle color", "Particool Colors!") as color|null
			if(new_color)
				movable_target.modify_particles_value("color", new_color)
		if("modify_icon_value")
			var/icon/new_icon = input(usr, "Pick icon", "Icon") as icon|null
			if(new_icon && movable_target.particles)
				movable_target.modify_particles_value("icon", new_icon)
	return TRUE

/datum/particles_editor/proc/list_to_matrix(list/L)
	//Normal Matrixes allow 6
	if(length(L) != 6)
		return matrix()
	return matrix(L[1],L[2],L[3],L[4],L[5],L[6])

/datum/particles_editor/proc/string_to_matrix(str)
	return list_to_matrix(string_to_list(str))

/datum/particles_editor/proc/string_to_list(str, toNum = FALSE)
	. = splittext(str,regex(@"(?<!\\),"))
	if(toNum)
		for(var/i in 1 to length(.))
			.[i] = text2num(.[i])
