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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// TextureManager.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 30/05/2009 00:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.draw.Pattern;
	
	/**
	 * 	The <code>TextureManager</code> class allows to easilly manage textures
	 * 	rendering for any <code>DisplayObject</code> instance. The <code>TextureManager</code>
	 * 	class is responsible for rendering all texture images used by <code>UIObjects</code>.
	 * 
	 * 	@see org.flashapi.swing.UIObject#textureManager
	 * 	@see org.flashapi.swing.UIObject#backgroundTextureManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextureManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>TextureManager</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	target	The <code>DisplayObject</code> instance where the texture
		 * 					will be rendered.
		 * 	@param	width	The width of the <code>TextureManager</code> object, in pixels.
		 * 	@param	height	The height of the <code>TextureManager</code> object, in pixels.
		 */
		public function TextureManager(target:DisplayObject, width:Number = 100, height:Number = 100) {
			super();
			initObj(target, width, height);
		}
		
		//-------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------
		
		/**
		 * 	Sets a specific shape to this <code>TextureManager</code> object that is 
		 * 	used render the texture image by using this custom shape instead of a
		 * 	rectangular area. If <code>null</code> the texture is drawn using the
		 * 	specified width and height.
		 * 
		 * 	@param figure A <code>Figure</code> object that allows access to its
		 * 					drawing methods to draw the custom shape.
		 * 
		 * 	@default null
		 */
		public var setShape:Function = null;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _gradientProperties:Object;
		/**
		 * 	Sets or gets the object used to initialize the gradient properties of this
		 * 	texture when the <code>draw()</code> method is called with
		 * 	<code>TextureType.GRADIENT</code> as parameter.
		 * 
		 * 	<p>The <code>gradientProperties</code> object must define the following
		 * 	properties:</p>
		 * 	
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Property</th>
		 * 			<th>Type</th>
		 * 			<th>Description</th>
		 * 			<th>Default value</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>type</code></td>
		 * 			<td><code>String</code></td>
		 * 			<td>A value from the <code>GradientType</code> class that specifies
		 * 			which gradient type to use: <code>GradientType.LINEAR</code> or
		 * 			<code>GradientType.RADIAL</code>.</td>
		 * 			<td><code>GradientType.LINEAR</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>colors</code></td>
		 * 			<td><code>Array</code></td>
		 * 			<td>An array of RGB hexadecimal color values to be used in the
		 * 			gradient.</td>
		 * 			<td><code>[0x000000, 0xFFFFFF]</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>colors</code></td>
		 * 			<td><code>Array</code></td>
		 * 			<td>An array of color distribution ratios; valid values are
		 * 			<code>0</code> to <code>255</code>.</td>
		 * 			<td><code>[0, 250]</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>matrix</code></td>
		 * 			<td><code>Matrix</code></td>
		 * 			<td>A transformation matrix as defined by the 
		 * 			<code>flash.geom.Matrix</code> class.</td>
		 * 			<td><code>null</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>spreadMethod</code></td>
		 * 			<td><code>String</code></td>
		 * 			<td>A value from the <code>SpreadMethod</code> class that specifies
		 * 			which spread method to use, either: <code>SpreadMethod.PAD</code>,
		 * 			<code>SpreadMethod.REFLECT</code> or <code>SpreadMethod.REPEAT</code>.</td>
		 * 			<td><code>SpreadMethod.PAD</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>interpolationMethod</code></td>
		 * 			<td><code>String</code></td>
		 * 			<td>A value from the <code>InterpolationMethod</code> class that specifies
		 * 			which value to use: <code>InterpolationMethod.LINEAR_RGB </code> or
		 * 			<code>InterpolationMethod.RGB</code>.</td>
		 * 			<td><code>InterpolationMethod.RGB</code></td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>focalPointRatio</code></td>
		 * 			<td><code>Number</code></td>
		 * 			<td>A number that controls the location of the focal point
		 * 			of the gradient.</td>
		 * 			<td><code>0</code></td>
		 * 		</tr>
		 * 	</table>
		 * 
		 * 	@see #draw()
		 */
		public function get gradientProperties():Object {
			return _gradientProperties;
		}
		public function set gradientProperties(properties:Object):void {
			for (var prop:String in properties) {
				if (prop == "colors") {
					var color:*;
					var colors:Array = [];
					for each(color in properties[prop]) colors.push(new Color().getValue(color));
					_gradientProperties[prop] = colors;
				} else _gradientProperties[prop] = properties[prop];
			}
		}
		
		private var _width:Number;
		/**
		 * 	Sets or gets the width of the <code>TextureManager</code> object,
		 * 	in pixels.
		 * 
		 * 	@see #height
		 * 	@see #resize()
		 */
		public function get width():Number {
			return _width;
		}
		public function set width(value:Number):void {
			_width = value;
			_pattern.resize(value, _height);
		}
		
		private var _height:Number;
		/**
		 * 	Sets or gets the height of the <code>TextureManager</code> object,
		 * 	in pixels.
		 * 
		 * 	@see #width
		 * 	@see #resize()
		 */
		public function get height():Number {
			return _height;
		}
		public function set height(value:Number):void {
			_height = value;
			_pattern.resize(_width, value);
		}
		
		private var _color:*;
		/**
		 * 	Sets or gets the color used to render the <code>TextureManager</code>
		 * 	object, when the <code>draw()</code> method is called with
		 * 	<code>TextureType.PLAIN</code> as parameter.
		 * 
		 * 	@see #draw()
		 */
		public function get color():* {
			return _color;
		}
		public function set color(value:*):void {
			_color = new Color().getValue(value);
		}
		
		private var _pattern:Pattern;
		/**
		 * 	Returns a reference to the <code>Pattern</code> instance that is used
		 * 	by this <code>TextureManager</code> object to render the texture.
		 */
		public function get pattern():Pattern {
			return _pattern;
		}
		
		private var _textureType:String = TextureType.PLAIN;
		/**
		 * 	Returns a <code>String</code> that represents the type of texture
		 * 	which is rendered by this <code>TextureManager</code> object.
		 * 	<ul>
		 * 		<li><code>TextureType.PLAIN</code> means that the texture is
		 * 		rendered with plain color.</li>
		 * 		<li><code>TextureType.GRADIENT</code> means that the texture is
		 * 		rendered with gradient colors.</li>
		 * 		<li><code>TextureType.TEXTURE</code> means that the texture is
		 * 		rendered by using the internal <code>Pattern</code> instance.</li>
		 * 	</ul>
		 * 
		 * 	@see #draw()
		 * 	@see #pattern
		 */
		public function get textureType():String {
			return _textureType;
		}
		
		private var _figure:Figure;
		/**
		 * 	Returns a reference to the <code>Figure</code> instance that is used
		 * 	by this <code>TextureManager</code> object to draw custom spahes to
		 * 	render the texture.
		 */
		public function get figure():Figure {
			return _figure;
		}
		
		private var _alpha:Number;
		/**
		 * 	Sets or gets the alpha value of the color of the rendered texture;
		 * 	valid values are <code>0</code> to <code>1</code>. If the value is
		 * 	less than <code>0</code>, the default is <code>0</code>. If the value
		 * 	is greater than <code>1</code>, the default is <code>1</code>.
		 * 
		 * 	@default 1.0
		 */
		public function get alpha():Number {
			return _alpha;
		}
		public function set alpha(value:Number):void {
			_alpha = value;
		}
		
		/**
		 * 	Sets or gets the color transformation of the internal <code>Pattern</code>
		 * 	instance associated with this <code>TextureManager</code> object.
		 * 
		 * 	@see #pattern
		 */
		public function get colorTransform():ColorTransform {
			return _pattern.colorTransform;
		}
		public function set colorTransform(value:ColorTransform):void {
			_pattern.colorTransform = value;
		}
		
		private var _target:DisplayObject;
		/**
		 * 	Returns a reference to the <code>DisplayObject</code> object that is
		 * 	used by this <code>TextureManager</code> object to render the texture.
		 */
		public function get target():DisplayObject {
			return _target;
		}
		
		/**
		 * 	Sets or gets the texture image by used this <code>TextureManager</code>
		 * 	object to render the texture. Texture can be a <code>BitmapData</code>,
		 * 	a <code>Shape</code>, <code>Sprite</code>, a <code>Bitmap</code> object
		 * 	or any extenal graphical asset, specified by the <code>texture</code>
		 * 	property of the constructor parameter.
		 */
		public function get texture():* {
			return _pattern.texture;
		}
		public function set texture(value:*):void {
			_pattern.texture = value;
		}
		
		//-------------------------------------------------------------------------
		//
		//  Public methods
		//
		//-------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all subprocess will
		 * 	be killed for this <code>TextureManager</code> object. After calling this
		 * 	function you have to set the <code>TextureManager</code> to <code>null</code>
		 * 	to make it elligible for garbage collection.
		 */
		public function finalize():void {
			if (_pattern != null) {
				_pattern.dispose();
				_pattern = null;
			}
		}
		
		/**
		 * 	Draws a texture image within the <code>DisplayObject</code> instance specified
		 * 	by the <code>target</code> parameter.
		 * 
		 * 	@param	textureType A <code>TextureType</code> class constant value that
		 * 						indicated the type of texture rendering for this
		 * 						<code>TextureManager</code> object:
		 * 	<ul>
		 * 		<li><code>TextureType.PLAIN</code> means that the texture is
		 * 		rendered with plain color,</li>
		 * 		<li><code>TextureType.GRADIENT</code> means that the texture is
		 * 		rendered with gradient colors,</li>
		 * 		<li><code>TextureType.TEXTURE</code> means that the texture is
		 * 		rendered by using the internal <code>Pattern</code> instance.</li>
		 * 	</ul>
		 * 
		 * 	@see #textureType
		 * 	@see #clear()
		 */
		public function draw(textureType:String = "plain"):void {
			switch(textureType) {
				case TextureType.PLAIN :
					_figure = new Figure(_target);
					drawPlainColor();
					break;
				case TextureType.GRADIENT :
					_figure = new Figure(_target);
					drawGradientColor();
					break;
				case TextureType.TEXTURE :
					_figure = _pattern.figure;
					drawPattern();
					break;
			}
		}
		
		/**
		 * 	Clears the rendered texture.
		 * 
		 * 	@see #draw()
		 */
		public function clear():void {
			clearPattern();
		}
		
		/**
		 * 	Resizes the <code>TextureManager</code> object with the specified
		 * 	<code>width</code> and <code>height</code>.
		 * 
		 * 	@param The new width for the texture, in pixels.
		 * 	@param The new height for the texture, in pixels.
		 * 
		 * 	@see #height
		 * 	@see #width
		 */
		public function resize(width:Number, height:Number):void {
			_width = width;
			_height = height;
			_pattern.resize(width, height);
		}
		
		/*
		public function get repeat():void{ return _repeat; }
		public function get repeatX():void { return _repeatX; }
		public function get repeatY():void { return _repeatY; }*/
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _repeat:Boolean;
		private var _repeatX:Boolean;
		private var _repeatY:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:DisplayObject, width:Number, height:Number):void {
			_target = target;
			_width = width;
			_height = height;
			_pattern = new Pattern(_target);
			_color = 0xFFFFFF;
			_alpha = 1.0;
			_gradientProperties = {
				type:GradientType.LINEAR,
				colors:[0x000000, 0xFFFFFF],
				ratios:[0, 250],
				matrix:null,
				spreadMethod:SpreadMethod.PAD,
				interpolationMethod:InterpolationMethod.RGB,
				focalPointRatio:0
			};
			_repeat = _repeatX = _repeatY = true;
		}
		
		private function drawPlainColor():void {
			clearPattern();
			_figure.beginFill(_color, _alpha);
			setShape != null ? setShape() : _figure.drawRectangle(0, 0, _width, _height);
			_figure.endFill();
			_textureType = TextureType.PLAIN;
		}
		
		private function drawGradientColor():void {
			clearPattern();
			var o:Object = _gradientProperties;
			if(o["matrix"]==null) {
				var m:Matrix = new Matrix();
				m.createGradientBox(width, _height, Math.PI / 2);
			} else m = o["matrix"];
			_figure.beginGradientFill(
				o.type, o.colors, [_alpha, _alpha], o.ratios, m,
				o.spreadMethod, o.interpolationMethod, o.focalPointRatio
			);
			setShape != null ? setShape() : _figure.drawRectangle(0, 0, _width, _height);
			_figure.endFill();
			_textureType = TextureType.GRADIENT;
		}
		private function drawPattern():void {
			_textureType = TextureType.TEXTURE;
			if (setShape != null) _pattern.setShape = setShape;
			_pattern.resize(_width, _height);
			//_pattern.display();
		}
		
		private function clearPattern():void {
			_pattern.clear();
			//_pattern.remove();
		}
	}
}