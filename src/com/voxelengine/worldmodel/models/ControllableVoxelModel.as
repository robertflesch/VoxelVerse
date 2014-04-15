/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.worldmodel.oxel.GrainCursorIntersection;
	import flash.display3D.Context3D;
    import flash.geom.Vector3D;
	import flash.utils.getTimer;
	import flash.geom.Matrix3D;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;	
	
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.*;
	import com.voxelengine.worldmodel.models.*
	import com.voxelengine.events.CollisionEvent;
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.events.ShipEvent;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class ControllableVoxelModel extends VoxelModel 
	{
		static protected const SHIP_VELOCITY:String 			= "velocity"
		static protected const SHIP_ALTITUDE:String 			= "altitude"
		static protected const SHIP_ROTATION:String 			= "rotation"
		static protected const MIN_COLLISION_GRAIN:int 			= 2;
		static public 	const 	BODY:String						= "BODY";
		// scratch objects to save on allocation of memory
		//private static const _sZERO_VEC:Vector3D 				= new Vector3D();
		protected static var _sScratchVector:Vector3D			= new Vector3D();
		protected static var _sScratchMatrix:Matrix3D			= new Matrix3D();
		
		protected var _gravityScalar:Vector3D 					= new Vector3D(0, -1, 0);
		protected var _ct:CollisionTest							= null;
		protected var _collisionCandidates:Vector.<VoxelModel> 	= null;
		protected var _displayCollisionMarkers:Boolean 			= false
		protected var _leaveTrail:Boolean 						= false
		protected var _forward:Boolean 							= false

		private var		_maxFallRate:Attribute 					= new Attribute( 5 );
		private var   	_maxSpeed:Attribute 					= new Attribute( 15 );
		private var   	_speedMultiplier:Number 				= 0.5;

		
		public function get 	mMaxSpeed():Number 						{ return (_maxSpeed.val * _speedMultiplier); }
		public function set 	mMaxSpeed($value:Number):void 			{ _maxSpeed.val = $value; }
		protected function get 	mSpeedMultiplier():Number 				{ return _speedMultiplier; }
		protected function set 	mSpeedMultiplier($value:Number):void	{ _speedMultiplier = $value; }
		protected function get 	mMaxFallRate():Number 					{ return _maxFallRate.val; }
		protected function set 	mMaxFallRate($value:Number):void 		{ _maxFallRate.val = $value; }
		
		protected function get 	mForward():Boolean 						{ return _forward; }
		protected function set 	mForward($val:Boolean):void 			{ _forward = $val; }
		
		
		public function ControllableVoxelModel( ii:InstanceInfo, mi:ModelInfo ):void 
		{
			super( ii, mi );
			Globals.g_app.addEventListener( ShipEvent.THROTTLE_CHANGED, throttleEvent, false, 0, true );
			Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildAdded );
			Globals.g_app.addEventListener( GUIEvent.APP_DEACTIVATE, onDeactivate );
			Globals.g_app.addEventListener( GUIEvent.APP_ACTIVATE, onActivate );
			_ct = new CollisionTest( this );
		}

		protected function onDeactivate( e:GUIEvent ):void 
		{
			
		}
		protected function onActivate( e:GUIEvent ):void 
		{
			stateLock( false );
			stateSet( "" );
		}
		
		override public function release():void
		{
			super.release();
			Globals.g_app.removeEventListener( ShipEvent.THROTTLE_CHANGED, throttleEvent );
			Globals.g_app.removeEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildAdded );
			Globals.g_app.removeEventListener( GUIEvent.APP_DEACTIVATE, onDeactivate );
			Globals.g_app.removeEventListener( GUIEvent.APP_ACTIVATE, onActivate );
			
		}
		protected function collisionPointsAdd():void {
			// TO DO Should define this in meta data??? RSF or using extents?
			
			var sizeOxel:Number = oxel.gc.size() / 2;
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel, 0 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel, sizeOxel*2 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( 0, sizeOxel, sizeOxel ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel*2, sizeOxel, sizeOxel ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, 0, sizeOxel ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( sizeOxel, sizeOxel*2, sizeOxel ) ) );
		}

		override protected function oxelLoaded():void
		{
			collisionPointsAdd();
			if ( _displayCollisionMarkers )
				_ct.markersAdd();
		}		
		
		protected function onChildAdded( me:ModelEvent ):void
		{
			if ( me.parentInstanceGuid != instanceInfo.instanceGuid )
				return;
				
//			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( me.ownerGuid );
		}
		
		protected function throttleEvent( event:ShipEvent ):void
		{
			if ( event.instanceGuid != instanceInfo.instanceGuid )
				return;
				
			//Log.out( "Ship.throttleEvent - val: " + event.value );
			
			var val:Number = -event.value;
			if ( -0.05 < val && val < 0.05 )
			{
				stopEngines();
			}
			else
			{
				startEngines( val );
			}
		}
		
		override public function collisionTest( $elapsedTimeMS:Number ):Boolean {
			
			//if ( this === Globals.controlledModel )
			if ( instanceInfo.usesCollision )
			{
				// check to make sure the ship or object you were on was not destroyed or removed
				//if ( lastCollisionModel && lastCollisionModel.instanceInfo.dead )
					//lastCollisionModelReset();
				
				if ( false == controlledModelChecks( $elapsedTimeMS ) )
				{
					setAnimation();
					return false;
				}
				else
					setAnimation();
			}
			
			return true;
		}
		
		protected function setAnimation():void
		{
		}
		
		protected function handleMouseMovement( $elapsedTimeMS:int ):void {
			throw new Error( "ControllableVoxelModel.handleMouseMovement - NEEDS TO BE OVERRIDEN" );
		}
		
		//static var temp:int = 0;
		override public function update($context:Context3D, $elapsedTimeMS:int):void {
			
			if ( this === Globals.controlledModel )
			{
				handleMouseMovement( $elapsedTimeMS );
			}
			super.update($context, $elapsedTimeMS);
			
			camera.positionSet = instanceInfo.positionGet;
			//camera.scale = instanceInfo.scale;
			// track not copied intentionally
			// Y Axis ok, X is wrong
			camera.center.setTo( instanceInfo.center.x, instanceInfo.center.y, instanceInfo.center.z );
			//var ccenter:Vector3D = camera.current.position;
			//camera.center.setTo( instanceInfo.center.x + ccenter.x, instanceInfo.center.y + ccenter.y, instanceInfo.center.z + ccenter.z );
			
			if ( leaveTrail )
				leaveTrailMarkers();
				
			//if ( 20 <= temp )
			//{
				//Log.out( "ControllableVoxelModel.update - ii position: " + instanceInfo.positionGet + "  cam position: " + camera.positionGet );
				//temp = 0;
			//}
			//temp++;
		}
		
		protected function collidedHandler( event:CollisionEvent ):void
		{
			if ( event.instanceGuid != this.instanceInfo.instanceGuid )
				return;
		
			if ( this == Globals.controlledModel )
				return;
				
			//turn off collision, figure a safe route out, take it!
			escapeHandler();
		}
		
		protected function escapeHandler():void
		{
			Log.out( "ControllableVoxelModel.escapeHandler - GET THE HELL OUT OF HERE" );
		}
		
		override public function setTargetLocation( $loc:Location ):void 
		{
			/*
			 * This is all current broken - not sure what it does, but I think it transfers the motion of the collision model to the player
			if ( lastCollisionModel )
			{
				// Add into your position, the change due to the change in ships position
				// this takes into account gravity. I am really only trying to maintain the x,z here.
				// except for when I have a UP transform.
				loc.positionSet = lastCollisionModel.modelToWorld( positionGetOld );
				// if we dont use this, then we dont get benifit of gravity
				//worldSpaceTargetPosition.y = _worldSpacePosition.y;
				
				// Add into your rotation, the change due to the change in ships rotation
				var rotDiff:Vector3D = lastCollisionModel.instanceInfo.rotationGet.subtract( rotationGetOld );
				if ( false == _sZERO_VEC.nearEquals( rotDiff, 0.01 ) )
					rotationSet = rotationGet.subtract( rotDiff );
			}
			*/
			
			// clamp player mouse rotation
			if ( $loc.rotationGet.x >= 90 )
				$loc.rotationSet = new Vector3D( 89.99, $loc.rotationGet.y, $loc.rotationGet.z );
			else if ( $loc.rotationGet.x <= -90 )
				$loc.rotationSet = new Vector3D( -89.99, $loc.rotationGet.y, $loc.rotationGet.z );
			
			// If you are are on solid ground, you cant change the angle of the avatar( or controlled object ) 
			// other then turning right and left
			_sScratchMatrix.identity();
			if ( !onSolidGround )
				_sScratchMatrix.appendRotation( -$loc.rotationGet.x, Vector3D.X_AXIS );
			_sScratchMatrix.appendRotation( -$loc.rotationGet.y,   Vector3D.Y_AXIS );
			
			var dvMyVelocity:Vector3D = _sScratchMatrix.transformVector( $loc.velocityGet );
			if ( dvMyVelocity.length )
			{
				_sScratchVector.setTo( $loc.positionGet.x, $loc.positionGet.y, $loc.positionGet.z );
				_sScratchVector.decrementBy( dvMyVelocity );
				$loc.positionSet = _sScratchVector;
			}
			
			//Log.out( "ControllableVoxelModel.calculateTargetPosition - worldSpaceTargetPosition: " + worldSpaceTargetPosition );
		}
		
		public function fall( $loc:Location, $elapsedTimeMS:int ):void
		{
			//Log.out( "Fall PRE: " + $loc.velocityGet.y );
			if ( mMaxFallRate > $loc.velocityGet.y )
				$loc.velocitySetComp( $loc.velocityGet.x, $loc.velocityGet.y + (0.0033333333333333 * $elapsedTimeMS) + 0.5, $loc.velocityGet.z );
			//Log.out( "Fall PST: " + $loc.velocityGet.y );
		}

		public function jump( mutliplier:Number = 1 ):void
		{
			//Log.out( "Jump PRE: " + instanceInfo.velocityGet.y );
			instanceInfo.addTransform( 0, -8 * mutliplier, 0, 0.1, ModelTransform.VELOCITY );
			//Log.out( "Jump PST: " + instanceInfo.velocityGet.y );
		}

		protected function controlledModelChecks( $elapsedTimeMS:Number ):Boolean {
			// set our next position by adding in velocities
			// If there is no collision or gravity, this is where the model would end up.
			var loc:Location = new Location();
			loc.setTo( instanceInfo );
			setTargetLocation( loc );
			//Log.out( "CVM.controlledModelChecks - loc.positionSet: " + loc.positionGet );
			
			const STEP_UP_CHECK:Boolean = true;
			// does model have collision, if no collision, then why bother with gravity
			if ( instanceInfo.usesCollision )
			{
				var timer:int = getTimer();
				var test:GrainCursorIntersection;
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.FRONT);
				//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.BACK);
				//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.LEFT);
				//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.RIGHT);
				//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.UP);
				//if ( test )
					//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
				//else	
					//Log.out("CVM.test - findClosestIntersectionInDirection NO MODEL: " );
				//test = Globals.g_modelManager.findClosestIntersectionInDirection(ModelManager.DOWN);
				//Log.out("CVM.test - findClosestIntersectionInDirection point: " + test.point );
					
//				Log.out("CVM.test - findClosestIntersectionInDirection took: " + (getTimer() - timer));
				
				
				_collisionCandidates = Globals.g_modelManager.whichModelsIsThisInfluencedBy( this )
				//trace( "collisionTest: " + _collisionCandidates.length )
				if ( 0 == _collisionCandidates.length )
				{
					if ( usesGravity )
					{
						fall( loc, $elapsedTimeMS );	
					}
					onSolidGround = false;
					instanceInfo.setTo( loc );
				}
				else
				{
					for each ( var collisionCandidate:VoxelModel in _collisionCandidates )
					{
						// if it collided or failed to step up
						// restore the previous position

						
						var restorePoint:int = collisionCheckNew( $elapsedTimeMS, loc, collisionCandidate, STEP_UP_CHECK )
						if ( -1 < restorePoint )
						{
							Globals.g_app.dispatchEvent( new CollisionEvent( CollisionEvent.COLLIDED, this.instanceInfo.instanceGuid ) );
							instanceInfo.restoreOld( restorePoint );
							instanceInfo.velocityReset();
							return false;
						}
						// New position is valid
						else
							instanceInfo.setTo( loc );
					}
				}
			}
			else
				instanceInfo.setTo( loc );
			
			return true;
		}
		
		/*
		 * Checks whether this $loc is valid, meaning none of the object's collision points
		 * are in a solid oxel. This is the most basic approach. The model just stops if it collides.
		 * $loc: 				Copy of the avatar's location object
		 * $collisionCandidate: The voxel model to collide with
		 * $stepUpCheck: 		True if the model should try to step up after colliding (Player Only)
		 * returns -1 if new position is valid, returns 0-2 if there was collision
		 * 0-2 is the number of steps back to take in position queue
		*/ 
		
		protected function collisionCheckNew( $elapsedTimeMS:Number, $loc:Location, $collisionCandidate:VoxelModel, $stepUpCheck:Boolean = false ):int {
			//Log.out( "ControllableVoxelModel.collisionCheckNew - ENTER" );
			// reset all the points to be in a non collided state
			if ( _ct.hasPoints() )
			{
				_ct.setValid();
				var points:Vector.<CollisionPoint> = _ct.collisionPoints();
				for each ( var cp:CollisionPoint in points )
				{
					// takes the CollisionPoint's point which is in model space, and puts it in world space
					var posWs:Vector3D = $loc.modelToWorld( cp.point );
					// pass in the world space coordinate to get back whether the oxel at the location is solid
					$collisionCandidate.isSolidAtWorldSpace( cp, posWs, MIN_COLLISION_GRAIN );
					// if collided, increment the count on that collision point set
					if ( true == cp.collided )
					{
						return 1;
					}
				}
			}
			// if no points or no collision, return -1 success!
			return -1;
		}
		
		protected function startEngines( val:Number, name:String = "" ):void
		{
		}
		
		protected function stopEngines():void
		{
		}
		
		// This is for direct control of model, such as in the voxel bomber.
		override protected function onKeyDown(e:KeyboardEvent):void 
		{
			super.onKeyDown( e );
			switch (e.keyCode) {
				case 87: case Keyboard.UP:
					throttleEvent( new ShipEvent( ShipEvent.THROTTLE_CHANGED, _instanceInfo.instanceGuid, _accelRate ) );
					break;
				case 83: case Keyboard.DOWN: 
					throttleEvent( new ShipEvent( ShipEvent.THROTTLE_CHANGED, _instanceInfo.instanceGuid, -_accelRate ) );
					break;
			}
        }
		
		private var  	count:int 			= 0;
		private function leaveTrailMarkers():void
		{
			if ( 0 == count % 20 )
			{
				// Take the center of the oxel, and collide around it
				var offsetMatrix:Matrix3D = instanceInfo.worldSpaceMatrix.clone()
				var centerLoc:Vector3D = instanceInfo.center;
				offsetMatrix.prependTranslation( centerLoc.x, 0, centerLoc.z );
				var wsCenter:Vector3D =  offsetMatrix.position;
				
				var trailMarker:InstanceInfo = new InstanceInfo();
				trailMarker.templateName = "1MeterRedBlock";
				trailMarker.dynamicObject = true;
				trailMarker.scale = new Vector3D( 0.25, 0.25, 0.25 );
				trailMarker.positionSet = wsCenter;
				trailMarker.addTransform( 0, 0, 0, 10, ModelTransform.LIFE );
				
				Globals.g_modelManager.create( trailMarker );
			}
			count++;
		}
		
		public function get leaveTrail():Boolean 
		{
			return _leaveTrail;
		}
		
		public function set leaveTrail(value:Boolean):void 
		{
			_leaveTrail = value;
		}
		
		public function get collisionMarkers():Boolean 
		{
			return _displayCollisionMarkers;
		}
		
		public function set collisionMarkers($value:Boolean):void 
		{
			if ( $value )
				_ct.markersAdd();
			else
				_ct.markersRemove();

			_displayCollisionMarkers = $value;
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
						instanceInfo.velocitySetComp( vel.x, vel.y, vel.z + speedVal ); 
						changed = true; 
						mForward = true; }
				}
				else	
					{ mForward = false; }
				if ( MouseKeyboardHandler.backward )	{ instanceInfo.velocitySetComp( vel.x, vel.y, vel.z - speedVal ); changed = true; }
				if ( MouseKeyboardHandler.leftSlide )	{ instanceInfo.velocitySetComp( vel.x + speedVal, vel.y, vel.z ); changed = true; }
				if ( MouseKeyboardHandler.rightSlide )	{ instanceInfo.velocitySetComp( vel.x - speedVal, vel.y, vel.z ); changed = true; }
				if ( MouseKeyboardHandler.down )	  	{ instanceInfo.velocitySetComp( vel.x, vel.y + speedVal, vel.z ); changed = true; }
				if ( MouseKeyboardHandler.up )
				{
					if ( Globals.controlledModel && Globals.controlledModel.usesGravity )
					{
						// Idea here is to keep the player from jumping unless their feet are on the ground.
						// If you wanted to add rocket boots, this is where is what it would effect
						if ( onSolidGround )
						{
							jump( 2 );
							changed = true;
						}
					}
					else 
					{
						instanceInfo.velocitySetComp( vel.x, vel.y - speedVal, vel.z )
						changed = true;
					}
				}
			}
			
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
