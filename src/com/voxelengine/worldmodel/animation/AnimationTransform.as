/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.animation
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import flash.geom.Vector3D;
	import org.flashapi.swing.text.ATM;
	import com.voxelengine.worldmodel.models.ModelTransform;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class AnimationTransform
	{
		private var _attachmentName:String = "INVALID_ATTACHMENT";
		private var _position:Vector3D = new Vector3D();
		private var _hasPosition:Boolean = false;
		private var _rotation:Vector3D = new Vector3D();
		private var _hasRotation:Boolean = false;
		private var _scale:Vector3D = new Vector3D(1,1,1);
		private var _hasScale:Boolean = false;
		private var _transforms:Vector.<ModelTransform> = new Vector.<ModelTransform>;
		private var _hasTransform:Boolean = false;
		private var _notNamed:Boolean = false;
		
		public function AnimationTransform( $json:Object ) 
		{ 
			if ( $json.attachmentName )
				_attachmentName = $json.attachmentName;
			else
				Log.out( "AnimationTransform - No attachmentName name", Log.ERROR );
				
			if ( $json.location )
			{
				_position = new Vector3D( $json.location.x, $json.location.y, $json.location.z );
				_hasPosition = true
			}
			
			// Transforms which are not named will stick around even after animation is played
			// So they should only be used on timed animations.
			if ( $json.notNamed )
			{
				_notNamed = $json.notNamed;
			}
			
			if ( $json.scale )
			{
				_scale = new Vector3D( $json.scale.x, $json.scale.y, $json.scale.z );
				_hasScale = true;
			}
			
			if ( $json.rotation )
			{
				_rotation = new Vector3D( $json.rotation.x, $json.rotation.y, $json.rotation.z );
				_hasRotation = true
			}
				
			if ( $json.transforms )
			{
				_hasTransform = true;
				for each ( var modelTransform:Object in $json.transforms )
				{
					var type:int = ModelTransform.stringToType( modelTransform.type.toLowerCase() );
					if ( "life" == modelTransform.type.toLowerCase() )
						addTransform( 0
									, 0
									, 0
									, modelTransform.time
									, type
									, attachmentName );
					else
					{
						if ( !modelTransform.time || !modelTransform.type )
						{
							Log.out( "AnimationTransform.construct - ALL transforms must contain x,y,z,time, type, and name values attachmentName: " + _attachmentName + "  mt data: " + modelTransform );
							return;
						}

						addTransform( modelTransform.delta.x
									, modelTransform.delta.y
									, modelTransform.delta.z
									, modelTransform.time
									, type
									, attachmentName );
					}
				}
			}
		}
		
		public function clone( $val:Number = 1 ):AnimationTransform
		{
			new Error( "AnimationTransform.clone - NOT VALIDATED" );
			var obj:Object = new Object();
			obj.attachmentName = _attachmentName;
			var at:AnimationTransform = new AnimationTransform( obj );
			at._position = position.clone();
			at._rotation = rotation.clone();
			at._scale = scale.clone();
			for each ( var mt:ModelTransform in _transforms )
				at._transforms.push( mt.clone( $val ) );
			return at;
		}

		public function addTransform( $x:Number, $y:Number, $z:Number, $time:Number, $type:int, $name:String = "Default" ):void 
		{
			_transforms.push( new ModelTransform( $x, $y, $z, $time, $type, $name ) );
			//Log.out( "InstanceInfo.addTransform " + mt.toString() );
		}
		
		public function get position():Vector3D 
		{
			return _position;
		}
		
		public function get rotation():Vector3D 
		{
			return _rotation;
		}
		
		public function get scale():Vector3D 
		{
			return _scale;
		}
		
		public function get transforms():Vector.<ModelTransform>
		{
			return _transforms;
		}
		
		public function get attachmentName():String 
		{
			return _attachmentName;
		}
		
		public function get hasPosition():Boolean 
		{
			return _hasPosition;
		}
		
		public function get hasRotation():Boolean 
		{
			return _hasRotation;
		}
		
		public function get hasScale():Boolean 
		{
			return _hasScale;
		}
		
		public function get hasTransform():Boolean 
		{
			return _hasTransform;
		}
		
		public function get notNamed():Boolean 
		{
			return _notNamed;
		}
		
		public function toString():String
		{
			return " attachmentName: " + _attachmentName + "  position: " + _position +  "  scale: " + _scale + "  rotation: " + _rotation + " transform: " + _transforms;
		}
		
	}
}
