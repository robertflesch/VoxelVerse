
package com.voxelengine.GUI
{
	import com.voxelengine.events.LoadingEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	
	public class WindowSplash extends VVCanvas
	{
		static private var _s_currentInstance:WindowSplash = null;
		static public function get isActive():Boolean { return _s_currentInstance ? true: false; }
		static public function create():WindowSplash 
		{  
			if ( null == _s_currentInstance )
				new WindowSplash();
			return _s_currentInstance; 
		}
		
		private var _outline:Image;

		public function WindowSplash():void 
		{ 
			super( Globals.g_renderer.width, Globals.g_renderer.height );

			_outline = new Image( Globals.appPath + "assets/textures/splash.png");
			if ( Globals.g_debug )
			{
				// this scale the window down, so we can see it, but it shows we are in debug
				_outline.scaleX = Globals.g_renderer.width/2791;
				_outline.scaleY = Globals.g_renderer.height/2592;
			}
			else
			{
				_outline.scaleX = Globals.g_renderer.width/791;
				_outline.scaleY = Globals.g_renderer.height / 592;
			}
			
			addElement( _outline );
			
			_s_currentInstance = this;
			
			if ( Globals.g_debug )
				display( Globals.g_renderer.width - 791, 0 );
			else
				display( 0, 0 );
			
			addEventListener(UIOEvent.REMOVED, onRemoved );
			Globals.g_app.addEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingComplete );
			Globals.g_app.stage.addEventListener( Event.RESIZE, onResize );
			
			var loadingTimer:Timer = null;
			if ( Globals.g_debug )
				loadingTimer = new Timer( 100, 1 );
			else
				loadingTimer = new Timer( 500, 1 );
			loadingTimer.addEventListener(TimerEvent.TIMER, onSplashLoaded );
			loadingTimer.start();
		} 
		
        protected function onResize(event:Event):void
        {
			_outline.scaleX = Globals.g_renderer.width/791;
			_outline.scaleY = Globals.g_renderer.height/592;
		}
		
		protected function onSplashLoaded(event:TimerEvent):void
		{
			// We want this to happen before everyone else knows we are done
			Globals.g_app.dispatchEvent( new LoadingEvent( LoadingEvent.SPLASH_LOAD_COMPLETE ) );			
		}

		private function onLoadingComplete( le:LoadingEvent ):void
		{
			//Log.out( "WindowSplash.onLoadingComplete" );
			Globals.g_app.removeEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingComplete );
			if ( WindowSplash.isActive )
			{
				WindowSplash._s_currentInstance.remove();
				WindowSplash._s_currentInstance = null;
			}
		}
		
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
			//Log.out( "WindowSplash.onRemoved" );
			removeEventListener(UIOEvent.REMOVED, onRemoved );
			_s_currentInstance = null;
		}

	}
}