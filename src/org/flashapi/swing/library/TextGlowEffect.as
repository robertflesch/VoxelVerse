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

package org.flashapi.swing.library {
	
	// -----------------------------------------------------------
	// TextShadowEffect.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/01/2010 18:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.filters.GlowFilter;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.text.ATM;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>TextGlowEffect</code> library allows to add text glow effect to
	 * 	SPAS 3.0 text objects that extend the <code>org.flashapi.swing.text.ATM</code>
	 * 	class.
	 * 	
	 * 	<p>The <code>TextGlowEffect</code> library adds two native methods to text
	 * 	objects: <code>addTextGlow()</code> and <code>removeTextGlow()</code>.</p>
	 * 
	 * 	<p>The <code>removeTextGlow()</code> method has no parameters.<br/>The 
	 * 	<code>addTextGlow()</code> method specifies the following parameters:</p>
	 * 
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Type</th>
	 * 			<th>Default</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>color</code></td>
	 * 			<td><code>uint</code></td>
	 * 			<td><code>0xFF0000</code></td>
	 * 			<td>The color of the glow.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>alpha</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td><code>1.0</code></td>
	 * 			<td>The alpha transparency value for the color.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>blurX</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td><code>6.0</code></td>
	 * 			<td>The amount of horizontal blur.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>blurY</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td><code>6.0</code></td>
	 * 			<td>The amount of vertical  blur.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>strength</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td><code>2</code></td>
	 * 			<td>The strength of the imprint or spread.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>quality</code></td>
	 * 			<td><code>int</code></td>
	 * 			<td><code>BitmapFilterQuality.LOW</code></td>
	 * 			<td>The number of times to apply the filter.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>inner</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td><code>false</code></td>
	 * 			<td>Specifies whether the glow is an inner glow.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>knockout</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td><code>false</code></td>
	 * 			<td>Specifies whether the object has a knockout effect.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 *  @includeExample TextGlowEffectExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextGlowEffect implements ExtLib {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>TextGlowEffect</code> library.
		 */
		public function TextGlowEffect() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function init():void {
			ATM.prototype.addTextGlow = function(
					color:uint = 0xFF0000, alpha:Number = 1.0, blurX:Number = 6.0,
					blurY:Number = 6.0, strength:Number = 2, quality:int = 1,
					inner:Boolean = false, knockout:Boolean = false
				):void {
					var fx:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
					this.spas_internal::textRef.filters = [fx];
				}
			ATM.prototype.removeTextGlow = function():void {
				this.spas_internal::textRef.filters = [];
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			ATM.prototype.addTextGlow = null;
			ATM.prototype.removeTextGlow = null;
		}
	}
}