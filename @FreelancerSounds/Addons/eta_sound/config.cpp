requiredAddons[] = {"cba_settings"};

class cfgPatches
{
    class ProjectFreelancerSounds
    {
        name = "ProjectFreelancerSounds";
        author = "Eta";
		    text= "";
        url = "";
        version="1.0";
        versionStr="1.0";
		requiredAddons[] = {
		"cba_jr"
		};
  };
};

class CfgFunctions
{

	class ADDON{
		class functions
		{
			file = "\eta_sound\etasound_functions";
			class init{postInit = 1;};
		};
	};
};

class CfgVehicles
{
  class Man;
  class CAManBase:Man
  {
    class ACE_SelfActions
    {
      class activate_pfc
      {
        displayName = "Activate PFC";
        condition = "'etasound_radio' in items _player";
        statement = "[ [], 'eta_pfc', player ] call BIS_fnc_MP;";
      };
    };
  };
};

class CfgWeapons
{
	class ACE_microDAGR;
	class etasound_radio:ACE_microDAGR
	{
		author = "Eta";
		displayname = "PFC";
		mass = 4;
	};
};

class CfgSounds
{
   class etasound_shield_failure
   {
         name = "";
         sound[] = {"\eta_sound\sounds\shields_down.ogg",100, 1,100};
         titles[] = {0, ""};
   };
   class etasound_heavy_wound
   {
         name = "";
         sound[] = {"\eta_sound\sounds\heavily_wounded.ogg",100, 1,100};
         titles[] = {0, ""};
   };
   class etasound_low_ammo
   {
         name = "";
         sound[] = {"\eta_sound\sounds\low_ammo.ogg",100, 1,100};
         titles[] = {0, ""};
   };
   class etasound_out_of_ammo
   {
         name = "";
         sound[] = {"\eta_sound\sounds\out_of_ammo.ogg",100, 1,100};
         titles[] = {0, ""};
   };
   class etasound_underfire
   {
         name = "";
         sound[] = {"\eta_sound\sounds\underfire.ogg",100, 1,100};
         titles[] = {0, ""};
   };
   class ogg_testing
   {
         name = "ogg_testing";
         sound[] = {"\eta_sound\sounds\test.ogg",100, 1,100};
         titles[] = {0, ""};
   };
};
