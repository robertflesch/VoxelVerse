/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel 
{
	import flash.events.KeyboardEvent;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	/* 
	 * All keyboard and mouse management should go thru here
	 */
	public class MouseKeyboardHandler
	{
		static private var _s_forward:Boolean  							= false;
		static private var _s_backward:Boolean 		 					= false;
		static private var _s_left:Boolean  							= false;
		static private var _s_right:Boolean  							= false;
		static private var _s_turn_left:Boolean  						= false;
		static private var _s_turn_right:Boolean  						= false;
		static private var _s_up:Boolean 								= false;
		static private var _s_down:Boolean 								= false;
		
		// Enable / Disable Keys
		static private var _s_leftTurnEnabled:Boolean 					= true;
		static private var _s_rightTurnEnabled:Boolean 					= true;
		static private var _s_backwardEnabled:Boolean 					= true;
		
		static private var _s_handlersAdded:Boolean 					= false;
		
		static private var _s_x:Number = 0;
		static private var _s_y:Number = 0;

		static public function get leftTurnEnabled():Boolean 				{ return _s_leftTurnEnabled; }
		static public function set leftTurnEnabled(value:Boolean):void 		{ _s_leftTurnEnabled = value; }
		static public function get rightTurnEnabled():Boolean 				{ return _s_rightTurnEnabled; }
		static public function set rightTurnEnabled(value:Boolean):void 	{ _s_rightTurnEnabled = value; }
		static public function get backwardEnabled():Boolean 				{ return _s_backwardEnabled; }
		static public function set backwardEnabled(value:Boolean):void 		{ _s_backwardEnabled = value; }
		
		static public function get forward():Boolean 					{ return (Globals.GUIControl || Log.showing) ? false : _s_forward; }
		static public function get backward():Boolean 					{ return (Globals.GUIControl || Log.showing) ? false : _s_backward; }
		static public function get leftSlide():Boolean 					{ return (Globals.GUIControl || Log.showing) ? false : _s_left; }
		static public function get rightSlide():Boolean 				{ return (Globals.GUIControl || Log.showing) ? false : _s_right; }
		static public function get leftTurn():Boolean 					{ return (Globals.GUIControl || Log.showing) ? false : _s_turn_left; }
		static public function get rightTurn():Boolean 					{ return (Globals.GUIControl || Log.showing) ? false : _s_turn_right; }
		static public function get up():Boolean 						{ return (Globals.GUIControl || Log.showing) ? false : _s_up; }
		static public function get down():Boolean 						{ return (Globals.GUIControl || Log.showing) ? false : _s_down; }
		
		
		public function MouseKeyboardHandler() 
		{
		}
		
		static public function fullScreenEvent(event:FullScreenEvent):void {
			if ( event.fullScreen )
			{
				Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove );
			}
			else if ( !event.fullScreen )
			{
				Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove );
			}			
		}
		
		static private function onMove( event: MouseEvent) : void
		{
			_s_x += event.movementX;
			_s_y += event.movementY;
		}
		
		static public function getMouseXChange():int
		{
			if ( (Globals.GUIControl || Log.showing) )
				return 0;
				
			var val:Number = 0;
			if ( Globals.g_app.stage.mouseLock )
			{
				val = _s_x * 50;
				_s_x = 0;
			}
			else
				val = Globals.g_app.stage.mouseX - Globals.g_app.stage.stageWidth / 2;

			return val ;
		}
		
		static public function getMouseYChange():int
		{
			if ( (Globals.GUIControl || Log.showing) )
				return 0;
				
			var val:Number = 0;
			if ( Globals.g_app.stage.mouseLock )
			{
				val = _s_y * 50;
				_s_y = 0;
			}
			else
				val = Globals.g_app.stage.mouseY - Globals.g_app.stage.stageHeight / 2;
				
			return val;
		}
		
		static public function rotationFromKeyboard( elapsedTimeMS:Number ):Number
		{
			// tweak this number to adjust rotation speed
			// derived from watching log of screen position
			const MAX_ROT_RATE:Number = 0.137;
			
			var dx:Number = 0;
			if ( leftTurn && leftTurnEnabled )     
				dx = -MAX_ROT_RATE * elapsedTimeMS;
			else if ( rightTurn && rightTurnEnabled )    
				dx = MAX_ROT_RATE * elapsedTimeMS;
			
			const MIN_TURN_AMOUNT:Number = 0.05;
			// Now apply the change from keyboard
//			Log.out( "MouseKeyboardHandler.rotationFromKeyboard - USING time: " + dx + "  time elapsed: " + elapsedTimeMS, Log.WARN );
			if ( MIN_TURN_AMOUNT < Math.abs(dx) )
			{
				return dx;
			}
			else
				return 0;
		}

		static public function addInputListeners():void 
		{
			if ( false == _s_handlersAdded )
			{
				_s_handlersAdded = true;
				Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
				Globals.g_app.stage.addEventListener( FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED, fullScreenEvent );
			}
		}
		
		static public function removeInputListeners():void 
		{
			if ( true == _s_handlersAdded )
			{
				_s_handlersAdded = false;
				Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				Globals.g_app.stage.removeEventListener( FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED, fullScreenEvent );
			}
		}
		
		static public function init():void 
		{
			addInputListeners();
		}
		
		static public function reset():void
		{
			_s_forward = false;		
			_s_backward = false;			
			_s_left = false;			
			_s_right = false;			
			_s_turn_left = false;			
			_s_turn_right = false;			
			_s_up = false;			
			_s_down = false;			
		}
		
		
		
		static private function keyDown(e:KeyboardEvent):void 
		{
			//if ( Keyboard.HOME == e.keyCode ) 									resetCamera();
			//if ( Keyboard.KEYNAME_BREAK == e.keyCode ) 							resetPosition()
			if ( 87 == e.keyCode || Keyboard.UP == e.keyCode )					_s_forward = true; 
			if ( ( 83 == e.keyCode || Keyboard.DOWN == e.keyCode ) && backwardEnabled )	_s_backward = true; 
			if ( 69 == e.keyCode || Keyboard.SPACE == e.keyCode )				_s_up = true; 
			if ( 81 == e.keyCode || Keyboard.SHIFT == e.keyCode )				_s_down = true; 
//			if ( Keyboard.A == e.keyCode )												_s_turn_left = true; 
//			if ( Keyboard.D == e.keyCode )												_s_turn_right = true; 
//			if ( Keyboard.LEFT == e.keyCode )									_s_left = true; 
//			if ( Keyboard.RIGHT == e.keyCode )									_s_right = true; 
			if ( Keyboard.LEFT == e.keyCode || Keyboard.A == e.keyCode )		_s_left = true; 
			if ( Keyboard.RIGHT == e.keyCode || Keyboard.D == e.keyCode )		_s_right = true; 
		}
		
		static private function keyUp(e:KeyboardEvent):void 
		{
			switch (e.keyCode) {
				case Keyboard.W: case Keyboard.UP: 		_s_forward = false; break;
				case Keyboard.S: case Keyboard.DOWN: 	_s_backward = false; break;
				
				case Keyboard.E: case Keyboard.SPACE: 	_s_up = false; break; // E
				case Keyboard.Q: case Keyboard.SHIFT: 	_s_down = false; break; // Q
				//case Keyboard.LEFT: _s_left = false; break;
				//case Keyboard.RIGHT: _s_right = false; break;
				//case 65: 
					//_s_turn_left = false; break;
				//case 68: 
					//_s_turn_right = false; break;
				case Keyboard.A: case Keyboard.LEFT: 	_s_left = false; break;
				case Keyboard.D: case Keyboard.RIGHT: 	_s_right = false; break;
				
			}
		}
	}
}