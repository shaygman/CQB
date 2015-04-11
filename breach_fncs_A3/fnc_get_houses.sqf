private ["_unit","_houses","_objects","_class","_cfg","_uaCfg","_house","_doorPositions","_doorNumbers","_name","_sel","_firstLetter","_dPos","_memPoint","_rad"];

_unit = _this select 0;
_rad = _this select 1;

_objects = nearestObjects [_unit,["House"],_rad];

_houses = [];

{
	_house = _x;
	_class = typeOf _house;
	_cfg = configFile >> "CfgVehicles" >> _class;
	_uaCfg = _cfg >> "userActions";
	
	if (!(isnil("_uaCfg"))) then 
	{
		if ((count _uaCfg) > 0) then
		{
			_houses set [(count _houses),_house];
		};
	};
}foreach _objects;


{
	_house  = _x;

	_doorNumbers = _house getVariable ["doorNumbers",nil];

	if (isNil ("_doorNumbers")) then
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
		/*
		{
		_ball1 = "Sign_Sphere25cm_F" createVehicle [0,0,0];
		_ball1 setPosASL _x;
		}foreach _doorPositions;
		*/
	};

}foreach _houses;

_houses