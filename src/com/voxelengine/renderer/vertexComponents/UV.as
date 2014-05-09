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

public class UV extends VertexComponent {

	private var _u:Number;
	private var _v:Number;
	
	public function UV( $u:Number, $v:Number ):void {
		super( Context3DVertexBufferFormat.FLOAT_2, 2 );
		_u = $u;
		_v = $v;
	}

	override public function writeToByteArray( $ba:ByteArray ):void {
		$ba.writeFloat( _u );
		$ba.writeFloat( _v );
	}
}
}

