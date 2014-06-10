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
import com.voxelengine.worldmodel.models.*;
import com.voxelengine.worldmodel.weapons.Projectile;
     
public final class ProjectilePool 
{ 
	private static var GROWTH_VALUE:uint; 
	private static var _counter:uint; 
	private static var _pool:Vector.<Projectile>; 
	private static const CLASS_NAME:String = "CannonBall";
	
	static public function remaining():uint { return _counter; }
	static public function total():uint { return _pool.length; }
	static public function totalUsed():uint { return _pool ? _pool.length - _counter : GROWTH_VALUE; }

	
	public static function initialize( $initialPoolSize:uint, $growthValue:uint ):void 
	{ 
		GROWTH_VALUE = $growthValue; 
		_counter = $initialPoolSize; 
		// We have to wait until types are loading before we can start our process
		Globals.g_app.addEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );
	} 
	
	private static function onTypesLoaded( $event:LoadingEvent ):void
	{
		// So types are done, now we have to preload the CLASS_NAME.mjson file
		Globals.g_app.removeEventListener( LoadingEvent.LOAD_TYPES_COMPLETE, onTypesLoaded );
		// Preload the modelInfo for the CLASS_NAME
		Globals.g_modelManager.modelInfoFindOrCreate( CLASS_NAME, "-1", false );
		// Listen for it being loaded
		Globals.g_app.addEventListener( ModelEvent.INFO_LOADED, onModelInfoLoaded );
	}
	
	private static function onModelInfoLoaded( $event:ModelEvent ):void
	{
		// if our CLASS_NAME.mjson has loaded, so now we can create all of the instances
		if ( CLASS_NAME == $event.instanceGuid )
		{
			Globals.g_app.removeEventListener( ModelEvent.INFO_LOADED, onTypesLoaded );
			var i:uint = _counter; 
			_pool = new Vector.<Projectile>(_counter);
			_counter = 0;
			//Log.out( "ProjectilePool.onModelInfoLoaded: counter: " + _counter + "  _currentPoolSize: " + _currentPoolSize + " poolsize: " + _pool.length );
			while( --i > -1 ) 
				addToPool( newModel() );
		}
	}
	
	public static function poolGet():Projectile 
	{ 
		if ( _counter > 0 ) 
			return _pool[--_counter]; 
			 
		var i:uint = GROWTH_VALUE; 
		while( --i > -1 ) 
				_pool.unshift( newModel() ); 
		_counter = GROWTH_VALUE; 
		return poolGet(); 
		 
	} 

	public static function poolDispose( $disposedProjectile:Projectile):void 
	{ 
		addToPool( $disposedProjectile ); 
	} 
	
	private static function addToPool( $projectile:Projectile ):void
	{
		_pool[_counter++] = $projectile; 
	}
	
	private static function newModel():Projectile
	{
		var pi:InstanceInfo = new InstanceInfo();
		pi.templateName = CLASS_NAME;
		pi.name = "Projectile";
		pi.grainSize = 2;
		pi.usesCollision = true;
		pi.dynamicObject = true;
		pi.baseLightLevel = 255;
		
		var mi:ModelInfo = Globals.g_modelManager.modelInfoGet(pi.templateName);
		var modelAsset:String = mi.modelClass;
		var modelClass:Class = ModelLibrary.getAsset( modelAsset )
		var vm:* = new modelClass( pi, mi );
		// the task of replacing the oxel is placed 
		vm.modelInfo.biomes.addParticleTaskToController( vm );

		return vm;
	}

} 
}

