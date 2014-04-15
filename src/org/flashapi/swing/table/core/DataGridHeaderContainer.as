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

package org.flashapi.swing.table.core {
	
	// -----------------------------------------------------------
	// DataGridHeaderContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.1, 19/11/2010 10:19
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.DataGridHeaderUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>DataGridHeaderContainer</code> class allows to create a <code>DataGridHeader</code>
	 * 	object which not let users interact whith <code>DataGrid</code> objects. It means
	 * 	that <code>DataGridHeaderContainers</code> are not item renderers. They are tipicaly
	 * 	used within a <code>DataGridHeaderRow</code> object to fill the space available
	 * 	over the <code>DataGrid</code> scroll bar.
	 * 
	 * 	<p><strong>Note: </strong> The CSS selector property for <code>DataGridHeaderContainer</code>
	 * 	objects is the same as the selector for <code>DataGridHeader</code> objects.</p>
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 	@see org.flashapi.swing.table.DataGridHeaderRow
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataGridHeaderContainer extends Canvas implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor.	Creates a new <code>DataGridHeaderContainer</code> object
		 * 					with the specified parameters.
		 * 
		 * 	@param	width	The width of the <code>DataGridHeaderContainer</code>
		 * 					object, in pixels.
		 * 	@param	height	The height of the <code>DataGridHeaderContainer</code>
		 * 					object, in pixels.
		 */
		public function DataGridHeaderContainer(width:Number = 300, height:Number = 20) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			lookAndFeel.drawBackground();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$autoAdjustSize = false;
			initSize(width, height);
			spas_internal::lafDTO.currentTarget = spas_internal::uioSprite;
			createTextureManager(spas_internal::uioSprite);
			createColorsObj();
			initLaf(DataGridHeaderUIRef);
			spas_internal::setSelector(Selectors.DATAGRID_HEADER);
			spas_internal::isInitialized(1);
		}
	}
}