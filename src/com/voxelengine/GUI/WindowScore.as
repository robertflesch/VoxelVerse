
package com.voxelengine.GUI
{
	import com.voxelengine.events.TargetEvent;
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.events.Event;
	import flash.utils.Timer;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import flash.geom.Vector3D;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class WindowScore extends VVContainer
	{
		static private var _s_currentInstance:WindowScore = null;
		private var _targets:int = 0;
		private var _text:Text;

		private var _vm:VoxelModel;
		private var fudgeFactor:int = 20;
		private var _heading:Slider = null;
		private var _loc:Text = null;
		private var _repeatTimer:Timer = null;
		static public function get instance():WindowScore
		{ 
			if ( null == _s_currentInstance )
				_s_currentInstance = new WindowScore();
				
			return _s_currentInstance; }
			

		public function WindowScore():void 
		{ 
			super();
			_s_currentInstance = this;
			
			_repeatTimer = new Timer( 250, 0 );
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
			_repeatTimer.start();
			
			_text = new Text( 200, 50 );
			_text.text = "targets: " + _targets;
			_text.textAlign = TextAlign.CENTER;
			_text.fontSize = 16;
			_text.fixToParentWidth = true;
			
			addElement( _text );
			
			display( Globals.g_renderer.width / 2 - 100 / 2, 0 );
			
			
			Globals.g_app.addEventListener( TargetEvent.DESTROYED, onTargetHit );
			Globals.g_app.addEventListener( TargetEvent.DAMAGED, onTargetHit );
		} 
		
		public function register():void
		{
			trace( "WindowScore.register: REGISTERED" );
			_targets++;
			_text.text = "targets: " + _targets;
		}

		private function onTargetHit( te:TargetEvent ):void
		{
			if ( TargetEvent.DESTROYED == te.type )
				trace( "WindowScore.onTargetHit: DESTROYED" );
			else if ( TargetEvent.DAMAGED == te.type )
				trace( "WindowScore.onTargetHit: DESTROYED" );
			else
				trace( "WindowScore.onTargetHit: ERROR" );
		}

		protected function onRepeat(event:TimerEvent):void
		{
		}

		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
			_repeatTimer.stop();
			_s_currentInstance = null;
		}
		
	}
}