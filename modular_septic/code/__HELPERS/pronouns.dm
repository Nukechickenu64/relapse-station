/datum/proc/p_themselves(capitalized, temp_gender)
	. = "itself"
	if(capitalized)
		. = capitalize(.)

/datum/p_their(capitalized, temp_gender)
	. = "it's"
	if(capitalized)
		. = capitalize(.)

/mob/p_themselves(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "itself"
	switch(temp_gender)
		if(FEMALE)
			. = "herself"
		if(MALE)
			. = "himself"
		if(PLURAL)
			. = "themselves"
	if(capitalized)
		. = capitalize(.)
