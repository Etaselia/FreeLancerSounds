#include "script_component.hpp"
waitUntil { not isNull player };

//MAIN FUNCTION CALLED BY ACE
eta_pfc = {

    //STARTUP FEEDBACK
    hintSilent "PF Radio operational";

    //PUBLIC VARIABLES
    etasound_underfire = false;
    etasound_yell = false;
    etasound_shield_down = false;

    //SUB-FUNCTIONS
    fnc_firefight = {
      sleep 5;
      etasound_underfire = false;
    };
    fnc_shield_timer = {
      sleep 15;
      etasound_shield_down = false;
    };
    fnc_yell = {
      sleep 120;
      etasound_yell = false;
    };

    fnc_etasound_shieldstatus_check = {
      sleep 0.1;
      private _shieldstatus = player getVariable ["optre_suit_energy",100];
      if (_shieldstatus <= 0) then {
        if (!etasound_shield_down) then {
          playSound "etasound_shield_failure";
          etasound_shield_down = true;
          [] remoteExec ["fnc_shield_timer", clientOwner, false];
        };
      };
    };

    fnc_etasound_wounded = {
      sleep 2;
      private _testpain = GET_PAIN(player); //Dependant on ACE Medical, calling in script_component.hpp
      if (_testpain > 0) then {
        if (!etasound_yell) then {
          etasound_yell = true;
          [] remoteExec ["fnc_yell", clientOwner, false];
          if (_testpain > 0.8) then {
            //play heavy wounded voiceline
            playSound "etasound_heavy_wound";
          }
          else {
            //play light wounded voiceline
            playSound "etasound_heavy_wound";
          };
        };
      };
    };


    //UNDER FIRE VOICELINE
    player addEventHandler ["Suppressed", {
			if !etasound_underfire then {
        playSound "etasound_underfire";
        etasound_underfire = true;
        [] remoteExec ["fnc_firefight", clientOwner, false];
      };
    }];


    //SHIELD / WOUNDED VOICELINEs
    player addEventHandler ["Hit", {

      //SHIELD
      [] remoteExec ["fnc_etasound_shieldstatus_check", clientOwner, false];

      //WOUNDED VOICELINES
      if (etasound_shield_down) then {
        [] remoteExec ["fnc_etasound_wounded", clientOwner, false];
      };
    }];

    //LOW_AMMO_VOICELINE
    player addEventHandler ["Reloaded", {
    	params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

      _current_weapon = currentWeapon player;
      _compat_mags = [_current_weapon] call BIS_fnc_compatibleMagazines;
      //this shit is stupid, for whatever reason magazines player returns an uppercase string while BIS_fnc_compatibleMagazines returns a lowercase string, took me a good 30min to figure out
      _available_mags = {toLower _x in _compat_mags} count (magazines player);
      if (_available_mags <= 1) then {
        playSound "etasound_low_ammo";
      };
    }];

    //EMPTY MAG
    player addEventHandler["FiredMan",{
      _current_mag = player ammo currentWeapon player;
      if (_current_mag <= 0) then {
        playSound "etasound_out_of_ammo";
      };
    }];
};
