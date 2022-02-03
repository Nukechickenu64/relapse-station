/area/service/janitor
	name = "\improper Public Custodial Area"

/area/hallway/entrance
	name = "\improper Outpost Entrance"
	icon_state = "hallA"

/area/hallway/train_station
	name = "\improper Train Station"
	icon_state = "hallF"
	droning_sound = DRONING_TRAIN

/area/hallway/train_station/janitorial_supplies
	name = "\improper Train Station Janitorial Supplies"

/area/hallway/train_station/emergency_supplies
	name = "\improper Train Station Emergency Supplies"

/area/hallway/train_station/arrival
	name = "\improper Arrival Station"
	icon_state = "hallF"

/area/hallway/train_station/path
	name = "\improper Train Path"
	icon_state = "hallP"

/area/hallway/streets
	name = "\improper Streets"
	icon_state = "hallS"
	droning_sound = DRONING_BALUARTE

/area/commons/dorms/lower
	name = "Lower Dormitories"

/area/commons/dorms/upper
	name = "Upper dormitories"

/area/maintenance/lift
	name = "\proper Central Lift"
	icon_state = "maintcentral"
	droning_sound = DRONING_LIFT

/area/maintenance/pitofdespair
	name = "\proper PIT OF DESPAIR"
	icon_state = "showroom"
	droning_sound = DRONING_PITOFDESPAIR

/area/maintenance/liminal/intro
	name = "Liminal Introduction"
	icon_state = "introduction"
	icon = 'modular_septic/icons/turf/areas.dmi'
	droning_sound = DRONING_LIMINALINTRO

/area/maintenance/liminal
	name = "Liminal Space"
	icon_state = "liminal"
	icon = 'modular_septic/icons/turf/areas.dmi'
	droning_sound = DRONING_LIMINAL
	requires_power = FALSE

/area/maintenance/liminal/red
	name = "Liminal Red"
	icon_state = "red"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/purple
	name = "Liminal Purple"
	icon_state = "purple"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/green
	name = "Liminal Green"
	icon_state = "green"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/darkgreen
	name = "Liminal Dark Green"
	icon_state = "darkgreen"
	droning_sound = DRONING_DARKLIMINAL

/area/maintenance/liminal/hallways
	name = "Liminal Hallways"
	icon_state = "engine"
	droning_sound = DRONING_LIMINALHALL
	mood_bonus = -10

/area/maintenance/liminal/deep
	name = "Liminal Deep"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALDEEP
	mood_bonus = -5

/area/engineering/greed
	name = "\improper Greed Engine"
	icon_state = "engine_sm"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/engineering/caving_equipment
	name = "Caving Equipment"
	icon_state = "engine"
