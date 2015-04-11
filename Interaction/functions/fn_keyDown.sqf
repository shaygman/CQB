//==================================================================CQB_fnc_keyDown==============================================================================================
//Handle keydown/keyUp EH
// Example: ['keyup',_this] call CQB_fnc_keyDown;
// "keyUp" 		string: "keyUp" or "KeyDown"
//_this 			ctrl varable
//===============================================================================================================================================================================
private ["_keyVarable","_ehType","_ctrl","_dikCode","_shift","_ctrlKey","_alt","_arrayToCheck","_action","_null"];
disableSerialization;

_ehType	 	= _this select 0;
_keyVarable = _this select 1;

_ctrl 		= _keyVarable select 0;
_dikCode 	= _keyVarable select 1;
_shift 		= _keyVarable select 2;
_ctrlKey 	= _keyVarable select 3;
_alt 		= _keyVarable select 4;

_arrayToCheck = str [_shift,_ctrlKey,_alt,_dikCode];

_action = -1;
{
	if (_arrayToCheck == str _x) exitWith {_action = _forEachIndex};
} foreach CQB_keyBinds;

if (tolower _ehType == "keyup") exitWith
{
	/*
	//Vault
	if (missionNameSpace getVariable ["CQB_coverVault",true]) then
	{
		if ((_dikCode in actionKeys "GetOver") && !(player getVariable ["CQB_vaultOver",false]) && (player getVariable ["CQB_wallAhead",""]) != "") exitWith {[] spawn CQB_fnc_vault};
	};

	//Change weapons
	if (missionNameSpace getVariable ["CQB_quickWeaponChange",false]) then
	{
		if (_dikCode in [2,3,4,5,6,7] && _shift) exitWith
		{
			//_null= [_dikCode] execVM "CQB\fnc\actions\fn_weaponSelect.sqf";
			[_dikCode] spawn CQB_fnc_weaponSelect;
		};
	};
	*/

	//keybinds
	switch (_action) do
	{
		case 0 : {CQB_interactionKey_down = false; CQB_interactionKey_up = true; CQB_interactionKey_holding = false};	//Interaction
	};
};

if (tolower _ehType == "keydown") exitWith
{
	//keybinds
	switch (_action) do
	{
		case 0 :
		{
			//Interaction
			CQB_interactionKey_down = true;
			CQB_interactionKey_up = false;

				//_null = [] execVM format["%1CQB\fnc\interaction\fn_interaction.sqf",CQB_path];
				[] spawn CQB_fnc_interaction
		};
	};
};

true;