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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  EasingProvider.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 12/07/2011 14:13
	 *  @see http://www.flashapi.org/
	 */
	
	 import org.flashapi.tween.constant.EaseType;
	 import org.flashapi.tween.motion.Back;
	 import org.flashapi.tween.motion.Bounce;
	 import org.flashapi.tween.motion.Circular;
	 import org.flashapi.tween.motion.Cubic;
	 import org.flashapi.tween.motion.Elastic;
	 import org.flashapi.tween.motion.Exponential;
	 import org.flashapi.tween.motion.Linear;
	 import org.flashapi.tween.motion.Quadratic;
	 import org.flashapi.tween.motion.Quartic;
	 import org.flashapi.tween.motion.Quintic;
	 import org.flashapi.tween.motion.Sinusoidal;
	
	/**
	 * 	The <code>EasingProvider</code> class creates a <code>DataProviderObject</code>
	 * 	that stores a set of <code>EasingProviderDto</code> objects for defining
	 * 	<code>Easing</code> functions names references and types that are available
	 * 	in the BTween API.
	 * 
	 * 	@see org.flashapi.tween.core.Easing
	 * 	@see org.flashapi.swing.databinding.EasingProviderDto
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.1
	 */
	public class EasingProvider extends AbstractDataProvider {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>EasingProvider</code> instance.
		 */
		public function EasingProvider() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		//--> Maintain alphabetical order of the data field:
		private function initObj():void {
			super.createStack( [
				{ label:"Back In",				data:new EasingProviderDto(Back, EaseType.IN, "Back In") },
				{ label:"Back Out",				data:new EasingProviderDto(Back, EaseType.OUT, "Back Out") },
				{ label:"Back In Out",			data:new EasingProviderDto(Back, EaseType.BOTH, "Back In Out") },
				{ label:"Bounce In",			data:new EasingProviderDto(Bounce, EaseType.IN, "Bounce In") },
				{ label:"Bounce Out",			data:new EasingProviderDto(Bounce, EaseType.OUT, "Bounce Out") },
				{ label:"Bounce In Out",		data:new EasingProviderDto(Bounce, EaseType.BOTH, "Bounce In Out") },
				{ label:"Circular In",			data:new EasingProviderDto(Circular, EaseType.IN, "Circular In") },
				{ label:"Circular Out",			data:new EasingProviderDto(Circular, EaseType.OUT, "Circular Out") },
				{ label:"Circular In Out",		data:new EasingProviderDto(Circular, EaseType.BOTH, "Circular In Out") },
				{ label:"Cubic In",				data:new EasingProviderDto(Cubic, EaseType.IN, "Cubic In") },
				{ label:"Cubic Out",			data:new EasingProviderDto(Cubic, EaseType.OUT, "Cubic Out") },
				{ label:"Cubic In Out",			data:new EasingProviderDto(Cubic, EaseType.BOTH, "Cubic In Out") },
				{ label:"Elastic In",			data:new EasingProviderDto(Elastic, EaseType.IN, "Elastic In") },
				{ label:"Elastic Out",			data:new EasingProviderDto(Elastic, EaseType.OUT, "Elastic Out") },
				{ label:"Elastic In Out",		data:new EasingProviderDto(Elastic, EaseType.BOTH, "Elastic In Out") },
				{ label:"Exponential In",		data:new EasingProviderDto(Exponential, EaseType.IN, "Exponential In") },
				{ label:"Exponential Out",		data:new EasingProviderDto(Exponential, EaseType.OUT, "Exponential Out") },
				{ label:"Exponential In Out",	data:new EasingProviderDto(Exponential, EaseType.BOTH, "Exponential In Out") },
				{ label:"Linear",				data:new EasingProviderDto(Linear, EaseType.IN, "Linear") },
				{ label:"Quadratic In",			data:new EasingProviderDto(Quadratic, EaseType.IN, "Quadratic In") },
				{ label:"Quadratic Out",		data:new EasingProviderDto(Quadratic, EaseType.OUT, "Quadratic Out") },
				{ label:"Quadratic In Out",		data:new EasingProviderDto(Quadratic, EaseType.BOTH, "Quadratic In Out") },
				{ label:"Quartic In",			data:new EasingProviderDto(Quartic, EaseType.IN, "Quartic In") },
				{ label:"Quartic Out",			data:new EasingProviderDto(Quartic, EaseType.OUT, "Quartic Out") },
				{ label:"Quartic In Out",		data:new EasingProviderDto(Quartic, EaseType.BOTH, "Quartic In Out") },
				{ label:"Quintic In",			data:new EasingProviderDto(Quintic, EaseType.IN, "Quintic In") },
				{ label:"Quintic Out",			data:new EasingProviderDto(Quintic, EaseType.OUT, "Quintic Out") },
				{ label:"Quintic In Out",		data:new EasingProviderDto(Quintic, EaseType.BOTH, "Quintic In Out") },
				{ label:"Sinusoidal In",		data:new EasingProviderDto(Sinusoidal, EaseType.IN, "Sinusoidal In") },
				{ label:"Sinusoidal Out",		data:new EasingProviderDto(Sinusoidal, EaseType.OUT, "Sinusoidal Out") },
				{ label:"Sinusoidal In Out",	data:new EasingProviderDto(Sinusoidal, EaseType.BOTH, "Sinusoidal In Out") }
			]);
		}
	}
}