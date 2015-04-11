if (!isDedicated) then {

	[] spawn {
		private [
			"_distance",
			"_isAdjust", 
			"_isNext", 
			"_isPrev",
			"_cursorTarget",
			"_intersects",
			"_animName",
			"_doorPhase",
			"_doorName",
			"_doorNumber",
			"_doorLockVar",
			"_lockedAnim",
			"_handleAnim"
		];

		if (isNil ("fnc_intersectSelections")) then
		{
			fnc_intersectSelections = compile preProcessFileLineNumbers "breaching\scripts\breach_fncs_A3\intersectSelections.sqf";
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
				_isNext = (inputaction "NextAction" > 0);
				_isPrev = (inputaction "PrevAction" > 0);
				(_isAdjust && {_isNext or {_isPrev}});
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
					
					// Currently most interesting doors and hatches are named door_#_rot or hatch_#_rot, those that aren't can rot in hell
					_animName = format ["%1_rot", _doorName];
					// Get the current door phase so we can increment or decrement it based on the input we've been given
					_doorPhase = _cursorTarget animationPhase _animName;
					
					//Check if the door is locked
					if((_cursorTarget getVariable [_doorLockVar,0]) == 0) then
					{
						// BI, can we have a sane "elseif" in SQF so I don't have to do this to avoid silly if chains?
						switch true do {
							case (_isNext && { _doorPhase < 1 }) : { _doorPhase = _doorPhase + 0.1; }; // Player wants to open the door
							case (_isPrev && { _doorPhase > 0 }) : { _doorPhase = _doorPhase - 0.1; }; // Player wants to close the door
						};

						// Make it happen!
						_cursorTarget animate [_animName, _doorPhase];
					}
					else
					{
						// play the locked door animation
						_lockedAnim = format ["Door_Locked_%1_rot",_doorNumber];
						_handleAnim = format ["Door_Handle_%1_rot_1",_doorNumber];
						[_cursorTarget,_handleAnim,_lockedAnim] call fnc_doorLocked;
						sleep 1; //wait for anim to end
					};
				};
			};

		};

	};

};