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
	
	import com.voxelengine.events.TransformEvent;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */

	public class ModelTransform
	{
		static private var objectEnum:int = 0;
		static public const LOCATION:int = objectEnum++; 	
		static public const LOCATION_TO:int = objectEnum++;
		static public const LOCATION_REPEATING:int = objectEnum++;
		static public const SCALE:int = objectEnum++;		
		static public const ROTATION:int = objectEnum++;    
		static public const ROTATE_TO:int = objectEnum++;   
		static public const ROTATION_REPEATING:int = objectEnum++;
		static public const LIFE:int = objectEnum++;		
		static public const VELOCITY:int = objectEnum++;
		static public const INFINITE_TIME:int = -1;
		
		static public const LOCATION_STRING:String 				= "location"
		static public const LOCATION_TO_STRING:String			= "location_to"
		static public const LOCATION_REPEATING_STRING:String 	= "location_repeating"
		static public const SCALE_STRING:String 				= "scale"
		static public const ROTATION_STRING:String 				= "rotation"
		static public const ROTATE_TO_STRING:String 			= "rotate_to"
		static public const ROTATION_REPEATING_STRING:String 	= "rotation_repeating"
		static public const LIFE_STRING:String 					= "life"
		static public const VELOCITY_STRING:String 				= "velocity"
		
		static private const TIMELEFT_INFINITE:int = -1;
		
		private var _time:int = 0;
		private var _originalTime:int = 0;
		private var _delta:Vector3D = new Vector3D();
		private var _transformTarget:Vector3D;
		private var _type:int;
		private var _name:String;
		private var _guid:String = "INVALID";
		private var _inverse:Boolean = false;  // REPEATING ROTATIONS change the sign on the delta every cycle.
		
		public function get time():int { return _time; }
		public function set time(val:int):void 
		{ 
			if ( 0 == time ) 
				_originalTime = val;  
			_time = val; 
		}
		public function get type():int { return _type; }
		public function set type(val:int):void { _type = val; }
		private function get transformTarget():Vector3D { return _transformTarget; }
		private function set transformTarget(val:Vector3D):void { _transformTarget = val; }
		public function get delta():Vector3D { return _delta; }
		private function set delta(val:Vector3D):void { _delta = val; }
		public function get name():String { return _name; }
		public function set name(val:String):void { _name = val; }
		
		public function ModelTransform( $x:Number, $y:Number, $z:Number, $time:Number, $type:int, $name:String = "Default" )
		{
			if ( 0 == $time )
				Log.out( "InstanceInfo.addTransform - No time defined", Log.ERROR );

			if ( 0 == $x && 0 == $y && 0 == $z && 0 == $time && ModelTransform.LIFE != $type )
				Log.out( "InstanceInfo.addTransform - No values defined", Log.ERROR );
			
			name = $name;
			type = $type;
			if ( type == ModelTransform.SCALE )
			{
				_delta.x = ($x - 1)  / 1000;
				_delta.y = ($y - 1) / 1000;
				_delta.z = ($z - 1) / 1000;
			}
			else if ( ModelTransform.ROTATE_TO == type || ModelTransform.LOCATION_TO == type )
			{
				_delta.x = $x;
				_delta.y = $y;
				_delta.z = $z;
			}
			else
			{
				_delta.x = $x / ( 1000 * $time );
				_delta.y = $y / ( 1000 * $time );
				_delta.z = $z / ( 1000 * $time );
			}
			
			if ( ModelTransform.INFINITE_TIME == $time )
				time = $time;
			else
				time = $time * 1000;
				
//			if ( ModelTransform.LIFE == type )
//				Log.out( "ModelTransform.constructor - data: " + toString() );	
		}
		
		// Animations use these as throw aways, when scaling animations
		public function clone( $val:Number ):ModelTransform
		{
			var mt:ModelTransform = new ModelTransform( 0, 0, 0, time, type, name );
			mt._delta.setTo( _delta.x * $val, _delta.y * $val, _delta.z * $val );
			mt._time = _time;
			mt._originalTime = _originalTime;
			return mt;
		}

		public function assignToInstanceInfo( ii:InstanceInfo ):String
		{
			if ( ii )
			{
				if ( _guid != "INVALID" )
					Log.out( "ModelTransform.assignToInstanceInfo - Guid already assigned", Log.ERROR );
				_guid = Globals.getUID();
			}
			
			if  (  ModelTransform.LOCATION == type 
				|| ModelTransform.LOCATION_REPEATING == type )	 	
				transformTarget = ii.positionGet;
			else if (  ModelTransform.ROTATION == type
					|| ModelTransform.ROTATION_REPEATING == type )	
				transformTarget = ii.rotationGet;
			else if (  ModelTransform.ROTATE_TO == type )	
			{
				transformTarget = ii.rotationGet;
				// This one cant get its delta until it gets its transform target
				_delta.x = ( _delta.x - transformTarget.x ) / time;
				_delta.y = ( _delta.y - transformTarget.y ) / time;
				_delta.z = ( _delta.z - transformTarget.z ) / time;
			}
			else if (  ModelTransform.LOCATION_TO == type )	
			{
				transformTarget = ii.positionGet;
				// This one cant get its delta until it gets its transform target
				_delta.x = ( _delta.x - transformTarget.x ) / time;
				_delta.y = ( _delta.y - transformTarget.y ) / time;
				_delta.z = ( _delta.z - transformTarget.z ) / time;
			}
			else if ( ModelTransform.SCALE == type )		transformTarget = ii.scale;
			else if ( ModelTransform.LIFE == type )			transformTarget = ii.life;
			else if ( ModelTransform.VELOCITY == type )		transformTarget = ii.velocityGet;
			
			return _guid;
		}
		
		public function modify( $referenceMt:ModelTransform, $val:Number ):void
		{
			_delta.setTo( $referenceMt._delta.x * $val, $referenceMt._delta.y * $val, $referenceMt._delta.z * $val );
			if ( _inverse )
				_delta.negate();
		}
		
		public function update( elapsedTimeMS:int, owner:VoxelModel ):Boolean
		{
			if ( null == transformTarget )
			{
				Log.out( "ModelTransform.update - ERROR - No transfrom target OR assigned is false" );
				return true;
			}
			
			var channelRunTime:Number = 0;
			if ( _time > 0 || _time == TIMELEFT_INFINITE )
			{
				// Translate channel active, update position
				if ( _time == TIMELEFT_INFINITE )
				{
					channelRunTime = elapsedTimeMS;
				}
				else
				{
					// if no time is left, return the remaining time as run time.
					// if this is the object's life, removed it.
					if ( elapsedTimeMS >= _time )
					{
						if ( ROTATION_REPEATING == type || LOCATION_REPEATING == type )
						{
							_time = _originalTime;
							_delta.negate();
							_inverse = !_inverse;
						}
						else
						{
							channelRunTime = _time;
							_time = 0;
							Globals.g_app.dispatchEvent( new TransformEvent( TransformEvent.ENDED, _guid, name ) );
						}
					}
					else
					{
						channelRunTime = elapsedTimeMS;
						_time -= elapsedTimeMS;
					}
				}
			}
			
			if ( 0 < channelRunTime )
			{
				if ( VELOCITY == type )
				{
					var dr:Vector3D = owner.instanceInfo.worldSpaceMatrix.deltaTransformVector( new Vector3D(0, 1, -1) );
	
					_transformTarget.x += channelRunTime * _delta.x * dr.x;
					_transformTarget.y += channelRunTime * _delta.y * dr.y;
					_transformTarget.z += channelRunTime * _delta.z * dr.z;
					
					//Log.out( "ModelTransform.update - Velocity: " + _transformTarget );
				}
				else
				{
					_transformTarget.x += channelRunTime * _delta.x;
					_transformTarget.y += channelRunTime * _delta.y;
					_transformTarget.z += channelRunTime * _delta.z;
					
					if ( ROTATION == type )
					{
						_transformTarget.x = _transformTarget.x % 360;
						_transformTarget.y = _transformTarget.y % 360;
						_transformTarget.z = _transformTarget.z % 360;
					}
					
				}
			}

			// this was doing bad things
			//if ( 0 == _time && VELOCITY == type )
			//{
				// return velocity to original value
				//_transformTarget.x -= _delta.x * 1000 * _originalTime/1000;
				//_transformTarget.y -= _delta.y * 1000 * _originalTime/1000;
				//_transformTarget.z -= _delta.z * 1000 * _originalTime/1000;
				//_transformTarget.x = Math.round( _transformTarget.x );
				//_transformTarget.y = Math.round( _transformTarget.y );
				//_transformTarget.z = Math.round( _transformTarget.z );
				//Log.out( "ModelTransfrom.return velocity to original: " + _transformTarget.y )
			//}
			
			if ( 0 == _time )
				return true;
				
			return false;
		}
		
		public function toJSON(k:*):* 
		{ 
			var outTime:int = -1;
			if ( TIMELEFT_INFINITE != _originalTime )
				outTime = _originalTime / 1000;
				
			var outDelta:Vector3D = _delta.clone();
			outDelta.scaleBy( 1000 );
			
			var outType:String = typeToString(_type);
			
			return {
					delta:		outDelta,
					time:		outTime,
					type:		outType
				};
		} 			
		
		static public function stringToType( val:String ):int
		{
			if ( LOCATION_STRING == val.toLowerCase() )
				return LOCATION;
			if ( LOCATION_TO_STRING == val.toLowerCase() )
				return LOCATION_TO;
			if ( LOCATION_REPEATING_STRING == val.toLowerCase() )
				return LOCATION_REPEATING;
			else if ( SCALE_STRING == val.toLowerCase() )
				return SCALE;
			else if ( ROTATION_STRING == val.toLowerCase() )
				return ROTATION;
			else if ( ROTATE_TO_STRING == val.toLowerCase() )
				return ROTATE_TO;
			else if ( ROTATION_REPEATING_STRING == val.toLowerCase() )
				return ROTATION_REPEATING;
			else if ( LIFE_STRING == val.toLowerCase() )
				return LIFE;
			else if ( VELOCITY_STRING == val.toLowerCase() )
				return VELOCITY;
			else
				Log.out( "ModelTransform.stringToType - ERROR - type not found: " + val, Log.ERROR );
			return -1;
		}

		static public function typeToString( val:int ):String
		{
			if ( LOCATION == val )
				return LOCATION_STRING;
			if ( LOCATION_TO == val )
				return LOCATION_TO_STRING;
			if ( LOCATION_REPEATING == val )
				return LOCATION_REPEATING_STRING;
			else if ( SCALE == val )
				return SCALE_STRING;
			else if ( ROTATION == val )
				return ROTATION_STRING;
			else if ( ROTATE_TO == val )
				return ROTATE_TO_STRING;
			else if ( ROTATION_REPEATING == val )
				return ROTATION_REPEATING_STRING;
			else if ( LIFE == val )
				return LIFE_STRING;
			else if ( VELOCITY == val )
				return VELOCITY_STRING;
			else
				Log.out( "ModelTransform.typeToString - ERROR - type not found: " + val, Log.ERROR );
				
			return "Undefined";
		}

		public function toString():String 
		{ 
			return "ModelTransform - delta: " +  _delta + "  time: " + _time + "  type: " + typeToString( _type ) + "  name: " + name;
		} 			
	}
}