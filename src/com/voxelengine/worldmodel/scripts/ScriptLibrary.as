/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.scripts
{
	import flash.utils.getDefinitionByName;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.scripts.*;
    
    public class ScriptLibrary 
    {
        public function ScriptLibrary() {}
        
        public static function getAsset ( assetLinkageID : String ) : Class
        {
			ControlObjectScript;
			AutoControlObjectScript;
			ControlBeastScript;
			DefaultScript;
			FireProjectileScript;
			BombScript;
			AutoFireProjectileScript;
			ExplosionScript;
			AcidScript;
			IceScript;
			FireScript;
			DragonFireScript;
			var asset:Class = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.scripts.DefaultScript" ) );
			try 
			{
				asset = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.scripts." + assetLinkageID ) );
			}
			catch ( error:Error )
			{
				Log.out( "ScriptLibrary.getAsset - ERROR - ERROR - ERROR: " + error, Log.ERROR );
			}
			
            return asset;
        }
    }   
}

