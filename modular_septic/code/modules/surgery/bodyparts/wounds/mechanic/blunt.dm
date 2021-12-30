/// Joint Dislocation (Moderate Blunt)
/datum/wound/blunt/moderate/mechanic
	name = "Joint Desynchronization"
	desc = "Parts of the patient's actuators have forcefully disconnected from each other, causing delayed and inefficient limb movement."
	treat_text = "Recommended wrenching of the affected limb, though manual synchronization by applying an aggressive grab to the patient and helpfully interacting with afflicted limb may suffice.  Use of synthetic healing chemicals may also help."
	examine_desc = "has visibly disconnected rotors"
	occur_text = "snaps and becomes unseated"
	descriptive = "A joint is snapped!"

	required_status = BODYPART_ROBOTIC
	treatable_tool = TOOL_WRENCH
	scar_keyword = null

/*
	Severe (Hairline Fracture)
*/
/datum/wound/blunt/severe/mechanic
	name = "Malfunctioning Actuators"
	desc = "Patient's actuators are malfunctioning, causing reduced limb functionality and performance."
	treat_text = "Recommended wrenching and taping of the affected limb. Use of synthetic healing chemicals may also help."
	examine_desc = "has loose and disconnected bits of metal"
	occur_text = "loudly hums as some loose nuts and bolts fall out"
	descriptive = "The exoskeleton is fractured!"

	required_status = BODYPART_ROBOTIC
	treatable_tool = TOOL_WRENCH
	scar_keyword = null

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/critical/mechanic
	name = "Broken Actuators"
	desc = "Patient's actuators have suffered severe dents and component losses, causing a severe decrease in limb functionality and performance."
	treat_text = "Recommended complete internal component repair and replacement, but wrenching and taping of the limb might suffice. Use of synthetic healing chemicals may also help."
	examine_desc = "is damaged at several spots, with protuding bits of metal"
	occur_text = "loudly hums as it's rotors scrapes away bits of metal"
	descriptive = "The exoskeleton is shattered!"

	required_status = BODYPART_ROBOTIC
	treatable_tool = TOOL_WRENCH
	scar_keyword = null
