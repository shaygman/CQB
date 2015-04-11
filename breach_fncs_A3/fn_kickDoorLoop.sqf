if (!isDedicated) then {

	[] spawn {
		private [
			"_distance",
			"_isAdjust", 
			"_isNext", 
			"_isPrev",
			"_cursorTarget",
			"_cameraPosition", 
			"_cameraVector", 
			"_cameraPositionTrue", 
			"_finalPosition", 
			"_finalPositionTrue",
			"_intersects",
			"_animName",
			"_doorPhase",
			"_doorName",
			"_doorNumber"
		];

		if (isNil ("fnc_intersectSelections")) then
		{
			fnc_intersectSelections = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\intersectSelections.sqf";
		};
		
		if (isNil ("fnc_kickDoor")) then
		{
			fnc_kickDoor = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\kickDoor.sqf";
		};
		
		if (isNil ("fnc_doorLocked")) then
		{
			fnc_doorLocked = compile preProcessFileLineNumbers "\A3\Structures_F\scripts\LockedDoor_Open.sqf";
		};
		
		_distance = 3; // Length of the intersect vector in meters

		// Evil loop of doom
		while {true} do 
		{

			// Wait until the combination of Adjust + NextAction / PrevAction keys is pressed
			waitUntil {
				_isAdjust = (inputaction "Adjust" > 0);
				_isAction = (inputaction "VehicleTurbo" > 0);
				(_isAdjust && _isAction);
			};

			_cursorTarget = cursorTarget;

			// No point in doing anything if the player isn't pointing at anything
			if(!isNull _cursorTarget) then {

				
				_intersects = [_cursorTarget,_distance,"GEOM"] call fnc_intersectSelections;

				// If we've got something in our way, let's try to open it
				if(count _intersects > 0) then {

					_doorName = (_intersects select 0) select 0;
					_doorNumber = _doorName select [(count _doorName) - 1,1]; // get the number at the end E.G. 2 from Door_2;
					
					//Get the variable name for locking the door.
					_doorLockVar = format ["bis_disabled_%1",_doorName];
					_doorExists = false; if((_doorName select [0,1]) == "D") then {_doorExists = true};
					
					if(_doorExists) then
					{
						// Currently most interesting doors and hatches are named door_#_rot or hatch_#_rot, those that aren't can rot in hell
						_animName = format ["%1_rot", _doorName];
						// Get the current door phase so we can increment or decrement it based on the input we've been given
						_doorPhase = _cursorTarget animationPhase _animName;
						
						if(_doorPhase < 0.8) then
						{
							// Kick the shit out of it!
							
							[player,_cursorTarget,_animName] call fnc_kickDoor;
							
							_bLocked = _cursorTarget getVariable [_doorLockVar,0];
							
							// unlock the door as the lock no longer works properly
							if (_bLocked == 1) then 
							{
								_cursorTarget setVariable [_doorLockVar,0,true];
							};
							
							sleep 2; // to let the animation finish. this makes sure you don't double kick a door.
						};
					};
				};
			};

		};

	};

};