/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import flash.display3D.Context3D;

	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.models.ModelStatisics;


	/**
	 * ...
	 * @author Robert Flesch RSF OxelBad - An OctTree / VOxelBad - model
	 */
	public class OxelBad extends Oxel
	{
		private static var _s_constructed_count:int = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Constructor - can only be made once for reference
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function OxelBad() {
			// have to be able to construct one!
			super();
			_s_constructed_count++;
			if ( 1 < _s_constructed_count )
				throw new Error("OxelBad - ERROR - construction of OxelBad");
				
			Oxel(this).initialize( null, new GrainCursor( 0xffffffff, 0xffffffff, 0xffffffff, 0 ), 0, null );				
		}
		
		override public function initialize( parent:Oxel, param_gc:GrainCursor, what:uint, stats:ModelStatisics ):void
		{
//			throw new Error("OxelBad - ERROR - initialize");
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Getters/Setters
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		override public function get gc():GrainCursor { throw new Error( "OxelBad - trying to get GC from bad oxel" ); }
		
		override public function get type():int 
		{ 
			throw new Error("OxelBad - ERROR - type - get");
			return Globals.INVALID;
		}
		/*
		override public function set type( val:int, $guid:String ):void 
		{ 
			throw new Error("OxelBad - ERROR - type - set");
		}
*/
		override public function get dirty():Boolean 
		{ 
			throw new Error("OxelBad - ERROR - type - set");
			return true;
		}
		override public function set dirty( isDirty:Boolean ):void 
		{ 
			throw new Error("OxelBad - ERROR - type - set");
		}
	}
}