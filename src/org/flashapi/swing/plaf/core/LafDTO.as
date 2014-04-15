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

package org.flashapi.swing.plaf.core {
	
	// -----------------------------------------------------------
	// LafDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 09/11/2010 10:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.state.ColorState;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>LafDTO</code> class lets you create a data transfert object to
	 * 	set parameters used by Look and Feel and <code>Skinnable</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public dynamic class LafDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new Look And Feel data transfert object to store
		 * 	all L&amp;F parameters set by its associated <code>UIObject</code>.
		 * 
		 * 	<p>The <code>LafDTO</code> defines the basic set of properties that can
		 * 	be used by <code>LookAndFeel</code> objects. But all <code>UIObjects</code>
		 * 	can define new <code>LafDTO</code> properties. Undocumented <code>LafDTO</code>
		 * 	properties are specified by the <code>UIObject</code> corresponding LAF
		 * 	reference (eg: the LAF reference for the <code>Button</code> class is the
		 * 	<code>ButtonUI</code> class).</p>
		 * 
		 * 	<p>The internal reference to the associated <code>UIObject</code> is
		 * 	untyped to enable access to ihnerited properties of <code>UIObject</code>
		 * 	subclasses.</p>
		 * 
		 * 	@param	uio	The <code>UIObject</code> instance associated with this Look
		 * 				and Feel data transfert object.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 * 	@see org.flashapi.swing.plaf.LookAndFeel
		 */
		public function LafDTO(uio:*) {
			super();
			this.uio = uio;
			this.container = uio.spas_internal::uioSprite;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Deprecated] A reference to the <code>UIObject</code> instance associated 
		 * 	with this Look And Feel data transfert object.
		 * 
		 * 	<p>The reference to the associated <code>UIObject</code> is untyped to enable
		 * 	access to ihnerited properties of <code>UIObject</code> subclasses.</p>
		 */
		public var uio:*;
		
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>UIObject</code> is active
		 * 	(<code>true</code>) or not (<code>false</code>).
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#active
		 */
		public var active:Boolean;
		
		/**
		 * 	A reference to the <code>UIObject</code> background opacity.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#backgroundAlpha
		 */
		public var backgroundAlpha:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> background texture manager.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#backgroundTextureManager
		 */
		public var backgroundTextureManager:TextureManager;
		
		/**
		 * 	A reference to the <code>UIObject</code> border opacity.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderAlpha
		 */
		public var borderAlpha:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> border color.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColor
		 */
		public var borderColor:Number;
		
		/**
		 * 	A reference to the <code>ColorState</code> object used by the
		 * 	<code>UIObject</code> to define its border colors.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColors
		 */
		public var borderColors:ColorState;
		
		/**
		 * 	A reference to the <code>UIObject</code> border width.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderWidth
		 */
		public var borderWidth:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> bottom left corner radius.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#bottomLeftCorner
		 */
		public var bottomLeftCorner:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> bottom right corner radius.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#bottomRightCorner
		 */
		public var bottomRightCorner:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> color.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#color
		 */
		public var color:Number;
		
		/**
		 * 	A reference to the <code>ColorState</code> object used by the
		 * 	<code>UIObject</code> to define its colors.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#colors
		 */
		public var colors:ColorState;
		
		/**
		 * 	A reference to the <code>UIObject</code> main container
		 * 	specified by the <code>container</code> property.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#container
		 */
		public var container:Sprite;
		
		/**
		 * 	A reference to the <code>UIObject</code> corner radius.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
		 */
		public var cornerRadius:Number;
		
		/**
		 * 	A reference to the current <code>DisplayObject</code> used to indicate
		 * 	to a look and feel method what is the display object that must be rendered.
		 * 	In most cases, this property is different for each look and feel method.
		 */
		public var currentTarget:*;
		
		/**
		 * 	A reference to the <code>UIObject</code> focus color.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#focusColor
		 */
		public var focusColor:Number;
		
		/**
		 * 	A reference to the object font color.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#fontColor
		 */
		public var fontColor:Number;
		
		/**
		 * 	A reference to the <code>ColorState</code> object used by the
		 * 	object to define its font colors.
		 * 
		 * 	@see org.flashapi.swing.button.core.ABM#fontColors
		 */
		public var fontColors:ColorState;
		
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>UIObject</code>
		 * 	glow effect is active (<code>true</code>) or not (<code>false</code>).
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#glow
		 */
		public var glow:Boolean;
		
		/**
		 * 	A reference to the <code>UIObject</code> glow effect color.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#glowColor
		 */
		public var glowColor:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> height.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#height
		 */
		public var height:Number;
		
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>UIObject</code>
		 * 	shadow effect is active (<code>true</code>) or not (<code>false</code>).
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#shadow
		 */
		public var shadow:Boolean;
		
		/**
		 * 	The current state of the <code>UIObject</code>.
		 */
		public var state:String;
		
		/**
		 * 	A reference to the <code>UIObject</code> texture manager.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#TextureManager
		 */
		public var textureManager:TextureManager;
		
		/**
		 * 	A reference to the <code>UIObject</code> top left corner radius.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#topLeftCorner
		 */
		public var topLeftCorner:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> top right corner radius.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#topRightCorner
		 */
		public var topRightCorner:Number;
		
		/**
		 * 	A reference to the <code>UIObject</code> width.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#width
		 */
		public var width:Number;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	The setSize method is used by UIObject instances to set the LafDTO object
		 * 	width and height at one time.
		 */
		spas_internal function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Finalizes the data transfert object.
		 * 	This method is called by the UIObject.finalize() function. 
		 */
		spas_internal function finalize():void {
			this.currentTarget = null;
			this.container = null;
			this.colors = null;
			this.fontColors = null;
			this.borderColors = null;
			this.textureManager = null;
			this.backgroundTextureManager = null;
			this.uio = null;
		}
	}
}