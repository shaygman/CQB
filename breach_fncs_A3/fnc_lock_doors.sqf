private ["_class","_cfg","_uaCfg","_house","_doorPositions","_doorNumbers","_name","_sel","_firstLetter","_dPos","_memPoint"];

_house = _this select 0;
_percentage = _this select 1;

_doorNumbers = _house getVariable ["doorNumbers",[]];

if !((count _doorNumbers) > 0) then
{
	
	_class = typeOf _house;
	_cfg = configFile >> "CfgVehicles" >> _class;
	_uaCfg = _cfg >> "userActions";

	_doorNumbers = [];
	_doorPositions = [];

	for "_i" from 0 to ((count _uaCfg) - 1) do
	{
		_sel = _uaCfg select _i;
		_name = configName _sel;
		_firstLetter = (toArray _name) select 0;
			if ((_firstLetter == 67) or ((_firstLetter == 99))) then
		{
			_memPoint = getText (_sel >> "position");
			_dPos = _house selectionPosition _memPoint;
			_doorNumbers set [(count _doorNumbers),((count _doorNumbers) + 1)];
			_doorPositions set [(count _doorPositions),ATLtoASL(_house modelToWorld _dPos)];
		};
	};
		
	_house setVariable ["doorNumbers",_doorNumbers];
	_house setVariable ["doorPositions",_doorPositions];
};

// work out number of doors to be locked
_numberOfDoors = (count _doorNumbers);
_numberToBeLocked = round ((_numberofDoors / 100) * _percentage);
if (_numberToBeLocked <= 0) exitWith {};

// Main function.
for "_i" from 0 to (_numberToBeLocked - 1) do
{
	_doorNum = _doorNumbers select (round (random ((count _doorNumbers) - 1)));
	_lockVar = format ["bis_disabled_Door_%1",_doorNum];
	_house setVariable [_lockVar,1,true];
	_doorNumbers = _doorNumbers - [_doorNum];
};
