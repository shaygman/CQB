private ["_house"];
_house = _this select 0;

_house addeventhandler ['Hit',{
		private ['_array','_build','_unit','_target','_impactPos','_targetarray','_doorAnimNameName','_bExplosiveDamage','_bDirectDamage','_object'];
		
		_build = _this select 0;
		_cause = _this select 1;
		_damage = _this select 2;
		
		hint format ["%1 \n %2",_cause,_damage];
		/*
		if (_target != '') then {

			_targetarray = toarray _target;
				
			for "_i" from ((count _targetarray) - 1) to 0 do {

				
				
			};
			
			
			_doorNumber = (_targetarray select ((count _targetarray) - 1)) - 48;
			_doorAnimName = format ["Door_%1_rot",_doorNumber];
			
			
			_doorAnimName = _target + "_rot";
			_ammoname = (_array select 6) select 4;



			_bExplosiveDamage = (_array select 6) select 3;
			_bDirectDamage = _array select 10; 

			
			if ((_bExplosiveDamage >= 0.3) && (!(_bDirectDamage))) then {

				_animPhase = _build animationphase _doorAnimName;

				_build animate [_doorAnimName,(abs (_animPhase - 1))];

			};

			if ((_ammoname == 'B_12Gauge_74Slug') && (((getposASL _unit) distance _impactPos) <= 3)) then {

				_3rdamin = _build animationphase _doorAnimName3rd;
				_animPhase = _build animationphase _doorAnimName;

				_build animate [_doorAnimName3rd,(abs (_3rdamin - 1))];
				_build animate [_doorAnimName,(abs (_animPhase - 1))];

			};

		};
		*/
	}];

