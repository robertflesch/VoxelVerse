/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import flash.geom.Vector3D;

	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CollisionTest 
	{
		private var _collisionPoints:Vector.<CollisionPoint> = new Vector.<CollisionPoint>();
		private var _owner:VoxelModel = null
		
		// Collision points are defined in World Space coordinates
		public function CollisionTest( $owner:VoxelModel )
		{
			_owner = $owner;
		}
		
		public function collisionPoints():Vector.<CollisionPoint>
		{
			return _collisionPoints;
		}
		
		public function addCollisionPoint( $val:CollisionPoint ):void
		{
			_collisionPoints.push( $val );
		}
		
		public function isNotValid():Boolean
		{
			for each ( var result:CollisionPoint in _collisionPoints )
			{
				if ( result.collided )
					return true;
			}
			return false;
		}

		public function isValid():Boolean
		{
			for each ( var result:CollisionPoint in _collisionPoints )
			{
				if ( result.collided )
					return false;
			}
			return true;
		}
		
		public function setValid():void
		{
			for each ( var cp:CollisionPoint in _collisionPoints )
			{
				cp.collided = false;
				cp.oxel = null;
			}
		}
		
		public function toString():String {
			var result:String = "CollisionTest type: ";
			for each ( var cp:CollisionPoint in _collisionPoints )
			{
				result += cp.toString() + " - "
			}
			
			return result;
		}
		
		public function hasPoints():Boolean { return  0 == _collisionPoints.length ? false : true; }
			
		public function markersAdd():void {
			
			for each ( var cp:CollisionPoint in _collisionPoints )
			{
				cp.markerAdd( _owner );
			}
		}
		
		
		
		public function markersRemove():void {
			
			for each ( var cp:CollisionPoint in _collisionPoints )
			{
				cp.markerRemove( _owner );
			}
		}
		
	}
}