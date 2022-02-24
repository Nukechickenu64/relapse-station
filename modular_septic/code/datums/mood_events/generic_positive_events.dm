//Sounding rod
/datum/mood_event/sounding_ua
	description = span_nicegreen("UUUUUUUUUUUUUUUA")
	mood_change = 6
	timeout = 10 SECONDS

/datum/mood_event/sounding_au
	description = span_nicegreen("AUUUUUUUUUUUUUUU")
	mood_change = 6
	timeout = 10 SECONDS

//Devious licked
/datum/mood_event/devious_lick
	description = span_achievementgood("I am going to be TikTok famous!")
	mood_change = 6
	timeout = 5 MINUTES

//I LOVE LEAAAANNNNNN!!!
/datum/mood_event/lean
	description = span_purple("I love lean...")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/lean/add_effects()
	var/message = pick("WHASUP NIGGA!", "Fortnite 2 has been announced by epic mega games!", "Nutsack")
	description = span_purple(message)

//Buried/cremated someone
/datum/mood_event/proper_burial
	description = span_nicegreen("Not everyone can be saved. At least they have been put to rest.")
	mood_change = 2
	timeout = 15 MINUTES

//Masochist mood
/datum/mood_event/paingood
	description = span_nicegreen("Pain cleanses the mind and the soul.")
	mood_change = 4
	timeout = 2 MINUTES

//Antag mood nerf
/datum/mood_event/focused
	description = span_nicegreen("I have a goal, and I will reach it, whatever it takes!")
	mood_change = 2
	hidden = TRUE

//Cum on face
/datum/mood_event/creampie/bukkake
	description = span_nicegreen("My face is <b>drenched</b> in cum!")
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/creampie/cummies
	description = span_nicegreen("My face is covered in cum.")
	mood_change = 2
	timeout = 3 MINUTES

//Femcum on face
/datum/mood_event/creampie/fembukkake
	description = span_nicegreen("My face is <b>drenched</b> in squirt!")
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/creampie/femcummies
	description = span_nicegreen("My face is covered in squirt.")
	mood_change = 2
	timeout = 3 MINUTES

