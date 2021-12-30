//Itobe language
/datum/language/newspeak
	name = "Newspeak"
	desc = "An oversimplified, artificial bastardization of latin. \
			Adopted fully by all under control of the Itobe empire since 2600, \
			and considered the standard tongue of humanity."
	key = "1"
	default_priority = 99
	icon = 'modular_septic/icons/misc/language.dmi'
	icon_state = "itobe"
	space_chance = 50

/**
 * As implied by the desc, the language is based on latin.
 * I have no fucking idea on how reliable this source is.
 *
 * https://www.sttmedia.com/syllablefrequency-latin
 */
/datum/language/newspeak/syllables = list(
// two party syllables
"ae", "am", "an", "ar", "at", "ci", "co", "de", "di", "em", "en", "er", "es", "et", "ia", "in", "is",
"it", "iu", "ni", "li", "ne", "ni", "nt", "on", "or", "os", "pe", "qu", "ra", "re", "ri", "ru", "se",
"si", "st", "ta", "te", "ti", "tu", "ue", "ui", "um", "ur", "us",
// three party syllables
"ant", "ati", "atu", "bus", "con", "cum", "ent", "era", "ere", "eri", "est", "iam", "ibu", "ili", "iss",
"ita", "itu", "ium", "ius", "nte", "nti", "oru", "per", "pro", "qua", "que", "qui", "quo", "rat", "rum",
"sse", "tat", "ter", "tis", "tum", "tur", "tus", "unt",
)
