
package com.voxelengine.GUI
{
	import com.voxelengine.events.RegionEvent;
	import com.voxelengine.events.ShipEvent;
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.ModelTransform;
	import com.voxelengine.worldmodel.models.Ship;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.Engine;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import flash.geom.Vector3D;
	import org.flashapi.swing.skin.KnobButtonSkin;
	
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.IOErrorEvent;
	import flash.display.Bitmap;
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class WindowShipControl extends VVContainer
	{
		static private var _s_currentInstance:WindowShipControl = null;
		static public function get currentInstance():WindowShipControl { return _s_currentInstance; }
		static private var _lastRotation:Number = 0;
		
		private var _instanceGuid:String;
		private var fudgeFactor:int = 20;
		private	var _knobSkin:KnobButtonSkin = new KnobButtonSkin("Test");
		private	var _knob:KnobButton;

		public function WindowShipControl( $instanceGuid:String ):void 
		{ 
			super();
			_s_currentInstance = this;
			// // Globals.GUIControl = true;
			_instanceGuid = $instanceGuid;
			autoSize = true;
			padding = 10;
			layout.orientation = LayoutOrientation.VERTICAL;
			layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			
			var pc:Container = new Container();
			//onCloseFunction = closeFunction;
			//defaultCloseOperation = ClosableProperties.CALL_CLOSE_FUNCTION;
			pc.layout.orientation = LayoutOrientation.HORIZONTAL;
			
			var throttle:Slider = new Slider( 150 );
			throttle.width = 50;
			// TODO - Need to change labels to a more readable text
			throttle.labels = ["Ahead Full", "Stop", "Back Full"];	
			throttle.value = 50;
			throttle.addEventListener(ScrollEvent.SCROLL, throttleHandler );
			pc.addElement( throttle );

			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onTextureLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			loader.load(new URLRequest( Globals.appPath + "assets/textures/shipwheel_150.png" ));
			
			_knob = new KnobButton( 75 );
			_knob.addEventListener(KnobEvent.KNOB_UPDATE, onKnobUpdate);
			_knob.addEventListener(KnobEvent.KNOB_UPDATE_FINISHED, onKnobUpdate);
			//_knob.alpha = 1;
			_knob.value = 0.5;
			_lastRotation = 0.0;
			pc.addElement( _knob );
			
			var altitude:Slider = new Slider( 150 );
			altitude.width = 50;
			altitude.labels = ["Up", "Hold", "Down"];	
			altitude.value = 50;
			altitude.addEventListener(ScrollEvent.SCROLL, altitudeScroll );
			pc.addElement( altitude );
			addElement( pc );
			
			var button:Button = new Button( "Give up Ship Control" );
			button.addEventListener(MouseEvent.CLICK, loseControl );

			addElement( button );

			display( Globals.g_renderer.width/2 - (width + fudgeFactor)/2, Globals.g_renderer.height - height - 128 );
            Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
			Globals.g_app.addEventListener( RegionEvent.REGION_UNLOAD, onRegionUnload );
			addEventListener(UIOEvent.REMOVED, onRemoved );
		} 
		
		private function onRegionUnload( le:RegionEvent ):void
		{
			loseControl( null );
		}
		
		private function loseControl(event:UIMouseEvent):void 
		{
			if ( WindowShipControl.currentInstance )
			{
				WindowShipControl.currentInstance.remove();
			}
			if ( WindowGunControl.currentInstance )
			{
				WindowGunControl.currentInstance.remove();
			}
			if ( WindowHeading.currentInstance )
			{
				WindowHeading.currentInstance.remove();
			}
			if ( WindowBombControl.currentInstance )
			{
				WindowBombControl.currentInstance.remove();
			}

			remove();
			
			Globals.player.instanceInfo.controllingModel = null;
		}
		
		public function onTextureLoadComplete (event:Event):void 
		{
			var textureBitmap:Bitmap = Bitmap(LoaderInfo(event.target).content);// .bitmapData;
			_knobSkin.button = textureBitmap;
			_knob.skin = _knobSkin;
		}			
						
		private function onFileLoadError(event:IOErrorEvent):void
		{
			Log.out("WindowShipControl.onFileLoadError - File load error: " + event, Log.ERROR );
		}		

		private function onKnobUpdate(e:KnobEvent):void 
		{
            var val:Number = e.target.value - 0.5;
			Globals.g_app.dispatchEvent( new ShipEvent( ShipEvent.DIRECTION_CHANGED, _instanceGuid, val ) );
        }
		
		private function altitudeScroll(event:ScrollEvent):void 
		{
			var val:Number = event.target.value/100;
			val = val - 0.5;
			Globals.g_app.dispatchEvent( new ShipEvent( ShipEvent.ALTITUDE_CHANGED, _instanceGuid, val ) );
		}
		
		private function throttleHandler(event:ScrollEvent):void 
		{
			var val:Number = event.target.value/100;
			val = val - 0.5;
			Globals.g_app.dispatchEvent( new ShipEvent( ShipEvent.THROTTLE_CHANGED, _instanceGuid, val ) );
		}
		
		private function headingStopScroll(event:ScrollEvent):void 
		{
//			Log.out( "WINDOWSHIPCONTROL.HEADINGSTOPSCROLL - WINDOWSHIPCONTROL.HEADINGSTOPSCROLL" );
		}
		
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
			removeEventListener(UIOEvent.REMOVED, onRemoved );
			
			_s_currentInstance = null;
		}
		
        protected function onResize(event:Event):void
        {
			move( Globals.g_renderer.width / 2 - (width + fudgeFactor) / 2, Globals.g_renderer.height - height - 128 );
		}
	}
}