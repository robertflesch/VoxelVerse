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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// ASTM.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 21/02/2009 00:43
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.text.TextLineMetrics;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>ASTM</code> class (for Abstract Sinple Text Methods) is the base
	 * 	class for objects that allow to display texts within a single line only.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ASTM extends ATM {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ASTM</code> object with the specified
		 * 	parameters.
		 * 
		 * 	@param	label	The text displayed within the text object.
		 * 	@param	width	The width of the text object, in pixels.
		 */
		public function ASTM(label:String = "", width:Number = NaN) {
			super();
			initObj(label, width);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies whether the text field is a password text field. If <code>true</code>
		 * 	the text object is treated as a password text field and hides the input
		 * 	characters using asterisks. If <code>false</code>, it is not treated as
		 * 	a password text field. When password mode is enabled, the Cut and Copy
		 * 	commands and their corresponding keyboard shortcuts will not function.
		 * 	This security mechanism prevents an unscrupulous user from using the
		 * 	shortcuts to discover a password on an unattended computer.
		 * 
		 * @default false
		 */
		public function get displayAsPassword():Boolean {
			return textRef.displayAsPassword;
		}
		public function set displayAsPassword(value:Boolean):void {
			textRef.displayAsPassword = value;
		}
		
		/**
		 * @private
		 */
		override public function set width(value:Number):void {
			if(!isNaN($width)) textRef.width = value - $padL - $padR;
			$width = value;
			$needsHorizontalIconUpdate = true;
			setRefresh();
		}
		
		/**
		 * @private
		 */
		override public function get height():Number {
			//return isNaN(_height) ? lookAndFeel.getDefaultHeight() : _height;
			//
			return isNaN($height) ? spas_internal::uioSprite.getBounds(null).height : $height;
		}
		
		/**
		 * @private
		 */
		override public function get backgroundHeight():Number {
			var bh:Number = isNaN($height) ? lookAndFeel.getDefaultHeight() : $height;
			return bh;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function createContainer():void {
			if(spas_internal::isBorderInstance) createBorderIstanceContainer();
			if(!isNaN($width)) textRef.width = $width;
			//spas_internal::textRef.border = true;
			textRef.multiline = false;
			textRef.selectable = $selectable;
			spas_internal::isBorderInstance ?
				spas_internal::uioSprite.addChildAt(textRef, 1) :
				spas_internal::uioSprite.addChild(textRef);
			$evtColl.addEvent(textRef, Event.CHANGE, textChangedHandler);
		}
		
		/**
		 * @private
		 */
		protected function fixHeight():void {
			textRef.height = isNaN($height) ? lookAndFeel.getDefaultHeight() : $height;
		}
		
		/**
		 * @private
		 */
		protected function initStoredHeight():void {
			$storedSize.height = this.height;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			super.setSpecificLafChanges();
			fixHeight();
		}
		
		/**
		 *  @private
		 */
		protected function fixBaseLine():void {
			var m:TextLineMetrics = textRef.getLineMetrics(0);
			$horizontalBaseLine = m.ascent;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number):void {
			$text = label;
			$width = width;
			$storedSize.width = width;
			$height = NaN;
		}
	}
}