/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.*;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Wings extends Engine 
	{
		// Todo: This needs to be global?
		static private const SHIP_WINGS:String 		= "Wings"
		
		public function Wings( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			
			if ( mi.json && mi.json.model && mi.json.model.engine )
			{
				var EngineInfo:Object = mi.json.model.engine;
				//if ( EngineInfo )
				//	_rotationRate = EngineInfo.WingsRotationRate;
			}
			else
				trace( "Wings - NO Wings INFO FOUND - Setting to default rotation rate " );
		}

		override public function start( $val:Number, $parentModel:VoxelModel, $useThrust:Boolean = true ):void 
		{
			//super.start( $val, $parentModel );
			//for each ( var vm:VoxelModel in _children )
			//{
				//if ( -1 != vm.instanceInfo.name.search( "Wings" ) )
				//{
					//vm.instanceInfo.addNamedTransform( 0, 0, $val * _rotationRate, -1, ModelTransform.ROTATION_STRING, SHIP_Wings );		
				//}
			//}
		}
		
		override public function stop( $parentModel:VoxelModel, $useThrust:Boolean = true ):void 
		{
			//super.stop( $parentModel );
			//for each ( var vm:VoxelModel in _children )
			//{
				// find the children models with "Wings" in them
				//if ( -1 != vm.instanceInfo.name.search( "Wings" ) )
					//vm.instanceInfo.removeNamedTransform( ModelTransform.ROTATION_STRING, SHIP_Wings );
			//}
		}
	}
}
