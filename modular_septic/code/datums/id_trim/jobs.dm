/datum/id_trim/job/assistant
	assignment = "Beggar"

/datum/id_trim/job/bartender
	assignment = "Innkeeper"

/datum/id_trim/job/botanist
	assignment = "Seeder"

/datum/id_trim/job/captain
	assignment = "Doge"

/datum/id_trim/job/cargo_technician
	assignment = "Freighter"

/datum/id_trim/job/chemist
	assignment = "Pharmacist"

/datum/id_trim/job/chief_engineer
	assignment = "Foreman"
	extra_access = list(ACCESS_TELEPORTER)
	minimal_access = list(ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CE, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_EVA,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
					ACCESS_MINERAL_STOREROOM, ACCESS_MINISAT, ACCESS_RC_ANNOUNCE, ACCESS_SEC_DOORS, ACCESS_TCOMSAT, ACCESS_TECH_STORAGE,
					ACCESS_MAILSORTING, ACCESS_MECH_MINING, ACCESS_MINERAL_STOREROOM, ACCESS_MINING, ACCESS_MINING_STATION)

/datum/id_trim/job/chief_medical_officer
	assignment = "Hippocrite"

/datum/id_trim/job/clown
	assignment = "Jester"

/datum/id_trim/job/detective
	assignment = "Sheriff"

/datum/id_trim/job/head_of_personnel
	assignment = "Gatekeeper"

/datum/id_trim/job/head_of_security
	assignment = "Coordinator"

/datum/id_trim/job/medical_doctor
	assignment = "Humorist"

/datum/id_trim/job/paramedic
	assignment = "Sanitar"

/datum/id_trim/job/quartermaster
	assignment = "Merchant"

/datum/id_trim/job/research_director
	assignment = "Technocrat"

/datum/id_trim/job/scientist
	assignment = "Technologist"

/datum/id_trim/job/security_officer
	assignment = "Ordinator"

/datum/id_trim/job/security_officer/supply
	assignment = "Ordinator (Cargo)"

/datum/id_trim/job/security_officer/engineering
	assignment = "Ordinator (Engineering)"

/datum/id_trim/job/security_officer/medical
	assignment = "Ordinator (Medical)"

/datum/id_trim/job/security_officer/science
	assignment = "Ordinator (Science)"

/datum/id_trim/job/shaft_miner
	assignment = "Pioneer"
	extra_access = list(ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_AUX_BASE, ACCESS_MAILSORTING, ACCESS_MECH_MINING, ACCESS_MINERAL_STOREROOM, ACCESS_MINING,
					ACCESS_MINING_STATION, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_EXTERNAL_AIRLOCKS,
					ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_MINERAL_STOREROOM, ACCESS_TCOMSAT, ACCESS_TECH_STORAGE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)

/datum/id_trim/job/station_engineer
	assignment = "Mechanist"
