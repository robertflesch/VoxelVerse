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
	// VerticalContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 21:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("VerticalContainer.png")]
	
	/**
	 * 	<img src="VerticalContainer.png" alt="VerticalContainer" width="18" height="18"/>
	 * 
	 * 	The <code>VerticalContainer</code> class is a special kind of <code>Container</code>
	 * 	objects which only lays out its children in a single vertical column.
	 * 	You use the <code>VerticalContainer</code> class instead of the <code>Container</code>
	 * 	class as a shortcut to avoid setting the <code>direction</code> property of the
	 * 	<code>Container</code> layout.
	 * 
	 * 	<p><strong>Note: </strong> the <code>autoHeight</code> property of <code>VerticalContainer</code>
	 * 	instances is <code>true</code> by default. It means that you cannot set the 
	 * 	<code>fixToParentHeight</code> property to <code>true</code> for the last child
	 * 	element of this container. If you want to use the <code>fixToParentHeight</code>
	 * 	property of the last child element, you must set the <code>autoHeight</code> property
	 * 	of the <code>VerticalContainer</code> instance to <code>false</code>.</p>
	 * 
	 * 	<p><strong>The <code>VerticalContainer</code> class supports the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">gap</code></td>
	 * 			<td>Sets the vertical gap of the container.</td>
	 * 			<td>Recognized values are numbers.</td>
	 * 			<td><code>gap</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.Container
	 * 	@see org.flashapi.swing.HorizontalContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class VerticalContainer extends Container implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>VerticalContainer</code> instance
		 * 	with the specified properties.
		 * 
		 * 	@param	width	The width of the <code>VerticalContainer</code>, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>VerticalContainer</code>, in
		 * 					pixels.
		 */
		public function VerticalContainer(width:Number = 100, height:Number = 100) { 
			super(width, height);
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
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$layout.orientation = LayoutOrientation.VERTICAL;
			$autoHeight = true;
			spas_internal::isInitialized(2);
		}
		
	}
}