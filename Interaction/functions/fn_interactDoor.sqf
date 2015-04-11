//==================================================================CQB_fnc_interactDoor========================================================================================
// Interaction with Door type
// Example: [_object] spawn CQB_fnc_interactMan;
//==============================================================================================================================================================================
private ["_object","_door","_optionalDoors","_suspectCorage","_typeOfSelected","_animation","_phase","_doorTypes","_loadName","_waitTime","_array","_str","_closed","_startPos"];
#define CQB_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define CQB_MIROR ["MineDetector","CQB_videoProbe"]
#define CQB_LOCKPICK ["ToolKit","AGM_DefusalKit","CQB_multiTool"]
#define CQB_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

disableSerialization;
_object 	= _this select 0;

_waitTime = 1;

_doorTypes	= ["door", "hatch"];
_loadName	= "GEOM";

_optionalDoors = [_object, _loadName] intersect [asltoatl (eyepos player),(player modelToworld [0, 3, 0])];

_door = "";
{
	_typeOfSelected = _x select 0;
	{
		if ([_x,_typeOfSelected] call BIS_fnc_inString) exitWith {_door = _typeOfSelected};
	} foreach _doorTypes;

} forEach _optionalDoors;


if (_door == "") exitWith {};

if (tolower worldName in CQB_ARMA2MAPS) then
{
	_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
	_animation = "dvere"+_str;
	//_animation = _door + "_rot";
}
else
{
	_animation = _door + "_rot";
};

_phase = if ((_object animationPhase _animation) > 0) then {0} else {1};

//Check if locked
if (((_object getVariable [format ["bis_disabled_%1",_door],0])==1) && !CQB_interactionKey_holding) exitWith
{
	_object animate [_animation, 0.1];
	sleep 0.1;
	_object animate [_animation, 0];
};

//ArmA2 maps have it all viceversa way to go BI
_closed = if (tolower worldName in CQB_ARMA2MAPS) then
			{
				if (_phase == 0) then {true} else {false};
			}
			else
			{
				if (_phase == 0) then {false} else {true};
			};

//Open dialog
if (CQB_interactionKey_holding && _closed && !dialog) exitWith
{

	_array = [["charge",format ["Place Breaching Charge (%1)",{_x == CQB_CHARGE} count magazines player],getText(configFile >> "CfgMagazines">> CQB_CHARGE >> "picture")],
			  ["check","Check door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
			  ["camera","Mirror under the door","\A3\ui_f\data\map\markers\military\unknown_CA.paa"],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

	//If door is unlocked change the action to lock
	if (_object getVariable [format ["bis_disabled_%1_info",_door],false]) then {
		if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then
		{
			_array set [1, ["lock","Wedge Door","\A3\ui_f\data\map\groupicons\waypoint.paa"]]
		} else {
			_array set [1, ["unlock","Pick Lock","\A3\ui_f\data\map\groupicons\waypoint.paa"]];
		};
	};


	//Check if we have the tools for the job
	if !(CQB_CHARGE in magazines player) then {_array set [0,-1]};
	if (({_x in items player} count CQB_MIROR)==0) then {_array set [2,-1]};
	if (({_x in items player} count CQB_LOCKPICK)==0) then {_array set [1,-1]};
	_array = _array - [-1];

	if (count _array == 1) exitWith {};
	_ok = createDialog "CQB_INTERACTION_MENU";
	waituntil {dialog};

	_ctrl = ((uiNameSpace getVariable "CQB_INTERACTION_MENU") displayCtrl 0);
	_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
	_ctrl ctrlCommit 0;

	_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

	lbClear _ctrl;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _ctrl lbAdd _displayname;
		_ctrl lbSetPicture [_index, _pic];
		_ctrl lbSetData [_index, _class];
	} foreach _array;
	_ctrl lbSetCurSel 0;

	player setVariable ["interactWith",[_object, _door, _phase]];
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn CQB_fnc_DoorMenuClicked"];
	waituntil {!dialog};
	sleep _waitTime;
	player setVariable ["CQB_interactionActive",false];
};

_object animate [_animation, _phase];
sleep _waitTime;
player setVariable ["CQB_interactionActive",false];

