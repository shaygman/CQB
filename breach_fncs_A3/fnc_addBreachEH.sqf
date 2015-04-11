_house = _this select 0;

_breachable = _house getVariable ["breachable",nil];

if (isNil("_breachable")) then
{
	_ehNum = [_house] call fnc_breachable;
	_house setVariable ["breachable",_ehNum];
	
	breachHouses set [(count breachHouses),_house];
};