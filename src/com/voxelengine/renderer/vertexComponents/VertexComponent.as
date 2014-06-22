/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.vertexComponents {
	import flash.utils.ByteArray;

public class VertexComponent {
	protected var 	_type:String;
	protected var 	_size:uint;
	
	public function VertexComponent( $type:String, $size:uint ):void 
	{
		_type = $type;
		_size = $size;
	}
	
	public function setNumArray(args:Vector.<Number>):void {;}
	public function setIntArray(args:Vector.<int>):void {;}
	public function setUint(args:uint):void {;}
	
	public function writeToByteArray( ba:ByteArray ):void {}
	
	public function type():String {
		return _type;
	}
	
	public function size():uint {
		return _size;
	}
	
	public function clone():VertexComponent {
		return new VertexComponent( _type, _size );
	}
}
}

