/mob/Login()
	GLOB.player_list |= src
	lastKnownIP	= client.address
	computer_id	= client.computer_id
	log_access("Mob Login: [key_name(src)] was assigned to a [type]")
	world.update_status()
	client.screen = list()				//remove hud items just in case
	client.images = list()

	if(!hud_used)
		create_mob_hud()
	if(hud_used)
		hud_used.show_hud(hud_used.hud_version)

	next_move = 1

	..()

	reset_perspective(loc)

	if(loc)
		loc.on_log(TRUE)

	//readd this mob's HUDs (antag, med, etc)
	reload_huds()

	reload_fullscreen() // Reload any fullscreen overlays this mob has.

	if(ckey in GLOB.deadmins)
		verbs += /client/proc/readmin

	add_click_catcher()

	sync_mind()

//Reload alternate appearances
	for(var/v in GLOB.active_alternate_appearances)
		if(!v)
			continue
		var/datum/atom_hud/alternate_appearance/AA = v
		AA.onNewMob(src)

	client.sethotkeys() //set mob specific hotkeys

	update_client_colour()
	if(client)
		client.click_intercept = null

		client.change_view(world.view) // Resets the client.view in case it was changed.

	if(!GLOB.individual_log_list[ckey])
		GLOB.individual_log_list[ckey] = logging
	else
		logging = GLOB.individual_log_list[ckey]

	player_logged = FALSE
