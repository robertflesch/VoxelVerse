/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.vertexComponents {
	import com.voxelengine.utils.ColorUtils;
	import flash.utils.ByteArray;
	import flash.display3D.Context3DVertexBufferFormat;

public class ColorUINT extends VertexComponent {

	private var 	_ABGR:uint;
	
	// don’t forget that AGAL textures are written in BGRA not ARGB! You will have to set the endian of the used ByteArray properly like this:
	// byteArray.endian = Endian.LITTLE_ENDIAN;		
	public function ColorUINT( $ARGB:uint ):void {
		super( Context3DVertexBufferFormat.BYTES_4, 1 );
		_ABGR = ColorUtils.convertRGBAToABGR( $ARGB );
	}
	
	override public function writeToByteArray( $ba:ByteArray ):void {
		$ba.writeUnsignedInt( _ABGR );
	}
}
}

