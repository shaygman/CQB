private ["_house"];
_house = _this select 0;	



_ehNum = _house addeventhandler 
['Hitpart',
	{
		private ['_array','_unit','_target','_impactPos','_targetarray','_doorAnimNameName','_bExplosiveDamage','_bDirectDamage','_object','_house','_dist','_indoors','_lockVar','_bLocked'];

		_array = _this select 0;
		
		_house = _array select 0;
		_unit = _array select 1;
		_eyePos = eyePos _unit;
		_impactPos = _array select 3;
		_targets = _array select 5;
		_target = _targets select 0;
		_object = _array select 2;
		_indoors = [_object] call fnc_indoors;
		_objectPos = getPosASL _object;
		_objectPos set [2,(_objectPos select 2) + 0.2]; // this is to ensure that the origin being at 0,0,0 locally doesn't intersect the floor.
		_ammoName = (_array select 6) select 4;
		_indirectHit = getNumber (configFile >> 'cfgAmmo' >> _ammoName >> 'indirectHit');
		
		if (isNil('_indirectHit')) then {_indirectHit  = 0.001};
		
		if (_indoors) then {_indirectHit = (_indirectHit * 2)};
		_indirectRange = (_indirectHit / 10) + 1; // + 1 for height difference between charge and door memory point;
		
		if (_indirectRange >= 30) then {_indirectRange = 30}; // just cap the distance so as not to incur the wrath of lag.
		
		if(zor_breaching_DEBUG) then
		{
			_ball1 = "Sign_Sphere10cm_F" createVehicle [0,0,0];
			_ball1 setPosASL _impactPos;
		};
		
		if (_target != '') then 
		{

			if !(_ammoName iskindof "BulletBase") then
			{
				_doorPositions = _house getVariable ['doorPositions',nil];
				
				if (!(isNil ('_doorPositions'))) then
				{
					
					_inRange = [];
					_doorNumbers = [];
					_doorNumber = 0;
					
					{
						_doorPosition = _x;
						_doorNumber = _doorNumber + 1;
						_dist = _doorPosition distance _objectPos;
						if (_dist <= _indirectRange) then
						{
							_inRange set [(count _inRange),_doorPosition];
							_doorNumbers set [(count _doorNumbers),_doorNumber];
						};
					}foreach _doorPositions;
					//_unit globalChat (str(_doorNumbers));
					_notOccluded = [];
					_i = 0;
					{
						_doorPosition = _x;
						
						_array = [_object,_doorPosition,_object,_object] call fnc_lineIntersectsWhere;
						_occluded = _array select 0;
						_occludedPos = _array select 1;
						
						if (_occluded) then
						{
							_dist = _doorPosition distance _occludedPos;
							
							if (_dist <= 0.8) then
							{
								_notOccluded set [(count _notOccluded),(_doorNumbers select _i)];
							};
						};
						
						_i = _i + 1;
					}foreach _inRange;
					
					{
						
						_doorNumber = _x;
						_animName = format ["Door_%1_rot",_doorNumber];
						_animPhase = _house animationPhase _animName;
						
						if(zor_breaching_DEBUG) then {_unit sideChat (str(_ammoName))};
						
						_house animate [_animName,(abs (_animPhase - 1))];
						
						_lockVar = format ["bis_disabled_Door_%1",_doorNumber];
						_bLocked = _house getVariable [_lockVar,0];
						
						if (_bLocked == 1) then 
						{
							_house setVariable [_lockVar,0,true];
						};
					}foreach _notOccluded;
				};
			}
			else
			{
				_animName = _target + "_rot";
				_animPhase = _house animationPhase _animName;
				// check the door is closed
				if(_animPhase < 0.1) then
				{
					if (_ammoName in breachAmmo) then // "B_12Gauge_Slug";
					{
						
						_doorMemPoint = _target + "_trigger";
						_doorPosition = ATLtoASL(_house modelToWorld (_house selectionPosition _doorMemPoint));
						_doorDist = _doorPosition distance _eyePos;
						_impactDist = _impactPos distance _eyePos;
						
						
						_impactOffset = [_doorPosition,_impactPos] call distance2D;
						//_unit sideChat (format ["%1 is the offset",_impactOffset]);

						if(_impactOffset > 0.29) then
						{
							
							if ((_impactDist <= 1.5) && (_doorDist <= 1.75)) then
							{
								// DON'T WANT TO BE ABLE TO SHOOT DOORS OPEN. ONLY BLOW THE LOCK OFF.
								//_house animate [_animName,(abs (_animPhase - 1))]; // DON'T WANT TO BE ABLE TO SHOOT DOORS CLOSED
								_house animate [_animName,(_animPhase + 0.2)];
								
								if(zor_breaching_DEBUG) then {_unit globalChat (str(_ammoName))};
								
								_lockVar = format ["bis_disabled_%1",_target];
								_bLocked = _house getVariable [_lockVar,0];
								
								// unlock the door as the lock no longer works properly
								if (_bLocked == 1) then 
								{
									_house setVariable [_lockVar,0,true];
								};
							};
						};
					};
				};
			};
		};
	}
];

_ehNum


	
	/*

			_doorAnimName = _target + "_rot";
			_ammoName = (_array select 6) select 4;



			_bExplosiveDamage = (_array select 6) select 3;
			_bDirectDamage = _array select 10; 

			
			if ((_bExplosiveDamage >= 0.3) && (!(_bDirectDamage))) then {

				_animPhase = _build animationphase _doorAnimName;

				_build animate [_doorAnimName,(abs (_animPhase - 1))];

			};

			if ((_ammoName == 'B_12Gauge_74Slug') && (((getposASL _unit) distance _impactPos) <= 3)) then {

				_3rdamin = _build animationphase _doorAnimName3rd;
				_animPhase = _build animationphase _doorAnimName;

				_build animate [_doorAnimName3rd,(abs (_3rdamin - 1))];
				_build animate [_doorAnimName,(abs (_animPhase - 1))];

			};
			
	*/