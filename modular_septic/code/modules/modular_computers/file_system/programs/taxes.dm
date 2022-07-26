/datum/computer_file/program/taxes
	filename = "taxman"
	filedesc = "TaxMan Economy Management"
	extended_desc = "Program for viewing and changing salaries and taxes."
	category = PROGRAM_CATEGORY_CREW
	program_icon_state = "id"
	transfer_access = ACCESS_HEADS
	requires_ntnet = TRUE
	size = 4
	tgui_id = "NtosTaxManager"
	program_icon = "coins"

/datum/computer_file/program/taxes/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

/datum/computer_file/program/taxes/ui_static_data(mob/user)
	var/list/data = list()

	var/list/accounts = list()
	for(var/datum/bank_account/account as anything in SSeconomy.generated_accounts)
		if(account.taxman_hidden || !account.account_holder)
			continue
		var/list/this_account = list()

		this_account["holder"] = account.account_holder
		this_account["salary"] = account.salary

		accounts += list(this_account)
	data["accounts"] = accounts
	var/list/taxes = list()
	for(var/tax_name in SSeconomy.taxation_is_theft)
		var/list/this_tax = list()

		this_tax["name"] = tax_name
		this_tax["value"] = SSeconomy.taxation_is_theft[tax_name]

		taxes += list(this_tax)
	data["taxes"] = taxes

	return data
