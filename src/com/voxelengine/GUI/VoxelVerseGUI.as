
package com.voxelengine.GUI
{
	import com.voxelengine.events.GUIEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.net.FileReference;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import flash.events.FullScreenEvent;
	import flash.display.StageDisplayState;
	
	import org.flashapi.swing.UIManager;
	
	import playerio.DatabaseObject;
	import playerio.PlayerIOError;

	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	import com.voxelengine.events.LoadingEvent;
	import com.voxelengine.events.LoginEvent;
	import com.voxelengine.events.ModeChoiceEvent;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.events.RegionEvent;
	
	import com.voxelengine.server.WindowLogin;
	import com.voxelengine.server.EventHandlers;
	import com.voxelengine.server.Network;
	
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
//	import com.voxelengine.worldmodel.scripts.FireProjectileScript;
	
	public class VoxelVerseGUI extends EventDispatcher
	{
		//	----------------------------------------------------------------
		//	PRIVATE MEMBERS
		//	----------------------------------------------------------------
		
		private const CROSS_HAIR_YELLOW:int = 0xCCFF00;
		private const CROSS_HAIR_RED:int = 0xFF0000;
		private var _crossHairColor:int = CROSS_HAIR_RED;
		private var _crossHairHorizontal : Sprite = new Sprite();
		private var _crossHairVertical : Sprite = new Sprite();
		private var _crossHairAdded:Boolean = false;
		private var _crossHairHide:Boolean = false;
		
		private var _built:Boolean = false;
		private var _debugMenu:WindowDebugMenu = null;
		private var _releaseMenu:WindowReleaseMenu = null;
		
		private var _fileReference:FileReference = new FileReference();

		private var _dirty : Boolean;
		
		private var _bulletSize:int = 2;
		private var _projectileEnabled:Boolean = true;
		private var _hub:Hub = null;
		private var _initialized:Boolean = false;

		static private var _currentInstance:VoxelVerseGUI = null;
		static public function get currentInstance():VoxelVerseGUI 
		{
			if ( null == _currentInstance )
				_currentInstance = new VoxelVerseGUI();
				
			return _currentInstance;
		}
		

		//	CONSTRUCTOR
		//	----------------------------------------------------------------
		public function VoxelVerseGUI(title : String = null) { 
			
					Globals.g_app.stage.addEventListener( FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED, fullScreenEvent );
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

		
		
		public function get toolBar(): Hub { return _hub; }
		
		private static var _openWindowCount:int = 0;
		static public function get openWindowCount():int { return _openWindowCount; }
		static public function set openWindowCount(value:int):void  
		{ 
			_openWindowCount = value; 
			
			if ( 0 == _openWindowCount ) {
				Globals.GUIControl = false;
				Globals.g_app.stage.mouseLock = true;
			}
			else {
				Globals.GUIControl = true;
				Globals.g_app.stage.mouseLock = false;
			}
		}
		
		
		private function createProjectile( vm:VoxelModel ):void 
		{
			/*
			if ( _projectileEnabled )
			{
				var ps:FireProjectileScript = new FireProjectileScript( _bulletSize );
				ps.accuracy = 0;
				ps.velocity = 1200;
				ps.owner = Globals.player.instanceInfo.instanceGuid;
				ps.onModelEvent( new ModelEvent( WeaponEvent.FIRE, "" ) );
				
				_projectileEnabled = false;
				var pt:Timer = new Timer( 1000, 1 );
				pt.addEventListener(TimerEvent.TIMER, onEnableProjectile );
				pt.start();
			}
			*/
		}

		protected function onEnableProjectile(event:TimerEvent):void
		{
			_projectileEnabled = true;
		}
		
		//public function saveMap():void {
			//Globals.g_regionManager.writeRegion();
		//}

		
		public function saveModelIVM():void 
		{
			Globals.GUIControl = true;
			trace("VoxelVerseGUI.saveModel - Saving model to FILE");
			 //three steps
			 //save updated model meta data with new guid
			 //save updated model ivm
			 //update the model manager, removing old guid and adding new guid
			var vm:VoxelModel = Globals.selectedModel;
			if ( !vm )
				vm = Globals.g_modelManager.modelInstancesGetFirst();
			if ( vm )
			{
				if ( Network.client )
					vm.save();
				else
				{
					var ba:ByteArray = new ByteArray();
					ba.clear();
					vm.IVMSaveLocal( ba );

					_fileReference.save( ba, vm.modelInfo.fileName + "_new.ivm");
					_fileReference.addEventListener( Event.CANCEL, function ( e:Event ):void { Globals.GUIControl = false; } );
					_fileReference.addEventListener( Event.COMPLETE, function ( e:Event ):void { Globals.GUIControl = false; } );
				}
			}
			else
				Log.out( "VoxelVerseGUI.saveModelIVM - No VoxelModel selected", Log.ERROR );
		}
		
		//public function saveModelMeta():void 
		//{
			//Globals.GUIControl = true;
			//trace("VoxelVerseGUI.saveModel - Saving model to FILE");
			// three steps
			// save updated model meta data with new guid
			// save updated model ivm
			// update the model manager, removing old guid and adding new guid
			//var vm:VoxelModel = Globals.selectedModel;
			//if ( vm )
			//{
				//if ( vm.modelInfo.template )
				//{
					//var oldGuid:String = vm.instanceInfo.fileName;
					//var newGuid:String = Globals.getUID();
					//vm.modelInfo = Globals.g_modelManager.updateFileName( newGuid, oldGuid );
					//vm.instanceInfo.fileName = vm.modelInfo.fileName;
				//}
//
				//var modelJSON:String = vm.modelInfo.getJSON();
				//_fileReference.save( modelJSON, vm.modelInfo.fileName + ".mjson" );
			//}
			//else
				//Log.out( "VoxelVerseGUI.saveModelIVM - No VoxelModel selected", Log.ERROR );
		//}
		
		public function crossHairResize(event:Event):void 
		{
			//trace( "VoxelVerseGUI.crossHairResize" );
			if ( _crossHairHorizontal )
			{
				var halfRW:int = Globals.g_renderer.width / 2;
				var halfRH:int = Globals.g_renderer.height / 2;
				_crossHairHorizontal.x = halfRW - _crossHairHorizontal.width/2;
				_crossHairHorizontal.y = halfRH;
				_crossHairVertical.x = halfRW;
				_crossHairVertical.y = halfRH - _crossHairVertical.height / 2;
				
			}
			
			if ( _hub )
				_hub.resizeHub( event );
		}
		
		private function deactivate(e:Event):void 
		{
			_crossHairColor = CROSS_HAIR_RED;
			crossHairChange();
			crossHairShow();
		}
		
		private function activate(e:Event):void 
		{
			//Log.out( "VoxelVerseGUI.activate - change cross hairs:" + e.toString() );
			_crossHairColor = CROSS_HAIR_YELLOW;
			crossHairChange();
			if ( _crossHairHide )
				crossHairHide();
			else
				crossHairShow();
			
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			if ( Globals.active && Globals.clicked )
			{
				//Log.out( "VoxelVerseGUI.mouseMove change cross hairs: " + e.toString() );
				_crossHairColor = CROSS_HAIR_YELLOW;
				crossHairChange();
			}
		}
		
		public function mouseLeave( e:Event ):void
		{
			Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			_crossHairColor = CROSS_HAIR_RED;
			crossHairChange();
		}
		
		
		private function addReleaseMenu():WindowReleaseMenu
		{
			if ( Globals.g_app.configManager.showButtons && Globals.g_app.configManager.showEditMenu )
			{
				crossHairAdd();
			}
			
			return new WindowReleaseMenu();
		}
		
		private function showHelpWindow():void
		{
			new WindowHelp();
		}
		
		private function crossHairAdd():void
		{
			_crossHairHorizontal.graphics.beginFill(_crossHairColor);
			_crossHairHorizontal.graphics.drawRect(0, 0, 50, 1);
			Globals.g_app.addChild(_crossHairHorizontal);
			
			_crossHairVertical.graphics.beginFill(_crossHairColor);
			_crossHairVertical.graphics.drawRect(0, 0, 1, 50);
			Globals.g_app.addChild(_crossHairVertical);
			
			Globals.g_app.stage.addEventListener( Event.RESIZE, crossHairResize );

			_crossHairAdded = true;
			crossHairResize( null );
		}

		private function crossHairChange():void
		{
			if ( !_crossHairAdded )
			{
				//trace( "VoxelVerseGUI.changeCrossHairs - _crossHairAdded not yet added" );
				return;
			}
				
			Globals.g_app.removeChild(_crossHairHorizontal);
			Globals.g_app.removeChild(_crossHairVertical);
			_crossHairHorizontal = new Sprite();
			_crossHairVertical = new Sprite();
			
			crossHairAdd();
		}
		
		public function crossHairShow():void {
			if ( _crossHairHorizontal )
				_crossHairHorizontal.visible = true;
			if ( _crossHairVertical )
				_crossHairVertical.visible = true;
		}
		
		public function crossHairHide():void {
			if ( _crossHairHorizontal )
				_crossHairHorizontal.visible = false;
			if ( _crossHairVertical )
				_crossHairVertical.visible = false;
				
			_crossHairHide = true;	
		}
		
		private function guiEventHandler( e:GUIEvent ):void
		{
			if ( GUIEvent.TOOLBAR_HIDE == e.type )
			{
				if ( _hub ) _hub.hide();
				crossHairHide();

			}
			else if ( GUIEvent.TOOLBAR_SHOW == e.type )
			{
				if ( _hub ) _hub.show();
				crossHairShow()
			}
		}
		
		
		public function hideGUI():void 
		{
			trace( "VoxelVerseGUI.hideGUI" ); 
			if ( _built )
			{
				if ( _debugMenu )
					_debugMenu.visible = false;
				if ( _releaseMenu )
					_releaseMenu.visible = false;
				if ( _hub )
					_hub.visible = false;
				crossHairHide();
			}
			
		}
		
		public function buildGUI():void 
		{
			if ( _built )
			{
				if ( _debugMenu )
					_debugMenu.visible = true;
				if ( _releaseMenu )
					_releaseMenu.visible = true;
				if ( _hub )
					_hub.visible = true;
				crossHairShow();
				return;	
			}
			
			//if ( false == Globals.g_debug )
				//new  WindowSplash();
			
			_releaseMenu = addReleaseMenu();
//			if ( true == Globals.g_debug )
				_debugMenu = new WindowDebugMenu();
			
			if ( Globals.g_app.configManager.showEditMenu )
			{
				_hub = new Hub();
			}
			
			if ( !Globals.g_renderer.hardwareAccelerated )
				 new WindowNotHardware( "WARNING", "Hardware acceleration is not enabled in your browser, this is happening in Chrome on some machines, try FireFox or Internet Explorer" );
				 
		}
		
		public function init():void
		{
            UIManager.initialize( Globals.g_app.stage );
			Globals.g_app.addEventListener( RegionEvent.REGION_LOAD_BEGUN, onRegionLoadingComplete );
			Globals.g_app.addEventListener( LoadingEvent.LOAD_COMPLETE, onModelLoadingComplete );
			Globals.g_app.addEventListener( GUIEvent.TOOLBAR_HIDE, guiEventHandler );
			Globals.g_app.addEventListener( GUIEvent.TOOLBAR_SHOW, guiEventHandler );
			Globals.g_app.addEventListener(Event.DEACTIVATE, deactivate);
			Globals.g_app.addEventListener(Event.ACTIVATE, activate);
			Globals.g_app.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
			
			Globals.g_app.addEventListener(ModelEvent.TAKE_CONTROL, WindowBeastControl.handleModelEvents );
			Globals.g_app.addEventListener(ModelEvent.TAKE_CONTROL, WindowBeastControlQuery.handleModelEvents );
		}

		private function addKeyboardListeners(event : Event) : void
		{
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
		}

		private function removeKeyboardListeners(event : Event) : void
		{
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
		}

		private function onRegionLoadingComplete(event : RegionEvent ) : void
		{
			Globals.g_app.removeEventListener(RegionEvent.REGION_LOAD_BEGUN, onRegionLoadingComplete);
			
			if ( true == Globals.sandbox )
			{
				Globals.g_app.addEventListener( ModeChoiceEvent.MODE_SANDBOX, modeChoiceEventSandbox );
				Globals.g_app.addEventListener( ModeChoiceEvent.MODE_ONLINE, modeChoiceEventOnline );
				EventHandlers.addEventHandlers();
				if ( "startingRegion" == Globals.g_regionManager.currentRegion.name )
					new WindowModeChoice();
				// else just load up the region	
			}
			else
			{
				modeChoiceEventOnline(null);
			}
		}
		
		private function modeChoiceEventSandbox( event : ModeChoiceEvent ) : void
		{
			Globals.mode = Globals.MODE_LOCAL;
			Globals.g_app.removeEventListener( ModeChoiceEvent.MODE_SANDBOX, modeChoiceEventSandbox );
			Globals.g_app.removeEventListener( ModeChoiceEvent.MODE_ONLINE, modeChoiceEventOnline );
			if ( !WindowSandboxList.isActive )
				WindowSandboxList.create();
				
			// Need this to see cannonballs
			EventHandlers.addEventHandlers();
		}
		
		private function modeChoiceEventOnline( event : ModeChoiceEvent ) : void
		{
			Globals.mode = Globals.MODE_PUBLIC;
			Globals.g_app.removeEventListener( ModeChoiceEvent.MODE_SANDBOX, modeChoiceEventSandbox );
			Globals.g_app.removeEventListener( ModeChoiceEvent.MODE_ONLINE, modeChoiceEventOnline );
			new WindowLogin();
		}
		
		private function onModelLoadingComplete(event : LoadingEvent ) : void
		{
			//Log.out( "VVGui.onModelLoadingComplete" );
			Globals.g_app.removeEventListener( LoadingEvent.LOAD_COMPLETE, onModelLoadingComplete );
			addKeyboardListeners( event );
//			buildGUI();	
		}
		
		private function onKeyPressed( e : KeyboardEvent) : void
		{
			//if ( Keyboard.F == e.keyCode )
			//{
				//createProjectile( Globals.controlledModel );
				//return;
			//}
			if ( (Globals.GUIControl || Log.showing) )
				return;				
				
			//trace( "onKeyPressed: " + e.keyCode );	
//			if ( true == Globals.g_debug )
			if ( !Log.showing )
			{
				if ( Keyboard.T == e.keyCode )
					Globals.player.torchToggle();
					
				if ( Keyboard.F11 == e.keyCode )
					Globals.g_renderer.screenShot( true );

				if ( Keyboard.F12 == e.keyCode )
					Globals.g_renderer.screenShot( false );
					
				if ( Keyboard.F9 == e.keyCode )
					toggleFullscreen();
					
					
				//if ( Keyboard.O == e.keyCode )
				//{
					//_bulletSize++;
					//if ( _bulletSize > 5 )
						//_bulletSize = 5;
					//Log.out( "VVGui.onKeyPressed - increased bullet size to: " + _bulletSize );
				//}
				//if ( Keyboard.P == e.keyCode )
				//{
					//_bulletSize--;
					//if ( _bulletSize < 1 )
						//_bulletSize = 1;
					//Log.out( "VVGui.onKeyPressed - decreased bullet size to: " + _bulletSize );
				//}
					
				if ( Keyboard.F == e.keyCode )
					createProjectile( Globals.controlledModel )
				
				if ( Keyboard.M == e.keyCode )
					saveModelIVM();

				if ( Keyboard.N == e.keyCode )
					new WindowModels();
					//new WindowVideoTest(); Wait for hummingbird
			}
			
			if  ( Globals.g_app.configManager.showEditMenu )
			{
				if ( Keyboard.I == e.keyCode )
					new WindowInventory();
					
				if ( Keyboard.O == e.keyCode )
				{
					Globals.g_modelManager.TestCheckForFlow();
					//Globals.g_renderer.context.dispose();
					//new WindowObjects();
				}
				
				if ( Keyboard.L == e.keyCode )
				{
					Globals.muted = !Globals.muted;
				}
				
				//if ( Keyboard.T == e.keyCode )
				//	new WindowTest();
			}
		}
	}
}