/obj/effect/decal
	name = "decal"
	anchored = TRUE
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = TURF_LAYER

/obj/effect/decal/ex_act(severity, target)
	destroy_effect()

/obj/effect/decal/fire_act(exposed_temperature, exposed_volume)
	if(!(resistance_flags & FIRE_PROOF)) //non fire proof decal or being burned by lava
		destroy_effect()

/obj/effect/decal/HandleTurfChange(turf/T)
	..()
	if(T == loc && (isspaceturf(T) || isclosedturf(T) || islava(T) || istype(T, /turf/open/water) || istype(T, /turf/open/chasm)))
		destroy_effect()

/obj/effect/turf_decal
	var/group = TURF_DECAL_PAINT
	icon = 'icons/turf/decals.dmi'
	icon_state = "warningline"
	anchored = TRUE
	layer = TURF_LAYER

//in case we need some special decals
/obj/effect/turf_decal/proc/get_decal()
	return image(icon='icons/turf/decals.dmi',icon_state=icon_state,dir=dir,layer=TURF_LAYER)

/obj/effect/turf_decal/Initialize()
	..()
	var/turf/T = loc
	if(!istype(T)) //you know this will happen somehow
		CRASH("Turf decal initialized in an object/nullspace")
	T.add_decal(get_decal(),group)
	return INITIALIZE_HINT_QDEL

/obj/effect/turf_decal/stripes/line
	icon_state = "warningline"

/obj/effect/turf_decal/stripes/end
	icon_state = "warn_end"

/obj/effect/turf_decal/stripes/corner
	icon_state = "warninglinecorner"

/obj/effect/turf_decal/stripes/asteroid/line
	icon_state = "ast_warn"

/obj/effect/turf_decal/stripes/asteroid/end
	icon_state = "ast_warn_end"

/obj/effect/turf_decal/stripes/asteroid/corner
	icon_state = "ast_warn_corner"

/obj/effect/turf_decal/delivery
	icon_state = "delivery"

/obj/effect/turf_decal/bot
	icon_state = "bot"

/obj/effect/turf_decal/loading_area
	icon_state = "loading_area"

/obj/effect/turf_decal/sand
	icon_state = "sandyfloor"

/obj/effect/turf_decal/sand/warning
	icon_state = "sandy_warn"

/obj/effect/turf_decal/sand/warning/corner
	icon_state = "sandy_warn_corner"

/obj/effect/turf_decal/sand/plating
	icon_state = "sandyplating"

/obj/effect/turf_decal/sand/plating/warning
	icon_state = "sandy_plating_warn"

/obj/effect/turf_decal/sand/plating/warning/corner
	icon_state = "sandy_plating_warn_corner"

/obj/effect/turf_decal/plaque
	icon_state = "plaque"
