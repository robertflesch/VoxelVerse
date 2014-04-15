/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel 
{
import flash.system.System;
     
public final class MemoryManager 
{ 
	private static var _s_startingMemory:int = 0;
	private static var _s_currentMemory:int = 0;

	public static function currentMemory():int { return _s_currentMemory; }
	
	public static function initialize():void 
	{ 
		_s_startingMemory = System.totalMemory / 1024;
	} 
	 
	public static function update():void 
	{ 
		_s_currentMemory = System.totalMemory / 1024 - _s_startingMemory;
	} 
} 
}

