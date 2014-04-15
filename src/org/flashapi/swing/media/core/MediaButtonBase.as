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
	// MediaButtonBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/06/2009 21:28
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.button.core.DrawableIconButton;
	import org.flashapi.swing.media.Media;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>MediaButtonBase</code> class is the base class for button objects
	 * 	that are associated with a specific <code>Media</code> instance to act on it.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MediaButtonBase extends DrawableIconButton {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>MediaButtonBase</code> instance with
		 * 	the specified parameters.
		 * 
		 * 	@param	media	A <code>Media</code> object associated with this
		 * 					<code>MediaButtonBase</code> instance.
		 * 	@param	width	The width of the <code>MediaButtonBase</code> instance,
		 * 					in pixels.
		 * 	@param	height	The height of the <code>MediaButtonBase</code> instance,
		 * 					in pixels.
		 * 	@param	defaultLaf	The default <code>LookAndFeel</code> class reference
		 * 						for this <code>MediaButtonBase</code> instance.
		 */
		public function MediaButtonBase(media:Media, width:Number, height:Number, defaultLaf:Class) {
			super(width, height, defaultLaf);
			initObj(media);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant that defines the default width for media button objects.
		 */
		public static const DEFAULT_WIDTH:Number = 35;
		
		/**
		 * 	A constant that defines the default height for media button objects.
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
		protected var $media:Media;
		/**
		 * 	Sets or gets the <code>Media</code> object associated with this 
		 * 	<code>MediaButtonBase</code> instance.
		 * 
		 * 	@default null
		 */
		public function set media(value:Media):void {
			removeMediaEvents();
			$media = value;
			addMediaEvents();
		}
		public function get media():Media {
			return $media;
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
		 * 	with this <code>MediaButtonBase</code> instance.
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(media:Media):void {
			$mediaEvtColl = new EventCollector();
			$media = media;
		}
	}
}