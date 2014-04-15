/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.weapons
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.*;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;	
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Barrel extends VoxelModel 
	{
		// Types of ammo
		// Size of ammo
		// Velocity of ammo
		public function Barrel( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			
			if ( mi.json && mi.json.model && mi.json.model.barrel )
			{
				var BarrelInfo:Object = mi.json.model.barrel;
				if ( BarrelInfo.reloadSpeed )
					trace( "Barrel - json - reloadSpeed: " + BarrelInfo.reloadSpeed );
			}
//			else
//				trace( "Barrel - NO Barrel INFO FOUND" );
			
				
		}
	}
}
