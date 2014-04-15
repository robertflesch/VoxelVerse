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
	// Container.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 17/04/2010 22:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.SimpleContainerBase;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.ContainerUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Container.png")]
	
	/**
	 * 	<img src="Container.png" alt="Container" width="18" height="18"/>
	 * 
	 * 	The <code>Container</code> class is an easy-to-use container object which
	 * 	allows to hold <code>UIObject</code> instances as well as <code>DisplaObject</code>
	 * 	instances. It provides both <code>UIObject</code> and <code>UIContainer</code>
	 * 	methods with no particular additional properties. It supplies developers
	 * 	a fast-and-easy way to load, add, or manipulate graphical objects within
	 * 	SPAS 3.0 applications. Contrary to <code>Canvas</code> instances, <code>Container</code>
	 * 	objects implement the SPAS 3.0 Look and Feel API, which means that you can use the
	 * 	<code>shadow</code> and <code>glow</code> properties with <code>Container</code>
	 * 	instances.
	 * 
	 * 	@see org.flashapi.swing.Canvas
	 * 	
	 *  @includeExample ContainerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Container extends SimpleContainerBase implements Observer, LafRenderer,Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Container</code> instance with the 
		 * 	specified dimensions.
		 * 
		 * 	@param	width	The width of the <code>Container</code> instance, 
		 * 					in pixels.
		 * 	@param	height	The height of the <code>Container</code> instance,
		 * 					in pixels.
		 */
		public function Container(width:Number = 100, height:Number = 100) { 
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
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initLaf(ContainerUIRef);
			spas_internal::setSelector(Selectors.uioSprite);
			spas_internal::isInitialized(1);
		}
	}
}