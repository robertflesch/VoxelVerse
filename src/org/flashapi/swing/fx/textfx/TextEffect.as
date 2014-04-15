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

package org.flashapi.swing.fx.textfx {
	
	// -----------------------------------------------------------
	// TextEffect.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/12/2009 22:49
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.event.TextFXEvent;
	
	public interface TextEffect {
		
		function initInEffect(effect:TextFX):void;
		function initOutEffect(effect:TextFX):void;
		function renderInEffect(effect:TextFX, character:FXCharacter, event:TextFXEvent = null):void;
		function renderOutEffect(effect:TextFX, character:FXCharacter, event:TextFXEvent = null):void;
	}
}