/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.worldmodel.models.CameraLocation;
	import com.voxelengine.worldmodel.models.Location;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * So a camera mimics a model, except its position can be offset from the players position
	 * and the rotation is a combination of the players position and the mouse offset on the X axis
	 * Additional camera locations are stored in the cameras, and the current camera is the one that
	 * has the index.
	 */
	public class Camera extends Location
	{
		private   var   _cameras:Vector.<CameraLocation>= new Vector.<CameraLocation>();
		private var 	_index:int 				= CameraLocation.FIRST_PERSON;
		
		public function Camera():void
		{
		}
		
		public function addLocation( c:CameraLocation ):void
		{
			_cameras.push( c );
		}
		
		public function get current():CameraLocation
		{
			if ( _index < _cameras.length )
				return _cameras[_index];
			else	
				return _cameras[0];
		}
		
		public function get count():int { return _cameras.length; }
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index( $val:int ):void 
		{
			_index = $val;
			if ( _index >= _cameras.length )
				_index = 0;
		}

		public function next():void 
		{
			_index++;
			if ( _index >= _cameras.length )
				_index = 0;
		}
	}
}

