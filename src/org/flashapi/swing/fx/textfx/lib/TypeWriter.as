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

package org.flashapi.swing.fx.textfx.lib {
	
	// -----------------------------------------------------------
	// TypeWriter.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 23/02/2010 14:56
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.event.TextFXEvent;
	import org.flashapi.swing.fx.textfx.FXCharacter;
	import org.flashapi.swing.fx.textfx.TextEffect;
	import org.flashapi.swing.fx.textfx.TextFX;
	
	public class TypeWriter implements TextEffect{
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		public function TypeWriter() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public function initInEffect(effect:TextFX):void {
			_xPos = 0;
		}
		
		public function initOutEffect(effect:TextFX):void {}
		
		public function renderInEffect(effect:TextFX, character:FXCharacter, event:TextFXEvent = null):void {
			if(!character.displayed) { 
				if (event.currentCount >= character.index) {
					character.display(_xPos);
					_xPos += character.width;
				}
			}
		}
		
		public function renderOutEffect(effect:TextFX, character:FXCharacter, event:TextFXEvent = null):void {
			if(character.displayed) {
				if(event.target.totalCount - event.currentCount -1 <= character.index) character.remove();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _xPos:Number = 0;
	}
}