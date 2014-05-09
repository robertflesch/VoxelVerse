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

public class Normal extends VertexComponent {

	private var 	_nx:Number;
	private var 	_ny:Number;
	private var 	_nz:Number;
	
	public function Normal( $nx:int, $ny:int, $nz:int ):void {
		super( Context3DVertexBufferFormat.FLOAT_3, 3 );
		_nx = $nx;
		_ny = $ny;
		_nz = $nz;
	}
	
	override public function writeToByteArray( $ba:ByteArray ):void {
		$ba.writeFloat( _nx );
		$ba.writeFloat( _ny );
		$ba.writeFloat( _nz );
	}
	
}
}

