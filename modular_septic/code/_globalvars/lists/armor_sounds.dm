GLOBAL_LIST_INIT(armor_sounds_damage, \
	list( \
		"heavy" = list( \
			CRUSHING = list('modular_septic/sound/armor/blunt_heavy1.ogg', 'modular_septic/sound/armor/blunt_heavy2.ogg', 'modular_septic/sound/armor/blunt_heavy3.ogg'), \
			PIERCING = list('modular_septic/sound/bullet/ricochet1.wav', 'modular_septic/sound/bullet/ricochet2.wav'), \
			CUTTING = list('modular_septic/sound/armor/stab_heavy1.ogg', 'modular_septic/sound/armor/stab_heavy2.ogg', 'modular_septic/sound/armor/stab_heavy1.ogg'), \
			IMPALING = list('modular_septic/sound/armor/chop_heavy1.ogg', 'modular_septic/sound/armor/chop_heavy2.ogg', 'modular_septic/sound/armor/chop_heavy1.ogg'), \
			), \
		"light" = list( \
			CRUSHING = list('modular_septic/sound/armor/soft1.ogg', 'modular_septic/sound/armor/soft2.ogg', 'modular_septic/sound/armor/soft3.ogg'), \
			PIERCING = 'modular_septic/sound/bullet/bullet_light.ogg', \
			CUTTING = list('modular_septic/sound/armor/soft1.ogg', 'modular_septic/sound/armor/soft2.ogg', 'modular_septic/sound/armor/soft3.ogg'), \
			IMPALING = list('modular_septic/sound/armor/soft1.ogg', 'modular_septic/sound/armor/soft2.ogg', 'modular_septic/sound/armor/soft3.ogg'), \
			), \
		), \
	)
GLOBAL_LIST_INIT(armor_sounds_damage_local, list())
GLOBAL_LIST_INIT(armor_sounds_break, \
	list( \
		"heavy" = 'modular_septic/sound/armor/break_heavy1.wav', \
		"light" = 'modular_septic/sound/armor/break_light1.ogg', \
		), \
	)
GLOBAL_LIST_INIT(armor_sounds_break, list())
