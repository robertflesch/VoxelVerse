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
	// GroupButtonBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 22/02/2010 23:11
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.ButtonsGroupEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>GroupButtonBase</code> class is the base class for all button objects
	 * 	that can be associated with a specific <code>ButtonsGroup</code> object.
	 * 
	 * 	@see org.flashapi.swing.button.core.ButtonsGroup
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class GroupButtonBase extends ABM implements Observer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. creates a new <code>GroupButtonBase</code> instance.
		 * 
		 * 	@param	label	Text to display on the button instance. 
		 * 	@param	width	The button width, in pixels.
		 * 	@param	height	The button height, in pixels.
		 * 	@param	html	Specifies whether the text to display is HTML or not.
		 * 	@param	defaultLaf	The default look and feel class fo this button object.
		 */
		public function GroupButtonBase(label:String, width:Number, height:Number, html:Boolean, defaultLaf:Class) {
			super();
			initObj(label, width, height, html, defaultLaf);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>group</code> property.
		 * 
		 * 	@see #group
		 */
		protected var $group:ButtonsGroup;
		/**
		 *  Sets or gets the <code>ButtonsGroup</code> object for this button.
		 */
		public function get group():ButtonsGroup {
			return $group;
		}
		public function set group(value:ButtonsGroup):void {
			setButtonGroup(value);
			$evtColl.addEvent(this, UIMouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * 	Returns the name of the <code>ButtonsGroup</code> instance associated
		 * 	with this button.
		 */
		public function get groupName():String { 
			return $group.name;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Removes this button object from the <code>ButtonsGroup</code>. Calling
		 * 	this method will do nothing if the button is not associated with a
		 * 	<code>ButtonsGroup</code> object.
		 */
		public function removeFromGroup():void {
			if($hasButtonGroup) {
				$group.remove(this);
				$hasButtonGroup = false;
				$evtColl.removeEvent(this, UIMouseEvent.CLICK, clickHandler);
				//TODO: verrifier correspondance avec CheckButtonBase
				//_toggle = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function finalize():void {
			if($hasButtonGroup) $group.remove(this);
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal <code>Boolean</code> value that indicates whether the
		 * 	button is associated to a group (<code>true</code>), or not (<code>false</code>).
		 */
		protected var $hasButtonGroup:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function setButtonGroup(value:ButtonsGroup):void {
			if ($hasButtonGroup) $group.remove(this);
			if($evtColl.hasRegisteredEvent(this, UIMouseEvent.CLICK, clickHandler))
				$evtColl.removeEvent(this, UIMouseEvent.CLICK, clickHandler);
			$group = value;
			value.add(this);
			$hasButtonGroup = true;
		}
		
		/**
		 * @private
		 */
		protected function setChange(c:ButtonsGroup):void {
			c.dispatchEvent(new ButtonsGroupEvent(ButtonsGroupEvent.GROUP_CHANGED));
		}
		
		/**
		 * @private
		 */
		protected function clickHandler(e:UIMouseEvent):void {
			$group.value = $label;
			$group.data = $data;
			$group.spas_internal::setSelectedItem(this);
			$group.spas_internal::setSelectedIndex(this);
			setChange($group);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number, html:Boolean, defaultLaf:Class):void {
			init(label, width, height, html);
			initLaf(defaultLaf);
			$vAlign = VerticalAlignment.MIDDLE;
			$hAlign = HorizontalAlignment.LEFT; 
			$labelPlacement = LabelPlacement.RIGHT;
			initTextField();
		}
	}
}