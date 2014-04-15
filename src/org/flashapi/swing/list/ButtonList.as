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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// ButtonList.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 04/03/2009 10:59
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	The <code>ButtonList</code> class provides methods and properties to manage
	 * 	SPAS 3.0 objects that consist in a list of <code>ListItem</code> objects
	 * 	related to button controls that inherit from the <code>ABM</code> class.
	 * 
	 * 	@see org.flashapi.swing.button.core.ABM
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonList extends ALM {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ButtonList</code> instance.
		 */
		public function ButtonList() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Buttons color management
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the color of all button controls managed by this <code>ButtonList</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.core.IUIObject#color
		 */
		override public function set color(value:*):void { 
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafColor = true;
				//colors.up = "none";
			} else {
				$color = getColor(value); //colors.up = 
				spas_internal::useDefaultLafColor = false;
			}
			var it:Iterator = $objList.iterator;
			var abm:ABM;
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				abm = next.item;
				if (abm.color != $color) abm.color = color;
			}
			it.reset();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function removeAll():void {
			var it:Iterator = $objList.iterator;
			while (it.hasNext()) {
				var li:ListItem = it.next() as ListItem;
				li.item.finalize();
				li = null;
			}
			it.reset();
			super.removeAll();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>toggleMode</code> property.
		 * 
		 * 	@see #toggleMode
		 */
		protected var $toggleMode:Boolean = false;
		/**
		 * 	Indicates wheter the list composed of button controls that are allowed to
		 * 	maintain their aspect if selected (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p>Only one item in the <code>ButtonList</code> object can be selected at time;
		 * 	it means that when a user selects a button control in a <code>ButtonList</code>,
		 * 	the button remains selected until the user selects another button control.</p>
		 * 
		 * 	@default false
		 */
		public function get toggleMode():Boolean {
			return $toggleMode;
		}
		public function set toggleMode(value:Boolean):void { 
			$toggleMode = value;
			if($listItem != null) $listItem.item.selected = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the width for all button controls displayed within the <code>ButtonList</code>
		 * 	instance.
		 * 	
		 * 	@param	width The new width for all button controls, in pixels.
		 */
		public function setButtonsWidth(width:Number):void {
			var it:Iterator = $objList.iterator;
			it.reset();
			var next:ListItem;
			var abm:ABM;
			var hr:Number = getHRatio();
			while(it.hasNext()) {
				next = it.next() as ListItem;
				abm = next.item;
				abm.width = width - hr;
			}
			it.reset();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function getHRatio():Number {
			if ($objList.size > 0) {
				var abm:ABM = $objList.get(0).item as ABM;
				return abm.getBounds(null).width - abm.width;
			} return 0;
		}
	}
}