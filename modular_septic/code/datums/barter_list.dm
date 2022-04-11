/datum/bartering_recipe
    var/id = null
    var/output_pathtype = null
    var/list/input = null

/datum/bartering_recipe/ppk
    //PPK
    id = "ppk"
    output_pathtype = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/ppk
    )
    input = list(
        /obj/item/food/canned/beans = 1
    )
