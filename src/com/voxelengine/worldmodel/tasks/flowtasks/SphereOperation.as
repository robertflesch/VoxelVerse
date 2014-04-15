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
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.GrainCursorUtils;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.TaskController;
	
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class SphereOperation extends AbstractTask
	{		
		private var _guid:String = "";
		private var _gc:GrainCursor = null;
		private var _grain:int = 0;
		private var _startTime:int;
		private var _cx:int = 0;
		private var _cy:int = 0;
		private var _cz:int = 0;
		private var _axis:int = -1;
		private var _radius:int = -1;
		private var _gmin:uint = 0;
		private var _currentGrain:int = -1;
		private var _what:int = -1; // type
		
		public function SphereOperation( gc:GrainCursor, what:int, guid:String,	cx:int, cy:int, cz:int, radius:int, currentGrain:int, gmin:uint = 0  ):void 
		{
			trace( "SphereOperation - created" );					
			super( "SphereOperation" );
			_gc = gc;
			if ( null == _gc )
				throw new Error( "SphereOperation.construct - NULL grain cursor");
			_guid = guid;
			_cx = cx;
			_cy = cy;
			_cz = cz;
			_radius = radius;
			_gmin = gmin;
			_currentGrain = currentGrain;
			_what = what;
			_startTime = getTimer();
			Globals.g_landscapeTaskController.addTask( this );
		}
		
		override public function start():void {
			super.start();
			
			var timer:int = getTimer();
	
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			var guid:String = vm.instanceInfo.instanceGuid;
			if ( vm )
			{
				var oxel:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( Globals.BAD_OXEL == oxel )
				{
					Log.out( "SphereOperation.start - BAD_OXEL found for gc: " + _gc, Log.ERROR );
				}
				else
				{
					//oxel.writeCylinder( _cx, _cy, _cz, _radius, _what, _axis, _currentGrain );
					oxel.write_sphere( guid, _cx, _cy, _cz, _radius, _what, _currentGrain );
					
					if ( _gmin < _currentGrain )
					{
						Log.out( "SphereOperation - Adding NEW: took: " + (getTimer() - timer) + " _currentGrain: " + _currentGrain );		
						new SphereOperation( _gc, _what, _guid, _cx, _cy, _cz, _radius, _currentGrain - 1, _gmin );
					}
					else
					{
						Log.out( "SphereOperation - END: took: " + (getTimer() - timer) + " in queue for: " + (timer - _startTime) );		
					}
				}
			}
			else
				Log.out( "SphereOperation.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
	}
}