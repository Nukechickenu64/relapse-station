/obj/machinery/vending/soder
	name = "\improper Mug Root Beer"
	desc = "Mug Moment."
	icon = 'modular_septic/icons/obj/vending.dmi'
	icon_state = "mug"
	panel_type = "panel2"
	product_slogans = "OOOOOOOOUUUUU... SO REFRESHING..."
	product_ads = "Only a matter of time until the refreshing, delicia taste of Mug Root Beer runs out!; We only have so much!; Top 10 Soda's that haven't publicly used child slavery!"
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/pepsi = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/coca_cola = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/coca_cola/diet = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/mug = 10
	)
	refill_canister = /obj/item/vending_refill/cola
	default_price = PAYCHECK_ASSISTANT * 0.7
	extra_price = PAYCHECK_MEDIUM
	payment_department = ACCOUNT_SRV
