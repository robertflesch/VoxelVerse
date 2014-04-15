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

package org.flashapi.swing.fx.uifx {
	
	// -----------------------------------------------------------
	// UIDistortion.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 16:31
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.fx.basicfx.DistortFX;
	
	use namespace spas_internal;

	public class UIDistortion extends DistortFX {
		
		public function UIDistortion(uio:UIObject, vPrecision:Number = 4, hPrecision:Number = 4, smooth:Boolean = true) {
			super(uio.parent, uio.spas_internal::uioSprite, vPrecision, hPrecision, smooth);
			_uio = uio;
		}
	}
}