/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack_objects.dmi'
	amount = 6
	max_amount = 6
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 40
	novariants = FALSE
	var/heal_brute = 0
	var/heal_burn = 0
	var/stop_bleeding = 0
	var/splint_fracture = FALSE
	var/self_delay = 50


/obj/item/stack/medical/attack(mob/living/M, mob/user)

	if(M.stat == 2)
		var/t_him = "it"
		if(M.gender == MALE)
			t_him = "him"
		else if(M.gender == FEMALE)
			t_him = "her"
		to_chat(user, "<span class='danger'>\The [M] is dead, you cannot help [t_him]!</span>")
		return

	if(!iscarbon(M) && !isanimal(M))
		to_chat(user, "<span class='danger'>You don't know how to apply \the [src] to [M]!</span>")
		return 1

	var/obj/item/bodypart/affecting
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		affecting = C.get_bodypart(check_zone(user.zone_selected))
		if(!affecting) //Missing limb?
			to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
			return
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			if(stop_bleeding)
				if(H.bleedsuppress)
					to_chat(user, "<span class='warning'>[H]'s bleeding is already bandaged!</span>")
					return
				else if(!H.bleed_rate)
					to_chat(user, "<span class='warning'>[H] isn't bleeding!</span>")
					return

		if(splint_fracture)
			if(!(affecting.body_part in list(ARM_LEFT, ARM_RIGHT, LEG_LEFT, LEG_RIGHT)))
				to_chat(user, "<span class='warning'>You can't splint that bodypart!</span>")
				return
			else if(!affecting.broken)
				to_chat(user, "<span class='warning'>[M]'s [parse_zone(user.zone_selected)] isn't broken!</span>")
				return
			else if(affecting.splinted)
				to_chat(user, "<span class='warning'>[M]'s [parse_zone(user.zone_selected)] is already splinted!</span>")
				return


	if(isliving(M))
		if(!M.can_inject(user, 1))
			return

	if(user)
		if (M != user)
			if (isanimal(M))
				var/mob/living/simple_animal/critter = M
				if (!(critter.healable))
					to_chat(user, "<span class='notice'> You cannot use [src] on [M]!</span>")
					return
				else if (critter.health == critter.maxHealth)
					to_chat(user, "<span class='notice'> [M] is at full health.</span>")
					return
				else if(src.heal_brute < 1)
					to_chat(user, "<span class='notice'> [src] won't help [M] at all.</span>")
					return
			user.visible_message("<span class='green'>[user] applies [src] on [M].</span>", "<span class='green'>You apply [src] on [M].</span>")
		else
			var/t_himself = "itself"
			if(user.gender == MALE)
				t_himself = "himself"
			else if(user.gender == FEMALE)
				t_himself = "herself"
			user.visible_message("<span class='notice'>[user] starts to apply [src] on [t_himself]...</span>", "<span class='notice'>You begin applying [src] on yourself...</span>")
			if(!do_mob(user, M, self_delay, extra_checks=CALLBACK(M, /mob/living/proc/can_inject,user,1)))
				return
			user.visible_message("<span class='green'>[user] applies [src] on [t_himself].</span>", "<span class='green'>You apply [src] on yourself.</span>")


	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(!affecting) //Missing limb?
			to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
			return
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			if(stop_bleeding)
				if(!H.bleedsuppress) //so you can't stack bleed suppression
					H.suppress_bloodloss(stop_bleeding)
		if(affecting.status == BODYPART_ORGANIC) //Limb must be organic to be healed - RR
			if(affecting.heal_damage(heal_brute, heal_burn))
				C.update_damage_overlays()
			if(splint_fracture)
				affecting.splinted = TRUE
				C.update_inv_splints()
		else
			to_chat(user, "<span class='notice'>[src] won't work on a robotic limb!</span>")
	else
		M.heal_bodypart_damage((src.heal_brute/2), (src.heal_burn/2))

	use(1)



/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = "A theraputic gel pack and bandages designed to treat blunt-force trauma."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	heal_brute = 40
	origin_tech = "biotech=2"
	self_delay = 20

/obj/item/stack/medical/gauze
	name = "medical gauze"
	desc = "A roll of elastic cloth that is extremely effective at stopping bleeding, but does not heal wounds."
	gender = PLURAL
	singular_name = "medical gauze"
	icon_state = "gauze"
	stop_bleeding = 1800
	self_delay = 20
	max_amount = 12

/obj/item/stack/medical/gauze/improvised
	name = "improvised gauze"
	singular_name = "improvised gauze"
	desc = "A roll of cloth roughly cut from something that can stop bleeding, but does not heal wounds."
	stop_bleeding = 900

/obj/item/stack/medical/gauze/cyborg
	materials = list()
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burn wounds."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	heal_burn = 40
	origin_tech = "biotech=2"
	self_delay = 20

/obj/item/stack/medical/splint
	name = "splints"
	desc = "Used to secure limbs following a fracture."
	gender = PLURAL
	singular_name = "splint"
	icon_state = "splint"
	amount = 3
	max_amount = 3
	self_delay = 40
	splint_fracture = TRUE
