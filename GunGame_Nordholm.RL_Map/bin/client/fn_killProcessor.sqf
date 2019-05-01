scriptName "fn_killProcessor";

#define __filename "fn_killProcessor.sqf"

// Increase
gg_kills = gg_kills + 1;
gg_stagekills = gg_stagekills + 1;

// Broadcast vars
player setVariable ["gg_level", gg_level, true];

// Max kills of current stage
_killsRequired = (gg_weaponList select gg_level) select 1;

// Check loadout
[] spawn gg_fnc_loadLevelLoadout;

// Check
if (gg_stagekills >= _killsRequired) then {
	gg_level = gg_level + 1;
	gg_stagekills = 0;
	playSound "levelup";

	if (gg_level >= (count gg_weaponList)) then {
		[player] remoteExec ["mav_fnc_win"];
	} else {
		// Check wether we are now the leading player
		if (gg_leadingplayer != player) then {
			if (({(_x getVariable ["gg_level", 0]) >= gg_level AND (_x != player)} count AllPlayers) == 0) then {
				[player] remoteExec ["gg_fnc_leadingPlayer"];
			};
		};
	};

	if (gg_level >= ((count gg_weaponList) - 3) AND (isNil "gg_suspensemusic")) then {
		[] remoteExec ["gg_fnc_suspensemusic"];
	};
} else {
	playSound "kill";
};

// Update list
[] spawn gg_fnc_progressionDisplayUpdate;
player addPrimaryWeaponItem "ace_optic_arco_2d";
[objNull, player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;