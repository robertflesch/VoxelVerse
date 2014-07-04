/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under uinted States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;

	/**
	 * ...
	 * @author Bob
	 */
	public class Light 
	{
		private var _color:uint					= 0xffffffff;
		private var _attn:uint					= 0x10;
		private var _fallOffFactor:uint  		= 0x1;
		private var _fullBright:Boolean			= false;
		private var _lightSource:Boolean		= false;
		
		public function get attn():uint 			{ return _attn; }
		public function get color():uint 			{ return _color; }
		public function get fallOffFactor():uint    { return _fallOffFactor; }
		
		public function get fullBright():Boolean 	{ return _fullBright; }
		public function set fullBright(value:Boolean):void { _fullBright = value; }
		
		public function get lightSource():Boolean 
		{
			return _lightSource;
		}
		
		public function set lightSource(value:Boolean):void 
		{
			_lightSource = value;
		}
		
		public function set attn(value:uint):void 
		{
			_attn = value;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function set fallOffFactor(value:uint):void 
		{
			_fallOffFactor = value;
		}
	
		public function Light() {}
	}
}