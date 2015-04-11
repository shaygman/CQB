_house = _this select 0;

_breachLock = _house getVariable ["breachLock",false];
	
if (!_breachLock) then
{
	nul = [_house,50] spawn fnc_lock_doors;
	_house setVariable ["breachLock",true,true];	
};


