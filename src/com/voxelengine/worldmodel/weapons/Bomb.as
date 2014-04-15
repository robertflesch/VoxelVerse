/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.weapons
{
	import com.voxelengine.events.ImpactEvent;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.SoundBank;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Bomb extends VoxelModel 
	{
		private var _bombHolder:VoxelModel = null;
		protected var _soundFile:String = "CannonBallExploding.mp3";		
		
		public function Bomb( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
			_bombHolder = instanceInfo.controllingModel;
			SoundBank.getSound( _soundFile ); // Preload the sound file
			instanceInfo.dynamicObject = true;
		}

		//override public function explosionResponse( center:Vector3D, ee:ImpactEvent ):void
		//{
			//bang( center );
		//}
		

		override public function update(context:Context3D, elapsedTimeMS:int):void 
		{
			super.update(context, elapsedTimeMS);
	
			// dont calculate collision until we have been released from zeppelin
			if ( null !=  instanceInfo.controllingModel )
				return;
		
			var modelList:Vector.<VoxelModel> = Globals.g_modelManager.whichModelsIsThisInsideOf( this )
			for each ( var collisionCandidate:VoxelModel in modelList )
			{
				if (  !_bombHolder.isInParentChain( collisionCandidate ) )
				{
					var mp:Vector3D = collisionCandidate.worldToModel( instanceInfo.positionGet );
					var isPassable:Boolean = collisionCandidate.isPassable( mp.x, mp.y, mp.z, oxel.gc.grain );
					if ( !isPassable )
					{
						var mpv:Vector3D = new Vector3D( mp.x + instanceInfo.center.x, mp.y + instanceInfo.center.y, mp.z + instanceInfo.center.z );
						var wp:Vector3D = collisionCandidate.modelToWorld( mpv );
						bang( wp );
						return;
					}
				}
			}
		}	
		
		private function bang( center:Vector3D ):void
		{
			instanceInfo.dead = true;
			for each ( var script:Script in _instanceInfo.scripts )
				script.dispose();

			Log.out( "Bomb.update - MODEL + WORLD BANG at x: " + center.x + " y: " + center.y + "  z: " + center.z );
			
			Globals.g_app.dispatchEvent( new ImpactEvent( ImpactEvent.EXPLODE, center, oxel.gc.grain * 16, oxel.gc.grain, instanceInfo.instanceGuid ) );
			
			SoundBank.playSound( SoundBank.getSound( _soundFile ) );
		}
	}
}
