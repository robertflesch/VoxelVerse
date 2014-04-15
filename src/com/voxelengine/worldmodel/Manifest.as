/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.TypeInfo;

	/**
	 * ...
	 * @author Bob
	 */
	public class Manifest 
	{
		public var _typeInfo:Vector.<TypeInfo> = new Vector.<TypeInfo>;
		
		public function add( ti:TypeInfo ):void
		{
			_typeInfo.push( ti );
		}
		
		public function publish():void
		{
			for each ( var ti:TypeInfo in _typeInfo )
			{
				trace( "Manifest.publish - " + ti );
				Globals.Info[ti.type] = ti;
			}
		}
		
		public function getJSON():String
		{
			var modelJSON:String = "{\"model\":";
			modelJSON += JSON.stringify( this );			
			modelJSON +=  "}"
			
			return modelJSON;
		}
	}
}