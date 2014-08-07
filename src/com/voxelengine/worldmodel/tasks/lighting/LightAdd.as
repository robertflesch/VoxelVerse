/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import flash.geom.Vector3D;

	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.pools.LightingPool;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.oxel.Lighting;
//	import com.voxelengine.worldmodel.oxel.BrightnessTests;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LightAdd extends LightTask 
	{		
		static public function handleLightEvents( $le:LightEvent ):void {
			if ( LightEvent.ADD == $le.type )
			{
				// This could effect more then one model...
				// TODO make this work for multiple models. Maybe just use a world location like the explosion code does.
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				if ( vm ) {
					var lo:Oxel = vm.oxel.childFind( $le.gc );
					if ( Oxel.validLightable( lo ) )
					{
						var ti:TypeInfo = Globals.Info[lo.type];
						if ( !lo.brightness.add( $le.lightID, ti.lightInfo.color, Lighting.MAX_LIGHT_LEVEL, ti.lightInfo.attn, true ) )
							throw new Error( "LightAdd.handleLightEvent - How did we get here?" );
//						lo.brightness.fallOffPerMeter = ti.lightInfo.attn;
						addTask( $le.instanceGuid, $le.gc, $le.lightID, Globals.ALL_DIRS );
					}
					else
						Log.out( "LightAdd.handleLightAddEvent - invalid light source", Log.ERROR );
				}
				else
					Log.out( "LightAdd.handleLightAddEvent - VoxelModel not found", Log.ERROR );
			}
			else if ( LightEvent.SOLID_TO_ALPHA == $le.type )
			{
				var vmc:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				if ( vmc ) {
					var co:Oxel = vmc.oxel.childFind( $le.gc );
					if ( co && Oxel.validLightable( co ) )
					{
						// This oxel changed from solid to AIR or Translucent
						// So I just need to rebalance it as an AIR oxel
						var airAttn:uint = Globals.Info[ Globals.AIR ].lightInfo.attn;
						const attnScaling:uint = co.brightness.materialFallOffFactor * airAttn * (co.gc.size() / Globals.UNITS_PER_METER);
						co.brightness.balanceAttnAll( attnScaling );
						// REVIEW - Just grabbing the ID of the brightest light, but I THINK all will spread.
						// Did not work correctly with just brightest light in other places, replacing here with all lights
						var lights:Vector.<uint> = co.brightness.lightIDNonDefaultUsedGet();
						for each ( var lightsOnThisOxel:uint in lights )
							addTask( $le.instanceGuid, $le.gc, lightsOnThisOxel, Globals.ALL_DIRS );						
					}
					else
						Log.out( "LightAdd.handleLightAddEvent - invalid light source", Log.ERROR );
				}
				else
					Log.out( "LightAdd.handleLightAddEvent - VoxelModel not found", Log.ERROR );
				
			}
		}
		 
		static private function addTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $lightDir:uint ):void {
			var lt:LightAdd = new LightAdd( $instanceGuid, $gc, $lightID, $lightDir, $gc.toID(), $gc.grain );
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		private var _lightDir:uint;
		private function get lightDir():uint { return _lightDir; }
		private function set lightDir( $val:uint ):void { _lightDir = $val; }
		/**
		 * NEVER NEVER NEVER use this, use the static addTask function 
		 * @param $instanceGuid1 - guid of parent model
		 * @param $gc of oxel that HAS light attributes
		 * @param $lightID a light id
		 * @param $taskType each oxel gets a unique task id, so that only one task per oxel happens (at once)
		 * @param $taskPriority small grains get processed first - so use grain size as priority
		 * 
		 */
		public function LightAdd( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $lightDir:uint, $taskType:String, $taskPriority:int ):void {
			_lightDir = $lightDir;
			super( $instanceGuid, $gc, $lightID, $taskType, $taskPriority );
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( vm ) {
			
				try {
					var lo:Oxel = vm.oxel.childFind( _gc );
					if ( Oxel.validLightable( lo ) ) {
						
						if ( !lo.gc.is_equal( _gc ) )
							Log.out ( "LightAdd.start - Didn't find child!", Log.ERROR );

						//Log.out ( "LightAdd.start - gc:" + lo.gc.toString() + " br: " + lo.brightness.toString() );
						lo.brightness.lightGet( lightID ).processed = true;
						spreadToNeighbors( lo );
					}
					else
						Log.out( "LightAdd.start - valid failed", Log.ERROR );
				}
				catch (error:Error) {
					Log.out( "LightAdd.start - Exception Caught: " + error.message + " lo.gc: " + lo.gc.toString(), Log.ERROR );
				}
			}
			else
				Log.out( "LightAdd.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			// Have to call complete or queue hangs
			super.complete();
		}
		
		private function spreadToNeighbors( $lo:Oxel ):void {
				
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				// For the initial spread from light, the the dir be the spread direction
				if ( Globals.ALL_DIRS == lightDir )
					lightDir = face;
				
				var no:Oxel = $lo.neighbor(face);
					
				if ( !Oxel.validLightable( no ) ) continue;
				if ( no.isLight ) continue;
				if ( checkIfProcessed( no ) ) continue;
				
				if ( no.gc.grain > $lo.gc.grain )  // implies it has no children.
					projectOnLargerGrain( $lo, no, face );
				else if ( no.gc.grain == $lo.gc.grain ) // equal grain can have children
					projectOnEqualGrain( $lo, no, face );
				else
					Log.out( "LightAdd.spreadToNeighbors - NEIGHBOR GRAIN IS SMALLER: ", Log.ERROR );
					
					
			}
		}
		
		// returns true if continue
		private function projectOnEqualGrain( $lo:Oxel, $no:Oxel, $face:int ):Boolean {
			
			if ( $no.childrenHas() ) 
			{
				if ( checkIfProcessed( $no ) )
					return true;
				projectOnNeighborChildren( $no, $lo.brightness, $face );
			}					
			else 
			{
				if ( true == $no.isSolid ) // this is a SOLID object which does not transmit light (leaves, water are exceptions)
				{
					if ( $no.brightness.influenceAdd( lightID, $lo.brightness, $face, true, $no.gc.size() ) )
						rebuildFace( $no, $face );
				} 
				else if ( Globals.AIR == $no.type ) { // this oxel does not have faces OR children, and transmits light
					// Add the influence, test for changes, if changed add this to light list
					if ( $no.brightness.influenceAdd( lightID, $lo.brightness, $face, false, $no.gc.size() ) )
						add( $no );
				}
				else { // this oxel has faces and transmits light (water and leaves)
					if ( $no.brightness.influenceAdd( lightID, $lo.brightness, $face, false, $no.gc.size() ) )
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
				return true; // What does this do?
			var bt:Lighting = LightingPool.poolGet();
			var btp:Lighting = LightingPool.poolGet();
			
			var grainUnits:uint = $lo.gc.size();
			// project the light oxel onto the virtual brightness
			bt.influenceAdd( lightID, $lo.brightness, $face, !$no.hasAlpha, grainUnits );
			if ( !bt.valuesHas() )
				return false;

			// if the target is larger then one size, we need to project calculation on parent recursively until it is correct size
			var currentLo:Oxel = $lo;
			var sizeDif:uint = $no.gc.grain - $lo.gc.grain;
			for ( var i:uint = 0; i < sizeDif; i++ ) {	
				var childID:uint = Oxel.childIdOpposite( $face, currentLo.gc.childId() );	
				btp.reset();
				// now extend the brightness child onto its parent!
				btp.childAdd( lightID, childID, bt, grainUnits, !$no.hasAlpha );
				bt.copyFrom( btp );
				grainUnits *= 2;
				// if sizeDiff is 2 or great, we have to recalculate the child id for the lo's parent
				if ( currentLo.parent )
					currentLo = currentLo.parent;
			}
			
			//Log.out( "LightAdd.projectOnLargerGrain ----------------------------------------------------" );
			//Log.out( "bt: \n" + bt.toString() );
			//Log.out( "no: \n" + $no.brightness.toString() );
			// add the calculated brightness and color info to $no
			var changed:Boolean;
			if ( bt.lightHas( lightID ) && bt.lightGet( lightID ).valuesHas( Lighting.DEFAULT_BASE_LIGHT_LEVEL ) )
				changed = $no.brightness.brightnessMerge( lightID, bt );
			//Log.out( "no: \n" + $no.brightness.toString() );
			//Log.out( "LightAdd.projectOnLargerGrain ----------------------------------------------------" );
			
			LightingPool.poolReturn( bt );
			LightingPool.poolReturn( btp );
			
			if ( changed ) {
				if ( true == $no.isSolid ) { // this is a SOLID object which does not transmit light (leaves, water are exceptions)
					rebuildFace( $no, $face );
				} else if ( Globals.AIR == $no.type ) {
					add( $no );
				} else {
					rebuildFace( $no, $face ); // what case is this? leaves and water?
					add( $no );
				}
			}
			
			// add routine will filter out if there are no values.
			return false;
		}

		// Checks if this oxel has been processed
		// Only transparent oxels are processed, meaning they have had all of their neighbors evaluated for the light content.
		private function checkIfProcessed( $o:Oxel ):Boolean {
			if ( $o.childrenHas() )
			{
				for each ( var child:Oxel in $o.children ) {
					if ( child.isSolid ) return false;
					if ( !checkIfProcessed( child ) ) return false;
				}
				// lets mark $o as processed for this lightID
				if ( $o.brightness && $o.brightness.lightHas( lightID ) )
					$o.brightness.lightGet( lightID ).processed = true;
				return true;
			}
			
			if ( $o.brightness && $o.brightness.lightHas( lightID ) && true == $o.brightness.lightGet( lightID ).processed )
				return true;
				
			return false;
		}
		
		private function projectOnNeighborChildren( $no:Oxel, $lob:Lighting, $face:int ):void {
			
			// I am getting the indexes for the imaginary children that are facing the real children
			// and a list of the real children
			var lobChild:Vector.<uint> = Oxel.childIDsForDirection( $face )
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );
			//var lobTestChild:Vector.<uint> = Oxel.childIDsForDirection( of );

			var bt:Lighting = LightingPool.poolGet();
			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				var noChild:Oxel = dchild[childIndex];
				if ( checkIfProcessed ( noChild ) )
					continue;
				// Idea here is I would grab a temp virtual brightness child that is opposite the child I am going to project upon.
				bt.reset();
				// Create a temporary brightness child, pull values from parent
				if ( !$lob.childGet( lightID, lobChild[childIndex], bt ) )
					continue; // this child has no value, so just continue
				if ( noChild.childrenHas() )
				{
					projectOnNeighborChildren( noChild, bt, $face );
				}
				else
				{
					// Make sure it has valid values
					// add influence from the temp child to the actual child.
					if ( bt.valuesHas() )
					{
						if ( !Oxel.validLightable( noChild ) )
							Log.out( "LightAdd.projectOnNeighborChildren - How do I get here?", Log.ERROR );
						
						// Project the virtual brightness object on the real child of the same size
						if ( noChild.brightness.influenceAdd( lightID, bt, $face, !noChild.hasAlpha, noChild.gc.size() ) ) {
							if ( noChild.hasAlpha )
								add( noChild )
							else
								rebuildFace( noChild, $face );
						}
					}
				}
			}
			LightingPool.poolReturn( bt );
		}
		
		static private function rebuildFace( $o:Oxel, $faceFrom:int ):void {
			
			if ( !$o.brightness.valuesHas() )
				return;

			if ( $o.quads && 0 < $o.quads.length )
				$o.quadRebuild( Oxel.face_get_opposite( $faceFrom ) );
		}
		
		private function add( $o:Oxel ):void {
			
			if ( checkIfProcessed( $o ) )
				return;
			
			if ( $o.isSolid )
			{
				Log.out( "LightAdd.add - SOLID", Log.ERROR );
				return;
			}
			
			if ( $o.brightness.valuesHas() )
				addTask( _guid, $o.gc, lightID, Globals.ALL_DIRS );
		}
	}
}