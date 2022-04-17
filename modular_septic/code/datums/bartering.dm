/datum/bartering_recipe
    var/id = null
    var/list/output_pathtype = null
    var/list/input = null

/datum/bartering_recipe/ppk
    //PPK
    id = "ppk"
    output_pathtype = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/ppk = 1
    )
    input = list(
        /obj/item/food/canned/beans = 1
    )

/datum/bartering_recipe/bastardo
    //PPK
    id = "bastard"
    output_pathtype = list(
        /obj/item/gun/ballistic/automatic/remis/smg/bastardo = 1
    )
    input = list(
        /obj/item/food/canned/beef = 2
    )
