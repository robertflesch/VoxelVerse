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

package org.flashapi.swing.media.core {
	
	// -----------------------------------------------------------
	// MediaTextBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/06/2009 21:31
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.media.Media;
	import org.flashapi.swing.text.ACTM;
	import org.flashapi.swing.util.TimeUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>MediaTextBase</code> class is the base class for text objects
	 * 	that are associated with a specific <code>Media</code> instance to act on it.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MediaTextBase extends ACTM {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>MediaTextBase</code> instance with
		 * 	the specified parameters.
		 * 
		 * 	@param	media	A <code>Media</code> object associated with this
		 * 					<code>MediaTextBase</code> instance.
		 * 	@param	width	The width of the <code>MediaTextBase</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>MediaTextBase</code> instance, in
		 * 					pixels.
		 * 	@param	defaultLaf	The default <code>LookAndFeel</code> class reference
		 * 						for this <code>MediaTextBase</code> instance.
		 */
		public function MediaTextBase(media:Media, width:Number, height:Number, defaultLaf:Class)  {
			super(width, height);
			initObj(media, defaultLaf);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant that defines the default width for media text objects.
		 */
		public static const DEFAULT_WIDTH:Number = 50;
		
		/**
		 * 	A constant that defines the default height for media text objects.
		 */
		public static const DEFAULT_HEIGHT:Number = 18;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>media</code> property.
		 * 
		 * 	@see #media
		 */
		protected var _media:Media;
		/**
		 * 	Sets or gets the <code>Media</code> object associated with this 
		 * 	<code>MediaTextBase</code> instance.
		 * 
		 * 	@default null
		 */
		public function get media():Media {
			return _media;
		}
		public function set media(value:Media):void {
			removeMediaEvents();
			_media = value;
			addMediaEvents();
		}
		
		/**
		 * @private
		 */
		override public function get width():Number {
			//return isNaN(_width) ? spas_internal::textRef.width : _width;
			return isNaN($width) ? spas_internal::uioSprite.getBounds(null).width : $width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>EventCollector</code> instance that is
		 * 	used to manage events relative to the <code>Media</code> object associated
		 * 	with this <code>MediaTextBase</code> instance.
		 */
		protected var $mediaEvtColl:EventCollector;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function removeMediaEvents():void {
			$mediaEvtColl.removeAllEvents();
		}
		
		/**
		 * 	@private
		 */
		protected function addMediaEvents():void { }
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			updateText();
			fixSize();
			setPositions();
			setEffects();
		}
		
		/**
		 * @private
		 */
		protected function formatTime(time:int):String {
			return TimeUtil.formatTime(time);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(media:Media, defaultLaf:Class):void {
			initMinSize(); 
			initLaf(defaultLaf);
			initTextFormat();
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			_media = media;
			$mediaEvtColl = new EventCollector();
		}
	}
}