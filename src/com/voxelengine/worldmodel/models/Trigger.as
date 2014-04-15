/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.worldmodel.models.*;
	import com.voxelengine.worldmodel.*;
	import com.voxelengine.events.OxelEvent;
	import com.voxelengine.pools.GrainCursorPool;
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Trigger extends VoxelModel 
	{
		private var _inside:Boolean = false;
		private var _was_selected:Boolean = false;
		private var _ba:ByteArray = null;
		
		public function Trigger( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			super( instanceInfo, mi );
		}

		override public function update(context:Context3D, elapsedTimeMS:int):void 
		{
			super.update(context, elapsedTimeMS);
			
			if ( Globals.controlledModel )
			{
				var wsPositionCenter:Vector3D = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( Globals.controlledModel.instanceInfo.center );
				
				var msPos:Vector3D;
				if ( instanceInfo.controllingModel )
				{
					msPos = instanceInfo.controllingModel.worldToModel( wsPositionCenter );
					msPos = msPos.subtract( this.instanceInfo.positionGet );
				}
				else
					msPos = worldToModel( wsPositionCenter );

				var gct:GrainCursor = GrainCursorPool.poolGet( oxel.gc.bound );
				gct.getGrainFromVector( msPos, 0 );
				if ( gct.is_inside( oxel.gc ) )
				{
					// Only want to dispatch the event once per transition
					if ( !_inside )
					{
						_inside = true;
						// Send OxelEvent?
						//Log.out( "Trigger.update - INSIDE" );
						for each ( var iscript:Script in instanceInfo.scripts )
						{
							var oe:OxelEvent = new OxelEvent( OxelEvent.INSIDE, instanceInfo.instanceGuid )
							//trace( "Trigger.update - inside: " + oe );
							Globals.g_app.dispatchEvent( oe );
						}
					}
				} 
				else
				{
					if ( _inside )
					{
						_inside = false;
						//Log.out( "Trigger.update - OUTSIDE" );
						for each ( var oscript:Script in instanceInfo.scripts )
						{
							var oe1:OxelEvent = new OxelEvent( OxelEvent.OUTSIDE, instanceInfo.instanceGuid )
							//trace( "Trigger.update - outside: " + oe1 );
							Globals.g_app.dispatchEvent( oe1 );
						}
					}
				}
				
				GrainCursorPool.poolDispose( gct );
			}

			var selected:Boolean = Globals.selectedModel == this ? true : false;
			if ( selected )
			{
				// the oxel.write prunes all of the children
				// so we have to save the byte array from what was inside.
				if ( !_was_selected && null == _ba )
				{
					_ba = new ByteArray();
					oxel.writeData( _ba );
				}
				
				var loco:GrainCursor = GrainCursorPool.poolGet(oxel.gc.bound);
				// this prunes the children oxel
				oxel.write( instanceInfo.instanceGuid, loco.set_values( 0, 0, 0, oxel.gc.grain ), Globals.LEAF, true );
				GrainCursorPool.poolDispose( loco );
				oxel.faces_set_all();
				oxel.faces_rebuild( Globals.INVALID, instanceInfo.instanceGuid );
				oxel.quadsBuild();
				_was_selected = true;
			}
			else if ( _was_selected )
			{
				_was_selected = false;
				var loco1:GrainCursor = GrainCursorPool.poolGet(oxel.gc.bound);
				// this prunes the children oxel
				loco1.set_values( 0, 0, 0, oxel.gc.grain );
				_ba.position = 0;
				oxel.readData( null, loco1, _ba, statisics );
				GrainCursorPool.poolDispose( loco1 );
				// this cleans up outside, but saddle is gone
				oxel.faces_rebuild( Globals.LEAF, instanceInfo.instanceGuid );
				oxel.faces_clean_all_face_bits();
				oxel.dirty = true;
				oxel.quadsBuild();
			}
		}
	}
}
