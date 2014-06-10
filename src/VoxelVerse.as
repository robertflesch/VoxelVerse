/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.events.LoadingEvent;
	import com.voxelengine.GUI.VoxelVerseGUI;
	import com.voxelengine.GUI.WindowSplash;
	import com.voxelengine.renderer.Renderer;
	import com.voxelengine.worldmodel.ConfigManager;
	import com.voxelengine.worldmodel.MemoryManager;
	import com.voxelengine.pools.PoolManager;
	import com.voxelengine.worldmodel.MouseKeyboardHandler;
	import com.voxelengine.worldmodel.RegionManager;

	import com.voxelengine.events.LightEvent;
	import com.voxelengine.worldmodel.tasks.lighting.LightAdd;
	import com.voxelengine.worldmodel.tasks.lighting.LightRemove;
	
	// TODO Flowing materials
	// TODO Gas
	// TODO Light maps
	
	public class VoxelVerse extends Sprite 
	{
		private var _timePrevious:int = getTimer();
		
		private var _configManager:ConfigManager = null;
		private var _poolManager:PoolManager = null;
		
		private var _showConsole:Boolean = false;
		private var _toolOrBlockEnabled: Boolean = false;
		private var _editing: Boolean = true;
		
		public function get editing():Boolean { return _editing; }
		public function set editing(val:Boolean):void { _editing = val; }
		public function get toolOrBlockEnabled():Boolean { return _toolOrBlockEnabled; }
		public function set toolOrBlockEnabled(val:Boolean):void { _toolOrBlockEnabled = val; }
		public function get configManager():ConfigManager { return _configManager; }
		
		public function get showConsole():Boolean { return _showConsole; }
		public function set showConsole(value:Boolean):void { _showConsole = value; }

		// Main C'tor for project
		public function VoxelVerse():void {
			addEventListener(Event.ADDED_TO_STAGE, init);
			Globals.g_app = this;
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			try
			{
				var urlPath:String = ExternalInterface.call("window.location.href.toString");
				Log.out( "VoxelVerse.swf loaded from: " + urlPath, Log.INFO);
				var index:int = urlPath.indexOf( "index.html" );
				if ( -1 == index )
				{
					index = urlPath.lastIndexOf( "/" );
					var gap:String = urlPath.substr( 0, index + 1 );
					Globals.appPath = gap;
				}
				else
					Globals.appPath = urlPath.substr( 0, index );
			}
			catch ( error:Error )
			{
				Log.out("VoxelVerse.init - ExternalInterface not found, using default location", Log.INFO);
				Globals.appPath = "";
			}
			
			// expect an exception to be thrown and caught here, the best way I know of to find out of we are in debug or release mode
			try
			{
				var result : Boolean = new Error().getStackTrace().search(/:[0-9]+]$/m) > -1;
				Globals.g_debug = result;
			}
			catch ( error:Error )
			{
				Globals.g_debug = false;
			}
			
			Globals.g_renderer.init( stage );
			
			addEventListener(LoadingEvent.SPLASH_LOAD_COMPLETE, onSplashLoaded);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
			stage.addEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
			stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, mouseDownRight);
			stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, mouseUpRight);
			
			addEventListener( LightEvent.ADD, LightAdd.handleLightEvents );
			addEventListener( LightEvent.CHANGE, LightAdd.handleLightEvents );
			addEventListener( LightEvent.REMOVE, LightRemove.handleLightEvents );
			
			VoxelVerseGUI.currentInstance.init();

			if ( false == WindowSplash.isActive )
				WindowSplash.create();
		}

		// after the splash and config have been loaded
		public function onSplashLoaded( event : LoadingEvent ):void
		{
			// TODO I dont like that some objects are created in globals, others are created here - RSF
			removeEventListener(LoadingEvent.SPLASH_LOAD_COMPLETE, onSplashLoaded);
			_poolManager = new PoolManager();
			Globals.g_regionManager = new RegionManager();
			_configManager = new ConfigManager();
			_poolManager = new PoolManager();
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.DEACTIVATE, deactivate);
			addEventListener(Event.ACTIVATE, activate);
			
			VoxelVerseGUI.currentInstance.buildGUI();	
		}

		private function enterFrame(e:Event):void 
		{
			var timeEntered:int = getTimer();
			var elapsed:int = timeEntered - _timePrevious;
			_timePrevious = timeEntered;
			
			MemoryManager.update();
			
			var timeUpdate:int = getTimer();
			Globals.g_modelManager.update( elapsed );
			timeUpdate = getTimer() - timeUpdate;
			
			var timeRender:int = getTimer();
			Globals.g_renderer.render();
			timeRender = getTimer() - timeRender;
			
			if ( showConsole )
				toggleConsole();
//			Log.out( "VoxelVerse.enterFrame - render: " + timeRender + "  timeUpdate: " + timeUpdate + "  total time: " +  + ( getTimer() - timeEntered ) + "  time to get back to app: " + elapsed );
			_timePrevious = getTimer();
		}
		
		private function deactivate(e:Event):void 
		{
//			Log.out( "VoxelVerse.deactive" + e.toString() );
			Globals.active = false;
			Globals.clicked = false;
			MemoryManager.update();
			MouseKeyboardHandler.reset();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			dispatchEvent( new GUIEvent( GUIEvent.APP_DEACTIVATE ) );
			
			if ( Globals.MODE_LOCAL != Globals.mode )
			{
				Globals.g_modelManager.save();
				Globals.g_regionManager.save();
			}
		}
		
		private function activate(e:Event):void 
		{
//			Log.out( "VoxelVerse.active" + e.toString() );
			Globals.active = true;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			dispatchEvent( new GUIEvent( GUIEvent.APP_ACTIVATE ) );
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			Globals.clicked = true;
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseDownRight(e:MouseEvent):void {
//			Log.out("VoxelVerse.mouseDownRight" );
			Globals.mouseView = true;
		}
		
		private function mouseUpRight(e:MouseEvent):void {
//			Log.out("VoxelVerse.mouseUpRight" );
			Globals.mouseView = false;
		}
		
		private function onMouseRightClick(e:MouseEvent):void 
		{
			//trace ( "VoxelVerse.onMouseRightClick - Right click functions enabled" )
		}
		
		/**
		 * Called when the app gains focus, now keyboard and mouse
		 * event are handled
		 * 
		 * 	@param e 	MouseEvent Object generated by system
		 */
		private function mouseMove(e:MouseEvent):void 
		{
			//Log.out( "VoxelVerse.mouseMove" + e.toString() );
			if ( Globals.clicked )
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			}
			Globals.active = true;
		}
		
		/**
		 *  Called when the mouse leaves the app
		 *  by leaving the app, the active is set to false
		 *  and the mouse view is turned off.
		 *  This allow the app to not pick up any other mouse or keyboard
		 *  activity when app is not active
		 * 
		 * 	@param e 	Event Object generated by system
		 */
		public function mouseLeave( e:Event ):void
		{
			//Log.out( "VoxelVerse.mouseLeave" + e.toString() );
			Globals.active = false;
			Globals.mouseView = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}

		private function toggleConsole():void 
		{
			showConsole = false;
			if ( Log.showing )
				Log.hide();
			else
				Log.show();
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode) {
				case Keyboard.BACKQUOTE:
					// trying to stop the BACKQUOTE from getting to the doomsday console.
					//e.stopImmediatePropagation();
					showConsole = true;
					break;
			}
		}
		
		
	}
}