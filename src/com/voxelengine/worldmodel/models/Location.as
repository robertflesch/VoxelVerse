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
	import flash.geom.Matrix3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	public class Location
	{
		private var _changed:Boolean 							= false;					// INSTANCE NOT EXPORTED
					
		private var _position:Vector3D 							= new Vector3D();			// toJSON
		private var _rotation:Vector3D 							= new Vector3D();			// toJSON
		private var _rotations:Vector.<Vector3D> 				= new Vector.<Vector3D>(3); // INSTANCE NOT EXPORTED
		private var _positions:Vector.<Vector3D> 				= new Vector.<Vector3D>(3); // INSTANCE NOT EXPORTED
		private var _scale:Vector3D 							= new Vector3D(1, 1, 1);	// toJSON
		private var _center:Vector3D 							= new Vector3D();			// INSTANCE NOT EXPORTED
		private var _centerConst:Vector3D 						= new Vector3D();			// INSTANCE NOT EXPORTED
		private var _velocity:Vector3D 							= new Vector3D();			// INSTANCE NOT EXPORTED

		private var _modelMatrix:Matrix3D 						= new Matrix3D();			// INSTANCE NOT EXPORTED
		private var _worldMatrix:Matrix3D 						= new Matrix3D();			// INSTANCE NOT EXPORTED
				
		private function get changed():Boolean 					{ return _changed; }
		private function set changed($val:Boolean):void			{ _changed = $val; }
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Center
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function get center():Vector3D 					{ return _center };
		public function set center($val:Vector3D):void			{ centerSetComp( $val.x, $val.y, $val.z ); }			
		public function 	centerSetComp( $x:Number, $y:Number, $z:Number ):void { 
			_changed = true;
			_centerConst.setTo( $x, $y, $z ); 
			_center.setTo( _centerConst.x * _scale.x, _centerConst.y * _scale.y, _centerConst.z * _scale.z );
			//Log.out( "set center - scale: " + _scale + "  center: " + center + "  centerConst: " + _centerConst );
		}
				
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Scale
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function get scale():Vector3D 					{ return _scale };
		public function set scale($val:Vector3D):void 			{ 
			_changed = true;
			_scale.setTo( $val.x, $val.y, $val.z ); 
			_center.setTo( _centerConst.x * $val.x, _centerConst.y * $val.y, _centerConst.z * $val.z );
			//Log.out( "set scale - scale: " + _scale + "  center: " + center + "  centerConst: " + _centerConst );
		}
				
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Rotation
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function get rotationGet():Vector3D 				{ return _rotation; }
		public function set rotationSet($val:Vector3D):void 	{ rotationSetComp( $val.x, $val.y, $val.z ); }
		public function get rotationGetRadians():Vector3D 		{ return new Vector3D( _rotation.x * Math.PI / 180, _rotation.y * Math.PI / 180, _rotation.z * Math.PI / 180 ) };
		public function 	rotationSetComp( $x:Number, $y:Number, $z:Number ):void { 
			//Log.out( "PosAndRot rot: " + _rotation.x+" " +_rotation.y+" " +_rotation.z );
			// Copy old rotation
			_changed = true;
			
			_rotations[2].setTo( _rotations[1].x, _rotations[1].y, _rotations[1].z );
			_rotations[1].setTo( _rotations[0].x, _rotations[0].y, _rotations[0].z );
			_rotations[0].setTo( _rotation.x,     _rotation.y,     _rotation.z );
			
			_rotation.setTo( $x % 360, $y % 360, $z % 360 ); 
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Position
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function get positionGet():Vector3D 				{ return _position; }
		public function set positionSet( $val:Vector3D ):void 	{ positionSetComp( $val.x, $val.y, $val.z ); }
		public function 	positionSetComp( $x:Number, $y:Number, $z:Number ):void 
		{ 
			_changed = true;
			
			_positions[2].setTo( _positions[1].x, _positions[1].y, _positions[1].z );
			_positions[1].setTo( _positions[0].x, _positions[0].y, _positions[0].z );
			_positions[0].setTo( _position.x,     _position.y,     _position.z );
			//trace( "Location.positionSetComp position[0] position: " + _positions[0] );
			
			_position.setTo( $x, $y, $z ); 
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Velocity
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function get velocityGet():Vector3D 				{ return _velocity };
		public function set velocitySet( $val:Vector3D ):void 	{ velocitySetComp( $val.x, $val.y, $val.z ); }
		public function 	velocityReset():void 				{ velocitySetComp( 0, 0, 0 ); }
		public function 	velocityResetY():void				{ _velocity.y = 0;}
		public function 	velocityScaleBy( $val:Number ):void	{ _velocity.scaleBy( $val ); }
		public function 	velocitySetComp( $x:Number, $y:Number, $z:Number ):void {  _velocity.setTo( $x, $y, $z ); }
		public function 	velocityClip():void 
		{
			velocitySetComp( ( -0.005 < velocityGet.x && velocityGet.x < 0.005) ? 0 : velocityGet.x
			               , ( -0.005 < velocityGet.y && velocityGet.y < 0.005) ? 0 : velocityGet.y
						   , ( -0.005 < velocityGet.z && velocityGet.z < 0.005) ? 0 : velocityGet.z )
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		// Location functions
		////////////////////////////////////////////////////////////////////////////////////
		public function Location()
		{
			_positions[2] = new Vector3D();
			_positions[1] = new Vector3D();
			_positions[0] = new Vector3D();
			_rotations[2] = new Vector3D();
			_rotations[1] = new Vector3D();
			_rotations[0] = new Vector3D();
		}
		
		public function setTo( $val:Location ):void
		{
			positionSet = $val.positionGet;
			rotationSet = $val.rotationGet;
			velocitySet = $val.velocityGet;
			center.setTo( $val.center.x, $val.center.y, $val.center.z );
			_scale = $val._scale;
		}
		
		public function restoreOld( index:int = 1 ):void
		{
			//trace( "Location.restoreOld position["+index+"] position: " + _positions[index] );
			_position.setTo( _positions[index].x, _positions[index].y, _positions[index].z );
			_rotation.setTo( _rotations[index].x, _rotations[index].y, _rotations[index].z );
			_changed = true;
		}
		
		public function nearEquals( $val:Location ):Boolean
		{
			if ( !positionGet.nearEquals( $val.positionGet, 0.01 ) )
				return false;
			if ( !rotationGet.nearEquals( $val.rotationGet, 0.01 ) )
				return false;
			return true;	
		}

		////////////////////////////////////////////////////////////////////////////////////
		// matrix ops
		////////////////////////////////////////////////////////////////////////////////////
		// dont recalculate unless it is needed
		// that is when ever it is access and the data in it has changed
		protected function recalculateMatrix( force:Boolean = false ):void
		{  
			if ( changed || force )
			{
				_modelMatrix.identity();
				//Log.out( "recalculateMatrix - scale: " + _scale + "  center: " + center + "  centerConst: " + _centerConst );
				
				_modelMatrix.prependRotation( rotationGet.x, Vector3D.X_AXIS, _center );
				_modelMatrix.prependRotation( rotationGet.y,  Vector3D.Y_AXIS, _center );
				_modelMatrix.prependRotation( rotationGet.z, Vector3D.Z_AXIS, _center );
				
				var wsp:Vector3D = positionGet.clone();
				wsp.negate();
				_modelMatrix.prependTranslation( wsp.x
											  , wsp.y
											  , wsp.z );
				
				_modelMatrix.appendScale( 1/_scale.x, 1/_scale.y, 1/_scale.z );
												  
				_worldMatrix.copyFrom( _modelMatrix );
				_worldMatrix.invert();
				
				changed = false;
			}
		}
		
		public function get worldSpaceMatrix():Matrix3D 		{ recalculateMatrix(); return _worldMatrix; }
		public function get modelMatrix():Matrix3D 				{ recalculateMatrix(); return _modelMatrix; }
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Look At
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function lookAtVector( length:int ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.deltaTransformVector( new Vector3D( 0, 0, -length ) );
		}
		
		public function lookDownVector( length:int ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.deltaTransformVector( new Vector3D( 0, length, 0 ) );
		}
		
		public function lookUpVector( length:int ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.deltaTransformVector( new Vector3D( 0, -length, 0 ) );
		}
		
		public function lookRightVector( length:int ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.deltaTransformVector( new Vector3D( length, 0, 0 ) );
		}
		
		public function lookBackVector( length:int ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.deltaTransformVector( new Vector3D( 0, 0, length ) );
		}

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// WorldToModel and ModelToWorld
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function worldToModel( v:Vector3D ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return _modelMatrix.transformVector( v );
		}
		
		public function modelToWorld( v:Vector3D ):Vector3D
		{
			if ( changed )
				recalculateMatrix();
			return worldSpaceMatrix.transformVector( v );
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// JSON initialization from JSON
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function setScaleInfo( json:Object ):void {
			if ( json.scale )
			{
				var scl:Vector3D = new Vector3D();
				if ( json.scale.x )
				{
					scl.x = 1/json.scale.x;
					if ( 0 == _scale.x )
						scl.x = 1;
				}
				if ( json.scale.y )
				{
					scl.y = 1/json.scale.y;
					if ( 0 == scl.y )
						scl.y = 1;
				}
				if ( json.scale.z )
				{
					scl.z = 1/json.scale.z;
					if ( 0 == scl.z )
						scl.z = 1;
				}
				
				scale = scl;
			}
		}
		
		public function setCenterInfo( json:Object ):void {
			if ( json.center )
				centerSetComp( json.center.x, json.center.y, json.center.z );

		}
		
		public function setPositionalInfo( json:Object ):void {
			if ( json.location )
				positionSetComp( json.location.x, json.location.y, json.location.z );
			
			if ( json.rotation )
				rotationSetComp( json.rotation.x, json.rotation.y, json.rotation.z );
		}
	}
}