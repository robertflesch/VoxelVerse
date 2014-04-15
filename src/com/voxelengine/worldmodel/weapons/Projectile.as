/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.weapons
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.ParticlePool;
	import com.voxelengine.pools.ProjectilePool;
	import com.voxelengine.worldmodel.scripts.ImpactScript;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.ImpactEvent;
	import com.voxelengine.worldmodel.scripts.ScriptLibrary;
	
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import com.voxelengine.worldmodel.SoundBank;
	
	import com.voxelengine.pools.GrainCursorPool;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Projectile extends VoxelModel 
	{
		static public var PROJECTILE_VELOCITY:String = "ProjectileVelocity";
		
		private var _ammo:Ammo 						= null;		
		//private var _soundFile:String 				= "CannonBallBounce.mp3";		
		//private var _soundFileExplode:String 		= "CannonBallExploding.mp3";		
		private var _thatWhichCreatedYou:VoxelModel = null;
		//private var _explosionRadius:int 			= 16; // oxel.gc.grain * 8
		//private var _explosionMin:int 				= 2; // oxel.gc.grain * 2
		//
		public function Projectile( $instanceInfo:InstanceInfo, $mi:ModelInfo ) 
		{ 
			super( $instanceInfo, $mi );
			instanceInfo.dynamicObject = true;
		}
		
		public function set ammo( $ammo:Ammo ):void
		{
			_ammo = $ammo;
//			SoundBank.getSound( _soundFile ); // Preload the sound file
			SoundBank.getSound( _ammo.impactSoundFile ); // Preload the sound file

			//if ( instanceInfo.controllingModel )
			//	_thatWhichCreatedYou = $thatWhichCreatedYou;
//			_explosionRadius = oxel.gc.size() * 4; // oxel.gc.grain * 8
//			_explosionMin = oxel.gc.size(); // oxel.gc.grain * 2
		}
		
		/*
		override public function bounce( mt:ModelTransform, collisionCandidate:VoxelModel ):void
		{
			var startPoint:Vector3D = instanceInfo.position.clone();
			startPoint.x += -100 * mt.delta.x;
			startPoint.y += -100 * mt.delta.y;
			startPoint.z += -100 * mt.delta.z;
			
			var worldSpaceIntersections:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
			collisionCandidate.lineIntersectWithChildren( startPoint, instanceInfo.position, worldSpaceIntersections, oxel.gc.bound );
			if ( worldSpaceIntersections.length )
			{
				var gci:GrainCursorIntersection = worldSpaceIntersections.shift();
				// reverse on the plane that intersects
				switch( gci.axis )
				{
					case 0: // x
						mt.delta.x = -mt.delta.x;
						break;
					case 1:
						mt.delta.y = -mt.delta.y;
						break;
					case 2:
						mt.delta.z = -mt.delta.z;
						break;
				}
			}
		}		
		*/
		override public function collisionTest( $elapsedTimeMS:Number ):Boolean {
			
			var modelList:Vector.<VoxelModel> = Globals.g_modelManager.whichModelsIsThisInsideOf( this )
			for each ( var collisionCandidate:VoxelModel in modelList )
			{
				if ( _thatWhichCreatedYou && _thatWhichCreatedYou.isInParentChain( collisionCandidate ) )
					continue;
				
				var projectileWSPosition:Vector3D = instanceInfo.positionGet;
				if ( instanceInfo.controllingModel )
					projectileWSPosition = projectileWSPosition.add( instanceInfo.controllingModel.instanceInfo.positionGet );
				//trace( "Projectile.update projectileWSPosition: " + projectileWSPosition );
				//var mp:Vector3D = collisionCandidate.worldToModel( instanceInfo.position );
				var msp:Vector3D = collisionCandidate.worldToModel( projectileWSPosition );
				//trace( "Projectile.update projectileMSPosition: " + msp );
				
				//trace( "Projectile.update collisionCandidateWSPosition: " + collisionCandidate.instanceInfo.position + "   with model: " + collisionCandidate.instanceInfo.name );
				
				var isPassable:Boolean = collisionCandidate.isPassable( msp.x, msp.y, msp.z, oxel.gc.grain );
				if ( !isPassable )
				{
					// so we hit something, depending on what it is, we will do different things
					// for example a ballon ALWAYS bounces off a projectile.
					//if ( Globals.BALLOON == fo.type )
					//{
						//bounce( collisionCandidate, this );
						//SoundBank.playSound( SoundBank.getSound( _soundFile ) );

					//}
					//else
					{
						var mpv:Vector3D = new Vector3D( msp.x + instanceInfo.center.x, msp.y + instanceInfo.center.y, msp.z + instanceInfo.center.z );
						var wsLoc:Vector3D = collisionCandidate.modelToWorld( mpv );
						var script:ImpactScript = instanceInfo.addScript( _ammo.contactScript, _ammo ) as ImpactScript;
						script.impact( wsLoc );

						return false;
					}
				}
				
			}
			
			return true;
		}

		// Since these stick around in the pools, we dont want to fully release them.
		override public function release():void 
		{
			//Log.out( "Projectile.release - guid: " + instanceInfo.instanceGuid );
			instanceInfo.dead = false;
			instanceInfo.removeAllTransforms();
			ProjectilePool.poolDispose( this );
		}
		
		override public function update( $context:Context3D, $elapsedTimeMS:int):void 
		{
			if ( instanceInfo.dead )
				return;
				
			super.update( $context, $elapsedTimeMS );
		}
		
	}
}
