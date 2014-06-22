/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act. 
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.LightInfo;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LightRemove extends LightTask 
	{		
		static public function handleLightEvents( $le:LightEvent ):void {
			if ( LightEvent.REMOVE == $le.type ) {
				var vmr:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				if ( vmr ) {
					var lor:Oxel = vmr.oxel.childFind( $le.gc );
					if ( lor && valid( lor ) ) {
						lor.brightness.lightRemove( $le.lightID );
						var alphaCountr:int;
						// walk thru the neighbors, if the no has less light then remove that light (just that or all lights?)
						for ( var facer:int = Globals.POSX; facer <= Globals.NEGZ; facer++ ) {
							var nor:Oxel = lor.neighbor(facer);
							if ( Globals.BAD_OXEL == nor )
								continue;
							
							if ( nor.hasAlpha ) {
								shineBackOnRemovedLight( lor, nor, facer, $le.lightID );
								alphaCountr++;
							}
						}
						//if ( 0 < alphaCountr )
						//	rebuild neighbors faces
					}
				}
				addTask( $le.instanceGuid, $le.gc, $le.lightID );
			}
			else if ( LightEvent.ALPHA_TO_SOLID == $le.type )
			{
				/*
				var blockageList:Vector.<BlockageCandidates> = new Vector.<BlockageCandidates>;
				// The only time this matters is if I have only TWO side that are translucent
				// All other times this blockage doesnt matter.
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				if ( vm ) {
					var lo:Oxel = vm.oxel.childFind( $le.gc );
					if ( lo && valid( lo ) ) {
						var alphaCount:int;
						var solidCount:int;
						// walk thru the neighbors, if the no has less light then remove that light (just that or all lights?)
						for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ ) {
							var no:Oxel = lo.neighbor(face);
							if ( Globals.BAD_OXEL == no )
								continue;
							if ( no.isSolid ) {
								solidCount++;
								continue;
							}
							
							// if one greater and there are two air, then this is only passage.
							// if one is greater and there are three air...
							if ( no.hasAlpha ) {
								alphaCount++;
								var gct:GrainCursor = GrainCursorPool.poolGet( no.gc.bound );
								var bt:Brightness = BrightnessPool.poolGet();
								var sizeDif:uint = no.gc.grain - lo.gc.grain;
								var childIDPath:Vector.<uint>; // = new Vector.<uint>; // used to save the path from child to parent over multiple levels
								if ( 0 < sizeDif ) { // for 1 neighbor oxel is one size larger
									
									childIDPath = pathToParent( lo, face, no.gc.grain );
									childBrightnessGet( no.brightness, childIDPath, bt );
									// bt should now have the correct brightness for the virtual child brightness
								}
								else if ( sizeDif < 0 ) { // for 1 neighbor oxel is one size SMALLER
									
									childIDPath = pathToParent( no, Oxel.face_get_opposite( face ), lo.gc.grain );
									childBrightnessGet( lo.brightness, childIDPath, bt );
									// bt should now have the correct brightness for the virtual child brightness
								}
								else { // Same size
									
									if ( null == no.brightness )
										continue;
									bt.copyFrom( no.brightness );
								}
								GrainCursorPool.poolDispose( gct );
								
								//var lightIDsToBeRemoved:Vector.<uint>	= new Vector.<uint>;
								var lightIDs:Vector.<uint> = bt.lightIDNonDefaultUsedGet();
								// Default ID excluded
								for each ( var oxelLightID:uint in lightIDs )
								{
									if ( 0 == oxelLightID )
										continue;
									if (  bt.lightHas( oxelLightID ) 
									   && lo.brightness.lightHas( oxelLightID ) 
									   && bt.lightGet( oxelLightID ).avg < lo.brightness.lightGet( oxelLightID ).avg ) 
									{
										blockageList.push( new BlockageCandidates( $le.instanceGuid, no.gc, oxelLightID ) );
										//addTask( $le.instanceGuid, no.gc, oxelLightID );
									}
								}
								BrightnessPool.poolReturn( bt );
							}
						}
						if ( 2 == alphaCount && 2 <= solidCount ) {
							for each ( var bc:BlockageCandidates in blockageList ) {
								addTask( bc.guid, bc.gc, bc.ID );
							}
						}
					}
				}
				*/
			}
		}
		
		static private function pathToParent( $o:Oxel, $face:uint, targetGrainSize:uint ):Vector.<uint> {
			var childIDPath:Vector.<uint> = new Vector.<uint>;
			var gct:GrainCursor = GrainCursorPool.poolGet( $o.gc.bound );
			gct.copyFrom( $o.gc ); // light oxel location
			gct.move( $face ); // now move it to location that we need the brightness from
			// get a vector with the parent/child id relationships
			while ( gct.grain < targetGrainSize ) {
				childIDPath.push( gct.childId() );
				gct.become_parent();
			}
			GrainCursorPool.poolDispose( gct );
			
			return childIDPath;
		}
		
		static private function childBrightnessGet( $lob:Brightness, path:Vector.<uint>, $bt:Brightness ):void {

			var btp:Brightness = BrightnessPool.poolGet();
			btp.copyFrom( $lob );
			var childIDPathIndex:int = path.length - 1;
			for ( var i:int = childIDPathIndex ; i >= 0;  i-- )
			{
				btp.childGetAllLights( path[i], $bt );
				btp.copyFrom( $bt );
			}
			$bt.copyFrom( btp );
			BrightnessPool.poolReturn( btp );
		}
		
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint ):void {
			//Log.out( "Light.addTask: for gc: " + $gc.toString() + "  taskId: " + $gc.toID() );
			var lt:LightRemove = new LightRemove( $instanceGuid, $gc, $lightID, $gc.toID(), $gc.grain );
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		// NEVER use this, use the static function
		public function LightRemove( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $taskType:String, $taskPriority:int ):void {
			super( $instanceGuid, $gc, $lightID, $taskType, $taskPriority );
		}
		

		/**
		 * @param $taskType The Task type.
		 * @param $taskPriority The priority of the task, 0 is the highest priority, int.MAX_VALUE is the lowest.
		 */
		private function remove( $o:Oxel ):void {
			LightRemove.addTask( _guid, $o.gc, lightID );
		}
		
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm ) {
				
				var lo:Oxel = vm.oxel.childFind( _gc );
				if ( valid( lo ) ) {
					//if ( !lo.gc.is_equal( _gc ) ) {
						// This is a distinct possibility for removal. If the light was last non air oxel
						// then removing it merged it into its parent.
						// Does it require different handling?
						//Log.out ( "LightRemove.start - Didn't find child!" );
					//}
					lo.brightness.lightRemove( lightID );
					removeFromNeighbors( lo );
				}
				else
					Log.out( "LightRemove.start - valid failed", Log.ERROR );

			}
			else
				Log.out( "LightRemove.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		static private function valid( $o:Oxel ):Boolean {
			
			if ( Globals.BAD_OXEL == $o ) // This is expected, if oxel is on edge of model
				return false;
			
			if ( !$o.brightness ) // does this oxel already have a brightness?
				return false;

			return true;
		}
		 
		private function removeFromNeighbors( $lo:Oxel ):void {
				
			//Log.out( "LightRemove.spreadToNeighbors - $lo: " + $lo.toStringShort() + "  brightness: " + $lo.brightness.toString() );
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = $lo.neighbor(face);
					
				if ( Globals.BAD_OXEL == no )
					continue;
				
				if ( no.childrenHas() )
					removeFromChildren( no, face );
				else if ( no.brightness && no.brightness.lightGet( lightID ) )
					terminalLightRemove( no, face );
//				else
//					Log.out( "LightRemove.spreadToNeighbors - Light doesnt exist: " + lightID );
			}
		}
		
		static private function shineBackOnRemovedLight( $lo:Oxel, $no:Oxel, $face:uint, excludedID:uint ):void {
			var lightIDs:Vector.<uint> = $no.brightness.lightIDNonDefaultUsedGet();
			// Default ID excluded
			// Adds the light from our alpha neighbor back into the recently emptied space.
			for each ( var oxelLightID:uint in lightIDs ) {
				if ( excludedID == oxelLightID )
					continue;
				$lo.brightness.influenceAdd( oxelLightID, $no.brightness, Oxel.face_get_opposite( $face ), false, $lo.gc.size() );
			}
		}
		
		private function removeFromChildren( $no:Oxel, $face:int ):void {
			// I am getting the indexes for the imaginary children that are facing the real children
			// and a list of the real children
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );

			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				var noChild:Oxel = dchild[childIndex];

				if ( noChild.childrenHas() )
					removeFromChildren( noChild, $face );
				else
					terminalLightRemove( noChild, $face );
			}
		}
		
		private function terminalLightRemove( $o:Oxel, $face:int ):void {
			
			if ( null == $o.brightness )
				return;
				
			if ( true == $o.isSolid ) { // this is a SOLID object which does not transmit light (leaves, water are exceptions)
				$o.brightness.influenceRemove( lightID, $face );
				if ( $o.brightness.lightHas( lightID ) && !$o.brightness.lightGet( lightID ).valuesHas() )
					$o.brightness.lightRemove( lightID );
				rebuildFace( $o, $face );
			}
			else if ( Globals.AIR == $o.type ) // this oxel does not have faces OR children, and transmits light
					remove( $o );
			else { // this oxel has faces and transmits light (water and leaves)
					rebuildFaces( $o );
					remove( $o );
			}
		}
		
		static private function rebuildFace( $o:Oxel, $faceFrom:int ):void {
			
			if ( $o.quads && 0 < $o.quads.length )
				$o.quadRebuild( Oxel.face_get_opposite( $faceFrom ) );
		}
		
		static private function rebuildFaces( $o:Oxel ):void {
			
			if ( $o.gc.eval( 4, 2, 4, 15 ) )
				Log.out( "rebuildFaces for removed light oxel: " );
			if ( $o.quads && 0 < $o.quads.length )
				$o.quadsRebuildAll();
		}
	}
}

import com.voxelengine.worldmodel.oxel.GrainCursor;

internal class BlockageCandidates {
	public function BlockageCandidates( $guid:String, $gc:GrainCursor, $ID:uint ):void {
		guid = $guid;
		gc = $gc;
		ID = $ID;
	}
	public var guid:String;
	public var gc:GrainCursor;
	public var ID:uint;
}