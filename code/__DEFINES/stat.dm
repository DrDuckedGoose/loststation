/*
	Used with the various stat variables (mob, machines)
*/

//mob/var/stat things
#define STATS_CONSCIOUS		0
#define STATS_UNCONSCIOUS	1
#define STATS_DEAD			2

//mob disabilities stat

#define BLIND 		1
#define MUTE		2
#define DEAF		4
#define NEARSIGHT	8
#define FAT			32
#define HUSK		64
#define NOCLONE		128
#define CLUMSY		256
#define DUMB        512
#define MONKEYLIKE  1024 //sets IsAdvancedToolUser to FALSE
#define PACIFISM 	2048

// bitflags for machine stat variable
#define BROKEN		1
#define NOPOWER		2
#define POWEROFF	4		// tbd
#define MAINT		8			// under maintaince
#define EMPED		16		// temporary broken by EMP pulse

//ai power requirement defines
#define POWER_REQ_NONE 0
#define POWER_REQ_ALL 1
#define POWER_REQ_CLOCKCULT 2
