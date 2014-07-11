package com.voxelengine.worldmodel.models
{
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.renderer.BlackLamp;
	import com.voxelengine.renderer.Lamp;
	import com.voxelengine.renderer.LampBright;
	import com.voxelengine.renderer.Torch;
	import com.voxelengine.renderer.RainbowLight;
	import com.voxelengine.worldmodel.weapons.Gun;
	import com.voxelengine.worldmodel.weapons.Bomb;
	
	import com.voxelengine.renderer.ShaderLight;
	import com.voxelengine.renderer.shaders.Shader;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import flash.display3D.Context3D;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix3D;
    import flash.geom.Vector3D;
	import flash.net.SharedObject;
	
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.events.LoadingEvent;
	import com.voxelengine.events.RegionEvent;
	import com.voxelengine.worldmodel.Region;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;

	import com.voxelengine.pools.GrainCursorPool;
	
    public class Player extends ControllableVoxelModel
    {
		//static private const 	HIPWIDTH:Number 			= (Globals.UNITS_PER_METER * 3)/8;
		static private const 	FALL:String					= "FALL";
		static private const 	FOOT:String					= "FOOT";
		static private const 	HEAD:String					= "HEAD";
//		static private const 	MOUSE_LOOK_CHANGE_RATE:int 	= 10000;
		static private const 	MOUSE_LOOK_CHANGE_RATE:int 	= 5000;
		static private const 	MIN_TURN_AMOUNT:Number 		= 0.09;
		static private const 	AVATAR_CLIP_FACTOR:Number 	= 0.90;
		static private var  	STEP_UP_MAX:int 			= 16;
		
		private var _inventoryStore:SharedObject;
		private var _inventory:Vector.<InventoryObjects> = new Vector.<InventoryObjects>();
		
		public function Player( instanceInfo:InstanceInfo, mi:ModelInfo ) { 
			super( instanceInfo, mi );
			
			instanceInfo.usesCollision = true;
			clipVelocityFactor = AVATAR_CLIP_FACTOR;
			modelInfo.editable = false;
			
			Globals.g_app.addEventListener( ModelEvent.CRITICAL_MODEL_LOADED, onCriticalModelLoaded );
			Globals.g_app.addEventListener( ModelEvent.RELEASE_CONTROL, handleModelEvents );
			
			Globals.g_app.addEventListener( LoadingEvent.PLAYER_LOAD_COMPLETE, onLoadingPlayerComplete );
			Globals.g_app.addEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingComplete );
			
			Globals.g_app.addEventListener( RegionEvent.REGION_UNLOAD, onRegionUnload );
			Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildAdded );
			
			takeControl( null );
			
			//_ct.markersAdd();
			
			//inventoryLoad();
			torchToggle();
		}
		
		override protected function onChildAdded( me:ModelEvent ):void
		{
			if ( me.parentInstanceGuid != instanceInfo.instanceGuid )
				return;
				
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( me.instanceGuid );
Log.out( "Player.onChildAdded model: " + vm.toString() );
			if ( vm is Engine )
Log.out( "Player.onChildAdded - Player has ENGINE" )
				//_engines.push( vm );
			if ( vm is Gun )
Log.out( "Player.onChildAdded - Player has GUN" )
				//_guns.push( vm );
			if ( vm is Bomb )
Log.out( "Player.onChildAdded - Player has BOMP" )
				//_bombs.push( vm );
		}
		
		
		
		private var _torchIndex:int;
		public function torchToggle():void 
		{
			Shader.lightsClear();
			var sl:ShaderLight;
			switch( _torchIndex ) {
				case 0:
					sl = new Lamp();
					break;
				case 1:
					sl = new Torch();
					(sl as Torch).flicker = true;
					break;
				case 2:
					sl = new RainbowLight();
					break;
				case 3:
					sl = new BlackLamp();
					break;
				case 4:
					sl = new LampBright();
					_torchIndex = -1; // its going to get incremented
					break;
			}
			_torchIndex++;
			sl.position = instanceInfo.positionGet.clone();
			sl.position.y += 30;
			sl.position.x += 4;
			Shader.lightAdd( sl ); 
		}
		
		/*
		// Be nice to have the UI driven
		public function torchAdd():void {
			Shader.lightsClear();
			var sl:Lamp = new Lamp();
			//var sl:Torch = new Torch();
			//sl.flicker = true;
			//var sl:RainbowLight = new RainbowLight();
			sl.position = instanceInfo.positionGet.clone();
			sl.position.y += 30;
			sl.position.x += 4;
			Shader.lightAdd( sl ); 
			_torchIndex = 0;
		}
		
		public function torchRemove():void {
			Shader.lightsClear();
		}
		*/
		private function inventoryLoad():void
		{
			//returns the mySharedObject if it exists, if not creates a new one
			_inventoryStore = SharedObject.getLocal("inventory");
			//take your array and put it on the so
			_inventory = _inventoryStore.data.inventory;
			
			//save the data
			inventorySave();			
		}

		private function inventorySave():void
		{
			_inventoryStore.data.inventory = _inventory;
			_inventoryStore.flush();			
		}
		
		private function inventoryAdd( $type:int, $item:* ):void
		{
			var io:InventoryObjects = new InventoryObjects();
			io.item = $item;
			io.type = $type
			
			_inventory.push( io );
			
			inventorySave();
		}
		
		public function inventoryGet():Array
		{
			return _inventoryStore.data.inventory
		}
		
		override public function collisionTest( $elapsedTimeMS:Number ):Boolean {
			
			if ( this === Globals.controlledModel )
			{
				// check to make sure the ship or object you were on was not destroyed or removed
				//if ( lastCollisionModel && lastCollisionModel.instanceInfo.dead )
					//lastCollisionModelReset();
				
				if ( false == controlledModelChecks( $elapsedTimeMS ) )
				{
					stateSet( "PlayerAniStand", 1 ); // Should be crash?
					return false;
				}
				else
					setAnimation();
			}
			
			return true;
		}
		
		override protected function setAnimation():void	{
			
			/*if ( Globals.g_app.toolOrBlockEnabled )
			{
				stateSet( "Pick", 1 );
			}*/
			
			if ( -0.4 > instanceInfo.velocityGet.y )
			{
				updateAnimations( "Jump", 1 );
			}
			else if ( 0.4 < instanceInfo.velocityGet.y )
			{
				updateAnimations( "Fall", 1 );
			}
			else if ( 0.2 < Math.abs( instanceInfo.velocityGet.z )  )
			{
				updateAnimations( "Walk", 2 );
			}
			else if ( 0.2 < Math.abs( instanceInfo.velocityGet.x )  )
			{
				updateAnimations( "Slide", 1 );
			}
			else
			{
				stateSet( "Stand", 1 );
			}
			//trace( "Player.update - end" );
		}
		
		override protected function collisionPointsAdd():void {
			/*  0,0xxxxxx8xxxxxx15,0 
			 *  x                x
			 *  x                x
			 *  x                x
			 *  0,4              x
			 * ...               ...
			 *  x                x
			 *  0,15xxxxx8xxxxxx15,15
			 * 
			 * */
			// TO DO Should define this in meta data??? RSF or using extents?
			// diamond around feet
			_ct.addCollisionPoint( new CollisionPoint( FALL, new Vector3D( 7.5, -1, 7.5 ), false ) );
			
			_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_FOOT, 7.5 ), true ) );
			//_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_FOOT + STEP_UP_MAX/2, 0 ) ) );
			//_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_FOOT + STEP_UP_MAX, 0 ) ) );
