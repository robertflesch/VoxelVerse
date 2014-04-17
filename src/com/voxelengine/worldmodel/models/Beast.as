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
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.geom.Matrix3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ShipEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class Beast extends ControllableVoxelModel 
	{
		static private const MIN_TURN_AMOUNT:Number = 0.02;
		
		// Trying to keep these numbers between 1 and 100
		private var   _climbRate:Attribute = new Attribute( 70 );
		private var   _moveSpeed:Attribute = new Attribute( 20 );
		private var	  _maxClimbAngle:Attribute = new Attribute( 45 );
		private var   _maxTurnRate:Attribute = new Attribute( 100 );
		private var   _stallSpeed:Attribute = new Attribute( 2 );
		
		protected var   _seatLocation:Vector3D =  new Vector3D( 8, 12, 13 );

		public function get mClimbRate():Number  				{ return _climbRate.val; }
		public function set mClimbRate($value:Number):void  	{ _climbRate.val = $value; }
		public function get mMoveSpeed():Number  				{ return _moveSpeed.val; }
		public function set mMoveSpeed($value:Number):void  	{ _moveSpeed.val = $value; }
		public function get mMaxClimbAngle():Number  			{ return _maxClimbAngle.val; }
		public function set mMaxClimbAngle($value:Number):void  { _maxClimbAngle.val = $value; }
		public function get mMaxTurnRate():Number  				{ return _maxTurnRate.val; }
		public function set mMaxTurnRate($value:Number):void  	{ _maxTurnRate.val = $value; }
		public function get mStallSpeed():Number 				{ return _stallSpeed.val; }
		public function set mStallSpeed($value:Number):void		{ _stallSpeed.val = $value; }
		
		static protected 	const 	TAIL:String					= "TAIL";
		static protected 	const 	WING:String					= "WING";
		static protected 	const 	WING_TIP:String				= "WING_TIP";
		static protected 	const 	FOOT:String					= "FOOT";
		static protected 	const 	FALL:String					= "FALL";
		
		public function Beast( ii:InstanceInfo, mi:ModelInfo ) { 
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
				trace( "Beast - NO Beast Json INFO FOUND" );
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
			camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT + 20, 0) );
			camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT + 20, 50) );
			camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT + 30, 80) );
			//camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT - 40, 50) );
			camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT + 40, 100) );
			camera.addLocation( new CameraLocation( false, 16, Globals.AVATAR_HEIGHT + 50, 250) );
		}
		
		override protected function collisionCheckNew( $elapsedTimeMS:Number, $loc:Location, $collisionCandidate:VoxelModel, $stepUpCheck:Boolean = false ):int {
			//Log.out( "ControllableVoxelModel.collisionCheckNew - ENTER" );
			// reset all the points to be in a non collided state
			if ( _ct.hasPoints() )
			{
				var wingTip:int = 0;
				var fall:int = 0;
				var foot:int = 0;
				var body:int = 0;
				var wing:int = 0;
				
				_ct.setValid();
				var points:Vector.<CollisionPoint> = _ct.collisionPoints();
				const LOOK_AHEAD:int = 10;
				var velocityScale:Number = $loc.velocityGet.z * LOOK_AHEAD;
				for each ( var cp:CollisionPoint in points )
				{
					if ( cp.scaled )
						cp.scale( velocityScale );
					// takes the CollisionPoint's point which is in model space, and puts it in world space
					var posWs:Vector3D = $loc.modelToWorld( cp.point );
					// pass in the world space coordinate to get back whether the oxel at the location is solid
					$collisionCandidate.isSolidAtWorldSpace( cp, posWs, MIN_COLLISION_GRAIN );
					// if collided, increment the count on that collision point set
					if ( true == cp.collided )
					{
						if ( FALL == cp.name ) fall++;
						else if ( FOOT == cp.name ) foot++;
						else if ( BODY == cp.name ) body++;
						else if ( WING_TIP == cp.name ) 
						{
							if ( !onSolidGround ) // ignore the wing points on the ground
								wingTip++;
						}
						else wing++;	
					}
				}
			}

			if ( !fall )
				onSolidGround = false;

			// only the point beneath the foot is touching
			if ( fall && !foot && !body )
			{
				//Log.out( "Beast.collsionCheckNew - Only fall point is true" );
				onSolidGround = true;
				$loc.velocityResetY();
			}
			// the foot is in a solid surface
			// get it out
			else if ( fall && foot && (!body || !wingTip || !wing) )
			{
				Log.out( "Beast.collsionCheckNew - Fall and Foot point is true" );
				onSolidGround = true;
				$loc.velocityResetY();

//				if (  5 > $loc.velocityGet.y )
				{
					//if ( 5 > $loc.velocityGet.length )
					{
						//Log.out( "Beast.collsionCheckNew - OK LAND" );
						// So I can see a problem here, what if I come in diagonally, and one collision point is stuck in a wall
						// and the other 3 in the floor.
						var co:Oxel = points[0].oxel;
						var no:Oxel = co.neighbor( Globals.POSY );
						// TODO how to handle children in no
						if ( no != Globals.BAD_OXEL )
						{
							//Log.out( "Beast.collisionCheckNew - Adjusting foot position" );
							var msCoord:int = no.gc.GetWorldCoordinate( Globals.AXIS_Y );
							var wsCoord:Vector3D = $collisionCandidate.modelToWorld( new Vector3D( 0, msCoord, 0 ) );
							$loc.positionSetComp( $loc.positionGet.x, wsCoord.y - points[0].point.y, $loc.positionGet.z );	
							return -1;
						}
					}
//					else
//						Log.out( "Beast.collsionCheckNew - MOVING TOO FAST TO LAND" );

				}
//				else
//					Log.out( "Beast.collsionCheckNew - FALLING TOO FAST TO LAND" );
					
				Log.out( "Beast.collisionCheckNew - Failed to adjust foot position" );
					
				
				return -1;
			}
			else if ( wingTip && !onSolidGround )
			{
				if ( points[0].collided )
				{
					Log.out( "Beast.collisionCheckNew - left wing TIP collided" );
					$loc.rotationSetComp( $loc.rotationGet.x,  $loc.rotationGet.y - 1, $loc.rotationGet.z )
					$loc.velocityScaleBy( 0.5 );
					return -1;
				}	
				else
				{
					Log.out( "Beast.collisionCheckNew - right wing TIP collided" );
					$loc.rotationSetComp( $loc.rotationGet.x,  $loc.rotationGet.y + 1, $loc.rotationGet.z )
					$loc.velocityScaleBy( 0.5 );
					return -1;
				}
				return 1;
				
			}
			else if ( wing && !onSolidGround )
				return 1;
			else if ( body )
				return 1;
				
			// return -1 success!
			return -1;
		}
		
		override public function update( $context:Context3D, $elapsedTimeMS:int):void {
			
			if ( this == Globals.controlledModel )
				handleMouseMovement( $elapsedTimeMS );
			
			super.update( $context, $elapsedTimeMS );
		}
		
		private var _dy:Number = 0;
		override protected function handleMouseMovement( $elapsedTimeMS:int ):void {
			if ( !Globals.mouseView && Globals.active && Globals.clicked ) 
			{
				var climbFactor:Number = ( mMaxClimbAngle + instanceInfo.rotationGet.x) / mMaxClimbAngle;
				var scaleFactor:Number = mClimbRate + climbFactor;
				// When you are climbing you can turn faster because you are going slower
				var effectiveTurnRate:Number = mMaxTurnRate * ( scaleFactor )
				instanceInfo.moveSpeed = mMoveSpeed * scaleFactor;
				var dx:Number
				dx = MouseKeyboardHandler.getMouseYChange()/effectiveTurnRate;
				dx *= $elapsedTimeMS;
				if ( MIN_TURN_AMOUNT >= Math.abs(dx) )
					dx = 0;
					

				_dy = MouseKeyboardHandler.getMouseXChange()/effectiveTurnRate;
				_dy *= $elapsedTimeMS;
				if ( MIN_TURN_AMOUNT >= Math.abs(_dy) )
					_dy = 0;
				
				if ( onSolidGround )
				{
					instanceInfo.rotationGet.setTo( 0, instanceInfo.rotationGet.y + _dy, 0 );
				}
				else
				{
					instanceInfo.rotationGet.setTo( instanceInfo.rotationGet.x + dx, instanceInfo.rotationGet.y + _dy, instanceInfo.rotationGet.z );
					// This sets the max climb angle, different beast could have different climb angles
					if ( -mMaxClimbAngle > instanceInfo.rotationGet.x )
					{
						instanceInfo.rotationGet.setTo( -mMaxClimbAngle, instanceInfo.rotationGet.y + _dy, instanceInfo.rotationGet.z );
					}
				}

				camera.rotationSetComp( instanceInfo.rotationGet.x, instanceInfo.rotationGet.y, instanceInfo.rotationGet.z );
			}
		}
		
		private const _smoothingFactor:Number = 0.1;
		private var   _workingAverage:Number = 0;
		override public function draw( $mvp:Matrix3D, $context:Context3D, $isChild:Boolean ):void {
				
			var viewMatrix:Matrix3D = instanceInfo.worldSpaceMatrix.clone();
			viewMatrix.append( $mvp );
			
			if ( !onSolidGround )
			{
				// This add a turn angle to the beast without causing the Z rotation to change turn characteristics.
				_workingAverage = ( _dy * _smoothingFactor ) + ( _workingAverage * ( 1.0 - _smoothingFactor) )			
				if ( 1.5 < Math.abs( _workingAverage ) )
				{
					if ( 0 < _workingAverage )
						_workingAverage = 1.5;
					else
						_workingAverage = -1.5;
				}
				viewMatrix.appendRotation( _workingAverage * -20, Vector3D.Z_AXIS );
			}
			
			if ( oxel )
			{
				var selected:Boolean = Globals.selectedModel == this ? true : false;
				
				oxel.drawNew( viewMatrix, this, $context, _shaders, selected, $isChild );
				
				if (Globals.g_app.editing && editCursor && editCursor.visible)
					editCursor.draw(viewMatrix, $context, false );
			}
			
			for each ( var vm:VoxelModel in _children )
			{
				if ( vm && vm.complete )
					vm.draw( viewMatrix, $context, true );
			}	
		}
		
		override public function drawAlpha(mvp:Matrix3D, $context:Context3D, $isChild:Boolean ):void	{
			
			var viewMatrix:Matrix3D = instanceInfo.worldSpaceMatrix.clone();
			viewMatrix.append(mvp);
			
			if ( !onSolidGround )
			{
				viewMatrix.appendRotation( _workingAverage * -20, Vector3D.Z_AXIS );
			}
			
			if ( oxel )
			{
				// We have to draw all of the non alpha first, otherwise parts of the tree might get drawn after the alpha does
				var selected:Boolean = Globals.selectedModel == this ? true : false;
				oxel.drawNewAlpha( viewMatrix, this, $context, _shaders, selected, $isChild );
				
				if (Globals.g_app.editing && editCursor && editCursor.visible)
					editCursor.draw(viewMatrix, $context, false );
			}
			
			for each (var vm:VoxelModel in _children)
			{
				if (vm && vm.complete)
					vm.drawAlpha(viewMatrix, $context, true );
			}
		}

		override public function updateVelocity( $elapsedTimeMS:int, $clipFactor:Number ):Boolean 
		{
			// TODO What should default behavoir be for a beast?
			return super.updateVelocity( $elapsedTimeMS, $clipFactor );
		}
		
		override protected function setAnimation():void	{
			
			var climbFactor:Number = ( mMaxClimbAngle + instanceInfo.rotationGet.x) / mMaxClimbAngle;
			if ( onSolidGround )
			{
				updateAnimations( "RaptorAniWalk", 0.5 );
				instanceInfo.velocityReset();
				stateLock( true, 500 );
			}
			else if ( mStallSpeed > instanceInfo.velocityGet.z )
			{
				updateAnimations( "RaptorAniLand", 0.5 );
				clipVelocityFactor = 0.95;
			}
			else if ( -5 > instanceInfo.rotationGet.x )
			{
				updateAnimations( "RaptorAniFly", 1 - climbFactor );
				mSpeedMultiplier = 0.35;
				//clipVelocityFactor = 0.95;
			}
			else if ( 15 < instanceInfo.rotationGet.x )
			{
				stateSet( "RaptorAniDive" );
				clipVelocityFactor = 1.01;
				mSpeedMultiplier = 1;
			}
			// Be fun to make this have the avatar put their arms out to the side
			else	
			{
				clipVelocityFactor = 0.995;
				if ( mForward )
				{
					updateAnimations( "RaptorAniFly", 0.5 );
					mSpeedMultiplier = 0.50;
				}
				else
				{
					stateSet( "RaptorAniGlide" );
					mSpeedMultiplier = 0.50;
				}
			}
		}

		override public function takeControl( $vm:VoxelModel ):void { 
			//Log.out( "Beast.takeControl - starting position: " + $vm.instanceInfo.positionGet );
			super.takeControl( $vm );
			MouseKeyboardHandler.leftTurnEnabled = false;
			MouseKeyboardHandler.rightTurnEnabled = false;
			//MouseKeyboardHandler.mouseLookReset()
			// now we set where the avatar will attach to beast.
			$vm.instanceInfo.positionSet = _seatLocation;
			$vm.instanceInfo.rotationSet = this.instanceInfo.rotationGet;
			//Log.out( "Beast.takeControl - after position set: " + $vm.instanceInfo.positionGet );
			Globals.g_app.addEventListener( ShipEvent.THROTTLE_CHANGED, throttleEvent );
			instanceInfo.usesCollision = true;
			$vm.stateSet( "PlayerAniRaptorRide");
			camera.index = 2;	
			Globals.g_app.dispatchEvent(new GUIEvent(GUIEvent.TOOLBAR_HIDE));
		}
	
		override public function loseControl( $vm:VoxelModel ):void	{
			super.loseControl( $vm );
			MouseKeyboardHandler.leftTurnEnabled = true;
			MouseKeyboardHandler.rightTurnEnabled = true;
			MouseKeyboardHandler.backwardEnabled = true;
			$vm.instanceInfo.positionSetComp( $vm.instanceInfo.positionGet.x, $vm.instanceInfo.positionGet.y + _seatLocation.y, $vm.instanceInfo.positionGet.z );
			//$vm.instanceInfo.rotationSet = this.instanceInfo.rotationGet;
			$vm.instanceInfo.rotationSetComp( 0, instanceInfo.rotationGet.y, 0 );
			Globals.g_app.removeEventListener( ShipEvent.THROTTLE_CHANGED, throttleEvent );
			instanceInfo.usesCollision = false;
		}
	}
}
