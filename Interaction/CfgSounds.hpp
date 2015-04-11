class noSound
{
	name = "noSound";
	sound[] = {"", 0, 1};
	titles[] = {};
};

class nvSound
{
	name = "nvSound";
	titles[] = {};

	#ifdef MCCMODE
	sound[] = {"\CQB_mod\Interaction\sounds\nvSound.ogg", 1, 1};
	#else
	sound[] = {"Interaction\sounds\nvSound.ogg", 1, 1};
	#endif
};

class CQB_zoom
{
	name = "CQB_zoom";
	titles[] = {};

	#ifdef MCCMODE
	sound[] = {"\CQB_mod\Interaction\sounds\zoom.ogg", 1, 1};
	#else
	sound[] = {"Interaction\sounds\zoom.ogg", 1, 1};
	#endif
};
