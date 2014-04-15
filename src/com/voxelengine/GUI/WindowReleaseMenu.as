
package com.voxelengine.GUI
{
	import flash.utils.getQualifiedClassName;
	import flash.events.Event;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.globalization.DateTimeFormatter;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;	
	public class WindowReleaseMenu extends VVContainer
	{
		static private var _s_currentInstance:WindowReleaseMenu = null;
		static public function get currentInstance():WindowReleaseMenu { return _s_currentInstance; }
		private var _fpsLabel:Label = new Label("FPS:");
		private var _locLabel:Label = new Label("x: 0  y: 0  z: 0");
		private var _rotLabel:Label = new Label("x: 0  y: 0  z: 0");

		private var _startTime:int = 0;
		protected var _frames:int = 0;
		protected var _fps:int = 0;
		protected var _prefix:String = "";
		
		public function WindowReleaseMenu():void 
		{ 
			super();
			_s_currentInstance = this;
			//Globals.GUIControl = true;
			autoSize = false;
			padding = 10;
			shadow = true;
			layout.orientation = LayoutOrientation.VERTICAL;
			layout.horizontalAlignment = LayoutHorizontalAlignment.RIGHT;
			
//			var d:Date = new Date();
//			var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
			//dtf.setDateTimePattern("yyyy-MM-dd 'at' hh:mm:ssa");
//			dtf.setDateTimePattern( "yyyy-MM-dd" );
//			trace(dtf.format(d)); 

			var name:Label = new Label( "VoxelVerse" );
			name.fontSize = 14;
			addElement( name );
			_startTime = getTimer();
			_prefix = "FPS: ";
			_fpsLabel.fontSize = 14;
			addElement( _fpsLabel );
			_locLabel.fontSize = 14;
			addElement( _locLabel );
			_rotLabel.fontSize = 14;
			addElement( _rotLabel );
			var spacer:Label = new Label( "" );
			spacer.fontSize = 14;
			addElement( spacer );
			var fs:Label = new Label( "FullScreen F9" );
			fs.fontSize = 14;
			addElement( fs );
			var ss:Label = new Label( "Screen Shot F12" );
			ss.fontSize = 14;
			addElement( ss );
			/* These were used when mouse was active.
			if ( Globals.g_app.configManager.showButtons )
			{
//				if ( !Globals.g_debug )
//					addButton( "Help"	, { callback:showHelpWindow } );
					
				var fullScreenButton:Box = new Box(64,64);
				fullScreenButton.backgroundTexture = "assets/textures/fullscreen.png";
				fullScreenButton.addEventListener(UIMouseEvent.PRESS, fullScreenHandler );
				addElement( fullScreenButton );
				
				var screenShotButton:Box = new Box(64,64);
				screenShotButton.backgroundTexture = "assets/textures/screenshot.png";
				screenShotButton.addEventListener(UIMouseEvent.PRESS, screenShotHandler );
				addElement( screenShotButton );
			
				if ( true == Globals.sandbox )
				{
					var sandboxButton:Box = new Box(64,64);
					sandboxButton.backgroundTexture = "assets/textures/sandbox.png";
					sandboxButton.addEventListener(UIMouseEvent.PRESS, sandboxHandler );
					addElement( sandboxButton );
				}
			}
			*/
			
			display( 0, 0 );	
			
			Globals.g_app.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
			
			onResize(null);
		} 
		
        protected function onResize(event:Event):void
        {
			move( Globals.g_renderer.width - 120, 0 );
		}
		
		private function fullScreenHandler(e:UIMouseEvent):void 
		{
			Globals.g_renderer.toggleFullscreen();
		}
		
		private function sandboxHandler(e:UIMouseEvent):void 
		{
			if ( !WindowSandboxList.isActive )
				WindowSandboxList.create();
		}
		
		private function screenShotHandler(e:UIMouseEvent):void 
		{
			Globals.g_renderer.screenShot( true );
		}
		
		private function onEnterFrame( event:Event ):void
		{
			updateFPS();
			updateLocation();
		}
		
		private function updateLocation():void
		{
			if ( Globals.controlledModel )
			{
				var loc:Vector3D = Globals.controlledModel.instanceInfo.positionGet;
				_locLabel.text = "x: " + int( loc.x ) + "  y: " + int( loc.y ) + "  z: " + int( loc.z ); 
				var rot:Vector3D = Globals.controlledModel.instanceInfo.rotationGet;
				_rotLabel.text = "x: " + int( rot.x ) + "  y: " + int( rot.y ) + "  z: " + int( rot.z ); 
			}
		}
		
		private function updateFPS():void
		{
			_frames++;
			var time:int = getTimer();
			var elapsed:int = time - _startTime;
			if(elapsed >= 1000)
			{
				_fps = Math.round(_frames * 1000 / elapsed);
				_frames = 0;
				_startTime = time;
				// update the parent component with the right 
				_fpsLabel.text = _prefix + _fps.toString();
			}
			
		}
		
		public static function addCommasToLargeInt( value:int ):String 
		{
			var answer:String = "";
			var sub:String = "";
			var remainder:String = value.toString();
			var len:int = remainder.length;
			for (; 3 < len;) {
				sub = "," + remainder.substr( len - 3, len );
				remainder = remainder.substr( 0, len - 3 );
				len = remainder.length;
				answer = sub + answer;
			}
			
			return answer;
		}
		
	}
}