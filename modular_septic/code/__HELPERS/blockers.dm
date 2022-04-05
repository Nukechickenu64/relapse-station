/proc/init_frill_blockers()
	var/list/blockers = list()
	for(var/type in subtypesof(/atom/movable/blocker))
		var/atom/movable/frill_blocker/frill_blocker = new type()
		blockers[frill_blocker.type] = frill_blocker
	return blockers
