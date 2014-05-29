/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.worldmodel.oxel.BrightnessTests;
	import com.voxelengine.worldmodel.TypeInfo;
	import flash.geom.Vector3D;
	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.pools.OxelPool;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Light extends LightTask 
	{		
		static public function handleLightEvents( $le:LightEvent ):void {
			if ( LightEvent.ADD == $le.type )
			{
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				main:if ( vm ) {
					var lo:Oxel = vm.oxel.childFind( $le.gc );
					//var lo:Oxel = vm.oxel.childGetOrCreate( $le.gc );
					if ( valid( lo ) )
					{
						if ( !lo.gc.is_equal( $le.gc ) )
							Log.out ( "Didn't find child!" );
						var ti:TypeInfo = Globals.Info[lo.type];
						lo.brightness.lightAdd( $le.lightID, ti.color, true );
						lo.brightness.lastLightID = $le.lightID;
							
						addTask( $le.instanceGuid, $le.gc, $le.lightID );
					}
					else
						Log.out( "Light.handleLightEvent - invalid light source", Log.ERROR );
				}
			}
		}
		 
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint ):void {
			//Log.out( "Light.addTask: for gc: " + $gc.toString() + "  taskId: " + $gc.toID() );
			var lt:Light = new Light( $instanceGuid, $gc, $lightID, $gc.toID(), $gc.grain );
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		/**
		 * NEVER NEVER NEVER use this, use the static addTask function 
		 * @param $instanceGuid - guid of parent model
		 * @param $gc of oxel that HAS light attributes
		 * @param $lightID a light id
		 * @param $taskType each oxel gets a unique task id, so that only one task per oxel happens (at once)
		 * @param $taskPriority small grains get processed first - so use grain size as priority
		 * 
		 */
		public function Light( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $taskType:String, $taskPriority:int ):void {
			super( $instanceGuid, $gc, $lightID, $taskType, $taskPriority );
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm ) {
				
				var lo:Oxel = vm.oxel.childFind( _gc );
				if ( valid( lo ) ) {
					lo.brightness.processed = true;
					if ( !lo.gc.is_equal( _gc ) )
						Log.out ( "Didn't find child!" );

					if ( _gc.eval( 6, 2, 1, 3 ) )
						Log.out ( "Look at grain 6 lights" );
Log.out ( "Light.start lo.gc: " + lo.gc.toString() );
					spreadToNeighbors( lo );
				}
				else
					Log.out( "Light.start - lightValid failed", Log.ERROR );

			}
			else
				Log.out( "Light.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		static private function valid( $o:Oxel ):Boolean {
			
			if ( Globals.BAD_OXEL == $o ) // This is expected, if oxel is on edge of model
				return false;
			
			if ( !$o.brightness ) // does this oxel already have a brightness?
				$o.brightness = BrightnessPool.poolGet();

			if ( 0 == $o.brightness.lastLightID )
			{
				Log.out( "Light.valid - 0 == LIGHT ID - continue" );
				return false;
			}
				
			return true;
		}
		
		private function spreadToNeighbors( $lo:Oxel ):void {
				
			Log.out( "Light.spreadToNeighbors - $lo: " + $lo.toStringShort() + "b: " + $lo.brightness.toString() );
			
				
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = $lo.neighbor(face);
					
				if ( !valid( no ) )
					continue;
				
				if ( no.isLight )
					continue;
			
				if ( no.gc.grain > $lo.gc.grain )  // implies it has no children.
				{
					projectOnLargerGrain( $lo, no, face );
				}
				else if ( no.gc.grain == $lo.gc.grain ) // equal grain can have children
				{ 
					projectOnEqualGrain( $lo, no, face );
				}
				else {
					Log.out( "Light.spreadToNeighbors - NEIGHBOR GRAIN IS SMALLER: ", Log.ERROR );
				}					
			}
		}
		
		// returns true if continue
		private function projectOnEqualGrain( $lo:Oxel, $no:Oxel, $face:int ):Boolean {
			
			if ( $no.childrenHas() ) 
			{
				if ( $no.brightness.processed )
					return true;
				projectOnNeighborChildren( $no, $lo.brightness, $face );
			}					
			//else if ( $no.brightness.lastLightID == $lo.brightness.lastLightID ) // dont reevaluate an oxel that already has the influence from this light
			else if ( $no.brightness.processed ) // dont reevaluate an oxel that already has been processed
			{
				return true; 
			}
			else 
			{
				if ( true == $no.isSolid ) // this is a SOLID object which does not transmit light (leaves, water are exceptions)
				{
					if ( $no.brightness.influenceAdd( $lo.brightness, $face, true, $no.gc.size() ) )
						rebuildFace( $no, $face );
				} 
				else if ( Globals.AIR == $no.type ) { // this oxel does not have faces OR children, and transmits light
					// Add the influence, test for changes, if changed add this to light list
					if ( $no.brightness.influenceAdd( $lo.brightness, $face, false, $no.gc.size() ) )
						add( $no );
				}
				else { // this oxel has faces and transmits light (water and leaves)
					if ( $no.brightness.influenceAdd( $lo.brightness, $face, false, $no.gc.size() ) )
					{
						rebuildFace( $no, $face );
						add( $no );
					}
				}
			}
			
			return false;
		}
		
		
		// returns true if continue
		private function projectOnLargerGrain( $lo:Oxel, $no:Oxel, $face:int ):Boolean {
			
			if ( $no.childrenHas() )
				return true;

			var sizeDif:uint = $no.gc.grain - $lo.gc.grain;
			if ( 1 < sizeDif )
				Log.out( "Light.projectOnLargerGrain - size greater then one" );
				
			var bt:Brightness = BrightnessPool.poolGet();
			var btp:Brightness = BrightnessPool.poolGet();
			
			var grainUnits:uint = $lo.gc.size();
			// project the light oxel onto the virtual brightness
			bt.influenceAdd( $lo.brightness, $face, !$no.hasAlpha, grainUnits )

if ( $no.gc.eval( 5, 4, 2, 5 ) ) {
	BrightnessTests.allTests();
	Log.out ( "influence ok, add brightness broken correctly" );
}
			
			// if the target is larger then one size, we need to project calculation on parent until it is correct size
			var childID:uint = Oxel.childIdOpposite( $face, $lo.gc.childId() );	
			for ( var i:uint = 0; i < sizeDif; i++ ) {	
				btp.reset();
				// now extend the brightness child onto its parent!
				btp.childAdd( childID, bt, grainUnits );
				bt.copyFrom( btp );
				grainUnits *= 2;
			}
			// add the calculated brightness and color info to $no
			var changed:Boolean = $no.brightness.addBrightness( $lo.brightness, bt );
			
			BrightnessPool.poolReturn( bt );
			BrightnessPool.poolReturn( btp );
			
			if ( changed ) {
				if ( true == $no.isSolid ) { // this is a SOLID object which does not transmit light (leaves, water are exceptions)
					rebuildFace( $no, $face );
				} else if ( $no.hasAlpha ) {
					add( $no );
				} else {
					rebuildFace( $no, $face ); // what case is this? leaves and water?
				}
			}
			
			// add routine will filter out if there are no values.
			return false;
		}
		
		private function projectOnNeighborChildren( $no:Oxel, $lob:Brightness, $face:int ):void {
			
			// I am getting the indexes for the imaginary children that are facing the real children
			// and a list of the real children
			var lobChild:Vector.<uint> = Oxel.childIDsForDirection( $face )
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );
//var lobTestChild:Vector.<uint> = Oxel.childIDsForDirection( of );

			var bt:Brightness = BrightnessPool.poolGet();
			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				var noChild:Oxel = dchild[childIndex];
				if ( noChild.brightness && noChild.brightness.processed )
					continue;
				// I dont like subfaceGet since it uses different logic, would prefer only one routine.
				// Idea here is I would grab the temp brightness opposite the child I am going to project upon.
				// then just add influence back on it.
				bt.reset();
				// Create a temporary brightness child, pull values from parent
				$lob.childGet( lobChild[childIndex], bt );
				if ( noChild.childrenHas() )
				{
					projectOnNeighborChildren( noChild, bt, $face );
				}
				else
				{
					// Make sure it has valid values
					if ( bt.valuesHas() )
					{
						if ( !valid( noChild ) )
							Log.out( "Light.projectOnNeighborChildren - How do I get here?" );
						
						// Project the virtual brightness object on the real child of the same size
						noChild.brightness.influenceAdd( bt, $face, !noChild.hasAlpha, noChild.gc.size() );
						
						if ( noChild.hasAlpha )
							add( noChild )
						else
							rebuildFace( noChild, $face );
					}
				}
			}
			BrightnessPool.poolReturn( bt );
		}
		
		private function add( $o:Oxel ):void {
			
			if ( $o.brightness.processed )
			{
				Log.out( "Light.add - PROCESSED ALREADY: " + $o.gc.toString() );
				return;
			}
			
			if ( $o.isSolid )
			{
				Log.out( "Light.add - SOLID", Log.ERROR );
				return;
			}
			
			if ( $o.gc.grain < 4 )
			{
				Log.out( "Light.add - TOO SMALL" );
				return;
			}
			
			//if ( $o.gc.grain > 5 )
			//{
				//Log.out( "Light.add - TOO LARGE FOR NOW" );
				//return;
			//}
			
			if ( $o.brightness.valuesHas() )
			{
				addTask( _guid, $o.gc, lightID );
				Log.out( "Light.add - gc:" + $o.gc.toString() + " br: " + $o.brightness.toString() );
			}
		}
		
		private function rebuildFace( $o:Oxel, $faceFrom:int ):void {
			
			if ( $o.gc.eval( 4, 1, 4, 14 ) )
				Log.out( "rebuildFace: " + $o.brightness.toString() )
				
			if ( !$o.isSolid ) {
				Log.out( "Brightness.calculateEffect - being called on non solid object", Log.ERROR );
				return;
			}
				
			if ( $o.brightness.sunlit )
				return;
			
			if ( !$o.brightness.valuesHas() )
				return;

			if ( $o.quads && 0 < $o.quads.length )
				$o.quadRebuild( Oxel.face_get_opposite( $faceFrom ) );
		}
	}
}