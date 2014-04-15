package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.events.WeaponEvent;
	import com.voxelengine.worldmodel.scripts.FireProjectileScript;

	
	public class AutoFireProjectileScript extends FireProjectileScript 
	{
		private var _timer:Timer;
		private var _repeatTime:int = 5000;
		
		public function AutoFireProjectileScript() 
		{
			super();
			
			_timer = new Timer( _repeatTime, 0);
			_timer.addEventListener( TimerEvent.TIMER
			                       , function() : void  { Globals.active ? fire():null }
								   , false
								   , 0
								   , true );
			//_timer.start();
			
			//_ammo.accuracy = 0.000;
			//_ammo.velocity = 1000;
			
			Globals.g_app.stage.addEventListener( KeyboardEvent.KEY_DOWN
			                                    , function(e:KeyboardEvent) : void  { Keyboard.F == e.keyCode ? fire():null }
												, false
												, 0
												, false );		// true here causes the fire ability to be lost, is it getting garbage collected?	
		}
		
		private function fire():void
		{
			trace( "AutoFireProjectileScript.fire" );
			Globals.g_app.dispatchEvent( new WeaponEvent( WeaponEvent.FIRE, _instanceGuid, null ) );
			//_owner.explode(1);
		}
	}
}