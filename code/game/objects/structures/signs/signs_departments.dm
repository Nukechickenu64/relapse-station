//departmental signs


///////MEDBAY

/obj/structure/sign/departments/medbay
	name = "\improper Medbay sign"
	sign_change_name = "Department - Medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "bluecross"
	is_editable = TRUE

/obj/structure/sign/departments/medbay/alt
	name = "\improper Medbay sign"
	sign_change_name = "Department - Medbay Alt"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "department_med"
	is_editable = TRUE

/obj/structure/sign/departments/examroom
	name = "\improper Exam Room sign"
	sign_change_name = "Department - Medbay: Exam Room"
	desc = "A guidance sign which reads 'Exam Room'."
	icon_state = "department_chem"
	is_editable = TRUE

/obj/structure/sign/departments/chemistry
	name = "\improper Chemistry sign"
	sign_change_name = "Department - Medbay: Chemistry"
	desc = "A sign labelling an area containing chemical equipment."
	icon_state = "department_chem"
	is_editable = TRUE

/obj/structure/sign/departments/chemistry/pharmacy
	name = "\improper Pharmacy sign"
	sign_change_name = "Department - Medbay: Pharmacy"
	desc = "A sign labelling an area containing pharmacy equipment."
	icon_state = "department_chem"
	is_editable = TRUE

/obj/structure/sign/departments/psychology
	name = "\improper Psychology sign"
	sign_change_name = "Department - Medbay: Psychology"
	desc = "A sign labelling where the Psychologist works, they can probably help you get your head straight."
	icon_state = "department_psych"
	is_editable = TRUE

///////ENGINEERING

/obj/structure/sign/departments/engineering
	name = "\improper Engineering sign"
	sign_change_name = "Department - Engineering"
	desc = "A sign labelling an area where engineers work."
	icon_state = "department_engi"
	is_editable = TRUE

///////SCIENCE

/obj/structure/sign/departments/science
	name = "\improper Science sign"
	sign_change_name = "Department - Science"
	desc = "A sign labelling an area where research and science is performed."
	icon_state = "department_sci"
	is_editable = TRUE

/obj/structure/sign/departments/science/alt
	name = "\improper Science sign"
	sign_change_name = "Department - Science Alt"
	desc = "A sign labelling an area where research and science is performed."
	icon_state = "department_sci"
	is_editable = TRUE

/obj/structure/sign/departments/xenobio
	name = "\improper Xenobiology sign"
	sign_change_name = "Department - Science: Xenobiology"
	desc = "A sign labelling an area as a place where xenobiological entities are researched."
	icon_state = "department_xeno"
	is_editable = TRUE

///////SERVICE

/obj/structure/sign/departments/botany
	name = "\improper Botany sign"
	sign_change_name = "Department - Botany"
	desc = "A sign labelling an area as a place where plants are grown."
	icon_state = "department_hydro"
	is_editable = TRUE

/obj/structure/sign/departments/custodian
	name = "\improper Janitor sign"
	sign_change_name = "Department - Janitor"
	desc = "A sign labelling an area where the janitor works."
	icon_state = "custodian"
	is_editable = TRUE

/obj/structure/sign/departments/holy
	name = "\improper Chapel sign"
	sign_change_name = "Department - Chapel"
	desc = "A sign labelling a religious area."
	icon_state = "department_chapel"
	is_editable = TRUE

/obj/structure/sign/departments/lawyer
	name = "\improper Legal Department sign"
	sign_change_name = "Department - Legal"
	desc = "A sign labelling an area where the Lawyers work, apply here for arrivals shuttle whiplash settlement."
	icon_state = "department_lawyer"
	is_editable = TRUE

///////SUPPLY

/obj/structure/sign/departments/cargo
	name = "\improper Cargo sign"
	sign_change_name = "Department - Cargo"
	desc = "A sign labelling an area where cargo ships dock."
	icon_state = "department_cargo"
	is_editable = TRUE

///////SECURITY

/obj/structure/sign/departments/security
	name = "\improper Security sign"
	sign_change_name = "Department - Security"
	desc = "A sign labelling an area where the law is law."
	icon_state = "department_sec"
	is_editable = TRUE

////MISC LOCATIONS

/obj/structure/sign/departments/restroom
	name = "\improper Restroom sign"
	sign_change_name = "Location - Restroom"
	desc = "A sign labelling a restroom."
	icon_state = "department_wc"
	is_editable = TRUE

/obj/structure/sign/departments/mait
	name = "\improper Maintenance Tunnel sign"
	sign_change_name = "Location - Maintenance"
	desc = "A sign labelling an area where the departments of the station are linked together."
	icon_state = "mait1"
	is_editable = TRUE

/obj/structure/sign/departments/mait/alt
	name = "\improper Maintenance Tunnel sign"
	sign_change_name = "Location - Maintenance Alt"
	desc = "A sign labelling an area where the departments of the station are linked together."
	icon_state = "mait2"
	is_editable = TRUE

/obj/structure/sign/departments/evac
	name = "\improper Evacuation sign"
	sign_change_name = "Location - Evacuation"
	desc = "A sign labelling an area where evacuation procedures take place."
	icon_state = "department_evac"
	is_editable = TRUE
	///This var detemines which arrow overlay to use.
	var/arrow_direction_state = "evac_overlay_n"

/obj/structure/sign/departments/evac/Initialize(mapload)
	. = ..()
	add_overlay(arrow_direction_state)

/obj/structure/sign/departments/evac/north

/obj/structure/sign/departments/evac/south
	arrow_direction_state = "evac_overlay_s"

/obj/structure/sign/departments/evac/east
	arrow_direction_state = "evac_overlay_e"

/obj/structure/sign/departments/evac/west
	arrow_direction_state = "evac_overlay_w"

/obj/structure/sign/departments/drop
	name = "\improper Drop Pods sign"
	sign_change_name = "Location - Drop Pods"
	desc = "A sign labelling an area where drop pod loading procedures take place."
	icon_state = "drop"
	is_editable = TRUE

/obj/structure/sign/departments/court
	name = "\improper Courtroom sign"
	sign_change_name = "Location - Courtroom"
	desc = "A sign labelling the courtroom, where the ever sacred Space Law is upheld."
	icon_state = "department_law"
	is_editable = TRUE
