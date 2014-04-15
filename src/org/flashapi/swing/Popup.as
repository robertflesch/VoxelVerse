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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// Popup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 20:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.wtk.AWM;
	
	use namespace spas_internal;
	
	[IconFile("Popup.png")]
	
	/**
	 * 	<img src="Popup.png" alt="Popup" width="18" height="18"/>
	 * 
	 * 	A <code>Popup</code> instance is similar to HTML popup windows. Typically,
	 * 	you use <code>Popup</code> windows to wrap self-contained application modules.
	 * 	<p><code>Popup</code> windows can automatically be closed after a specified
	 * 	delay, as you can do in DHTML.</p>
	 * 
	 * 	<p><code>Popup</code> objects are composed of several elements; some are listed below:
	 * 		<ul>
	 * 			<li><bold>Title Bar:</bold><br />
	 * 				The horizontal bar at the top of a popup window that contains the
	 * 				icon and name at the left, the specified title text,
	 * 				and to the right, the closing button. 
	 * 				Clicking on the icon will pop up a menu to control the popup window.
	 * 			</li>
	 * 			<li><bold>Icon:</bold><br />
	 * 				An <code>Icon</code> instance placed on the top left-hand corner of
	 * 				the popup window (optional). When it is displayed, the icon is used as a
	 * 				button to control the menu of the popup window.
	 * 			</li>
	 * 			<li><bold>Pull-down Control Menu:</bold><br />
	 * 				A <code>Menu</code> instance that appears when the icon is selected.
	 * 				(Only if an icon is displayed.)
	 * 			</li>
	 * 			<li><bold>Header control:</bold><br />
	 * 				A special container used to display task bars under the popup window
	 * 				title bar.
	 * 			</li>
	 * 			<li><bold>Footer control:</bold><br />
	 * 				A special container used to display informations below the content panel.
	 * 			</li>
	 * 			<li><bold>Scrollbars:</bold><br />
	 * 				Scrollbars are displayed at the right-hand side and/or bottom of a popup 
	 * 				window and enables to scroll the content of the window.
	 * 			</li>
	 * 			<li><bold>Closing Button:</bold><br />
	 * 				Button generally used to remove the popup window from the application.
	 * 				As the <code>Popup</code> class implement the <code>ClosableObject</code>
	 * 				interface, when users click on the closing button, the resulting action
	 * 				will depend on the <code>defaultCloseOperation</code> property settings.
	 * 			</li>
	 * 		</ul>
	 * 	</p>
	 * 
	 * 	@includeExample PopupExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Popup extends AWM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Popup</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	label	Text to appear on the title bar of the <code>Popup</code>
		 * 					instance. 
		 * 	@param	width	The width of the <code>Popup</code> instance, in pixels. 
		 * 	@param	height	The height of the <code>Popup</code> instance, in pixels.
		 */
		public function Popup(label:String = "", width:Number = 150, height:Number = 80) {
			super();
			initObj(label, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _delay:int;
		/**
		 *  Sets or gets the time delay, in milliseconds, before the <code>Popup</code>
		 * 	instance will be removed if the <code>temporary</code> property is set
		 * 	to <code>true</code>.
		 *
		 * 	@default 5000
		 * 
		 * 	@see #temporary
		 */
		public function get delay():int {
			return _delay;
		}
		public function set delay(value:int):void {
			_delay = value;
		}
		
		/**
		 * @private
		 */
		override public function set glow(value:Boolean):void {
			super.glow = $closeButton.boxhelp.glow = true;
		}
		
		[Inspectable(defaultValue="true", name="shadow")]
		/**
		 * @private
		 */
		override public function set shadow(value:Boolean):void {
			super.shadow = $closeButton.boxhelp.shadow = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>temporary</code> property.
		 * 
		 * 	@see #temporary
		 */
		protected var $temporary:Boolean;
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>Popup</code>
		 * 	instance must automatically be removed after a specified time
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #delay
		 */
		public function get temporary():Boolean {
			return $temporary;
		}
		public function set temporary(value:Boolean):void {
			$temporary = value;
			if(displayed && value) autoRemove();
			else if(!value) $evtColl.removeEvent(_timer, TimerEvent.TIMER, remove);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				doStartEffect(setToTopLevel);
				if($temporary) autoRemove();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			if (_timer != null) {
				_timer.stop();
				if ($evtColl.hasRegisteredEvent(_timer, TimerEvent.TIMER, remove)) {
					$evtColl.removeEvent(_timer, TimerEvent.TIMER, remove);
				}
				_timer = null;
			}
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			displayIcon();
			move(x, y);
			$scrollableArea.display();
			refresh();
			setLAFPositions();
		}
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			fixSize();
			displayWindow();
			setContentPosition();
			$scrollableArea.resize($width, $height);
			lookAndFeel.setCloseButtonPosition();
			$buttonsWidth = $closeButton.visible ? $outerWidth - $closeButton.x : 0;
			setTitleProperties();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _timer:Timer;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number):void {
			init(label, width, height);
			initMinSize(50, 0);
			createContainers();
			createTitleBarItems();
			createTitleBar();
			$temporary = $minimized = $maximized = false;
			_delay = 5000;
			spas_internal::setSelector(Selectors.WINDOW);
			spas_internal::isInitialized(1);
		}
		
		private function displayWindow():void {
			lookAndFeel.drawWindow();
			$borderDecorator.drawBackground();
			if($innerPanel) lookAndFeel.drawInnerPanel();
			$borderDecorator.drawBorders();
			drawMask();
			//lookAndFeel.drawMask();
			lookAndFeel.drawTitleBar();
		}
		
		private function autoRemove():void {
			_timer = new Timer(_delay, 1);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, remove);
			_timer.start();
		}
	}
}