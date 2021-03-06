#define DEBUG					//Enables byond profiling and full runtime logs - note, this may also be defined in your .dme file
								//Enables in-depth debug messages to runtime log (used for debugging)
//#define TESTING				//By using the testing("message") proc you can create debug-feedback for people with this
								//uncommented, but not visible in the release version)

#ifdef TESTING
//#define GC_FAILURE_HARD_LOOKUP	//makes paths that fail to GC call find_references before del'ing.
									//Also allows for recursive reference searching of datums.
									//Sets world.loop_checks to false and prevents find references from sleeping

//#define VISUALIZE_ACTIVE_TURFS	//Highlights atmos active turfs in green
#endif

#define PRELOAD_RSC	1			/*set to:
								0 to allow using external resources or on-demand behaviour;
								1 to use the default behaviour;
								2 for preloading absolutely everything;
								*/

#define BACKGROUND_ENABLED FALSE    // The default value for all uses of set background. Set background can cause gradual lag and is recommended you only turn this on if necessary.
								// 1 will enable set background. 0 will disable set background.

//Update this whenever you need to take advantage of more recent byond features
#define MIN_COMPILER_VERSION 511
#if DM_VERSION < MIN_COMPILER_VERSION
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to byond.com/download and update.
#error You need version 511 or higher
#endif

//Additional code for the above flags.
#ifdef TESTING
#warn compiling in TESTING mode. testing() debug messages will be visible.
#endif

#ifdef TRAVISTESTING
#define TESTING
#endif
