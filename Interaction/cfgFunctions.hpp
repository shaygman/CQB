class CQB
{
	tag = "CQB";

	class Interaction
	{
		#ifdef CQBMODE
		file = "\CQB_mod\Interaction\functions";
		class pre_init
		{
			preInit = 1;
			description = "Pre init mod only";
		};
		#else
		file = "Interaction\functions";
		#endif

		class keyDown {description = "Handles key pressed";};
		class interaction {};
		class interactDoor {};
		class DoorMenuClicked {};
		class DOOR_CAM_Handler {};
		class interactProgress {};
	};

	class general
	{
		#ifdef CQBMODE
		file = "\CQB_mod\general\functions";
		class pre_init
		{
			preInit = 1;
			description = "Pre init mod only";
		};
		#else
		file = "general\functions";
		#endif
	};
};