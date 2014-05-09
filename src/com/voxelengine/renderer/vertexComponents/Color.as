/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.vertexComponents {
	import flash.utils.ByteArray;
	import flash.display3D.Context3DVertexBufferFormat;

public class Color extends VertexComponent {

	private var 	_a:Number;
	private var 	_r:Number;
	private var 	_g:Number;
	private var 	_b:Number;
	
	// don’t forget that AGAL textures are written in BGRA not ARGB! You will have to set the endian of the used ByteArray properly like this:
	// byteArray.endian = Endian.LITTLE_ENDIAN;		
	public function Color( $r:Number, $g:Number, $b:Number, $a:Number = 1.0 ):void {
		super( Context3DVertexBufferFormat.FLOAT_4, 4 );
		_a = $a;
		_r = $r;
		_b = $b;
		_g = $g;
	}
	
	override public function writeToByteArray( $ba:ByteArray ):void {
		$ba.writeFloat( _r );
		$ba.writeFloat( _g );
		$ba.writeFloat( _b );
		$ba.writeFloat( _a );
	}
}
}

