/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.flowtasks
{
	import com.developmentarc.core.tasks.tasks.AbstractTask;
	import com.voxelengine.worldmodel.models.EditCursor;
	
	import flash.utils.getTimer;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class CylinderOperation extends AbstractTask
	{		
		private var _guid:String 		= "";
		private var _gc:GrainCursor 	= null;
		private var _grain:int 			= 0;
		private var _startTime:int      = 0;
		private var _cx:int 			= 0;
		private var _cy:int 			= 0;
		private var _cz:int 			= 0;
		private var _axis:int 			= -1;
		private var _radius:int 		= -1;
		private var _gmin:uint 			= 0;
		private var _currentGrain:int 	= -1;
		private var _what:int 			= -1; // type
		private const _runTime:int 		= 250; // if I reduce run time, it never makes it through the higher grain models
		private var  _runCount:int 		= 1;
		
		public function CylinderOperation( gc:GrainCursor, what:int, guid:String,	cx:int, cy:int, cz:int, axis:int, radius:int, currentGrain:int, gmin:uint, runCount:int = 100  ):void 
		{
			super( "CylinderOperation" );
			_gc = gc;
			if ( null == _gc )
				throw new Error( "CylinderOperation.construct - NULL grain cursor");
			_guid = guid;
			_cx = cx;
			_cy = cy;
			_cz = cz;
			_axis = axis;
			_radius = radius;
			_gmin = gmin;
			_currentGrain = currentGrain;
			_what = what;
			_runCount = runCount;
			_startTime = getTimer();
			if ( EditCursor.CURSOR_OP_DELETE == EditCursor.cursorOperation )
				EditCursor.cursorColor = Globals.EDITCURSOR_CYLINDER_ANIMATED;
			Globals.g_landscapeTaskController.addTask( this );
		}
		
		override public function start():void {
			super.start();
			
			var timer:int = getTimer();
	
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			if ( vm && 0 < _runCount )
			{
				_runCount--;
				//var oxel:Oxel = vm.oxel.childGetOrCreate( _gc );
				var oxel:Oxel = vm.oxel.childFind( _gc );

				if ( Globals.BAD_OXEL == oxel )
				{
					Log.out( "CylinderOperation.start - BAD_OXEL found for gc: " + _gc, Log.ERROR );
				}
				else
				{
					var completed:Boolean = oxel.writeCylinder( _guid, _cx, _cy, _cz, _radius, _what, _axis, _currentGrain, timer, _runTime, _gc.grain );
					if ( !completed )
					{
						Log.out( "CylinderOperation - rerunning: took: " + (getTimer() - timer) + " _currentGrain: " + _currentGrain );		
						new CylinderOperation( _gc, _what, _guid, _cx, _cy, _cz, _axis, _radius, _currentGrain, _gmin, _runCount );
					}
					else if ( _gmin < _currentGrain )
					{
						Log.out( "CylinderOperation - Adding NEW: took: " + (getTimer() - timer) + " _currentGrain: " + _currentGrain );		
						new CylinderOperation( _gc, _what, _guid, _cx, _cy, _cz, _axis, _radius, _currentGrain - 1, _gmin, _runCount );
					}
					else
					{
						Log.out( "CylinderOperation - END: took: " + (getTimer() - timer) );
						if ( EditCursor.CURSOR_OP_DELETE == EditCursor.cursorOperation )
							EditCursor.cursorColor = Globals.EDITCURSOR_CYLINDER;

						//if ( EditCursor.cursorColor == Globals.EDITCURSOR_CYLINDER_ANIMATED )
						//{
							//EditCursor.cursorColor == Globals.EDITCURSOR_CYLINDER;
						//}
					}
				}
			}
			else if ( 0 == _runCount )
				Log.out( "CylinderOperation.start - Run Count too high: " + _guid, Log.WARN );
			else
				Log.out( "CylinderOperation.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}