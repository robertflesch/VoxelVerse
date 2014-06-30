/*==============================================================================
  Copyright 2011-2014 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{
import com.voxelengine.renderer.VertexIndexBuilder;
import com.voxelengine.Log;
     
public final class VertexIndexBuilderPool 
{ 
	private static var _currentPoolSize:uint; 
	private static var _growthValue:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<VertexIndexBuilder>; 
	
	static public function remaining():uint { return _counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }

	public static function initialize( $maxPoolSize:uint, $growthValue:uint ):void 
	{ 
		_currentPoolSize = $maxPoolSize; 
		_growthValue = $growthValue; 
		_counter = $maxPoolSize; 
		 
		var i:uint = $maxPoolSize; 
		 
		_pool = new Vector.<VertexIndexBuilder>(_currentPoolSize); 
		while( --i > -1 ) 
			_pool[i] = new VertexIndexBuilder(); 
	} 
	 
	public static function poolGet():VertexIndexBuilder 
	{ 
		if ( _counter > 0 ) 
			return _pool[--_counter]; 
			 
		_currentPoolSize += _growthValue;
		_pool = null
		_pool = new Vector.<VertexIndexBuilder>(_currentPoolSize); 
		for ( var newIndex:int = 0; newIndex < _growthValue; newIndex++ )
		{
			_pool[newIndex] = new VertexIndexBuilder();
		}
		_counter = newIndex - 1; 
		
		return poolGet(); 
	} 

	public static function poolDispose(disposedVIB:VertexIndexBuilder):void 
	{ 
		disposedVIB.release();
		_pool[_counter++] = disposedVIB; 
	} 
} 
}

