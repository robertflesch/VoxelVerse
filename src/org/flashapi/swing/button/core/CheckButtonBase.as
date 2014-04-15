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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// CheckButtonBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 22:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.util.Observer;
	
	/**
	 * 	The <code>CheckButtonBase</code> class is the base class for button objects
	 * 	that maintain an on/off state, which toggles automatically when they are
	 * 	clicked (e.g. <code>CheckBox</code> or <code>RadioButton</code> objects).
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CheckButtonBase extends GroupButtonBase implements Observer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Ccreates a new <code>CheckButtonBase</code> instance.
		 * 
		 * 	@param	label	Text to display on the button instance. 
		 * 	@param	width	The button width, in pixels.
		 * 	@param	height	The button height, in pixels.
		 * 	@param	html	Specifies whether the text to display is HTML (<code>true</code>),
		 * 					or not (<code>false</code>).
		 * 	@param	defaultLaf	The default look and feel class for this button object.
		 */
		public function CheckButtonBase(label:String, width:Number, height:Number, html:Boolean, defaultLaf:Class) {
			super(label, width, height, html, defaultLaf);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set toggle(value:Boolean):void { }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function drawIcon(brush:Class, rect:Rectangle = null):void {}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			super.setSpecificLafChanges();
			super.drawIcon(lookAndFeel.getDefaultIcon());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$toggle = true;
		}
	}
}