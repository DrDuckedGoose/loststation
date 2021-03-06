//These mutations change your overall "form" somehow, like size

//Epilepsy gives a very small chance to have a seizure every life tick, knocking you unconscious.

/datum/mutation/human/epilepsy

	name = "Epilepsy"
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>You get a headache.</span>"

/datum/mutation/human/epilepsy/on_life(mob/living/carbon/human/owner)
	if(prob(1) && owner.stat == STATS_CONSCIOUS)
		owner.visible_message("<span class='danger'>[owner] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
		owner.Unconscious(200)
		owner.Jitter(1000)
		addtimer(CALLBACK(src, .proc/jitter_less, owner), 90)

/datum/mutation/human/epilepsy/proc/jitter_less(mob/living/carbon/human/owner)
	if(owner)
		owner.jitteriness = 10

/datum/mutation/human/bad_dna
	name = "Unstable DNA"
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>You feel strange.</span>"

/datum/mutation/human/bad_dna/on_acquiring(mob/living/carbon/human/owner)
	to_chat(owner, text_gain_indication)
	var/mob/new_mob
	if(prob(95))
		if(prob(50))
			new_mob = owner.randmutb()
		else
			new_mob = owner.randmuti()
	else
		new_mob = owner.randmutg()
	if(new_mob && ismob(new_mob))
		owner = new_mob
	. = owner
	on_losing(owner)

/datum/mutation/human/cough
	name = "Cough"
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='danger'>You start coughing.</span>"

/datum/mutation/human/cough/on_life(mob/living/carbon/human/owner)
	if(prob(5) && owner.stat == STATS_CONSCIOUS)
		owner.drop_item()
		owner.emote("cough")

/datum/mutation/human/dwarfism
	name = "Dwarfism"
	quality = POSITIVE
	get_chance = 15
	lowest_value = 256 * 12

/datum/mutation/human/dwarfism/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.resize = 0.8
	owner.update_transform()
	owner.pass_flags |= PASSTABLE
	owner.visible_message("<span class='danger'>[owner] suddenly shrinks!</span>", "<span class='notice'>Everything around you seems to grow..</span>")

/datum/mutation/human/dwarfism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.resize = 1.25
	owner.update_transform()
	owner.pass_flags &= ~PASSTABLE
	owner.visible_message("<span class='danger'>[owner] suddenly grows!</span>", "<span class='notice'>Everything around you seems to shrink..</span>")

/datum/mutation/human/clumsy

	name = "Clumsiness"
	quality = MINOR_NEGATIVE
	text_gain_indication = "<span class='danger'>You feel lightheaded.</span>"

/datum/mutation/human/clumsy/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.disabilities |= CLUMSY

/datum/mutation/human/clumsy/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.disabilities &= ~CLUMSY
	to_chat(owner, "<span class='danger'>You no longer feel funny.</span>")

/datum/mutation/human/tourettes
	name = "Tourettes Syndrome"
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>You twitch.</span>"

/datum/mutation/human/tourettes/on_life(mob/living/carbon/human/owner)
	if(prob(5) && owner.stat == STATS_CONSCIOUS)
		owner.Stun(125)
		switch(rand(1, 3))
			if(1)
				owner.emote("twitch")
			if(2 to 3)
				owner.say("[prob(50) ? ";" : ""][pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER", "TITS")]")
		var/x_offset_old = owner.pixel_x
		var/y_offset_old = owner.pixel_y
		var/x_offset = owner.pixel_x + rand(-2,2)
		var/y_offset = owner.pixel_y + rand(-1,1)
		animate(owner, pixel_x = x_offset, pixel_y = y_offset, time = 1)
		animate(owner, pixel_x = x_offset_old, pixel_y = y_offset_old, time = 1)

/datum/mutation/human/deaf
	name = "Deafness"
	quality = NEGATIVE
	text_gain_indication = "<span class='danger'>You can't seem to hear anything.</span>"

/datum/mutation/human/deaf/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.disabilities |= DEAF

/datum/mutation/human/deaf/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.disabilities &= ~DEAF

/datum/mutation/human/race
	name = "Monkified"
	quality = NEGATIVE
	time_coeff = 2

/datum/mutation/human/race/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	. = owner.monkeyize(TR_KEEPITEMS | TR_KEEPIMPLANTS | TR_KEEPORGANS | TR_KEEPDAMAGE | TR_KEEPVIRUS | TR_KEEPSE)

/datum/mutation/human/race/on_losing(mob/living/carbon/monkey/owner)
	if(owner && istype(owner) && owner.stat != STATS_DEAD && (owner.dna.mutations.Remove(src)))
		. = owner.humanize(TR_KEEPITEMS | TR_KEEPIMPLANTS | TR_KEEPORGANS | TR_KEEPDAMAGE | TR_KEEPVIRUS | TR_KEEPSE)
