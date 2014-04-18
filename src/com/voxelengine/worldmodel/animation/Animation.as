/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.animation
{
	import com.voxelengine.events.LoadingEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import mx.utils.StringUtil;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.utils.CustomURLLoader;
	import com.voxelengine.worldmodel.models.VoxelModel;

	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * The world model holds the active oxels
	 */
	public class Animation
	{
		private var _loaded:Boolean = false;
		private var _name:String;
		private var _transforms:Vector.<AnimationTransform> = new Vector.<AnimationTransform>;
		private var _attachments:Vector.<AnimationAttachment> = new Vector.<AnimationAttachment>;
		private var _loader:CustomURLLoader;
		private var _owner:String;
		
		private var _sound:AnimationSound = null;
		
		public function get name():String  { return _name; }
		public function get transforms():Vector.<AnimationTransform> { return _transforms; }
		public function get loaded():Boolean { return _loaded; }
		
		public function Animation( $animationName:Object, $owner:String ) 
		{ 
			_owner = $owner;
			if ( $animationName.name )
			{
				_name = $animationName.name;
				load( _name );
			}
			else
				Log.out( "Animation - No animation name", Log.ERROR );	
		}
		
		public function init( $json:Object ):void 
		{
			//Log.out( "Animation.init - fileName: " + _name );
			if ( $json.sound )
			{
				_sound = new AnimationSound();
				_sound.init( $json.sound );
			}
			if ( $json.attachment )
			{
				for each ( var attachmentJson:Object in $json.attachment )
				{
					_attachments.push( new AnimationAttachment( attachmentJson ) );				
				}
			}
			if ( $json.animation )
			{
				for each ( var transformJson:Object in $json.animation )
				{
					_transforms.push( new AnimationTransform( transformJson ) );				
				}
			}
			
			Globals.g_app.dispatchEvent( new LoadingEvent( LoadingEvent.ANIMATION_LOAD_COMPLETE, name ) );
		}
		
		public function play( $owner:VoxelModel, $val:Number ):void
		{
			//Log.out( "Animation.play - name: " + _name );
			if ( _sound )
				_sound.play( $owner, $val );
				
			if ( 0 < _attachments.length )
			{
				for each ( var aa:AnimationAttachment in _attachments )
				{
					var cm:VoxelModel = $owner.childFindByName( aa.attachsTo );
					if ( cm )
					{
						aa.create( cm );
					}
				}
			}
		}
		
		public function stop( $owner:VoxelModel ):void
		{
			if ( _sound )
				_sound.stop();
				
			if ( 0 < _attachments.length )
			{
				for each ( var aa:AnimationAttachment in _attachments )
				{
					var cm:VoxelModel = $owner.childFindByName( aa.attachsTo );
					if ( cm )
					{
						aa.detach();
					}
				}
			}
		}
		
		public function update( $val:Number ):void
		{
			if ( _sound )
				_sound.update( $val / 3 );
		}
		
		static private const ANIMATION_FILE_EXT:String = ".ajson"
		private function load( $fileName:String ):void
		{
			var fileName:String = $fileName + ANIMATION_FILE_EXT
			var aniNameAndLoc:String = Globals.modelPath + _owner + "/" + fileName;
			//Log.out( "Animation.load - loading: " + aniNameAndLoc );
			var request:URLRequest = new URLRequest( aniNameAndLoc );
			_loader = new CustomURLLoader(request);
			_loader.addEventListener(Event.COMPLETE, onLoadedAction);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorAction);
		}
		
		private function onLoadErrorAction(event:IOErrorEvent):void
		{
			_loader.reportIOError( event, "Animation.onLoadErrorAction: ERROR LOADING ANIMATION: " );
		}	
			
		private function onLoadedAction(event:Event):void
		{
			_loaded = true;
			Log.out( "Animation.onLoadedAction - LOADED: " + name );
			try 
			{
				var jsonString:String = StringUtil.trim( String(event.target.data) );
				var jsonResult:Object = JSON.parse(jsonString);
			}
			catch ( error:Error )
			{
				_loader.reportError( event, "Animation.onLoadedAction - ERROR PARSING: " );
			}
			
			init( jsonResult );
		}       
	}
}
