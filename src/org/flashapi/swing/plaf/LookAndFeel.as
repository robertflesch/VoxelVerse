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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// LookAndFeel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 17:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	/**
	 * 	The <code>LookAndFeel</code> interface defines the interface for objects that 
	 * 	implement the SPAS 3.0 pluggable look and feel mechanism. SPAS 3.0 pluggable 
	 * 	look and feel allows to change the look and feel of the GUI at runtime.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface LookAndFeel {
		
		/**
		 * 	Determines the "raise" effect for an object that implements a lookandfeel.
		 * 
		 * 	@see #removeRaiseEffect()
		 * 	@see org.flashapi.swing.UIObject.core#raise
		 * 	@see org.flashapi.swing.UIObject.core#autoRaise
		 */
		function addRaiseEffect():void;
		
		/**
		 * 	Removes the "emphasize" effect for an object that implements a lookandfeel.
		 * 
		 * 	@see #drawEmphasizedState()
		 */
		function clearEmphasizedState():void;
		
		/**
		 * 	The method used by the <code>LookAndFeel</code> instance to draw the back
		 * 	face of an object.
		 */
		function drawBackFace():void;
		
		/**
		 * 	Renders the "emphasize" effect for an object that implements a lookandfeel.
		 * 
		 * 	@see #clearEmphasizedState()
		 */
		function drawEmphasizedState():void;
		
		/**
		 * 	Returns a reference to the <code>GlowFilter</code> used by this look and feel
		 * 	to render the "glow" effect.
		 * 
		 * 	@return The <code>GlowFilter</code> used by this look and feel to render the
		 * 				"glow" effect.
		 */
		function getGlowFilter():GlowFilter;
		
		/**
		 * 	Returns a reference to the effect filter used by this look and feel to render
		 * 	the emphasized state effect or when the <code>UIObject</code> has the focus.
		 * 
		 * 	@return The effect filter used by this look and feel to define the focus of an object.
		 */
		function getFocusFilter():GlowFilter;
		
		/**
		 * 	Returns a reference to the <code>DropShadowFilter</code> used by this look and feel
		 * 	to render the "shadow" effect.
		 * 
		 * 	@return The filter used by this look and feel for rendering the shadow effect.
		 */
		function getShadowFilter():DropShadowFilter;
		
		/**
		 * 	The <code>onChange()</code> method is called by objects before they change
		 * 	their lookandfeel ; it performs operations that disable specific actions created
		 * 	by the current lookandfeel.
		 */
		function onChange():void;
		
		/**
		 * 	Disables the "raise" effect for an object that use a lookandfeel.
		 * 
		 * 	@see #addRaiseEffect()
		 * 	@see org.flashapi.swing.UIObject.core#raise
		 * 	@see org.flashapi.swing.UIObject.core#autoRaise
		 */
		function removeRaiseEffect():void;
	}
}