if (isNil("fnc_lineIntersectsWhere")) then
{
	fnc_lineIntersectsWhere = compile PreProcessFilelineNumbers "breaching\scripts\breach_fncs_A3\fnc_lineIntersectsWhere.sqf";
};

if (isNil("fnc_indoors")) then
{
	fnc_indoors = compile PreProcessFilelineNumbers "breaching\scripts\breach_fncs_A3\fnc_indoors.sqf";
};

if (isNil ("fnc_get_houses")) then
{
	fnc_get_houses = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\fnc_get_houses.sqf";
};

if (isNil ("fnc_breachable")) then
{
	fnc_breachable = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\fnc_breachable.sqf";
};

if (isNil ("fnc_lock_doors")) then
{
	fnc_lock_doors = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\fnc_lock_doors.sqf";
};

if (isNil ("distance2D")) then
{
	distance2D = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\distance2D.sqf";
};

if (isNil("fnc_get_angle")) then 
{
	fnc_get_angle = compile loadfile "breaching\scripts\breach_fncs_A3\fnc_get_angle.sqf";
};

if (isNil("fnc_removeBreachEH")) then 
{
	fnc_removeBreachEH = compile loadfile "breaching\scripts\breach_fncs_A3\fnc_removeBreachEH.sqf";
};

if (isNil("fnc_addBreachEH")) then 
{
	fnc_addBreachEH = compile loadfile "breaching\scripts\breach_fncs_A3\fnc_addBreachEH.sqf";
};

if (isNil("fnc_lockCheck")) then 
{
	fnc_lockCheck = compile loadfile "breaching\scripts\breach_fncs_A3\fnc_lockCheck.sqf";
};
