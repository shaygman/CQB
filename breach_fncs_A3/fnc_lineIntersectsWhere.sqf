private ["_obj1","_obj2","_pos1","_pos2","_dist","_ignore1","_ignore2","_vX","_vY","_vZ","_obstructedPos","_obstructed","_array","_angle"];
_obj1 = _this select 0;
_obj2 = _this select 1;
_pos1 = if ((typename _obj1) == "Array") then {_obj1} else {getposASL _obj1};
_pos2 = if ((typename _obj2) == "Array") then {_obj2} else {getposASL _obj2};
_dist = _pos1 distance _pos2;
_ignore1 = _this select 2;
_ignore2 = _this select 3;
{
	if (isNil ("_x")) then
	{
		_x = objNull;
	};
}foreach [_ignore1,_ignore2];



_vX = ((_pos2 select 0) - (_pos1 select 0))/_dist;
_vY = ((_pos2 select 1) - (_pos1 select 1))/_dist;
_vZ = ((_pos2 select 2) - (_pos1 select 2))/_dist;

_obstructedPos = [0,0,0];

if (isnil("fnc_intersects")) then {
fnc_intersects = compile "
	private ['_pos1','_pos2','_obstructed','_checkdist'];

	_pos1 = _this select 0;
	_checkdist = _this select 1;

	_pos2 = if ((_angle) >=  180) then {

		[(_pos1 select 0) + (_vX * _checkdist),(_pos1 select 1) + (_vY * _checkdist),(_pos1 select 2) + (_vZ * _checkdist)]

	} else {

		[(_pos1 select 0) + (_vX * _checkdist),(_pos1 select 1) + (_vY * _checkdist),(_pos1 select 2) + (_vZ * _checkdist)]

	};
	
	_obstructed = lineintersects [_pos1,_pos2,_ignore1,_ignore2];
	
	[_obstructed,_pos2]";

};


_angle = [_pos1,_pos2] call fnc_get_angle;






_obstructed = lineIntersects [_pos1,_pos2,_ignore1,_ignore2];

if (!_obstructed) exitWith
{
	[_obstructed,_obstructedPos]
};

_array = [_pos1,0.01] call fnc_intersects;
_obstructed = _array select 0;
if (_obstructed) exitwith
{
	_obstructedPos = _array select 1;
	[_obstructed,_obstructedPos]
};

_array = [];
while {_obstructed} do
{
	_dist = _dist - 1;
	_array = [_pos1,_dist] call fnc_intersects;
	_obstructed = _array select 0;
};

while {!_obstructed} do
{
	_dist = _dist + 0.1;
	_array = [_pos1,_dist] call fnc_intersects;
	_obstructed = _array select 0;
};

while {_obstructed} do
{
	_dist = _dist - 0.01;
	_array = [_pos1,_dist] call fnc_intersects;
	_obstructed = _array select 0;
};

while {!_obstructed} do
{
	_dist = _dist + 0.01;
	_array = [_pos1,_dist] call fnc_intersects;
	_obstructed = _array select 0;
};

_obstructedPos = _array select 1;
[_obstructed,_obstructedPos]


