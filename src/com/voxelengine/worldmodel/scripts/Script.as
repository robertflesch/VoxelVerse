/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.scripts
{
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.events.OxelEvent;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class Script
	{
		protected var _instanceGuid:String = null;
		
		public function get instanceGuid():String  					{ return _instanceGuid; }
		public function set instanceGuid(val:String ):void 				{ _instanceGuid = val; }

		public function Script() 
		{ 
		}
		
		public function processJsonInfo( modelInfo:ModelInfo ):void {		
			
		}
		
		public function dispose():void { ; }
	}
}
