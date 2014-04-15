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
	// PanelContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 18/06/2009 20:30
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	[IconFile("PanelContainer.png")]
	
	/**
	 * 	<img src="PanelContainer.png" alt="PanelContainer" width="18" height="18"/>
	 * 
	 * 	A <code>PanelContainer</code> consists of a title bar, a caption, a border,
	 * 	and a content area for displaying child elements. Typically, you use 
	 * 	<code>PanelContainer</code> objects to wrap top-level application modules.
	 * 
	 * 	<p><code>PanelContainer</code> instances are similar to Flex
	 * 	<code>mx.containers.Panel</code> controls.</p>
	 * 
	 * 	<p><strong>Note: </strong> The <code>PanelContainer.innerPanel</code> and the
	 * 	<code>PanelContainer.shadow</code> properties are <code>true</code> by default.
	 * 	The <code>PanelContainer.padding</code>, <code>PanelContainer.verticalGap</code> 
	 * 	and <code>PanelContainer.horizontalGap</code> are set to <code>10</code> pixels 
	 * 	by default.</p>
	 * 
	 * 	@includeExample PanelContainerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PanelContainer extends Popup implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>PanelContainer</code> instance with 
		 * 					the specified parameters.
		 * 
		 * 	@param	label	The text label displayed in the title bar of this 
		 * 					<code>PanelContainer</code> instance.
		 * 	@param	width	The width of this <code>PanelContainer</code> instance,
		 * 					in pixels.
		 * 	@param	height	The height of this <code>PanelContainer</code> instance,
		 * 					in pixels.
		 */
		public function PanelContainer(label:String = "", width:Number = 150, height:Number = 80) {
			super(label, width, height);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Overriden API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set temporary(value:Boolean):void {
			$temporary = value;
		}
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				doStartEffect();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			showCloseButton = $draggable = false;
			$innerPanel = this.shadow = true;
			setIPOffset();
			$verticalGap = $horizontalGap = padding = 10;
			spas_internal::setSelector(Selectors.PANEL_CONTAINER);
			spas_internal::isInitialized(2);
		}
	}
}