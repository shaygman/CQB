_pos1 = _this select 0; if (typeName _pos1 == "OBJECT") then {_pos1 = getPosASL _pos1};
_pos2 = _this select 1;	if (typeName _pos2 == "OBJECT") then {_pos2 = getPosASL _pos2};

_x1 = _pos1 select 0;
_y1 = _pos1 select 1;

_x2 = _pos2 select 0;
_y2 = _pos2 select 1;

_result = (sqrt(((_x1 - _x2) ^ 2) + ((_y1 - _y2) ^ 2)));

_result