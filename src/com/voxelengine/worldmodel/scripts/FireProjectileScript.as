/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.pools.ProjectilePool;
	import com.voxelengine.worldmodel.models.ModelManager;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import flash.geom.Vector3D;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	
	import com.voxelengine.events.ProjectileEvent;
	import com.voxelengine.events.WeaponEvent;
	import com.voxelengine.pools.ParticlePool;
	import com.voxelengine.worldmodel.weapons.*;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.worldmodel.models.ModelTransform;
	import com.voxelengine.worldmodel.SoundBank;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.ModelInfo;
	//import org.flintparticles.common.events.ParticleEvent;

	public class FireProjectileScript extends Script 
	{
		public function FireProjectileScript() 
		{
			Globals.g_app.addEventListener( WeaponEvent.FIRE, onFire );
			Globals.g_app.addEventListener( ProjectileEvent.PROJECTILE_CREATED, createProjectile );
		}
		
		// TODO - Is there anyway that this is removed? and listeners are removed?
		
		public function onFire( $event:WeaponEvent ):void 
		{
			// This gun listens for a WeaponEvent.FIRE, that means that a weapon has been fired
			// make sure its the owner of this weapon that fired it. so that correct position info, etc can be determined
			if ( instanceGuid != $event.instanceGuid )
			{
				trace( "FireProjectileScript.onFire - ignoring event for someone else" + $event + " modelGuid: " + instanceGuid );
				return;
			}
			
			//Log.out( "FireProjectileScript.onFire - EVENT: " + WeaponEvent.FIRE );
			// this calculates the bullets starting position.
			// That is determined by the guns location, and rotation, and by its parents location and rotation
			
			// first we calculate the location of the end of the barrel
			const gunModel:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
			if ( gunModel )
			{
				// What was I thinking here?
				//var gunMSLocation:Vector3D = gunModel.positionGetWithParent;
				var gunMSLocation:Vector3D = gunModel.instanceInfo.positionGet
				var gunMSCenterLocation:Vector3D = gunMSLocation.add( gunModel.instanceInfo.center );

				// now we have to determine the starting location of the bullet 
				// size of bullet
				var ammo:Ammo = $event.ammo;
				var bulletG0:int = 1 << ammo.grain;
				// Why is "Y" over 4, but rest are over 2?
				var bulletCenter:Vector3D  = new Vector3D ( bulletG0/2, bulletG0/4, bulletG0/2 );
				var bulletMSLocation:Vector3D = gunMSCenterLocation.subtract( bulletCenter );
				
				var bulletWSLocation:Vector3D;
				if ( gunModel.instanceInfo.controllingModel )
				{
					var shipModel:VoxelModel = gunModel.instanceInfo.controllingModel;
					if ( shipModel )
					{
						// adjust the bullets starting location based on parents rotation
						//trace( "pre " + bulletMSLocation );
						//bulletWSLocation = shipModel.instanceInfo.worldSpaceMatrix.deltaTransformVector( bulletMSLocation );
						bulletWSLocation = shipModel.modelToWorld( bulletMSLocation );
						//trace( "pst " + bulletWSLocation );
					}
					else
						bulletWSLocation = gunModel.modelToWorld( bulletMSLocation );
				}
				else
					bulletWSLocation = gunModel.modelToWorld( bulletMSLocation );


				var dr:Vector3D = new Vector3D(0, 0, -1);
				dr = gunModel.deltaTransformVector( dr );
				
				// dont handle event directly, since then I will generate event at same times as everyone else.
				var pe:ProjectileEvent = new ProjectileEvent( ProjectileEvent.PROJECTILE_SHOT );
				pe.ammo = ammo.clone();
				pe.owner = gunModel.instanceInfo.instanceGuid;
				pe.position = bulletWSLocation;
				pe.direction = dr;
				
				Globals.g_app.dispatchEvent( pe );
				//Log.out( "FireProjectileScript.onFire - dispatchEvent: " + pe );
				
				SoundBank.playSound( SoundBank.getSound( ammo.launchSoundFile ) );
			}
		}
		
		static public function createProjectile( pe:ProjectileEvent ):void
		{
			var ownerGuid:String = pe.owner;
			var gunModel:VoxelModel = Globals.g_modelManager.getModelInstance( ownerGuid );
			if ( gunModel && gunModel.instanceInfo.controllingModel )
			{
				var cm:VoxelModel = gunModel.instanceInfo.controllingModel;
				var parentVelocity:Vector3D = cm.instanceInfo.worldSpaceMatrix.deltaTransformVector( cm.instanceInfo.velocityGet );
			}
			
			if ( 1 == pe.ammo.type )
			{
					bulletPool( pe, parentVelocity );

			}
			else if ( 2 == pe.ammo.type )
			{
				var count:int = pe.ammo.count;
				for ( var i:int = 0; i < count; i++ )
				{
					bulletPool( pe, parentVelocity );
				}
				
			}
			var mm:ModelManager = Globals.g_modelManager;
			//Log.out( "bulletPool.createProjectile" );
		}
		
		static private function bulletPool( pe:ProjectileEvent, parentVelocity:Vector3D ):void
		{
			var pm:Projectile = ProjectilePool.poolGet();
			// Arrg - particles just contain place holder oxel the first time when first created.
			// So any changes are wiped away once the actual model loads.
			
			pm.instanceInfo.usesCollision = true;
			pm.ammo = pe.ammo;
			
			var grainChange:int = pe.ammo.grain - pm.oxel.gc.grain;
			pm.changeGrainSize( grainChange );
//			trace( "bulletPool: changing type to: " + Globals.Info[pe.ammo.oxelType].name );
			pm.oxel.changeAllButAirToType( pe.ammo.oxelType );
			
			pm.instanceInfo.positionSet = pe.position;
//			Log.out( "FireProjectileScript.bulletPool ProjectileEvent: " + pe );
			var dr:Vector3D = pe.direction.clone();
			var accuracy:Number = pe.ammo.accuracy;
			
			if ( 0.5 < Math.random() )
				dr.x += Math.random() * accuracy;
			else
				dr.x -= Math.random() * accuracy;
				
			if ( 0.5 < Math.random() )
				dr.y += Math.random() * accuracy;
			else
				dr.y -= Math.random() * accuracy;
				
			if ( 0.5 < Math.random() )
				dr.z += Math.random() * accuracy;
			else
				dr.z -= Math.random() * accuracy;
			
			dr.scaleBy( -pe.ammo.velocity );

			if ( parentVelocity )
			{
//				Log.out( "FireProjectileScript.bulletPool PRE - direction: " + dr + "  parentModel: " + parentVelocity );
				dr = dr.add( parentVelocity );
//				Log.out( "FireProjectileScript.bulletPool PST - direction: " + dr + "  parentModel: " + parentVelocity );
			}
			else
				Log.out( "FireProjectileScript.bulletPool - direction: " + dr );
				
			pm.instanceInfo.addTransform( dr.x, dr.y, dr.z, ModelTransform.INFINITE_TIME, ModelTransform.LOCATION, Projectile.PROJECTILE_VELOCITY );
			//pm.instanceInfo.addTransform( 0, Globals.GRAVITY, 0, ModelTransform.INFINITE_TIME, ModelTransform.LOCATION, "Gravity" );
			pm.instanceInfo.addTransform( 0, 0, 0, pe.ammo.life, ModelTransform.LIFE );
			//pm.instanceInfo.addTransform( 0, 0, 0.1, ModelTransform.INFINITE_TIME, ModelTransform.ROTATION_STRING );
			
			// add this particle to the system, it will get returned to pool when it dies.
			Globals.g_modelManager.modelAdd( pm );
			
		}
	}
}