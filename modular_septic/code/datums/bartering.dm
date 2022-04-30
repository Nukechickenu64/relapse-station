/datum/bartering_recipe
    var/list/outputs = null
    var/list/inputs = null

/datum/bartering_recipe/ppk
    outputs = list(
        /obj/item/gun/ballistic/automatic/pistol/remis/ppk = 1
    )
    inputs = list(
        /obj/item/food/canned/beans = 1
    )

/datum/bartering_recipe/bastardo
    outputs = list(
        /obj/item/gun/ballistic/automatic/remis/smg/bastardo = 1
    )
    inputs = list(
        /obj/item/food/canned/beef = 2
    )
