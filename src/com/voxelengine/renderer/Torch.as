/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer {

import flash.geom.Vector3D;
	
public class Torch extends ShaderLight {
	
	private var _phase:Number = 0;
	private var _base:Number = 100;
	private var _range:Number = 100;
	private var _flicker:Boolean = true;
	
	public function Torch( r:Number = 1, g:Number = 0.9, b:Number = 0 ) {
		color.setTo( r, g, b );
		endDistance = 100;
	}
		
	override public function update():void
	{
		// http://gamedev.stackexchange.com/questions/23167/fast-and-simple-attenuation-from-a-flaming-torch
		// They suggest changing the color and endDistance
		// I am not alterng color, just adding a flicker by changing range of light
		// Could also move the origin around.
		if ( flicker ) {
			_phase += 0.03;
			endDistance = _base + _range * Math.abs( Math.sin( _phase ) * 0.6 + Math.random() * 0.6 );
		}
	}
	
	public function set range(value:Number):void  { _range = value; }
	public function set base(value:Number):void  { _base = value; }
	public function set phase(value:Number):void { _phase = value; }
	public function get flicker():Boolean { return _flicker; }
	public function set flicker(value:Boolean):void { _flicker = value; }
}
}

