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
	private static var GROWTH_VALUE:uint; 
	private static var counter:uint; 
	private static var pool:Vector.<Quad>; 
	private static var currentQuad:Quad; 
	
	static public function remaining():uint { return counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - counter; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		GROWTH_VALUE = growthValue; 
		counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		pool = new Vector.<Quad>(_currentPoolSize); 
		while( --i > -1 ) 
			pool[i] = new Quad(); 
	} 
	 
	public static function poolGet():Quad 
	{ 
		if ( counter > 0 ) 
			return currentQuad = pool[--counter]; 
			 
		var i:uint = GROWTH_VALUE; 
		_currentPoolSize += GROWTH_VALUE;
		Log.out( "QuadPool  - Allocating more Quads: " + _currentPoolSize, Log.ERROR );
		while( --i > -1 ) 
				pool.unshift ( new Quad() ); 
		counter = GROWTH_VALUE; 
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

