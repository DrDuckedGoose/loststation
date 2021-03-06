//Speech verbs.
/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	var/regex/whisper_finder = regex("^\\.w\\s+|^\\.w")
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	if(findtext(message, ".w", 1, 3))
		whisper(whisper_finder.Replace(message, ""))
	else
		usr.say(message)


/mob/verb/whisper_verb(message as text)
	set name = "Whisper"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	whisper(message)

/mob/proc/whisper(message, datum/language/language=null)
	say(message, language) //only living mobs actually whisper, everything else just talks

/mob/verb/me_verb(message as text)
	set name = "Me"
	set category = "IC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	usr.emote("me",1,message)

/mob/proc/say_dead(var/message)
	var/name = real_name
	var/alt_name = ""

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	if(jobban_isbanned(src, "OOC"))
		to_chat(src, "<span class='danger'>You have been banned from deadchat.</span>")
		return

	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			to_chat(src, "<span class='danger'>You cannot talk in deadchat (muted).</span>")
			return

		if(src.client.handle_spam_prevention(message,MUTE_DEADCHAT))
			return

	var/mob/dead/observer/O = src
	if(isobserver(src) && O.deadchat_name)
		name = "[O.deadchat_name]"
	else
		if(mind && mind.name)
			name = "[mind.name]"
		else
			name = real_name
		if(name != real_name)
			alt_name = " (died as [real_name])"

	var/K

	if(key)
		K = src.key

	message = src.say_quote(message, get_spans())
	var/rendered = "<span class='game deadsay'><span class='prefix'>STATS_DEAD:</span> <span class='name'>[src.client.prefs.chat_toggles & CHAT_ANONDCHAT ? "" : "([key]) "][name]</span>[alt_name] <span class='message'>[message]</span></span>"

	deadchat_broadcast(rendered, follow_target = src, speaker_key = K)

/mob/proc/emote(var/act)
	return

/mob/proc/hivecheck()
	return 0

/mob/proc/lingcheck()
	return 0
