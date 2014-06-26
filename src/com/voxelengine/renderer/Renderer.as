/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer 
{
	import flash.display.Stage3D;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.FullScreenEvent;
	//import flash.system.Capabilities;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.FileReference;
	import flash.system.System;	
	
	import com.adobe.images.JPGEncoder;	
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;

	import com.voxelengine.worldmodel.models.Camera;
	import com.voxelengine.worldmodel.models.CameraLocation;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.Location;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class Renderer extends EventDispatcher 
	{
		private var _width:int;
		private var _height:int;
		private var _startingWidth:int = 0;
		private var _startingHeight:int = 0;
		
		private var _stage3D:Stage3D;
		private var _context:Context3D = null;
		
		private var _isFullScreen:Boolean = false;
		private var _isResizing:Boolean = false;

		private var _isHW:Boolean = true;

		private var _mvp:Matrix3D = new Matrix3D();
		private var _viewOffset:Vector3D = new Vector3D();
		
		public function get stage3D():Stage3D { return _stage3D; }
		
		public function get width():int { return _width; }
		public function get height():int { return _height; }
		public function get context():Context3D { return _context; }
		
		public function get hardwareAccelerated():Boolean { return _isHW; }
		
		public function viewOffsetSet( x:int, y:int, z:int ):void 
		{ 
			_viewOffset.x = x; _viewOffset.y = y; _viewOffset.z = z; 
		}

		private function addStageListeners():void 
		{
			Globals.g_app.stage.addEventListener( Event.RESIZE, resizeEvent );
			Globals.g_app.stage.addEventListener( FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED, fullScreenEvent );
		}
		
		private function addStage3DListeners():void 
		{
			_stage3D.addEventListener( Event.CONTEXT3D_CREATE, onContextCreated );
			_stage3D.addEventListener( ErrorEvent.ERROR, onStage3DError );
		}

		public function init( stage:Stage ):void 
		{
			setStageSize( stage.stageWidth, stage.stageHeight );
			addStageListeners();
			
			_stage3D = stage.stage3Ds[0];
			addStage3DListeners()

			_stage3D.x = 0;
			_stage3D.y = 0;
			
			// This allows flash to run on older video drivers.
			//Context3DProfile.BASELINE_CONSTRAINED
			_stage3D.requestContext3D( Context3DRenderMode.AUTO, Context3DProfile.BASELINE_CONSTRAINED);
			//_stage3D.requestContext3D( Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			
		}
		
		public function resizeEvent(event:Event):void 
		{
			//Log.out( "Render.resizeListener " );
			setStageSize( Globals.g_app.stage.stageWidth, Globals.g_app.stage.stageHeight);
			onContextCreated( event );
		}		
		
		public function setStageSize( w:int, h:int ):void {
			//Log.out( "Renderer.setStageSize w: " + w + "  h: " + h );
			_width = w;
			_height = h;

			_startingWidth = _width;
			_startingHeight = _height;
		}
		
		public function fullScreenEvent(event:FullScreenEvent):void {
			if ( event.fullScreen )
			{
				//Log.out( "Renderer - enter fullscreen has been called" + event );
				if( !Globals.g_app.stage.mouseLock )
					Globals.g_app.stage.mouseLock = true;
			}
			else if ( !event.fullScreen )
			{
				//Log.out( "Renderer - leaving fullscreen has been called" + event );
			}
		}
		
		public function toggleFullscreen():void
		{
			if ( StageDisplayState.NORMAL == Globals.g_app.stage.displayState )
				Globals.g_app.stage.displayState =	StageDisplayState.FULL_SCREEN_INTERACTIVE;
			else
				Globals.g_app.stage.displayState =	StageDisplayState.NORMAL;
		}

		public function screenShot( drawUI:Boolean ):void
		{
			var tmp : BitmapData = new BitmapData( _width, _height, false );
			// this draws the stage3D on the bitmap.
			render(tmp);
			
			// this adds on the gui
			if ( drawUI )
				tmp.draw( Globals.g_app.stage );
			
			var encoder:JPGEncoder = new JPGEncoder(90);
			var date:Date = new Date();
			var dateString:String = date.fullYear + "." + date.month + "." + date.day + "." + date.hours + "." + date.minutes + "." + date.seconds;
			new FileReference().save( encoder.encode(tmp), "voxelverse screenshot " + dateString + ".jpg");
			tmp.dispose();
		}

		public function setBackgroundColor( r:int=0, g:int=0, b:int=0 ):void {
			// Clears the back buffer to this color, for now it will be the "sky" color
			_context.clear( r/255, g/255, b/ 255, 0);
		}
		
		// This handles the event created in the init function
		public function onContextCreated(e:Event):void {
			//Log.out( "Renderer.onContextCreated" + e.toString() );

			// If new context and its not null, dispose of what we have
			if ( null != _context ) {
				Log.out("Renderer.onContextCreated - dispose" );
				Globals.g_modelManager.dispose();
				_context.dispose();
				_context = null;
			}

 			//Log.out("Renderer.onContextCreated " + Capabilities.version);
			if ( null == _context && "context3DCreate" == e.type ) {
				Log.out("Renderer.onContextCreated - reinitialize context: " + _stage3D.context3D );
				_context = _stage3D.context3D;
				if ( Globals.g_debug )
					_context.enableErrorChecking = true;
				else	
					_context.enableErrorChecking = false;
				Globals.g_modelManager.reinitialize();
			}

			if ( _context )
			{
				// 0	No antialiasing
				// 2	Minimal antialiasing.
				// 4	High-quality antialiasing.
				// 16	Very high-quality antialiasing.
				const antiAlias:int = 0;
				Log.out( "Renderer.onContextCreated - ANTI_ALIAS set to: " + antiAlias );
				
				// false indicates no depth or stencil buffer is created, true creates a depth and a stencil buffer. 
				const enableDepthAndStencil:Boolean = true;
				_context.configureBackBuffer( width, height, antiAlias, enableDepthAndStencil );
				
					
				//CONFIG::debug {	_context.enableErrorChecking = true; }			

				_isHW = _context.driverInfo.toLowerCase().indexOf("software") == -1;			
				if ( !_isHW )
					Log.out( "Renderer.onContextCreated - SOFTWARE RENDERING - driverInfo: " + _context.driverInfo, Log.WARN );
				else
					Log.out( "Renderer.onContextCreated - driverInfo: " + _context.driverInfo );
			}
		}
		
		// display message
		private function onStage3DError ( e:ErrorEvent ):void {
			//legend.text = "This content is not correctly embedded. Please change the wmode value to allow this content to run.";
			Log.out( "Renderer.onStage3DError !!!!!!!!!!!!!!!!!!!!!!!!!!!!Stage3DError occured!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", Log.ERROR );
		}		
	
		
		public function render( screenShot:BitmapData = null ):void 
		{
			if ( null == _context )
			{
				Log.out( "Renderer.render - CONTEXT NULL" );
				return;
			}
			
			if ( "Disposed" == _context.driverInfo )
			{
				Log.out( "Renderer.render - CONTEXT Disposed" + _context.toString() );
				return;
			}
				
			var cm:VoxelModel = Globals.controlledModel;
			// Very early in render cycle the controlled model may not be instantitated yet.
			if ( !cm )
				return;
				
			backgroundColor();
			
			var wsPositionCamera:Vector3D = cm.instanceInfo.worldSpaceMatrix.transformVector( cm.camera.current.position );
//			trace( "Renderer.render - wsPositionCamera: " + wsPositionCamera );
			wsPositionCamera.negate();
			
			// Empty starting matrix
			_mvp.identity();
			
			const cmRotation:Vector3D = cm.camera.rotationGet;
			_mvp.prependRotation( cmRotation.x, Vector3D.X_AXIS );
			_mvp.prependRotation( cmRotation.y, Vector3D.Y_AXIS );
			_mvp.prependRotation( cmRotation.z, Vector3D.Z_AXIS );

			// the position of the controlled model
 			_mvp.prependTranslation( wsPositionCamera.x, wsPositionCamera.y, wsPositionCamera.z ); 
			
			//var p:Vector3D = _mvp.position.clone();
			//p.negate();
			//trace( "Renderer.render - _mvp.position: " + _mvp.position + "  p: " + p );
			
			_mvp.append( perspectiveProjection(90, _width/_height, Globals.g_nearplane, Globals.g_farplane) );

			Globals.g_modelManager.draw( _mvp, _context );

			if ( screenShot )
				_context.drawToBitmapData( screenShot );
			else
				_context.present();
		}
		
		private function perspectiveProjection(fov:Number = 90, aspect:Number = 1, near:Number = 1, far:Number = 2048):Matrix3D {
			var y2:Number = near * Math.tan(fov * Math.PI / 360); 
			var y1:Number = -y2;
			var x1:Number = y1 * aspect;
			var x2:Number = y2 * aspect;
			
			var a:Number = 2 * near / (x2 - x1);
			var b:Number = 2 * near / (y2 - y1);
			var c:Number = (x2 + x1) / (x2 - x1);
			var d:Number = (y2 + y1) / (y2 - y1);
			var q:Number = -(far + near) / (far - near);
			var qn:Number = -2 * (far * near) / (far - near);
			
			return new Matrix3D(Vector.<Number>([
				a, 0, 0, 0,
				0, b, 0, 0,
				c, d, q, -1,
				0, 0, qn, 0
			]));
		}
		
		private function backgroundColor():void 
		{
			if ( Globals.g_regionManager.currentRegion )
			{
				var skyColor:Vector3D = Globals.g_regionManager.currentRegion.getSkyColor();
				// Not only does this set the color, but it appears to clear the "BackBuffer"
				setBackgroundColor( skyColor.x, skyColor.y, skyColor.z );
			}
			else
				setBackgroundColor( 92, 172, 238 );
		}
	}
}