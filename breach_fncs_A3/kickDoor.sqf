
_unit = _this select 0;
_build = _this select 1;
_doorAnim = _this select 2;
// animation depending on weapon equiped.

// placeholder awaiting the proper animations
_cfgWeapons = (configFile >> "cfgWeapons");
_weaponType = getNumber (_cfgWeapons >> (currentWeapon _unit) >> "type");
_animWeapon = switch (_weaponType) do {case 1 : {"Wrfl"}; case 2 : {"Wpst"}; default {"Wrfl"};};
_animName = "AovrPercMrunSrasWrflDf";
//player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
_unit switchMove _animName; //"AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 0.5;
_build animate [_doorAnim, 1];
playSound3D ["A3\Sounds_F\sfx\explosion1.wss", _unit];