scriptName "fn_loadLevelLoadout";

#define __filename "fn_loadLevelLoadout.sqf"

// Clear loadout
removeAllItems player;
removeBackpackGlobal player;

// Player Inventar nach Respawn
player addBackpack "TAC_LBT_LEGAB2_BK";
player addPrimaryWeaponItem "ace_optic_arco_2d";
player addHeadgear "TAC_SF10H";
player addUniform "TRYK_U_B_BLKBLK_CombatUniform";
player addVest "TAC_Jvest_B";
player addGoggles "TAC_shoulder_armorC_BK";
player additem "TAC_SG_SK";
player additem "ace_optic_arco_2d";

// Get current weapon info to be spawned with
if (isNil {(gg_weaponList select gg_level) select 0}) exitWith {};
_weapon = (gg_weaponList select gg_level) select 0;
_magazineType = (gg_weaponList select gg_level) select 2;
_magazineCount = (gg_weaponList select gg_level) select 3;

if (_magazineType == "<auto>") then {
	_magazineType = (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0);
};

// Add weapon
player addMagazines [_magazineType, _magazineCount];
player addWeapon _weapon;

// Check if double weapons
if ((count weapons player) > 1) then {
	removeAllWeapons player;
	removeAllItems player;
	player addMagazines [_magazineType, _magazineCount];
	player addWeapon _weapon;
};

player enableStamina false;
player setCustomAimCoef 0;
player addPrimaryWeaponItem "ace_optic_arco_2d";