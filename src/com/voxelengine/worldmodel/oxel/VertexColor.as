/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import com.voxelengine.utils.ColorUtils;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.lighting.Light;
/**
 * ...
 * @author Robert Flesch
 */
public class VertexColor {
	
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
	
	//private var _colors:Vector.<uint> = new Vector.<uint>;
	// http://jacksondunstan.com/articles/1288 could this be faster?
	private var _colors:Dictionary = new Dictionary(true);
	private var _changed:Boolean = true;
	private var _composite:uint
	
	public function VertexColor( lightID:uint, colorAndBrightness:uint ) {
		colorAdd( lightID, colorAndBrightness );
	}
	
	public function colorAdd( lightID:uint, colorAndBrightness:uint ):void {
		_changed = true;
		_colors[lightID] = colorAndBrightness;
	}
	
	public function colorGet( lightID:uint ):uint {
		return _colors[lightID];
	}
	
	public function colorHas( lightID:uint ):Boolean {
		if ( null == _colors[lightID] )
			return false;
		
		return true;
	}
	
	public function attnGet( lightID:uint ):uint {
		return ( _colors[lightID] >>> 24 );
	}
	
	public function attnSet( lightID:uint, attn:uint ):void {
		var val:uint = _colors[lightID];
		val &= 0x00ffffff;
		val |= attn << 24;
	}
	
	public function colorRemove( lightID:uint ):void {
		_changed = true;
		delete _colors[lightID]; //removes the key
	}
	
	// this returns a composite color made of default color plus any additional colors
	public function colorGetComposite():uint {
		//return 0x66666666;
		if ( false == _changed )
			return _composite;
			
		for each ( var color:uint in _colors ) {
			_composite = ColorUtils.testCombineARGB( _composite, color );
		}
		
		_changed = false;
		return _composite;
	}
	
} // end of class VertexColor
} // end of package
