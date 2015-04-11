private ["_unit","_objects","_doorNumbers","_doorPositions","_houses","_house","_class","_cfg","_uaCfg"];



_randomLock = true;

if (isNil ("compFunctions")) then
{
	compFunctions = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\compFunctions.sqf";
};
call compFunctions;

breachHouses = [];
breachAmmo = ["B_65x39_Caseless","B_12Gauge_Pellets","B_12Gauge_Slug","prpl_B_12Gauge_Pellets","prpl_B_12Gauge_Slug","BPX_UTS15_Pellets Buckshot","BPX_UTS15_Slug Slug"];
_maxDist = 30;
_cleanupDist = _maxDist * 2; // just to be safe. if a unit has active houses in a 30 meter radius and moves 30 meters north there are now houses active 60meters south and so a 60m radius is needed
_sleepTime = _maxDist / 5; // Average 5ms speed while running.
// start monitor
/* nul = [] spawn
{
	while {true} do
	{
		hintsilent (str(count breachHouses));
		sleep 1;
	};
}; */


// start EH loop
while {true} do
{
	_unit = player;
	if (vehicle _unit == _unit) then // this checks that the player is on foot
	{
		// add EH to relevant houses
		_farHouses = [_unit,_cleanupDist] call fnc_get_houses;
		_nearHouses = [_unit,_maxDist] call fnc_get_houses;
		_toRemoveHouses = _farHouses - _nearHouses;

		if ((count _toRemoveHouses) > 0) then 
		{
			// remove all the breachable EH footprints if the EH is on the house
			{
				[_x] call fnc_removeBreachEH;
			}foreach _toRemoveHouses;
		};

		// if there are houses closeby
		if ((count _nearHouses) > 0) then
		{
			// add the breachable EH if neccesary
			{
				[_x] call fnc_addBreachEH;
				
				if (_randomLock) then
				{
					[_x] call fnc_lockCheck;
				};
				
			}foreach _nearHouses;
		};
		breachHouses = breachHouses - _toRemoveHouses;
	}
	else
	{
		// clean up until player is on foot again
		_farHouses = [_unit,_cleanupDist] call fnc_get_houses;
		if ((count _farHouses) > 0) then
		{
			{
				[_x] call fnc_removeBreachEH;
			}foreach _farHouses;
		};
		breachHouses = breachHouses - _farHouses;

		waitUntil {(vehicle _unit == _unit) or (!alive _unit)};
	};
	//hint "cycling";
	sleep _sleepTime;
};

hint "Breaching stopped, error!";