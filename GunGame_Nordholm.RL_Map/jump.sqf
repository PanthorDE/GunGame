if (isNull player) exitwith {} ;

fn_Animation =
{
    _unit = _this select 0;
    _anim = _this select 1;
    _unit switchMove _anim;// PLAY ANIMATION JUMP
    //_unit playMovenow _anim;
};

dokeyDown={
     private ["_r","_key_delay","_max_height"] ;
     _key_delay  = 0.3;// MAX TIME BETWEEN KEY PRESSES 
     _max_height = 4.3;// SET MAX JUMP HEIGHT
     player setvariable ["key",false];
   _r = false ; 
     
   //  HINT STR (_this select 1);// show key number
   
   // VARIOUS CHECKS 
   if (player getvariable["key",true] and (_this select 1)  == 57) exitwith {player setvariable["key",false]; [_key_delay] spawn {sleep (_this select 0);player setvariable["key",true]; };_r};
     if ((_this select 1)  == 57 and speed player >8) then {
       if  (player == vehicle player  and player getvariable ["jump",true] and isTouchingGround player ) then  {
   
    player setvariable["key",true];// RESTE DOUBLE KEY TAP    
    player setvariable ["jump",false];// DISABLE JUMP
    
   _height = 6-((load player)*10);// REDUCE HEIGHT BASED ON WEIGHT
   //hint str _height;

// MAKE JUMP IN RIGHT DIRECTION
_vel = velocity player;
_dir = direction player;
_speed = 0.4;
If (_height > _max_height) then {_height = _max_height};// MAXIMUM HEIGHT OF JUMP 
player setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+(cos _dir*_speed),(_vel select 2)+_height];

    [[player,"AovrPercMrunSrasWrflDf"],"fn_Animation",nil,false] spawn BIS_fnc_MP; //BROADCAST ANIMATION
     player spawn {sleep 2;_this setvariable ["jump",true]};// RE-ENABLE JUMP
    
   };
    _r=true;
      };
     _r;
} ;

waituntil {!(IsNull (findDisplay 46))};
(FindDisplay 46) displayAddEventHandler ["keydown","_this call dokeyDown"];  