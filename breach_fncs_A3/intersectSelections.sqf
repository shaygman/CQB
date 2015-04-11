private [	
			"_cursorTarget",
			"_cameraPosition", 
			"_cameraVector", 
			"_cameraPositionTrue", 
			"_finalPosition", 
			"_finalPositionTrue",
			"_intersects"
		];

_obj = _this select 0; if(typename _obj != "OBJECT") exitWith {hint "intersectSelections.sqf requires an object as it's first argument"};
_distance = _this select 1; if(isNil("_distance")) then {_distance = 1};
_LOD = _this select 2; if(isNil("_LOD")) then {_LOD = "GEOM"}; // defaults to the regular geometry

_cameraVector = [positionCameraToWorld [0,0,0], positionCameraToWorld [0,0,1]] call BIS_fnc_vectorFromXtoY; // Get the current camera vector
_cameraPosition = eyePos player; // Starting point for the intersect line
_cameraPositionTrue = if(surfaceIsWater _cameraPosition) then {_cameraPosition} else {ASLtoATL _cameraPosition}; // Normalize the starting position
_finalPosition = [_cameraPosition, [_cameraVector call BIS_fnc_unitVector, _distance] call BIS_fnc_vectorMultiply] call BIS_fnc_vectorAdd; // Calculate the end position for the intersect line based on the camera vector
_finalPositionTrue = if(surfaceIsWater _finalPosition) then {_finalPosition} else {ASLtoATL _finalPosition}; // Normalize the final position of the intersect line
_intersects = [_obj, _LOD] intersect [_cameraPositionTrue, _finalPositionTrue]; // Get the stuff the line intersects

_intersects