//			_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 11, Globals.AVATAR_HEIGHT_FOOT, 7.5 ) ) );
//			_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_FOOT, 11 ) ) );
//			_ct.addCollisionPoint( new CollisionPoint( FOOT, new Vector3D( 4, Globals.AVATAR_HEIGHT_FOOT, 7.5 ) ) );
			// middle of chest
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_CHEST - 4, 7.5 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_CHEST, 7.5 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( BODY, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_CHEST + 4, 7.5 ) ) );
			// diamond around feet
			_ct.addCollisionPoint( new CollisionPoint( HEAD, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_HEAD, 7.5 ) ) );
			_ct.addCollisionPoint( new CollisionPoint( HEAD, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_HEAD, 7.5 ), false ) );
			//_ct.addCollisionPoint( new CollisionPoint( HEAD, new Vector3D( 7.5, Globals.AVATAR_HEIGHT_HEAD, 15 ) ) );
			//_ct.addCollisionPoint( new CollisionPoint( HEAD, new Vector3D( 0, Globals.AVATAR_HEIGHT_HEAD, 7.5 ) ) );

			//_ct.markersAdd();
		}

		override protected function cameraAddLocations():void {
//			camera.addLocation( new CameraLocation( true, 0, 0, 0 ) );
//			camera.addLocation( new CameraLocation( true, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT - 4, 0 ) );
//			camera.addLocation( new CameraLocation( true, 0, Globals.AVATAR_HEIGHT - 4, 0) );
			//camera.addLocation( new CameraLocation( true, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT - 4, Globals.AVATAR_WIDTH/2) );
			camera.addLocation( new CameraLocation( true, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT - 4, Globals.AVATAR_WIDTH/2 - 4) );
			camera.addLocation( new CameraLocation( false, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT - 4, 50) );
//			camera.addLocation( new CameraLocation( true, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT + 20, 50) );
			camera.addLocation( new CameraLocation( false, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT, 100) );
//			camera.addLocation( new CameraLocation( true, Globals.AVATAR_WIDTH/2, Globals.AVATAR_HEIGHT, 250) );
		}

		override public function takeControl( $modelLosingControl:VoxelModel, $addAsChild:Boolean = true ):void {
			Log.out( "Player.takeControl" );
			super.takeControl( $modelLosingControl, false );
			instanceInfo.usesCollision = true;
			// We need to grab the rotation of the old parent, otherwise we get rotated back to 0 since last rotation is 0
			if ( $modelLosingControl )
				instanceInfo.rotationSet = $modelLosingControl.instanceInfo.rotationGet;

			Globals.g_app.dispatchEvent(new GUIEvent(GUIEvent.TOOLBAR_SHOW));
		}

		override public function loseControl($modelDetaching:VoxelModel, $detachChild:Boolean = true):void
		{
			Log.out( "Player.loseControl" );
			super.loseControl( $modelDetaching, false );
			instanceInfo.usesCollision = false;
		}

		override public function update($context:Context3D, $elapsedTimeMS:int):void	{

			if ( 0 < Shader.lightCount() ) {
				var sl:ShaderLight = Shader.lights(0);
				sl.position = instanceInfo.positionGet.clone();
				sl.position.y += 30;
				sl.position.x += 4;
				sl.update();
			}

			super.update( $context, $elapsedTimeMS );
		}
		
		private function onRegionUnload( le:RegionEvent ):void {
			instanceInfo.controllingModel = null;
			usesGravity = false;
			lastCollisionModelReset();
		}
		
		private function onLoadingPlayerComplete( le:LoadingEvent ):void {
			complete = true;
			calculateCenter();
			Globals.player = this;
			Globals.g_app.removeEventListener( LoadingEvent.PLAYER_LOAD_COMPLETE, onLoadingPlayerComplete );
			
			var region:Region = Globals.g_regionManager.currentRegion;
			if ( region.playerPosition )
			{
				//Log.out( "Player.onLoadingPlayerComplete - setting position to  - x: "  + region.playerPosition.x + "   y: " + region.playerPosition.y + "   z: " + region.playerPosition.z );
				instanceInfo.positionSetComp( region.playerPosition.x, region.playerPosition.y, region.playerPosition.z );
			}
			else
				instanceInfo.positionSetComp( 0, 0, 0 );
			
			if ( region.playerRotation )
			{
				//Log.out( "Player.onLoadingPlayerComplete - setting player rotation to  -  y: " + region.playerRotation );
				instanceInfo.rotationSet = new Vector3D( 0, region.playerRotation.y, 0 );
			}
			else
				instanceInfo.rotationSet = new Vector3D( 0, 0, 0 );
		}

		private function onLoadingComplete( le:LoadingEvent ):void {
			//Globals.g_app.removeEventListener( ModelEvent.CRITICAL_MODEL_LOADED, onLoadingComplete );
			Globals.g_app.removeEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingComplete );
			if ( !Globals.g_regionManager.currentRegion.criticalModelDetected )
			{
				//Log.out( "Player.onLoadingComplete - no critical model" );
				collisionPointsAdd();
				MouseKeyboardHandler.addInputListeners();
				gravityOn()
				
			}
		}
		
		private function onCriticalModelLoaded( le:ModelEvent ):void {
			//Globals.g_app.removeEventListener( ModelEvent.CRITICAL_MODEL_LOADED, onCriticalModelLoaded );
			Log.out( "Player.onCriticalModelLoaded - CRITICAL model" );
			MouseKeyboardHandler.addInputListeners();
			collisionPointsAdd();
			gravityOn()
		}

		private function gravityOn():void {
			if ( true == Globals.g_regionManager.currentRegion.gravity )
				usesGravity = true;
			else		
				usesGravity = false;
		}

		override protected function handleMouseMovement( $elapsedTimeMS:int ):void {
			//if ( Globals.mouseView && Globals.active ) 
			if ( Globals.active && !Globals.GUIControl && Globals.clicked ) 
			{
				// up down
				var dx:Number = 0;
				dx = MouseKeyboardHandler.getMouseYChange() / MOUSE_LOOK_CHANGE_RATE;
				dx *= $elapsedTimeMS;
				if ( MIN_TURN_AMOUNT >= Math.abs(dx) )
					dx = 0;
					
				// right left
				var dy:Number = MouseKeyboardHandler.getMouseXChange() / MOUSE_LOOK_CHANGE_RATE;
				dy *= $elapsedTimeMS;
				if ( MIN_TURN_AMOUNT >= Math.abs(dy) )
					dy = 0;
				//
				//Log.out( "Player.handleMouseMovement - rotation: " + _instanceInfo.rotationGet );
				// I only want to rotate the head here, not the whole body. in the X dir.
				// so if I made the head the main body part, could I keep the rest of the head fixed on the x and z axis...
				instanceInfo.rotationSetComp( instanceInfo.rotationGet.x, instanceInfo.rotationGet.y + dy, instanceInfo.rotationGet.z );
				//camera.rotationSetComp( instanceInfo.rotationGet.x, instanceInfo.rotationGet.y, instanceInfo.rotationGet.z );
				// this uses the camera y rotation, but it breaks other things like where to dig.
				camera.rotationSetComp( camera.rotationGet.x + dx, instanceInfo.rotationGet.y, instanceInfo.rotationGet.z );
				//trace( "handleMouseMovement instanceInfo.rotationGet: " + instanceInfo.rotationGet + "  camera.rotation: " + camera.rotationGet );
			}
		}

		// returns -1 if new position is valid, returns 0-2 if there was collision
		// 0-2 is the number of steps back to take in position queue
		override protected function collisionCheckNew( $elapsedTimeMS:Number, $loc:Location, $collisionCandidate:VoxelModel, $stepUpCheck:Boolean = true ):int {

			//if ( $loc.velocityGet.y != 0 )
			//	Log.out( "Player.collisionCheckNew - ENTER: vel.y: " + instanceInfo.velocityGet.y );
			var foot:int = 0;
			var body:int = 0;
			var head:int = 0;
			var fall:int = 0;
			// reset all the points to be in a non collided state
			_ct.setValid();
			var points:Vector.<CollisionPoint> = _ct.collisionPoints();
			// the amount that the test point pushes forward from current position
			// currently basing it on velocity in Z dir
			const LOOK_AHEAD:int = 10;
			var velocityScale:Number = $loc.velocityGet.z * LOOK_AHEAD;
			
			for each ( var cp:CollisionPoint in points )
			{
				if ( cp.scaled )
					cp.scale( velocityScale );
					
				// takes the cp point which is in model space, and puts it in world space
				var posWs:Vector3D = $loc.modelToWorld( cp.pointScaled );
				
				// pass in the world space coordinate to get back whether the oxel at the location is solid
//				cp.collided = $collisionCandidate.isSolidAtWorldSpace( posWs, MIN_COLLISION_GRAIN );
				$collisionCandidate.isSolidAtWorldSpace( cp, posWs, MIN_COLLISION_GRAIN );
				// if collided, increment the count on that collision point set
				if ( true == cp.collided )
				{
					if ( FALL == cp.name ) fall++;
					else if ( FOOT == cp.name ) foot++;
					else if ( BODY == cp.name ) body++;
					else if ( HEAD == cp.name ) head++;
				}
			}
			// fall point is in space! falling....
			if ( !fall )
			{
				//Log.out( "Player.collisionCheckNew - fall" );
				//Log.out( "Player.collisionCheckNew - FALL fall = 0, foot=0, stepUp: " + $stepUpCheck + " velocityGet.y: " + $loc.velocityGet.y );
				if ( usesGravity )
				{
					this.fall( $loc, $elapsedTimeMS );
				}
				
				onSolidGround = false;
				if ( foot || body || head )
				{
					if ( mMaxFallRate > $loc.velocityGet.y && usesGravity )
						$loc.velocitySetComp( 0, $loc.velocityGet.y + (0.0033333333333333 * $elapsedTimeMS) + 0.5, 0 );
					
					return -1;
				}
				return -1;
			}
			
			// Everything is clear
			if ( !head && !foot && !body )
			{
				//Log.out( "Player.collisionCheckNew - all good" );
				return -1;
			}
			else if ( foot && !body && !head )
			{
				//Log.out( "Player.collisionCheckNew - foot" );
				lastCollisionModel = $collisionCandidate;
				onSolidGround = true;
				$loc.velocityResetY();
				
				// oxel that fall point is in
				var go:Oxel = points[0].oxel;
				// its localation in MS (ModelSpace)
				var msCoord:int = go.gc.getModelY();
				// add its height in MS
				msCoord += go.size_in_world_coordinates();
				// if foot oxel, then there are two choices
				// 1) foot is in ground, in which case we should adjust avatars position
				// 2) there is a step up chance
				
				// oxel that foot point is in
				var fo:Oxel = points[1].oxel;
				var msCoordFoot:int = fo.gc.getModelY();
				msCoordFoot += fo.size_in_world_coordinates();
				// we need to do minor adjustment on foot position?
				if ( fo.gc.grain == go.gc.grain && fo.gc.grainY == go.gc.grainY || msCoord == msCoordFoot )
				{
					//Log.out( "Player.collisionCheckNew - FOOT in solid ground adjusting foot height" );
					// add its height in MS
					msCoord = msCoordFoot;
					_sScratchVector.setTo( 0, msCoord, 0 );
					var wsCoord:Vector3D = $collisionCandidate.modelToWorld( _sScratchVector );
					$loc.positionSetComp( $loc.positionGet.x, wsCoord.y, $loc.positionGet.z );	
					//Log.out( "Player.collisionCheckNew - FOOT in solid ground adjusting foot height to: " + wsCoord.y );
					return -1;
				}
				else // step up chance
				{
					var stepUpSize:int = msCoordFoot - msCoord;
					if ( 0 == stepUpSize )
					{
						Log.out( "Player.collisionCheckNew - REJECT - step up size is 0 why? " + stepUpSize );
						return 0;
					}
					else if ( STEP_UP_MAX < stepUpSize )
					{
						Log.out( "Player.collisionCheckNew - REJECT - step TOO large: " + stepUpSize );
						return 0;
					}
					
					const STEP_SIZE_GRAIN:int = 4;
					if ( STEP_SIZE_GRAIN == fo.gc.grain )
					{
						var stepUpOxel:Oxel = fo.neighbor(Globals.POSY);
						if ( stepUpOxel.childrenHas() )
						{
							Log.out( "Player.collisionCheckNew - REJECT - step has kids or is solid: " + stepUpSize + " need a more detailed examination of children" );
							return 0;
						}
					}
					else if ( STEP_SIZE_GRAIN > fo.gc.grain ) // This grain is too small, bump up to STEP_SIZE
					{
						Log.out( "Player.collisionCheckNew - step smaller then l meter:" );
						var stepUpOxel1:Oxel = fo.neighbor(Globals.POSY);
						if ( Globals.BAD_OXEL != stepUpOxel1 )
						{
							var msCoordFoot1:int = stepUpOxel1.gc.getModelY();
							msCoordFoot1 += stepUpOxel1.size_in_world_coordinates();
							_sScratchVector.setTo( 0, msCoordFoot1, 0 );
							var wsCoord1:Vector3D = $collisionCandidate.modelToWorld( _sScratchVector );
							$loc.positionSetComp( $loc.positionGet.x, wsCoord1.y, $loc.positionGet.z );	
							Log.out( "Player.collisionCheckNew - step  too small: adjusting foot height to: " + wsCoord1.y );
							return -1;
	//						Log.out( "Player.collisionCheckNew - REJECT - step  too small: " + fo.gc.grain + " need a more detailed examination of children" );
	//						return 0;
						}
					}
					//Log.out( "Player.collisionCheckNew - PASS stepupSize: " + stepUpSize + " ADDING transform" );
					
					// Dont like adding this to instance info... when everything else is using loc
					jump( 1 );
				}
			}
			else if ( ( head || body ) && !foot )
			{
				// We probably jumped up into something
				//Log.out( "Player.collisionCheckNew - HEAD failed to clear" );
				return 2;
			}
			else if ( head && body && foot )
			{
				// Wall crawling
				Log.out( "Player.collisionCheckNew - EVERYTHING failed to clear" );
				return 0;
			}
			else if ( head || body || foot )
			{
				Log.out( "Player.collisionCheckNew - something failed to clear foot:" + foot + " body: " + body + " head: " + head );
				return 1;
			}
			Log.out( "Player.collisionCheckNew - ALL CLEAR" );
			return -1;
		}
		
		public function collisionCheckOLD():void {
			var collided:Boolean = false;
			var pt:PositionTest = isPositionValid( lastCollisionModel );
			if ( pt.isNotValid() )
			{
//				Log.out( "Player.collisionCheck PositionTest: " + pt.toString() );
				/*
				// head is clear, chest is clear, foot is blocked
				if ( pt.head && pt.chest && !pt.foot )
				{
					trace( "Player.collisionCheck step up chance" );
					// if a step up pts in a legal foot position, then test with that foot position
					if ( pt.footHeight <= instanceInfo.positionGet.y + STEP_UP_MAX )
					{
						// now I need to retest head, chest and foot in new position
						instanceInfo.positionSetComp( instanceInfo.positionGet.x, pt.footHeight, instanceInfo.positionGet.z );
						pt = isPositionValid( lastCollisionModel );
						// if the body in the new position is not all valid, we will get stuck
						if ( !pt.head || !pt.chest || !pt.foot )
							collided = true;
					}
					else
						collided = true;
						
					//resetVelocities();	
				}
				// if head OR chest OR foot is blocked, we are blocked
				else if ( !pt.head || !pt.chest || !pt.foot )
				{
					// TODO Should consider redirecting the velocity to an angle orthagonal to the face
					collided = true;
					// ok I see why you continue up to wall after you hit the first time.
					// since the velocity is being reset, the slower speed alows you to get a bit closer before colliding.
				}
				*/
			}
//			else
//				trace( "Player.collisionCheck NO Collided at: " + pt.position );
		
			if ( usesGravity && lastCollisionModel )
			{
				// if the model is falling, let it, RSF I think this is supposed to be where the parent model is falling.
				if ( instanceInfo.positionGet.y < instanceInfo.positionGet.y )
				{
					Log.out( "Player.collisionCheck instanceInfo.usesGravity && lastCollisionModel: " + pt.toString() );
					instanceInfo.positionSetComp( instanceInfo.positionGet.x, instanceInfo.positionGet.y, instanceInfo.positionGet.z );
				}
			}
			
//			if ( $collisionModel )
//			{
//				Log.out( "InstanceInfo.collisionCheck - What is this doing here??? " + $collisionModel.worldToModel( instanceInfo.positionGet ), Log.ERROR );
				//lastModelPosition = $collisionModel.worldToModel( positionGet );
				//lastModelRotation = $collisionModel.instanceInfo.rotationGet;
//			}
			
			// if collided set position back to original
			if ( pt.isNotValid() )
			{
				instanceInfo.restoreOld();
				instanceInfo.velocityReset();
			}
		}		
		/* applyGravityNew
		private	function applyGravityNew( $elapsedTimeMS:int ):void
		{
			onSolidGround = false;
			var leastFallDistance:Vector3D = new Vector3D( 0, 1, 0 );
			// if we are not in any models influence, then reset lastModelInfo
			// Test of position for use in object movement				
			for each ( var collisionCandidate:VoxelModel in _collisionCandidates )
			{
				if ( instanceInfo.usesGravity )
				{
					var fallDistance:Vector3D = calculateFallDueToGravity( collisionCandidate, $elapsedTimeMS );
					//trace( "Player.applyGravity: " + fallDistance.length );
					if ( 0 == fallDistance.length )
					{
						leastFallDistance = fallDistance;
						lastCollisionModel = collisionCandidate;
						onSolidGround = true;
						Log.out( "Player.applyGravity - OnSolidGround keys: " + InstanceInfo.s_velocityFromKeys.y + "  vel: " + instanceInfo.velocity.y );
						break;
					}
					else if ( fallDistance.length < leastFallDistance.length ) 
					{
						leastFallDistance = fallDistance;
						lastCollisionModel = collisionCandidate;
						onSolidGround = true;
						instanceInfo.velocityResetY();
						Log.out( "Player.applyGravity - FALLING", Log.ERROR );
					}
				}
				else
				{
					// TODO Take the last model in the list, yuck!
					lastCollisionModel = collisionCandidate;
				}
			}
			
			if ( instanceInfo.usesGravity && !onSolidGround )
			{
				// Still nothing at a full 2 units, so fall baby, fall.
				if ( -5 < instanceInfo.velocity.y )
					instanceInfo.velocity.y = leastFallDistance.y;
//					instanceInfo.velocity.y += leastFallDistance.y;
				// You have fallen off something, keep going till you hit!
				if ( instanceInfo.positionGet.y < -10000 )
					instanceInfo.reset();
			}
		}
		*/
		/* calculateFallDueToGravityNew
		public function calculateFallDueToGravityNew( collisionModel:VoxelModel, elapsedTimeMS:int ):Vector3D
		{
			var result:Vector3D = new Vector3D();
			var hitSolid:Boolean = false;
			var points:Vector.<CollisionPoint> = _ct.collisionPoints();
			for each ( var cp:CollisionPoint in points )
			{
				if ( FOOT == cp.name )
				{
					// takes the cp point which is in model space, and puts it in world space
					var fallPoint:Vector3D = cp.point.clone();
					fallPoint.y -= 2;
					var posWs:Vector3D = modelToWorld( fallPoint );
					// pass in the world space coordinate to get back whether the oxel at the location is solid
					if ( collisionModel.isSolidAtWorldSpace( posWs, MIN_COLLISION_GRAIN ) )
					{
						hitSolid = true;
						break;
					}
				}
			}
			
			if ( hitSolid )
			{
				// what is first valid spot beneath me?
				result.setTo( _gravityScalar.x, _gravityScalar.y, _gravityScalar.z );
			}
			return result;
		}
		*/
		/* applyGravity
		private	function applyGravity( $elapsedTimeMS:int ):void
		{
			onSolidGround = false;
			var leastFallDistance:Vector3D = new Vector3D( 0, 1, 0 );
			// if we are not in any models influence, then reset lastModelInfo
			// Test of position for use in object movement				
			for each ( var collisionCandidate:VoxelModel in _collisionCandidates )
			{
				if ( instanceInfo.usesGravity )
				{
					var fallDistance:Vector3D = calculateFallDueToGravity( collisionCandidate, $elapsedTimeMS );
					//trace( "Player.applyGravity: " + fallDistance.length );
					if ( fallDistance.length < leastFallDistance.length ) 
					{
						leastFallDistance = fallDistance;
						// IS this needed for anything?
						//if ( lastCollisionModel != collisionCandidate )
						//{
							//if ( _lastCollisionModel )
								//Log.out( "voxelmodel.update - changing collision model from: " + _lastCollisionModel.instanceInfo.modelGuid + " to " + collisionCandidate.instanceInfo.modelGuid );
							//else	
								//Log.out( "voxelmodel.update - first collision model: " );
			
								
							//_instanceInfo.lastModelPosition = collisionCandidate.worldToModel( instanceInfo.positionGet );
							//_instanceInfo.lastModelRotation = collisionCandidate.instanceInfo.rotationGet;
						//}
						lastCollisionModel = collisionCandidate;
						onSolidGround = true;
						//trace( "Player.applyGravity: velocityResetY" );
						instanceInfo.velocityResetY();
						//Log.out( "Player.applyGravity - velocityResetY??? ", Log.ERROR );
					}
				}
				else
				{
					lastCollisionModel = collisionCandidate;
				}
			}
			
			if ( instanceInfo.usesGravity && 0 < leastFallDistance.length )
			{
				// Still nothing at a full 2 units, so fall baby, fall.
				if ( -5 < instanceInfo.velocityGet.y )
					instanceInfo.velocitySetComp( instanceInfo.velocityGet.x, instanceInfo.velocityGet.y + leastFallDistance.y, instanceInfo.velocityGet.z );
				// You have fallen off something, keep going till you hit!
				if ( instanceInfo.positionGet.y < -10000 )
					instanceInfo.reset();
			}
		}
		
		public function calculateFallDueToGravity( collisionModel:VoxelModel, elapsedTimeMS:int ):Vector3D
		{
			var result:Vector3D = new Vector3D();
			if ( collisionModel )
			{
				var eyeLevelModelSpacePosition:Vector3D = collisionModel.worldToModel( instanceInfo.positionGet );
				var leftFoot:Vector3D  = instanceInfo.lookRightVector( HIPWIDTH );
				leftFoot.x = eyeLevelModelSpacePosition.x + leftFoot.x;
				leftFoot.y = eyeLevelModelSpacePosition.y - Globals.AVATAR_HEIGHT_FOOT;
				leftFoot.z = eyeLevelModelSpacePosition.z + leftFoot.z;

				var rightFoot:Vector3D = instanceInfo.lookRightVector(  -HIPWIDTH );
				rightFoot.x = eyeLevelModelSpacePosition.x + rightFoot.x;
				rightFoot.y = eyeLevelModelSpacePosition.y - Globals.AVATAR_HEIGHT_FOOT;
				rightFoot.z = eyeLevelModelSpacePosition.z + rightFoot.z;
				
				var gct0:GrainCursor = GrainCursorPool.poolGet( collisionModel.oxel.gc.bound );
				const collideAtGrain:int = 2; // collide at 1/4 meter level, TODO how to get this in UNITS_PER_METER? too latein the night
				
				// This is a grain 2 down from my foot.
				var pt:PositionTest = new PositionTest();
				pt.type = PositionTest.FOOT;
				const testDistance:int = 2;
				var leftFootEmpty:Boolean = collisionModel.isPassableAvatar( leftFoot.x, leftFoot.y - testDistance, leftFoot.z, gct0, collideAtGrain, pt );
				var rightFootEmpty:Boolean = collisionModel.isPassableAvatar( rightFoot.x, rightFoot.y - testDistance, rightFoot.z, gct0, collideAtGrain, pt );

				if ( leftFootEmpty && rightFootEmpty )
				{
					//Log.out( "ApplyGravity - both feet are not solid" );
					// lets do a sanity check and check between the feet too
    				var betweenFeet:Boolean = collisionModel.isPassableAvatar( eyeLevelModelSpacePosition.x, rightFoot.y - testDistance, eyeLevelModelSpacePosition.z, gct0, collideAtGrain, pt );
					if ( betweenFeet )
					{
						leftFoot.incrementBy( _gravityScalar );
						leftFootEmpty = collisionModel.isPassableAvatar( leftFoot.x, leftFoot.y , leftFoot.z, gct0, collideAtGrain, pt );
						if ( leftFootEmpty )
						{
							result.setTo( _gravityScalar.x, _gravityScalar.y, _gravityScalar.z );
						}
						else
						{
							result.setTo( _gravityScalar.x, _gravityScalar.y, _gravityScalar.z );
							result.scaleBy(0.5);
						}
					}
				}
				GrainCursorPool.poolDispose( gct0 );
			}
			else
			{
				result.setTo( _gravityScalar.x, _gravityScalar.y, _gravityScalar.z );
			}
			return result;
		}
		*/
		
	}
}
