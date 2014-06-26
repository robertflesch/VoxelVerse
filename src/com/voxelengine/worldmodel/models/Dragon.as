/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.worldmodel.models.CameraLocation;
	import com.voxelengine.worldmodel.models.CollisionPoint;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.geom.Matrix3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ShipEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class Dragon extends Beast 
	{
		public function Dragon( ii:InstanceInfo, mi:ModelInfo ) { 
			super( ii, mi );
			
			//MouseKeyboardHandler.backwardEnabled = false;
			
			processJsonInfo();
			
			instanceInfo.usesCollision = true;
			//usesGravity = true;
			collisionMarkers = true;
		}

		private	function processJsonInfo():void {
			if ( modelInfo.json && modelInfo.json.model )
			{
				var beastInfo:Object = modelInfo.json.model.beast;
				if ( beastInfo.moveSpeed)
				{
					mMoveSpeed = beastInfo.moveSpeed/10000;
				}
				else
					mMoveSpeed = mMoveSpeed/10000;
				
				if ( beastInfo.maxTurnRate )
				{
					mMaxTurnRate = beastInfo.maxTurnRate * 100;
				}
				else
					// This should be around 10,000
					mMaxTurnRate = mMaxTurnRate * 100;
				
				if ( beastInfo.maxClimbAngle )
				{
					mMaxClimbAngle = beastInfo.maxClimbAngle;
				}
				
				if ( beastInfo.clipFactor )
				{
					clipVelocityFactor = beastInfo.clipFactor/100;
				}
				else
					clipVelocityFactor = clipVelocityFactor/100;
					
				if ( beastInfo.climbRate )
				{
					mClimbRate = beastInfo.climbRate/100;
				}
				else
					mClimbRate = mClimbRate / 100;
					
				if ( beastInfo.maxSpeed )
				{
					mMaxSpeed = beastInfo.maxSpeed;
				}
					
				if ( beastInfo.seatLocation.x && beastInfo.seatLocation.y && beastInfo.seatLocation.z )
				{
					_seatLocation.setTo( beastInfo.seatLocation.x, beastInfo.seatLocation.y, beastInfo.seatLocation.z );
				}
			}
			else
				trace( "Dragon - NO Dragon Json INFO FOUND" );
		}
		
		override protected function collisionPointsAdd():void {
			// TO DO Should define this in meta data??? RSF or using extents?
			
			var sizeOxel:Number = oxel.gc.size() / 2;
			_ct.addCollisionPoint( new CollisionPoint( FALL, new Vector3D( sizeOxel, -16, 0 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( sizeOxel, -15, 0 ) ) ); // foot
			/*
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel, -20 ) ) ); //beak
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel, 65 ) ) ); // tail
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel * 2.5, sizeOxel ) ) ); //top/avatar -0 should I add this when mounted?
			
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( 0, sizeOxel, sizeOxel ) ) ); // left side
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel * 2, sizeOxel, sizeOxel ) ) ); // right side
			/*
			// note if I added these in from children, then I could get postion from children each frame...
			_ct.addCollisionPoint( new CollisionPoint( WING_TIP, new Vector3D( -55, sizeOxel, sizeOxel ) ) ); // left wing tip
			_ct.addCollisionPoint( new CollisionPoint( WING_TIP, new Vector3D( 80, sizeOxel, sizeOxel ) ) ); // right wing tip
			_ct.addCollisionPoint( new CollisionPoint( WING, new Vector3D( -25, sizeOxel, sizeOxel ) ) ); // left wing
			_ct.addCollisionPoint( new CollisionPoint( WING, new Vector3D( 45, sizeOxel, sizeOxel ) ) ); // right wing
			*/
			//_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, -6, 0 ) ) ); // bottom
		}

		override protected function cameraAddLocations():void {
			camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT + 20, 0) );
			camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT + 20, 50) );
			camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT + 30, 80) );
			//camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT - 40, 50) );
			camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT, 100) );
			camera.addLocation( new CameraLocation( true, 16, Globals.AVATAR_HEIGHT, 250) );
		}
		
		override protected function setAnimation():void	{
			
			var climbFactor:Number = ( mMaxClimbAngle + instanceInfo.rotationGet.x) / mMaxClimbAngle;
			if ( onSolidGround )
			{
				updateAnimations( "Walk", 0.5 );
				instanceInfo.velocityReset();
				stateLock( true, 500 );
			}
			else if ( mStallSpeed > instanceInfo.velocityGet.z )
			{
				updateAnimations( "Land", 0.5 );
				clipVelocityFactor = 0.95;
			}
			else if ( -5 > instanceInfo.rotationGet.x )
			{
				updateAnimations( "Fly", 1 - climbFactor );
				mSpeedMultiplier = 0.35;
				//clipVelocityFactor = 0.95;
			}
			else if ( 15 < instanceInfo.rotationGet.x )
			{
				stateSet( "Dive" );
				clipVelocityFactor = 1;
				mSpeedMultiplier = 1;
			}
			// Be fun to make this have the avatar put their arms out to the side
			else	
			{
				clipVelocityFactor = 0.995;
				if ( mForward )
				{
					updateAnimations( "Fly", 0.5 );
					mSpeedMultiplier = 0.50;
				}
				else
				{
					stateSet( "Glide" );
					mSpeedMultiplier = 0.50;
				}
			}
		}

		override public function takeControl( $modelLosingControl:VoxelModel, $addAsChild:Boolean = true ):void {
			//Log.out( "Dragon.takeControl - starting position: " + $vm.instanceInfo.positionGet );
			super.takeControl( $modelLosingControl, $addAsChild );
			$modelLosingControl.stateSet( "Ride");
			$modelLosingControl.stateLock( true );
		}
	
		override public function loseControl($modelDetaching:VoxelModel, $detachChild:Boolean = true):void {
			super.loseControl( $modelDetaching, $detachChild );
			$modelDetaching.stateLock( false );
		}
	
		override public function updateVelocity( $elapsedTimeMS:int, $clipFactor:Number ):Boolean
		{
			var changed:Boolean = false;
			
			// if app is not active, we still need to clip velocitys, but we dont need keyboard or mouse movement
			if ( this == Globals.controlledModel && Globals.active )
			{
				var vel:Vector3D = instanceInfo.velocityGet;
				var speedVal:Number = instanceInfo.speed( $elapsedTimeMS ) / 4;
				
				// Add in movement factors
				if ( MouseKeyboardHandler.forward )	{ 
					if ( instanceInfo.velocityGet.length < mMaxSpeed )
					{
						instanceInfo.velocitySetComp( 0, 0, vel.z + speedVal ); 
						changed = true; 
						mForward = true; }
				}
				else	
					{ mForward = false; }
				if ( MouseKeyboardHandler.backward )	{ instanceInfo.velocitySetComp( vel.x, vel.y, vel.z - speedVal ); changed = true; }
				if ( onSolidGround )
				{
					// Only allow slide left and right when on ground
					if ( MouseKeyboardHandler.leftSlide )	{ instanceInfo.velocitySetComp( vel.x + speedVal, vel.y, vel.z ); changed = true; }
					if ( MouseKeyboardHandler.rightSlide )	{ instanceInfo.velocitySetComp( vel.x - speedVal, vel.y, vel.z ); changed = true; }
				}
				else
				{
					if ( MouseKeyboardHandler.down )	  	{ instanceInfo.velocitySetComp( vel.x, vel.y + speedVal, vel.z ); changed = true; }
				}
				if ( MouseKeyboardHandler.up )          { instanceInfo.velocitySetComp( vel.x, vel.y - speedVal, vel.z ); changed = true; }
			}
			
			/*
			if ( !onSolidGround && instanceInfo.usesCollision && this == Globals.controlledModel )
			{
				if ( mStallSpeed > instanceInfo.velocityGet.z && instanceInfo.velocityGet.length < mMaxSpeed  )
				{
					//Log.out( "Dragon.updateVelocity - stalled: " + instanceInfo. velocityGet.y + "  time: " + $elapsedTimeMS + "  tval: " + 0.0033333333333333 * $elapsedTimeMS );
					if ( mMaxFallRate > instanceInfo.velocityGet.y )
						instanceInfo.velocitySetComp( instanceInfo.velocityGet.x, instanceInfo.velocityGet.y + (0.001 * $elapsedTimeMS), instanceInfo.velocityGet.z );
				}
			}
			*/
			
			// clip factor can scale quickly when diving.
			// so if it increases the speed, make sure speed is not over max
			if ( $clipFactor < 1 )
				instanceInfo.velocityScaleBy( $clipFactor );
			else
			{
				if ( instanceInfo.velocityGet.length < mMaxSpeed ) 				
					instanceInfo.velocityScaleBy( $clipFactor );
			}
			
			instanceInfo.velocityClip();
			
			//trace( "InstanceInfo.updateVelocity: " + velocity );
			return changed;	
		}
	}
}
