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

package org.flashapi.swing.draw {
	
	// -----------------------------------------------------------
	// DrawShapeFactory.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/11/2007 11:46
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	The <code>DrawShapeFactory</code> class generates shapes specified by the
	 * 	<code>setShape</code> function property, depending on the <code>TextureManager</code>
	 * 	properties of the <code>UIObject</code> that calls the 
	 * 	<code>DrawShapeFactory.drawShape()</code> method.
	 * 
	 * 	<p>You use this factory object to easily manage plaf (pluggable look-and-feel)
	 * 	shapes within Look and Feel classes.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DrawShapeFactory {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>DrawShapeFactory</code> object for the
		 * 	specified <code>UIObject</code> instance.
		 * 
		 * 	@param	uio	The <code>UIObject</code> instance that uses this
		 * 				<code>DrawShapeFactory</code>.
		 */
		public function DrawShapeFactory(uio:IUIObject) {
			super();
			initObj(uio);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Not implemented yet.]
		 */
		public var setBackFaceShape:Function = null;
		
		/**
		 * 	Defines the shape to use with the <code>drawShape()</code> method.
		 * 
		 * 	@see #drawShape()
		 */
		public var setShape:Function = null;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  [Not implemented yet.]
		 */
		public function drawBackFaceShape():void {}
		
		/**
		 * 	Draws the shape specified by the <code>setShape</code> function property.
		 * 
		 * 	@see #setShape
		 */
		public function drawShape():void {
			_uio.textureManager.setShape = setShape;
			if(_uio.textureManager.texture!=null) _uio.textureManager.draw(TextureType.TEXTURE);
			else if(_uio.gradientMode) _uio.textureManager.draw(TextureType.GRADIENT);
			else _uio.textureManager.draw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _uio:IUIObject;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(uio:IUIObject):void {
			_uio = uio;
		}
	}
}