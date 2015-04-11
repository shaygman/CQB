_house = _this select 0;

_breachable = _house getVariable ["breachable",nil];
if (!isNil ("_breachable")) then
{
	_house setVariable ["breachable",nil];
	_house removeEventHandler ["Hitpart",_breachable];
};