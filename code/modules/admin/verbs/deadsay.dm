/client/proc/dsay(msg as text)
	set category = "Special Verbs"
	set name = "Dsay" //Gave this shit a shorter name so you only have to time out "dsay" rather than "dead say" to use it --NeoFite
	set hidden = 1
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.")
		return
	if(!src.mob)
		return
	if(prefs.muted & MUTE_DEADCHAT)
		to_chat(src, "<span class='danger'>You cannot send DSAY messages (muted).</span>")
		return

	if (src.handle_spam_prevention(msg,MUTE_DEADCHAT))
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	log_talk(mob,"[key_name(src)] : [msg]",LOGDSAY)

	if (!msg)
		return
	var/static/nicknames = world.file2list("config/admin_nicknames.txt")

	var/rendered = "<span class='game deadsay'><span class='prefix'>STATS_DEAD:</span> <span class='name'>ADMIN([src.holder.fakekey ? pick(nicknames) : src.key])</span> says, <span class='message'>\"[msg]\"</span></span>"

	for (var/mob/M in GLOB.player_list)
		if(isnewplayer(M))
			continue
		if (M.stat == STATS_DEAD || (M.client && M.client.holder && (M.client.prefs.chat_toggles & CHAT_DEAD))) //admins can toggle deadchat on and off. This is a proc in admin.dm and is only give to Administrators and above
			to_chat(M, rendered)

	SSblackbox.add_details("admin_verb","Dsay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
