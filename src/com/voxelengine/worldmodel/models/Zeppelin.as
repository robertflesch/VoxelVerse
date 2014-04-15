/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import flash.display3D.Context3D;
    import flash.geom.Vector3D;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;	
	
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.events.ShipEvent;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Zeppelin extends Ship 
	{
		static protected const SHIP_VELOCITY:String 	= "velocity"
		static protected const SHIP_ALTITUDE:String 	= "altitude"
		static protected const SHIP_ROTATION:String 	= "rotation"
		
		public function Zeppelin( ii:InstanceInfo, mi:ModelInfo ):void 
		{
			super( ii, mi );
			Globals.g_app.addEventListener( ShipEvent.THROTTLE_CHANGED, throttleEvent, false, 0, true );
			Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onChildAdded );
			instanceInfo.track = true;
		}
		
		protected function onChildAdded( me:ModelEvent ):void
		{
			if ( me.parentInstanceGuid != instanceInfo.instanceGuid )
				return;
				
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( me.instanceGuid );
			if ( vm is Engine )
				_engines.push( vm );
			if ( vm is Gun )
				_guns.push( vm );
			if ( vm is Bomb )
				_bombs.push( vm );
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
			// set our next position by adding in velocities
			// If there is no collision or gravity, this is where the model would end up.
			throw new Error( "Not implemented" );
			var loc:Location = new Location();
			loc.setTo( instanceInfo );
			instanceInfo.setTargetLocation( loc, lastCollisionModel, this, true );
			
			const STEP_UP_CHECK:Boolean = true;
			// does model have collision, if no collision, then why bother with gravity
			if ( instanceInfo.usesCollision )
			{
				_collisionCandidates = Globals.g_modelManager.whichModelsIsThisInfluencedBy( this )
				//trace( "collisionTest: " + _collisionCandidates.length )
				if ( 0 == _collisionCandidates.length )
				{
					if ( instanceInfo.usesGravity )
					{
						var leastFallDistance:Vector3D = new Vector3D( 0, 1, 0 );
						instanceInfo.velocity.y += leastFallDistance.y;
						onSolidGround = false;
					}
					instanceInfo.setTo( loc );
				}
				else
				{
					onSolidGround = false;
					for each ( var collisionCandidate:VoxelModel in _collisionCandidates )
					{
						// if it collided or failed to step up
						// restore the previous position
						var restorePoint:int = collisionCheckNew( $elapsedTimeMS:Number, loc, collisionCandidate, STEP_UP_CHECK )
						if ( -1 < restorePoint )
						{
							instanceInfo.restoreOld( restorePoint );
							instanceInfo.velocityReset();
							instanceInfo.recalculateMatrix();
							return false;
						}
						// New position is valid
						else
							instanceInfo.setTo( loc );
					}
				}
			}
			return true;
		}
		
		
		override public function update(context:Context3D, $elapsedTimeMS:int):void 
		{
			instanceInfo.changed = false;
			
			internal_update( context, $elapsedTimeMS );
			
			// Do the things that just a voxel model does
			// update the edit cursor
			if ( Globals.g_app.editing && editCursor && Globals.selectedModel == this )
				editCursor.update( context, $elapsedTimeMS );
				
			// Changed first param inside from false to true ( calculateTargetPosition )
			collisionTest();

			instanceInfo.recalculateMatrix();
			
			for each ( var vm:VoxelModel in _children )
				vm.update( context, $elapsedTimeMS );
				
			if ( instanceInfo.changed && this == Globals.controlledModel )
				dispatchMovementEvent();
		}
		
		protected function startEngines( val:Number, name:String = "" ):void
		{
			//Log.out( "Beast.startEngines" );
			if ( 0 == _engines.length )
			{
				Log.out( "Beast.startEngines - NO WORKING ENGINES" );
				return;
			}
			
			for each ( var engine:Engine in _engines )
			{
				if ( name != "" )
				{
					if ( engine.instanceInfo.name == name )
						engine.start( val/8, this, false );
						
				}
				else
					engine.start( val/8, this, false );
			}
		}
		
		protected function stopEngines():void
		{
			for each ( var engine:Engine in _engines )
				engine.stop( this );
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
	}
}
