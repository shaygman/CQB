private ["_angle"];

_obj1 = _this select 0;
_obj2 = _this select 1;

_pos1 = if ((typename _obj1) == "Array") then {_obj1} else {getposATL _obj1};
_pos2 = if ((typename _obj2) == "Array") then {_obj2} else {getposATL _obj2};


_adj = (_pos2 select 1) - (_pos1 select 1);
_opp = (_pos2 select 0) - (_pos1 select 0);

if (_adj == 0) then {_adj = 0.0001};
if (_opp == 0) then {_opp = 0.0001};

_angle = _opp atan2 _adj;

if (_angle < 0) then
{
	_angle = _angle + 360;
};

_angle