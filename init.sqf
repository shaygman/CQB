enableSaving [false, false];

if (!isDedicated) then
{
	0 spawn {
		private ["_keyDown","_null"];
		waituntil {!(IsNull (findDisplay 46))};
		CQB_keyBinds = profileNamespace getVariable ["CQB_keyBinds", [[false,false,false,219]]];

		//Prevent error messages for backward comp
		if (count CQB_keyBinds < 1) then
		{
			profileNamespace setVariable ["CQB_keyBinds",[[false,false,false,219]]];
			CQB_keyBinds = profileNamespace getVariable ["CQB_keyBinds",[[false,false,false,219]]];
		};

		//Handle Key
		_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "_null = ['keydown',_this] call CQB_fnc_keyDown"];
		_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyUp", "_null = ['keyup',_this] call CQB_fnc_keyDown"];
	};
};

finishMissionInit;