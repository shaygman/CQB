//==================================================================CQB_fnc_interaction=========================================================================================
// Interaction perent
//==============================================================================================================================================================================
private ["_targets","_null","_selected","_objects","_dir","_target","_vehiclePlayer","_airports","_counter","_searchArray","_sides",
		 "_positionStart","_positionEnd","_pointIntersect","_break","_interactiveObjects","_objArray","_keyName","_text"];
disableSerialization;
_break = false;

//Do not fire while inside a dialog
if (dialog) exitWith {};
sleep 0.3;
CQB_interactionKey_holding =  if (CQB_interactionKey_down) then {true} else {false};

//Fails safe if ui get stuck
if (time > (player getVariable ["CQB_interactionActiveTime",time-5])+10) then {player setVariable ["CQB_interactionActive",false]};

//If we are busy quit
if ((player getVariable ["CQB_interactionActive",false]) || (time < (player getVariable ["CQB_interactionActiveTime",time-5])+1)) exitWith {};
player setVariable ["CQB_interactionActive",true];
player setVariable ["CQB_interactionActiveTime",time];

//Outside of vehicle
if (vehicle player == player) then
{
	_target = cursorTarget;
	player reveal _target;

	//Handle house
	if (_target isKindof "house" || _target isKindof "wall") exitWith
	{
		//[_target] execvm "Interaction\functions\fn_interactDoor.sqf";
		_null= [_target] call CQB_fnc_interactDoor
	};
};

if !(_break) then
{
	player setVariable ["CQB_interactionActive",false];
};