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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	//  Drawing.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.5, 15/03/2010 21:38
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.libs.DrawingUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Drawing.png")]
	
	/**
	 * 	<img src="Drawing.png" alt="Drawing" width="18" height="18"/>
	 * 
	 * 	The <code>Drawing</code> class allows to create <code>UIObject</code>
	 * 	that can be used to display custom drawings.
	 * 
	 *  @includeExample DrawingExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Drawing extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--> TODO: background autosize does not work.
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Drawing</code> instance with the specified
		 * 	dimensions.
		 * 
		 * 	@param	width 	The width of the <code>Drawing</code> instance, in pixels.
		 * 	@param	height 	The height of the <code>Drawing</code> instance, in pixels.
		 */
		public function Drawing(width:Number = 100, height:Number = 100) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>figure</code> property.
		 * 
		 * 	@see #figure
		 */
		protected var $figure:Figure;
		/**
		 * 	Returns a reference to the <code>Figure</code> instance used by this
		 * 	<code>Drawing</code> instance to apply vector drawing commands. 
		 * 
		 * 	@see #graphics
		 */
		public function get figure():Figure {
			return $figure;
		}
		
		/**
		 * 	Returns a reference to the <code>Graphics</code> instance used by this
		 * 	<code>Drawing</code> instance to apply vector drawing commands.
		 * 
		 * 	@see #figure
		 */
		override public function get graphics():Graphics {
			return spas_internal::uioSprite.graphics;
		}
		
		/**
		 * 	@private
		 */
		override public function set texture(value:*):void {
			$textureManager.resize($width, height);
			super.texture = value;
		}
		
		private var _showBackground:Boolean = true;
		/**
		 *  A <code>Boolean</code> value that specifies whether the background of this
		 * 	<code>Drawing</code> instance is visible (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get showBackground():Boolean {
			return _showBackground;
		}
		public function set showBackground(value:Boolean):void {
			_showBackground = value;
			if (!value) $textureManager.clear();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Drawing public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Fills a <code>Drawing</code> object with a bitmap image. The bitmap can be
		 * 	repeated or tiled to fill the figure. The fill remains in effect until you
		 * 	call the <code>beginFill()</code>, <code>beginBitmapFill()</code>,
		 * 	<code>beginGradientFill()</code> method. Calling the <code>clear()</code>
		 * 	method clears the fill.
		 * 
		 * 	<p>Flash Player does not render the fill until the <code>endFill()</code>
		 * 	method is called.</p>
		 * 
		 * 	@param	bitmap	A transparent or opaque bitmap image that contains the bits
		 * 					to be displayed.
		 * 	@param	matrix	A matrix object, which you can use to define transformations
		 * 					on the bitmap.
		 * 	@param	repeat	 If <code>true</code>, the bitmap image repeats in a tiled
		 * 					pattern. If <code>false</code>, the bitmap image does not
		 * 					repeat, and the edges of the bitmap are used for any fill
		 * 					area that extends beyond the bitmap.
		 * 	@param	smooth	If <code>false</code>, upscaled bitmap images are rendered
		 * 					by using a nearest-neighbor algorithm and look pixelated.
		 * 					If <code>true</code>, upscaled bitmap images are rendered
		 * 					by using a bilinear algorithm. Rendering by using the nearest
		 * 					neighbor algorithm is usually faster.
		 */
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {
			$figure.beginBitmapFill(bitmap, matrix, repeat, smooth);
		}
		
		/**
		 * 	Specifies a simple one-color fill that Flash Player uses for subsequent calls
		 * 	to other <code>Drawing</code> methods (such as <code>lineTo()</code> or
		 * 	<code>drawCircle()</code>) for the object. The fill remains in effect until
		 * 	you call the <code>beginFill()</code>, <code>beginBitmapFill()</code> or
		 * 	<code>beginGradientFill()</code> method. Calling the <code>clear()</code> method
		 * 	clears the fill.
		 * 
		 * 	<p>Flash Player does not render the fill until the <code>endFill()</code> method
		 * 	is called.</p>
		 * 
		 * 	@param	color	The color of the fill.
		 * 	@param	alpha	The alpha value of the fill, from <code>0.0</code> to <code>1.0</code>.
		 */
		public function beginFill(color:uint = 0x000000, alpha:Number = 1.0):void {
			$figure.beginFill(color, alpha);
		}
		
		/**
		 * 	Clears the graphics that were drawn to this <code>Drawing</code> object,
		 * 	and resets fill and line style settings.
		 * 
		 * 	@see #endFill()
		 * 	@see #clearBackground()
		 */
		public function clear():void {
			_actionStack = [];
			$figure.clear();
		}
		
		/**
		 * 	Clears the background container of this <code>Drawing</code> object,
		 * 	and resets fill and line style settings.
		 * 
		 * 	@see #clear()
		 */
		public function clearBackground():void {
			$textureManager.clear();
		}
		
		/**
		 * 	Specifies a line style to be used for subsequent calls to <code>Drawing</code>
		 * 	methods such as the <code>drawLine()</code> method or the <code>drawCircle()</code>
		 * 	method.
		 * 	
		 * 	<p>The line style remains in effect until you call the <code>lineGradientStyle()</code>
		 * 	method or the <code>lineStyle()</code> method with different parameters.</p>
		 * 
		 * 	<p>You can call the <code>lineStyle()</code> method in the middle of drawing
		 * 	a path to specify different styles for different line segments within the path.</p>
		 * 
		 * 	<p><strong>Note:</strong> Calls to the <code>clear()</code> method set the line
		 * 	style back to <code>undefined</code>.</p>
		 * 	
		 * 	@param	thickness	An integer that indicates the thickness of the line in points;
		 * 	valid values are <code>0</code> to <code>255</code>. If the parameter is <code>undefined</code>,
		 * 	a line is not drawn. If a value of less than <code>0</code> is passed, the default is
		 * 	<code>0</code>. The value <code>0</code> indicates hairline thickness. If a value
		 * 	greater than <code>255</code> is passed, the default is <code>255</code>.
		 * 	@param	color	A hexadecimal color value of the line; Default is <code>0x000000</code>
		 * 					(black).
		 * 	@param	alpha	A number that indicates the alpha value of the color of the line;
		 * 	valid values are <code>0</code> to <code>1</code>. Default is <code>1</code> (solid).
		 * 	If the value is less than <code>0</code>, the default is <code>0</code>. If the value
		 * 	is greater than <code>1</code>, the default is <code>1</code>.
		 * 	@param	pixelHinting	A <code>Boolean</code> value that specifies whether to hint strokes
		 * 	to full pixels. This affects both the position of anchors of a curve and the line stroke
		 * 	size itself. With <code>pixelHinting</code> set to <code>true</code>, Flash Player hints 
		 * 	line widths to full pixel widths. With <code>pixelHinting</code> set to <code>false</code>,
		 * 	disjoints can appear for curves and straight lines. 
		 * 	@param	scaleMode	A value from the <code>LineScaleMode</code> class that specifies
		 * 	which scale mode to use. Valid values are: <code>LineScaleMode.NONE</code>, <code>LineScaleMode.NORMAL</code>,
		 * 	<code>LineScaleMode.VERTICAL</code> and <code>LineScaleMode.HORIZONTAL</code>.
		 * 	@param	caps	A value from the <code>CapsStyle</code> class that specifies the type of
		 * 	caps at the end of lines. Valid values are: <code>CapsStyle.NONE</code>, <code>CapsStyle.ROUND</code>,
		 * 	and <code>CapsStyle.SQUARE</code>.
		 * 	@param	joints	 A value from the <code>JointStyle</code> class that specifies the type
		 * 	of joint appearance used at angles. Valid values are: <code>JointStyle.BEVEL</code>,
		 * 	<code>JointStyle.MITER</code>, and <code>JointStyle.ROUND</code>.
		 * 	@param	miterLimit	A number that indicates the limit at which a miter is cut off. Valid
		 * 	values range from <code>1</code> to <code>255</code> (and values outside of that range
		 * 	are rounded to <code>1</code> or <code>255</code>). This value is only used if the jointStyle
		 * 	is set to <code>JointStyle.MITER</code>. The <code>miterLimit</code> value represents the
		 * 	length that a miter can extend beyond the point at which the lines meet to form a joint.
		 * 	The value expresses a factor of the line thickness. For example, with a miterLimit factor
		 * 	<code>2.5</code> of and a thickness of <code>10</code> pixels, the miter is cut off at
		 * 	<code>25</code> pixels.
		 * 
		 * 	@see #clear()
		 */
		public function lineStyle(thickness:Number = 1, color:uint = 0x000000, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void {
			$figure.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		}
		
		/**
		 * 	Specifies a gradient to use for the stroke when drawing lines.
		 * 
		 * 	<p>Call the <code>lineStyle()</code> method before you call the <code>lineGradientStyle()</code>
		 * 	method to enable a stroke, or else the value of the line style will be <code>undefined</code>.</p>
		 * 
		 * 	<p>You can call the <code>lineStyle()</code> method in the middle of drawing
		 * 	a path to specify different styles for different line segments within the path.</p>
		 * 
		 * 	<p><strong>Note:</strong> Calls to the <code>clear()</code> method set the line
		 * 	style back to <code>undefined</code>.</p>
		 * 
		 * 	@param	type	A value from the <code>GradientType</code> class that specifies
		 * 	which gradient type to use, either <code>GradientType.LINEAR</code> or
		 * 	<code>GradientType.RADIAL</code>.
		 * 	@param	colors	An array of RGB hex color values to be used in the gradient.
		 * 	@param	alphas	An array of alpha values for the corresponding colors in the colors
		 * 	array; valid values are <code>0</code> to <code>1</code>. If the value is less than
		 * 	<code>0</code>, the default is <code>0</code>. If the value is greater than <code>1</code>,
		 * 	the default is <code>1</code>.
		 * 	@param	ratios	An array of color distribution ratios; valid values are from <code>0</code>
		 * 	to <code>255</code>. This value defines the percentage of the width where the color is
		 * 	sampled at 100%. The value <code>0</code> represents the left-hand position in the
		 * 	gradient box, and <code>255</code> represents the right-hand position in the gradient
		 * 	box. This value represents positions in the gradient box, not the coordinate space
		 * 	of the final gradient, which might be wider or thinner than the gradient box. Specify
		 * 	a value for each value in the colors parameter.
		 * 	@param	matrix	 transformation matrix as defined by the <code>flash.geom.Matrix</code>
		 * 	class. The <code>Matrix</code> class includes a <code>createGradientBox()</code> method,
		 * 	which lets you conveniently set up the matrix for use with the <code>lineGradientStyle()</code>
		 * 	method.
		 * 	@param	spreadMethod	A value from the <code>SpreadMethod</code> class that specifies
		 * 	which spread method to use. Valid values are <code>SpreadMethod.PAD</code>,
		 * 	<code>preadMethod.REFLECT</code> and <code>SpreadMethod.REPEAT</code>.
		 * 	@param	interpolationMethod	 A value from the <code>InterpolationMethod</code> class
		 * 	that specifies which value to use. Valid values are <code>InterpolationMethod.LINEAR_RGB</code>
		 * 	and <code>InterpolationMethod.RGB</code>.
		 * 	@param	focalPointRatio	A number that controls the location of the focal point of
		 * 	the gradient. The value <code>0</code> means the focal point is in the center.
		 * 	The value <code>1</code> means the focal point is at one border of the gradient
		 * 	circle. The value <code>-1</code> means that the focal point is at the other border
		 * 	of the gradient circle. Values less than <code>-1</code> or greater than <code>1</code>
		 * 	are rounded to <code>-1</code> or <code>1</code>.
		 * 
		 * 	@see #clear()
		 */
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void {
			$figure.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * 	Applies a fill to the lines and curves that were added since the last call
		 * 	to the <code>Drawing</code> methods. If the current drawing position does
		 * 	not equal the previous position specified in a <code>moveTo()</code> method
		 * 	and a fill is defined, the path is closed with a line and then filled.
		 * 
		 * 	@see #clear()
		 */
		public function endFill():void {
			$figure.endFill();
			setRefresh();
		}
		
		/**
		 * 	Specifies a gradient fill to be used for subsequent calls to other <code>Drawing</code>
		 * 	methods (such as <code>lineTo()</code> or <code>drawCircle()</code>) for the object.
		 * 	The fill remains in effect until you call the <code>beginFill()</code>,
		 * 	<code>beginBitmapFill()</code> or <code>beginGradientFill()</code> method. Calling
		 * 	the <code>clear()</code> method clears the fill.
		 * 
		 * 	<p>Flash Player does not render the fill until the <code>endFill()</code> method is
		 * 	called.</p>
		 * 
		 * 	@param	type	A value from the <code>GradientType</code> class that specifies
		 * 	which gradient type to use: <code>GradientType.LINEAR</code> or <code>GradientType.RADIAL</code>.
		 * 	@param	colors	An array of RGB hexadecimal color values to be used in the gradient
		 * 	You can specify up to 15 colors. For each color, be sure you specify a corresponding
		 * 	value in the <code>alphas</code> and <code>ratios</code> parameters.
		 * 	@param	alphas	An array of alpha values for the corresponding colors in the colors
		 * 	array; valid values are <code>0</code> to <code>1</code>. If the value is less than
		 * 	<code>0</code>, the default is <code>0</code>. If the value is greater than <code>1</code>,
		 * 	the default is <code>1</code>.
		 * 	@param	ratios	An array of color distribution ratios; valid values are <code>0</code> to
		 * 	<code>255</code>. This value defines the percentage of the width where the color is
		 * 	sampled at 100%. The value <code>0</code> represents the left-hand position in the
		 * 	gradient box, and <code>255</code> represents the right-hand position in the gradient box.
		 * 	@param	matrix	A transformation matrix as defined by the <code>flash.geom.Matrix</code>
		 * 	class. The <code>Matrix</code> class includes a <code>createGradientBox()</code> method,
		 * 	which lets you conveniently set up the matrix for use with the <code>beginGradientFill()</code>
		 * 	method.
		 * 	@param	spreadMethod	A value from the <code>SpreadMethod</code> class that specifies
		 * 	which spread method to use, either: <code>SpreadMethod.PAD</code>, <code>SpreadMethod.REFLECT</code>,
		 * 	or <code>SpreadMethod.REPEAT</code>.
		 * 	@param	interpolationMethod	A value from the <code>InterpolationMethod</code> class that
		 * 	specifies which value to use: <code>InterpolationMethod.LINEAR_RGB</code> or
		 * 	<code>InterpolationMethod.RGB</code>.
		 * 	@param	focalPointRatio	 A number that controls the location of the focal point of the
		 * 	gradient. <code>0</code> means that the focal point is in the center. <code>1</code>
		 * 	means that the focal point is at one border of the gradient circle. <code>-1</code>
		 * 	means that the focal point is at the other border of the gradient circle. A value
		 * 	less than <code>-1</code> or greater than <code>1</code> is rounded to <code>-1</code>
		 * 	or <code>1</code>.
		 */
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void {
			$figure.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * 	Specifies a dashed line style to be used for subsequent calls to <code>Drawing</code>
		 * 	methods such as the <code>drawLine()</code> method or the <code>drawCircle()</code>
		 * 	method.
		 * 	
		 * 	<p>The line style remains in effect until you call the <code>lineGradientStyle()</code>
		 * 	method or the <code>lineStyle()</code> method with different parameters.</p>
		 * 
		 * 	<p>You can call the <code>lineStyle()</code> method in the middle of drawing
		 * 	a path to specify different styles for different line segments within the path.</p>
		 * 
		 * 	<p><strong>Note:</strong> Calls to the <code>clear()</code> method set the line
		 * 	style back to <code>undefined</code>.</p>
		 * 	
		 * 	@param	thickness	An integer that indicates the thickness of the line in points;
		 * 	valid values are <code>0</code> to <code>255</code>. If the parameter is <code>undefined</code>,
		 * 	a line is not drawn. If a value of less than <code>0</code> is passed, the default is
		 * 	<code>0</code>. The value <code>0</code> indicates hairline thickness. If a value
		 * 	greater than <code>255</code> is passed, the default is <code>255</code>.
		 * 	@param	color	A hexadecimal color value of the line; Default is <code>0x000000</code>
		 * 					(black).
		 * 	@param	alpha	A number that indicates the alpha value of the color of the line;
		 * 	valid values are <code>0</code> to <code>1</code>. Default is <code>1</code> (solid).
		 * 	If the value is less than <code>0</code>, the default is <code>0</code>. If the value
		 * 	is greater than <code>1</code>, the default is <code>1</code>.
		 * 	@param	dashWidth	The width of the dashes for this dashed line.
		 * 	@param	gap	The width of the gaps between each dash.
		 * 	@param	pixelHinting	A <code>Boolean</code> value that specifies whether to hint strokes
		 * 	to full pixels. This affects both the position of anchors of a curve and the line stroke
		 * 	size itself. With <code>pixelHinting</code> set to <code>true</code>, Flash Player hints 
		 * 	line widths to full pixel widths. With <code>pixelHinting</code> set to <code>false</code>,
		 * 	disjoints can appear for curves and straight lines. 
		 * 	@param	scaleMode	A value from the <code>LineScaleMode</code> class that specifies
		 * 	which scale mode to use. Valid values are: <code>LineScaleMode.NONE</code>, <code>LineScaleMode.NORMAL</code>,
		 * 	<code>LineScaleMode.VERTICAL</code> and <code>LineScaleMode.HORIZONTAL</code>.
		 * 	@param	caps	A value from the <code>CapsStyle</code> class that specifies the type of
		 * 	caps at the end of lines. Valid values are: <code>CapsStyle.NONE</code>, <code>CapsStyle.ROUND</code>,
		 * 	and <code>CapsStyle.SQUARE</code>.
		 * 	@param	joints	 A value from the <code>JointStyle</code> class that specifies the type
		 * 	of joint appearance used at angles. Valid values are: <code>JointStyle.BEVEL</code>,
		 * 	<code>JointStyle.MITER</code>, and <code>JointStyle.ROUND</code>.
		 * 	@param	miterLimit	A number that indicates the limit at which a miter is cut off. Valid
		 * 	values range from <code>1</code> to <code>255</code> (and values outside of that range
		 * 	are rounded to <code>1</code> or <code>255</code>). This value is only used if the jointStyle
		 * 	is set to <code>JointStyle.MITER</code>. The <code>miterLimit</code> value represents the
		 * 	length that a miter can extend beyond the point at which the lines meet to form a joint.
		 * 	The value expresses a factor of the line thickness. For example, with a miterLimit factor
		 * 	<code>2.5</code> of and a thickness of <code>10</code> pixels, the miter is cut off at
		 * 	<code>25</code> pixels.
		 */
		public function dashedLineStyle(thickness:Number = 1, color:uint = 0x000000, alpha:Number = 1.0, dashWidth:Number = 4, gap:Number = 4, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void {
			$figure.dashedLineStyle(thickness, color, alpha, dashWidth, gap, pixelHinting, scaleMode, caps, joints, miterLimit);
		}
		
		/**
		 * 	Draws a triangle defined by the specified points. These points define the
		 * 	vertice coordinates of the triangle as shown below:
		 * <pre>
		 * A ------ B
		 *  \      /
		 *   \    /
		 *    \  /
		 *     C</pre>
		 * 
		 * 	@param	xa	The x coordinate of the first point (A), in pixels.
		 * 	@param	ya	The y coordinate of the first point (A), in pixels.
		 * 	@param	xb	The x coordinate of the intermediary point (B), in pixels.
		 * 	@param	yb	The y coordinate of the intermediary point (B), in pixels.
		 * 	@param	xc	The x coordinate of the last point (C), in pixels.
		 * 	@param	yc	The y coordinate of the last point (C), in pixels.
		 */
		public function drawTriangle(xa:Number, ya:Number, xb:Number, yb:Number, xc:Number, yc:Number):void {
			$figure.drawTriangle(xa, ya, xb, yb, xc, yc);
		}
		
		/**
		 * 	[Not implementd yet.]
		 * 	Draws a triangle, where the vertices are rounded, defined by the specified
		 * 	points. These points define the vertice coordinates of the triangle as
		 * 	shown below:
		 * <pre>
		 * A ------ B
		 *  \      /
		 *   \    /
		 *    \  /
		 *     C</pre>
		 * 
		 * 	@param	xa	The x coordinate of the first point (A), in pixels.
		 * 	@param	ya	The y coordinate of the first point (A), in pixels.
		 * 	@param	xb	The x coordinate of the intermediary point (B), in pixels.
		 * 	@param	yb	The y coordinate of the intermediary point (B), in pixels.
		 * 	@param	xc	The x coordinate of the last point (C), in pixels.
		 * 	@param	yc	The y coordinate of the last point (C), in pixels.
		 * 	@param	ellipseWidth	[Not implementd yet.]
		 * 	@param	ellipseHeight	[Not implementd yet.]
		 */
		public function drawRoundedTriangle(xa:Number, ya:Number, xb:Number, yb:Number, xc:Number, yc:Number, ellipseWidth:Number = 10, ellipseHeight:Number = 10):void {
			$figure.drawRoundedTriangle(xa, ya, xb, yb, xc, yc, ellipseWidth = 10, ellipseHeight = 10);
		}
		
		/**
		 * 	Draws a square with the specified width.
		 * 
		 * 	@param	x	The x coordinate of the square top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the square top-left hand corner, in pixels.
		 * 	@param	width	The width the square, in pixels.
		 */
		public function drawSquare(x:Number, y:Number, width:Number):void {
			$figure.drawRectangle(x, y, width, width);
		}
		
		/**
		 * 	Draws a rectangle with the specified width and height.
		 * 
		 * 	@param	x	The x coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	width	The width the rectangle, in pixels.
		 * 	@param	height	The height the rectangle, in pixels.
		 */
		public function drawRectangle(x:Number, y:Number, width:Number, height:Number):void {
			$figure.drawRectangle(x, y, width, height);
		}
		
		/**
		 * 	Draws a rounded corners rectangle with the specified width and height.
		 * 	All corner radiuses for the rectangle have the same value. To draw a
		 * 	a rounded corners rectangle with a different value for each of the four
		 * 	radiuses, use the <code>drawRoundedBox()</code> method.
		 * 
		 * 	<p>You can independently define the width and the height of the
		 * 	corner radiuses value.</p>
		 * 
		 * 	@param	x	The x coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	width	The width the rectangle, in pixels.
		 * 	@param	height	The height the rectangle, in pixels.
		 * 	@param	ellipseWidth	The with of the corner radiuses, in pixels. 
		 * 	@param	ellipseHeight	The height of the corner radiuses, in pixels.
		 * 
		 * 	@see #drawRoundedBox()
		 */
		public function drawRoundedRectangle(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number = 10, ellipseHeight:Number = 10):void {
			$figure.drawRoundedRectangle(x, y, width, height, ellipseWidth, ellipseHeight);
		}
		
		/**
		 * 	Draws a beveled corners rectangle with the specified width and height.
		 * 	All bevel values are the same for each rectangle corner.
		 * 
		 * 	<p>You can independently define the width and the height of the
		 * 	bevel value.</p>
		 * 
		 * 	@param	x	The x coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	width	The width the rectangle, in pixels.
		 * 	@param	height	The height the rectangle, in pixels.
		 * 	@param	bevelWidth	The with of the corner bevel, in pixels. 
		 * 	@param	bevelHeight	The height of the corner bevel, in pixels. 
		 */
		public function drawBeveledRectangle(x:Number, y:Number, width:Number, height:Number, bevelWidth:Number = 10, bevelHeight:Number = 10):void {
			$figure.drawBeveledRectangle(x, y, width, height, bevelWidth, bevelHeight);
		}
		
		/**
		 * 	Draws a circle. You must set the line style, fill, or both before you call
		 * 	this method.
		 * 
		 * 	@param	x	The x location of the center of the circle, in pixels.
		 * 	@param	y	The y location of the center of the circle, in pixels.
		 * 	@param	radius	The radius of the circle, in pixels.
		 * 
		 * 	@see #drawArc()
		 * 	@see #drawEllipse()
		 */
		public function drawCircle(x:Number, y:Number, radius:Number):void {
			$figure.drawCircle(x, y, radius);
		}
		
		/**
		 * 	Draws an ellipse. You must set the line style, fill, or both before you call the
		 * 	<code>drawEllipse()</code> method.
		 * 
		 * 	@param	x	The x location of the center of the ellipse, in pixels.
		 * 	@param	y	The y location of the center of the ellipse, in pixels.
		 * 	@param	width	The width of the ellipse, in pixels.
		 * 	@param	height	The height of the ellipse, in pixels.
		 * 
		 * 	@see #drawArc()
		 * 	@see #drawCircle()
		 */
		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void {
			$figure.drawEllipse(x, y, width, height);
		}
		
		/**
		 * 	Draws a rounded corners rectangle with the specified width and height.
		 * 	All values for the rectangle corner radiuses can be set separately.
		 * 	To draw a rounded corners rectangle which as the same value for each of
		 * 	the four radiuses, use the <code>drawRoundedRectangle()</code> method.
		 * 
		 * 	<p><strong>Note:</strong> The <code>drawRoundedRectangle()</code> method 
		 * 	is faster than the <code>drawRoundedBox()</code> method.</p>
		 * 	
		 * 	@param	x	The x coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the rectangle top-left hand corner, in pixels.
		 * 	@param	width	The width the rectangle, in pixels.
		 * 	@param	height	The height the rectangle, in pixels.
		 * 	@param	topLeftRadius	The top-left hand corner radius, in pixels.
		 * 	@param	topRightRadius	The top-right hand corner radius, in pixels.
		 * 	@param	bottomRightRadius	The bottom-right hand corner radius, in pixels.
		 * 	@param	bottomLeftRadius	The bottom-left hand corner radius, in pixels.
		 */
		public function drawRoundedBox(x:Number, y:Number,  width:Number, height:Number,  
										topLeftRadius:Number, topRightRadius:Number,  
										bottomRightRadius:Number, bottomLeftRadius:Number):void { 
			$figure.drawRoundedBox(x, y,  width, height, topLeftRadius, topRightRadius, bottomRightRadius, bottomLeftRadius);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			if(_showBackground) {
				if($textureManager.texture!=null) $textureManager.draw(TextureType.TEXTURE);
				else if($gradientMode) $textureManager.draw(TextureType.GRADIENT);
				else $textureManager.draw();
			}
			drawMask();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _actionStack:Array;
		private var _mask:Shape;
		private var _draw:Shape;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			initSize(width, height);
			$autoWidth = isNaN(width);
			$autoHeight = isNaN(height);
			$autoSize = $autoWidth && $autoHeight;
			initMinSize(1, 1);
			_actionStack = [];
			_mask = new Shape();
			_draw = new Shape();
			spas_internal::lafDTO.cornerRadius = $cornerRadius = 0;
			initLaf(DrawingUIRef);
			createTextureManager(spas_internal::uioSprite);
			spas_internal::uioSprite.cacheAsBitmap = _draw.cacheAsBitmap = true;
			spas_internal::uioSprite.addChild(_draw);
			spas_internal::uioSprite.addChild(_mask);
			$figure = Figure.setFigure(_draw);
			_draw.mask = _mask;
			spas_internal::setSelector(Selectors.DRAWING);
			spas_internal::isInitialized(1);
		}
		
		private function drawMask():void {
			var r:Rectangle = _draw.getBounds(_draw);
			var h:Number = $autoSize || $autoHeight ? r.y + r.height : $height;
			var w:Number = $autoSize || $autoWidth ? r.x + r.width : $width;
			with (_mask.graphics) {
				clear();
				beginFill(0, 0.5);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
	}
}