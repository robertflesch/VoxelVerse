/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.lighting.Light;
/**
 * ...
 * @author Robert Flesch
 */
public class BrightnessData {
	
	/*
	 *           0,1,0  ___________ 1,1,0
	 *                /|          /|
	 *               / |   1,1,1 / |
	 *     ^  0,1,1 /__|________/  |   POSX ->
	 *     |       |   |        |  |
	 *    POSY     |   |________|__|
	 *             |  / 0,0,0   |  / 1,0,0
	 *             | /          | /
	 *             |/___________|/
	 *      POSZ   0,0,1        1,0,1
	 *        |
	 *        \/
	 */

	private static const BRIGHTNESS_DATA_CHILD_0:uint			= 0x00000001;
	private static const BRIGHTNESS_DATA_CHILD_1:uint			= 0x00000002;
	private static const BRIGHTNESS_DATA_CHILD_2:uint			= 0x00000004;
	private static const BRIGHTNESS_DATA_CHILD_3:uint			= 0x00000008;
	private static const BRIGHTNESS_DATA_CHILD_4:uint			= 0x00000010;
	private static const BRIGHTNESS_DATA_CHILD_5:uint			= 0x00000020;
	private static const BRIGHTNESS_DATA_CHILD_6:uint			= 0x00000040;
	private static const BRIGHTNESS_DATA_CHILD_7:uint			= 0x00000080;
	private static const BRIGHTNESS_DATA_PARENT:uint			= 0x00000100;
	private static const BRIGHTNESS_DATA_ALL_SET:uint			= 0x000001ff;
	private static const BRIGHTNESS_DATA_ALL_RESET:uint			= 0xfffffe00;
		
	private var _data:uint = 0;					
		
	public function get child0():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_0); }
	public function set child0( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_0; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child1():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_1); }
	public function set child1( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_1; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child2():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_2); }
	public function set child2( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_2; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child3():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_3); }
	public function set child3( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_3; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child4():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_4); }
	public function set child4( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_4; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child5():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_5); }
	public function set child5( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_5; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child6():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_6); }
	public function set child6( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_6; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	public function get child7():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_CHILD_7); }
	public function set child7( $val:Boolean ):void 		{ _data |= BRIGHTNESS_DATA_CHILD_7; if ( $val ) _data |= BRIGHTNESS_DATA_PARENT; }

	//public function get allSet():Boolean 					{ return 0 < (_data & BRIGHTNESS_DATA_ALL_SET); }
	public function get ready():Boolean 					{ 
		if ( BRIGHTNESS_DATA_ALL_SET == ( _data & BRIGHTNESS_DATA_ALL_SET ) )
			return true;
		return false;
	}
	
	public function readyForce():void 					{ 
		_data |= BRIGHTNESS_DATA_ALL_SET;
	}
	
	public function readyReset():void 					{ 
		_data &= BRIGHTNESS_DATA_ALL_RESET;
	}
} // end of class FlowInfo
} // end of package
