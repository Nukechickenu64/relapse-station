//Turned into a brain
/datum/mood_event/freakofnature
	description = span_warning("Where's is my body?! What did they do to me?!!")
	mood_change = -15
	timeout = 12 MINUTES

//Revived after suicide
/datum/mood_event/letmedie
	description = span_warning("I don't want to live again...")
	mood_change = -12
	timeout = 12 MINUTES

//Got cloned recently
/datum/mood_event/clooned
	description = span_boldwarning("Awake... but at what cost?")
	mood_change = -8
	timeout = 15 MINUTES

//Cringe filter
/datum/mood_event/cringe
	description = span_boldwarning("I tried to say something stupid.")
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/ultracringe
	description = span_boldwarning("I am fucking retarded!")
	mood_change = -8
	timeout = 15 MINUTES

//Pain mood
/datum/mood_event/painbad
	description = span_danger("I am feeling so much pain!")
	mood_change = -5
	timeout = 3 MINUTES

//Saw a badly injured crewmember
/datum/mood_event/saw_injured
	description = span_danger("I have seen terrible things!")
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/saw_injured/lesser
	mood_change = -1
	timeout = 5 MINUTES

//Saw a crewmember die
/datum/mood_event/saw_dead
	description = span_dead("I have seen someone die!")
	mood_change = -5
	timeout = 10 MINUTES

/datum/mood_event/saw_dead/lesser
	mood_change = -2
	timeout = 5 MINUTES

//Died
/datum/mood_event/died
	description = span_dead("<b>I saw the afterlife, and i don't like it!</b>")
	mood_change = -6
	timeout = 10 MINUTES

//Bad smell
/datum/mood_event/miasma
	description = span_warning("I smell something putrid!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/miasma/harsh
	description = span_danger("The rotting stench is unbearable!")
	mood_change = -6

//Ate shit
/datum/mood_event/creampie/shitface
	description = span_infection("My face is covered in shit.")
	mood_change = -2
	timeout = 10 MINUTES

//Gun pointed at us
/datum/mood_event/gunpoint
	description = span_animatedpain("There is a gun pointed at me!")
	mood_change = -4
