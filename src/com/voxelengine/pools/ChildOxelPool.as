/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import flash.utils.getTimer;
import com.voxelengine.Log;
import com.voxelengine.worldmodel.oxel.Oxel
     
public final class ChildOxelPool 
{ 
	private static const COUNT:int = 8;
	private static var _currentPoolSize:uint; 
	private static var _growthValue:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Vector.<Oxel>>; 
	
	static public function remaining():uint { return _counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }

	public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
	{ 
		_currentPoolSize = maxPoolSize; 
		_growthValue = growthValue; 
		_counter = maxPoolSize; 
		 
		var i:uint = maxPoolSize; 
		 
		_pool = new Vector.<Vector.<Oxel> >(_currentPoolSize); 
		while( --i > -1 ) 
			_pool[i] = new Vector.<Oxel>(COUNT,true); 
	} 
	 
	public static function poolGet():Vector.<Oxel> 
	{ 
		if ( _counter > 0 ) 
			return _pool[--_counter]; 
			 
		Log.out( "ChildOxelPool.poolGet  - Allocating more ChildOxels: " + _currentPoolSize, Log.ERROR );
		var timer:int = getTimer();

		_currentPoolSize += _growthValue;
		_pool = null
		_pool = new Vector.<Vector.<Oxel> >(_currentPoolSize); 
		for ( var newIndex:int = 0; newIndex < _growthValue; newIndex++ )
		{
			_pool[newIndex] = new Vector.<Oxel>(COUNT,true);
		}
		_counter = newIndex - 1; 
		
		Log.out( "ChildOxelPool.poolGet - Done allocating more ChildOxels: " + _currentPoolSize  + " took: " + (getTimer() - timer), Log.ERROR );
		return poolGet(); 
	} 

	public static function poolReturn(disposedChildVector:Vector.<Oxel>):void 
	{ 
		for ( var i:int = 0; i < COUNT; i++ )
			disposedChildVector[i] = null;
			
		_pool[_counter++] = disposedChildVector; 
	} 
} 
}

