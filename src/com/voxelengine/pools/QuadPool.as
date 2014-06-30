/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import com.voxelengine.Log;
import com.voxelengine.renderer.Quad
     
public final class QuadPool 
{ 
	private static var _currentPoolSize:uint; 
	private static var _growthValue:uint; 
	private static var counter:uint; 
	private static var pool:Vector.<Quad>; 
	
	static public function remaining():uint { return counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - counter; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		_growthValue = growthValue; 
		counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		pool = new Vector.<Quad>(_currentPoolSize); 
		while( --i > -1 ) 
			pool[i] = new Quad(); 
	} 
	 
	public static function poolGet():Quad 
	{ 
		if ( counter > 0 ) 
			return pool[--counter]; 
			 
		_currentPoolSize += _growthValue;
		pool = null
		pool = new Vector.<Quad>(_currentPoolSize); 
		for ( var newIndex:int = 0; newIndex < _growthValue; newIndex++ )
		{
			pool[newIndex] = new Quad();
		}
		counter = newIndex - 1; 
		
		return poolGet(); 
	} 

	public static function poolDispose(disposedQuad:Quad):void 
	{ 
		// TODO Are all of the 1) vertices 2) indices 3) UV being released?
		// RSF - Dont need to be, they are allocated along with quad at creation
		pool[counter++] = disposedQuad; 
	} 
} 
}

