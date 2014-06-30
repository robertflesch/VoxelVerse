/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.animation
{
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class AnimationAttachment
	{
		private var _attachsTo:String = "INVALID_ATTACHMENT";
		private var _instanceInfo:InstanceInfo = null;
		private var _voxelModel:VoxelModel = null;
		private var _owner:VoxelModel = null;
		
		public function AnimationAttachment( $json:Object ) 
		{
			if ( $json.attachsTo )
				_attachsTo = $json.attachsTo;
			else
				throw new Error( "AnimationAttachment.construct - NO attachsTo" );
			
			Log.out( "AnimationAttachment - _attachsTo: " + _attachsTo + " fileName: " + $json.fileName );
			_instanceInfo = new InstanceInfo();
			_instanceInfo.initJSON( $json );
		}
		
		public function get instanceInfo():InstanceInfo 
		{
			return _instanceInfo;
		}
		
		public function get attachsTo():String 
		{
			return _attachsTo;
		}
		
		public function create( $owner:VoxelModel ):void
		{
			Log.out( "AnimationAttachment.create owner: " + $owner.toString() );
			_owner = $owner;
			_instanceInfo.controllingModel = $owner;
			if ( null == _voxelModel )
			{
				Globals.g_app.addEventListener( ModelEvent.CHILD_MODEL_ADDED, onAttachmentCreated );
				Globals.g_modelManager.create( _instanceInfo );
			}
			else
			{
				//Log.out( "AnimationAttachment.create owner: " + $owner.toString() + "   attachment: " + _voxelModel.toString() );
				$owner.childAdd( _voxelModel );
			}
		}
		
		public function detach():void
		{
			//Log.out( "AnimationAttachment.detach owner: " + _owner.toString() + "   attachment: " + _voxelModel.toString() );
			if ( null != _voxelModel && null != _owner )
				_owner.childRemove( _voxelModel );
		}
		
		private function onAttachmentCreated( event:ModelEvent ):void
		{
			//Log.out( "AnimationAttachment.onAttachmentCreated owner: " + _owner.toString() );
			if ( event.instanceGuid == _instanceInfo.instanceGuid )
			{
				_voxelModel = Globals.g_modelManager.getModelInstance( _instanceInfo.instanceGuid );
				_owner.childAdd( _voxelModel );
				Globals.g_app.removeEventListener( ModelEvent.CHILD_MODEL_ADDED, onAttachmentCreated );			
			}
				
		}
	}
}
