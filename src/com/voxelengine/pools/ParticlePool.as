/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.pools 
{

import com.voxelengine.events.LoadingEvent;
import com.voxelengine.events.ModelEvent;
import com.voxelengine.Log;
import com.voxelengine.Globals;
import com.voxelengine.worldmodel.models.Particle;
import com.voxelengine.worldmodel.models.ModelInfo;
import com.voxelengine.worldmodel.models.InstanceInfo;
import com.voxelengine.worldmodel.models.ModelLibrary;

public final class ParticlePool 
{ 
	private static var _currentPoolSize:uint; 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Particle>; 
	private static var _currentParticle:Particle; 
	private static const CLASS_NAME:String = "Particle";
	
	static public function remaining():uint { return _counter; }
	static public function total():uint { return _currentPoolSize; }
	static public function totalUsed():uint { return _currentPoolSize - _counter; }

	public static function initialize( $maxPoolSize:uint, $growthValue:uint ):void 
	{ 
		_currentPoolSize = $maxPoolSize; 
		GROWTH_VALUE = $growthValue; 
		_counter = $maxPoolSize; 
		Globals.g_app.addEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );

	} 
	
	private static function onTypesLoaded( e:LoadingEvent ):void
	{
		Globals.g_app.removeEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );
		// Preload the modelInfo for the cannonBall
		Globals.g_modelManager.modelInfoFindOrCreate( CLASS_NAME, "-1", false );
		// Listen for it being loaded
		Globals.g_app.addEventListener( ModelEvent.INFO_LOADED, onModelInfoLoaded );
	}
	
	private static function onModelInfoLoaded( e:ModelEvent ):void
	{
		// so cannonBall.mjson has loaded, so now we can create all of the instances
		if ( CLASS_NAME == e.instanceGuid )
		{
			Globals.g_app.removeEventListener( ModelEvent.INFO_LOADED, onTypesLoaded );
			var i:uint = _currentPoolSize; 
			_pool = new Vector.<Particle>(_currentPoolSize); 
			_counter = 0;
			//Log.out( "ProjectilePool.onModelInfoLoaded: counter: " + _counter + "  _currentPoolSize: " + _currentPoolSize + " poolsize: " + _pool.length );
			while( --i > -1 ) 
				addToPool( newModel() );
		}
	}

	public static function poolGet():Particle
	{ 
		if ( _counter > 0 ) 
			return _currentParticle = _pool[--_counter]; 
			 
		var i:uint = GROWTH_VALUE; 
		_currentPoolSize += GROWTH_VALUE;
		while( --i > -1 ) 
				_pool.unshift( newModel() ); 
		_counter = GROWTH_VALUE; 
		return poolGet(); 
		
		
		 
	} 
	
	private static function addToPool( particle:Particle ):void
	{
		_pool[_counter++] = particle; 
	}
	
	public static function poolDispose(disposedParticle:Particle):void 
	{ 
		//Log.out( "ParticlePool.particle_dispose" );
		disposedParticle.instanceInfo.removeAllNamedTransforms();
		_pool[_counter++] = disposedParticle; 
	} 
	
	private static function newModel():Particle
	{
		var pi:InstanceInfo = new InstanceInfo();
		pi.templateName = CLASS_NAME;
		pi.name = CLASS_NAME;
		pi.grainSize = 2;
		pi.usesCollision = false;
		pi.dynamicObject = true;
		
		var mi:ModelInfo = Globals.g_modelManager.modelInfoGet(pi.templateName);
		var modelAsset:String = mi.modelClass;
		var modelClass:Class = ModelLibrary.getAsset( modelAsset )
		var vm:* = new modelClass( pi, mi );
		// At this point the Particle just has a placeholder oxel
		// Still need to figure out how to load the actual ivm
		// being on as a task on a low priority thread
		vm.modelInfo.biomes.addParticleTaskToController( vm );

		return vm;
	}

} 
}

