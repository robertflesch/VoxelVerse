////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing.framework {
	
	// -----------------------------------------------------------
	// FPSMonitor.as
	// -----------------------------------------------------------
	
	/**
	* @author Piergiorgio NIERO
	* @see http://www.flashfuck.it/2008/05/27/fpsmonitor-for-as3-and-flex-projects/
	*/
	
	// -----------------------------------------------------------
	// MonitorPanel.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2009 00:01
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>MonitorPanel</code> class creates a small fps monitor that displays
	 * 	both, FPS and memory usage values, while debugging SPAS 3.0 applications.
	 * 
	 * 	<p>The <code>MonitorPanel</code> monitoring iplementation is based on the 
	 * 	full-free <code>FPSMonitor</code> class, by Piergiorgio NIERO.</p>
	 * 
	 * 	@see http://www.flashfuck.it/2008/05/27/fpsmonitor-for-as3-and-flex-projects/
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MonitorPanel extends DebugPanelBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>MonitorPanel</code> object.
		 */
		public function MonitorPanel() {
			super(Locale.spas_internal::LABELS.MONITOR_PANEL_TITLE, 250, 170);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private const MEM_UNIT:Number = 1 / 1024;
		private const MONITOR_MEM_MAX:int = 100;//mb
		private const MONITOR_FPS_MAX:int = 100;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _tmpFps:Number = 0;
		private var _fps:Number = 0;
		private var _ms:int = 0;
		private var _time:int;
		private var _bmp:BitmapData;
		private var _monitor:Bitmap;
		private var _fpsTxt:TextField;
		private var _playerVersion:String;
		//private var _1024:Number;
		private var _mem:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createMonitor();
			initMonitor();
			display();
		}
		
		private function createMonitor():void {
			var yPos:Number = $title.height;
			_bmp = new BitmapData(100, 100, true, 0x99333333);
			_monitor = new Bitmap(_bmp);
			_monitor.y = yPos + 45;
			this.addChild(_monitor);
			_fpsTxt = new TextField();
			_fpsTxt.y = yPos;
			_monitor.x = _fpsTxt.x = 5;
			_fpsTxt.width = 240;
			_fpsTxt.defaultTextFormat = new TextFormat(WebFonts.VERDANA, 10, 0xFFFFFF);
			_fpsTxt.selectable = false;
			this.addChild(_fpsTxt);
		}
		
		private function initMonitor():void {
			_playerVersion = "(" + Capabilities.playerType + ") " +
				Capabilities.version + " debug:" + Capabilities.isDebugger;
			_ms = getTimer();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			_time = getTimer() - 1000;
			if(_time>_ms){
				_fps = _tmpFps + (_tmpFps * .001 * (_time - _ms));
				_ms = getTimer();
				_tmpFps = 0;
			} else _tmpFps++;
			_mem = System.totalMemory * MEM_UNIT * .001;
			_bmp.scroll(1, 0);
			_bmp.setPixel32(1, 100 - (_fps / MONITOR_FPS_MAX * 100), 0xFFFFFFFF);
			_bmp.setPixel32(1, 100 - (_mem / MONITOR_MEM_MAX * 100), 0xFF000000);
			_fpsTxt.text = _playerVersion + "\nFPS: " + _fps + "\nMEM: " + _mem.toString().substr(0, 5);
		}
	}
}