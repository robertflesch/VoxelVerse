/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.shaders
{
	import flash.utils.getDefinitionByName;
	
	import com.voxelengine.Log;
	import com.voxelengine.renderer.shaders.*;
    
    public class ShaderLibrary 
    {
        public function ShaderLibrary() {}
        
        public static function getAsset ( assetLinkageID : String ) : Class
        {
			ShaderOxel;
			ShaderAlpha;
			ShaderFire;
			var asset:Class = Class ( getDefinitionByName ( "com.voxelengine.renderer.shaders.ShaderOxel" ) );
			try 
			{
				asset = Class ( getDefinitionByName ( "com.voxelengine.renderer.shaders." + assetLinkageID ) );
			}
			catch ( error:Error )
			{
				Log.out( "ShaderLibrary.getAsset - ERROR - ERROR - ERROR: " + error, Log.ERROR );
			}
			
            return asset;
        }
    }   
}

