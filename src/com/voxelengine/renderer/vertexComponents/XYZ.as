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

public class XYZ extends VertexComponent {

	private var 	_x:Number;
	private var 	_y:Number;
	private var 	_z:Number;
	
	public function XYZ( $x:Number, $y:Number, $z:Number ):void {
		super( Context3DVertexBufferFormat.FLOAT_3, 3 );
		_x = $x;
		_y = $y;
		_z = $z;
	}
	
	override public function setNumArray(args:Vector.<Number>):void {
		_x = args[0];
		_y = args[1];
		_z = args[2];
	}

	override public function writeToByteArray( $ba:ByteArray ):void {
		$ba.writeFloat( _x );
		$ba.writeFloat( _y );
		$ba.writeFloat( _z );
	}
}
}

