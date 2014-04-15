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
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Stand extends VoxelModel 
	{
		//Stand
		//Stand
		//Sight
		public function Stand( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			
			if ( mi.json && mi.json.model && mi.json.model.Stand )
			{
				var StandInfo:Object = mi.json.model.Stand;
				if ( StandInfo.reloadSpeed )
					trace( "Stand - json - reloadSpeed: " + StandInfo.reloadSpeed );
			}
//			else
//				trace( "Stand - NO Stand INFO FOUND" );
			
				
		}
	}
}
