//Default nevado language
/datum/language/common
	name = "Nulatin"
	desc = "A language derived from the unification of portuguese, spanish and other modern-ish latin-derived languages. \
			Used to be the main language of Itobe, until it was officially replaced with Newspeak in 2530."
	default_priority = 100
	icon = 'modular_septic/icons/misc/language.dmi'
	icon_state = "nulatin"
	space_chance = 50

/**
 * As implied by the desc, the syllables are mostly taken from spanish, portuguese and italian
 * I have no fucking idea on how reliable these sources are.
 *
 * https://www.sttmedia.com/syllablefrequency-spanish
 * https://www.sttmedia.com/syllablefrequency-portuguese
 * https://www.sttmedia.com/syllablefrequency-italian
 */
/datum/language/common/syllables = list(
// Two party syllables
"ad", "al", "am", "an", "ar", "as", "ão", "ci", "co", "de", "di", "do", "du", "el", "en", "er", "es", "he", "ia", "ie",
"io", "il", "in", "la", "lo", "le", "ll", "ma", "me", "na", "ne", "no", "nt", "om", "on", "or", "os", "ol", "pa", "pe",
"qu", "ra", "re", "ri", "ro", "sa", "se", "so", "su", "st", "ta", "te", "ti", "to", "tr", "tt", "ue", "um", "un", "ve",
// Three party syllables
"aci", "ada", "ado", "ara", "ale", "att", "ato", "ame", "and", "ant", "ara", "are", "che", "ció", "com", "con", "des",
"dos", "ela", "ele", "ent", "era", "ero", "eri", "est", "ida", "ido", "ito", "ien", "ier", "ión", "inh", "las", "los",
"mas", "men", "não", "ndo", "nha", "nte", "nto", "ocê", "par", "por", "per", "qua", "que", "res", "ria", "sta", "ste",
"ten", "tos", "tra", "uma", "una", "ver", "voc",
)
