/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.tests
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.tasks.tests.*;
	import flash.utils.getDefinitionByName;
    
    public class TestLibrary 
    {
        public function TestLibrary()
        {
            
        }
        
        public static function getAsset ( assetLinkageID : String ) : Class
        {
			TestSphere;	
			TestSolid;
			TestError;
			TestDebugMacro;
			var asset:Class = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.tasks.tests.TestError" ) ) ;;
			try 
			{
				asset = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.tasks.tests." + assetLinkageID ) ) ;
			}
			catch ( error:Error )
			{
				trace( "----------------------------------------" );
				trace( "TestLibrary.getAsset - ERROR: " + error );
				trace( "----------------------------------------" );
			}

            //var asset : Class = Class ( getDefinitionByName ( "VoxelVerse" ) ) ;
			// This works
            //asset = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.VoxelModel" ) ) ;
			// This don't!
            //asset = Class ( getDefinitionByName ( "com.voxelengine.worldmodel.tasks.Flow" ) ) ;
            //asset = Class ( getDefinitionByName ( assetLinkageID ) ) ;
            //
            return asset;
        }
    }   
}

