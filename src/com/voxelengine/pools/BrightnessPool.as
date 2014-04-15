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
import com.voxelengine.worldmodel.oxel.Brightness;
     
public final class BrightnessPool
{ 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Brightness>; 
	
	static public function remaining():uint { return _counter; }
	static public function total():uint { return _pool.length; }
	static public function totalUsed():uint { return _pool.length - _counter; }

	public static function initialize( $maxPoolSize:uint, $growthValue:uint ):void 
	{ 
		_counter = $maxPoolSize; 
		GROWTH_VALUE = $growthValue; 
		 
		_pool = new Vector.<Brightness>( $maxPoolSize ); 
		
		var i:uint = $maxPoolSize; 
		while( --i > -1 ) 
			_pool[i] = new Brightness(); 
	} 
	 
	public static function poolGet():Brightness 
	{ 
		if ( _counter > 0 ) 
			return _pool[--_counter]; 
			 
		Log.out( "BrightnessPool  - Allocating more Brightnesss: " + GROWTH_VALUE, Log.ERROR );
		
		var i:uint = GROWTH_VALUE; 
		while( --i > -1 ) 
				_pool.unshift ( new Brightness() ); 
				
		_counter = GROWTH_VALUE; 
		return poolGet(); 
		 
	} 

	public static function poolReturn( $disposedBrightness:Brightness ):void 
	{ 
		if ( !$disposedBrightness )
		{
			Log.out( "BrightnessPool.poolReturn - displosedBrightness is NULL" );
			return;
		}
		$disposedBrightness.reset();	
		_pool[_counter++] = $disposedBrightness; 
	} 
} 
}

