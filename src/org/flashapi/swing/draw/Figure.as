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

package org.flashapi.swing.draw {
	
	// -----------------------------------------------------------
	// Figure.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 09/11/2010 09:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashapi.swing.draw.DashedLine;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.util.RangeChecker;
	
	/**
	 * 	The <code>Figure</code> class is a decorator class for extending Flash Player
	 * 	drawing capabilities.
	 * 
	 * 	@see org.flashapi.swing.draw.DashedLine
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Figure extends Shape {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Figure</code> instance for the specified
		 * 	target.
		 * 
		 * 	@param	target	A <code>Sprite</code> or a <code>Shape</code> where the
		 * 					<code>Figure</code> object is drawn.
		 */
		public function Figure(target:*) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates and retruns a new <code>Figure</code> instance for the <code>DisplayObject</code>
		 * 	specified by the <code>target</code> parameter, irrespective of whether it is a 
		 * 	<code>Sprite</code> or a <code>Shape</code> object.
		 * 
		 * 	@param	target	The drawing target where to create a <code>Figure</code>
		 * 					instance.
		 * 
		 * 	@return	A <code>Figure</code> object for the specified <code>DisplayObject</code>.
		 */
		public static function setFigure(target:DisplayObject):Figure {
			var tgt:* = target is Sprite ? target as Sprite : target as Shape;
			return new Figure(tgt);
		}
		
		/**
		 * 	Fills a <code>Figure</code> object with a bitmap image. The bitmap can be
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
			$gfx.beginBitmapFill(bitmap, matrix, repeat, smooth);
		}
		
		/**
		 * 	Specifies a simple one-color fill that Flash Player uses for subsequent calls
		 * 	to other <code>Figure</code> methods (such as <code>lineTo()</code> or
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
			$gfx.beginFill(color, alpha);
		}
		
		/**
		 * 	Clears the graphics that were drawn to this <code>Figure</code> object,
		 * 	and resets fill and line style settings.
		 * 
		 * 	@see #endFill()
		 */
		public function clear():void {
			$gfx.clear();
		}
		
		/**
		 * 	Specifies a line style to be used for subsequent calls to <code>Figure</code>
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
			$hasDashedLine = false;
			$gfx.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
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
			$hasDashedLine = false;
			$gfx.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * 	Applies a fill to the lines and curves that were added since the last call
		 * 	to the <code>Figure</code> methods. If the current drawing position does
		 * 	not equal the previous position specified in a <code>moveTo()</code> method
		 * 	and a fill is defined, the path is closed with a line and then filled.
		 * 
		 * 	@see #clear()
		 */
		public function endFill():void {
			$gfx.endFill();
			$hasDashedLine = false;
		}
		
		/**
		 * 	Specifies a gradient fill to be used for subsequent calls to other <code>Figure</code>
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
			$gfx.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * 	Specifies a dashed line style to be used for subsequent calls to <code>Figure</code>
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
			$hasDashedLine = true;
			if($dashedLine == null) {
				$dashedLine = new DashedLine($tgt);
				$dashedLineProp = new Object();
			}
			$dashedLineProp.thickness = thickness;
			$dashedLineProp.color = color;
			$dashedLineProp.alpha = alpha;
			$dashedLineProp.dashWidth = dashWidth;
			$dashedLineProp.gap = gap;
			$dashedLineProp.pixelHinting = pixelHinting;
			$dashedLineProp.scaleMode = scaleMode;
			$dashedLineProp.joints = joints;
			$dashedLineProp.miterLimit = miterLimit;
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
			with($gfx) {
				if($hasDashedLine) lineStyle(0, 0, 0);
				moveTo(xa, ya);
				lineTo(xb, yb);
				lineTo(xc, yc);
				lineTo(xa, ya);
			}
			if($hasDashedLine) {
				getDashedLineProperties();
				var ptA:Point = new Point(xa, ya);
				var ptB:Point = new Point(xb, yb);
				var ptC:Point = new Point(xc, yc);
				
				$dashedLine.drawTriangle(ptA, ptB, ptC);
			}
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
			with($gfx) {
				moveTo(xa, ya);
				lineTo(xb, yb);
				lineTo(xc, yc);
				lineTo(xa, ya);
			}
		}
		
		/**
		 * 	Draws a square with the specified width.
		 * 
		 * 	@param	x	The x coordinate of the square top-left hand corner, in pixels.
		 * 	@param	y	The y coordinate of the square top-left hand corner, in pixels.
		 * 	@param	width	The width the square, in pixels.
		 */
		public function drawSquare(x:Number, y:Number, width:Number):void {
			drawRectangle(x, y, width, width);
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
			with($gfx) {
				if($hasDashedLine) lineStyle(0, 0, 0);
				moveTo(x, y);
				lineTo(width, y);
				lineTo(width, height);
				lineTo(x, height);
				lineTo(x, y);
			}
			if($hasDashedLine) {
				getDashedLineProperties();
				var from:Point = new Point(x, y);
				var to:Point = new Point(width, height);
				$dashedLine.drawRectangle(from, to);
			}
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
			with($gfx) {
				moveTo(x+ellipseWidth, y);
				lineTo(width-ellipseWidth, y);
				curveTo(width, y, width, y+ellipseHeight);
				lineTo(width, height-ellipseHeight);
				curveTo(width, height, width-ellipseWidth, height);
				lineTo(x+ellipseWidth, height);
				curveTo(x, height, x, height-ellipseHeight);
				lineTo(x, y+ellipseHeight);
				curveTo(x, y, x+ellipseWidth, y);
			}
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
			with($gfx) {
				moveTo(x+bevelWidth, y);
				lineTo(width-bevelWidth, y);
				lineTo(width, y+bevelHeight);
				lineTo(width, height-bevelHeight);
				lineTo(width-bevelWidth, height);
				lineTo(x+bevelWidth, height);
				lineTo(x, height-bevelHeight);
				lineTo(x, y+bevelHeight);
				lineTo(x+bevelWidth, y);
			}
		}
		
		/**
		 * 	Draws a curved portion of a circle (arc).
		 * 
		 * 	@param	x	The x center coordinate of the circle, in pixels.
		 * 	@param	y	The y center coordinate of the circle, in pixels.
		 * 	@param	radius	The radius of arc, in pixels, in pixels.
		 * 	@param	arc	Specifies the sweep of the arc. Negative values draw clockwise.
		 * 	@param	startAngle	The starting angle of the arc in degrees.
		 * 	@param	yRadius	The raduis size based on the oordinate axis. Allows to draw
		 * 	elliptical arcs.
		 * 
		 * 	@see #drawCircle()
		 * 	@see #drawEllipse()
		 */
		public function drawArc(x:Number, y:Number, radius:Number, arc:Number, startAngle:Number, yRadius:Number = NaN):void {
			// ==============
			// mc.drawArc() - by Ric Ewing (ric@formequalsfunction.com) - version 1.5 - 4.7.2002
			// 
			// x, y = This must be the current pen position... other values will look bad
			// radius = radius of Arc. If [optional] yRadius is defined, then r is the x radius
			// arc = sweep of the arc. Negative values draw clockwise.
			// startAngle = starting angle in degrees.
			// yRadius = [optional] y radius of arc. Thanks to Robert Penner for the idea.
			// ==============
			// Thanks to: Robert Penner, Eric Mueller and Michael Hurwicz for their contributions.
			// ==============
			RangeChecker.checkNum(arc, 360, 0, "arc");
			if (isNaN(yRadius)) yRadius = radius;
			var angleMid:Number;
			var bx:Number;
			var by:Number;
			var cx:Number;
			var cy:Number;
			var segs:int = Math.ceil(Math.abs(arc)/45);
			var segAngle:Number = arc / segs;
			var theta:Number = -Geometry.radianToDegree(segAngle); //-(segAngle / 180) * Math.PI;
			var angle:Number = -Geometry.radianToDegree(startAngle); //-(startAngle / 180) * Math.PI;
			var ax:Number = x - Math.cos(angle) * radius;
			var ay:Number = y - Math.sin(angle) * yRadius;
			var i:uint = 0;
			if (segs>0) {
				for (; i < segs; i++) {
					angle += theta;
					angleMid = angle-(theta/2);
					bx = ax+Math.cos(angle)*radius;
					by = ay+Math.sin(angle)*yRadius;
					cx = ax + Math.cos(angleMid) * (radius / Math.cos(theta / 2));
					cy = ay + Math.sin(angleMid) * (yRadius / Math.cos(theta / 2));
					$gfx.curveTo(cx, cy, bx, by);
				}
			}
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
			var angle:Number = 0;
			var fromX:Number;
			var fromY:Number;
			var toX:Number;
			var toY:Number;
			var dA:Number = Math.PI/8
			var distance:Number = radius/Math.cos(dA);
			if($hasDashedLine) $gfx.lineStyle(0, 0, 0);
			$gfx.moveTo(x+radius, y);
			for(var i:uint = 0; i<8; i++) {
				angle += 2*dA;
				fromX = x+Math.cos(angle-(dA))*distance, fromY = y+Math.sin(angle-(dA))*distance;
				toX = x+Math.cos(angle)*radius, toY = y+Math.sin(angle)*radius;
				$gfx.curveTo(fromX, fromY, toX, toY);
			}
			if($hasDashedLine) {
				getDashedLineProperties();
				var o:Point = new Point(x, y);
				$dashedLine.drawCircle(o, radius, true);
			}
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
			var controlx:Number = width*(Math.SQRT2-1)
			var controly:Number = height*(Math.SQRT2-1); 
			var anchorx:Number = width*Math.SQRT1_2;
			var anchory:Number = height*Math.SQRT1_2; 
			with($gfx) {
				moveTo(x+width, y); 
				curveTo(x+width, y+controly, x+anchorx, y+anchory); 
				curveTo(x+controlx, y+height, x, y+height); 
				curveTo(x-controlx, y+height, x-anchorx, y+anchory); 
				curveTo(x-width, y+controly, x-width, y); 
				curveTo(x-width, y-controly, x-anchorx, y-anchory); 
				curveTo(x-controlx, y-height, x, y-height); 
				curveTo(x+controlx, y-height, x+anchorx, y-anchory); 
				curveTo(x+width, y-controly, x+width, y); 
			}	
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
		public function drawRoundedBox(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomRightRadius:Number, bottomLeftRadius:Number):void { 
			var c1:Number = getRadius(topLeftRadius);
			var c2:Number = getRadius(topRightRadius);
			var c3:Number = getRadius(bottomRightRadius);
			var c4:Number = getRadius(bottomLeftRadius);
			with ($gfx) {
				if($hasDashedLine) lineStyle(0, 0, 0);
				moveTo(x+c1, y);
				lineTo(width-c2, y);
				curveTo(width, y, width, y+c2);
				lineTo(width, height-c3);
				curveTo(width, height, width-c3, height);
				lineTo(x+c4, height);
				curveTo(x, height, x, height-c4);
				lineTo(x, y+c1);
				curveTo(x, y, x+topLeftRadius, y);
			}
			if($hasDashedLine) {
				getDashedLineProperties();
				var from:Point = new Point(x, y);
				var to:Point = new Point(width, height);
				$dashedLine.drawRoundedBox(from, to, c1, c2, c3, c4);
			}
		}
		
		/**
		 * 	Draws a line using the current line style from the current drawing position
		 * 	to (<code>x, y</code>); the current drawing position is then set to (<code>x, y</code>).
		 * 	If the target object in which you are drawing contains content that was
		 * 	created with the Flash drawing API, calls to the <code>lineTo()</code>
		 * 	method are drawn underneath the content. If you call <code>lineTo()</code>
		 * 	before any calls to the <code>moveTo()</code> method, the default position
		 * 	for the current drawing is (<code>0, 0</code>). If any of the parameters
		 * 	are missing, this method fails and the current drawing position is
		 * 	not changed.
		 * 
		 * 	@param	x	A number that indicates the horizontal position relative to the
		 * 	registration point of the target display object, in pixels.
		 * 	@param	y	A number that indicates the vertical position relative to the
		 * 	registration point of the target display object, in pixels.
		 */
		public function lineTo(x:Number, y:Number):void {
			$gfx.lineTo(x, y);
		}
		
		/**
		 * 	Moves the current drawing position to (<code>x, y</code>). If any of the
		 * 	parameters are missing, this method fails and the current drawing
		 * 	position is not changed.
		 * 
		 * 	@param	x	A number that indicates the horizontal position relative to the
		 * 	registration point of the target display object, in pixels.
		 * 	@param	y	A number that indicates the vertical position relative to the
		 * 	registration point of the target display object, in pixels.
		 */
		public function moveTo(x:Number, y:Number):void {
			$gfx.moveTo(x, y);
		}
		
		/**
		 * 	Draws a curve using the current line style from the current drawing position
		 * 	to (<code>anchorX, anchorY</code>) and using the control point that
		 * 	(<code>controlX, controlY</code>) specifies. The current drawing position
		 * 	is then set to (<code>anchorX, anchorY</code>).
		 * 
		 * 	@param	controlX	A number that specifies the horizontal position of the
		 * 	control point relative to the registration point of the target display object.
		 * 	@param	controlY	A number that specifies the vertical  position of the
		 * 	control point relative to the registration point of the target display object.
		 * 	@param	anchorX	A number that specifies the horizontal position of the next
		 * 	anchor point relative to the registration point of the target display object.
		 * 	@param	anchorY	A number that specifies the vertical position of the next
		 * 	anchor point relative to the registration point of the target display object.
		 */
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			$gfx.curveTo(controlX, controlY, anchorX, anchorY);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal reference of the <code>DashedLine</code> instance
		 * 	used within this <code>Figure</code> object.
		 */
		protected var $dashedLine:DashedLine = null;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An <code>Boolean</code> that indicates whether this <code>Figure</code>
		 * 	object is renderer with a daseh line (<code>true</code>), or not
		 * 	(<code>false</code>).
		 */
		protected var $hasDashedLine:Boolean;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An object that contains all properties to define the <code>DashedLine</code> 
		 * 	instance used within this <code>Figure</code> object.
		 */
		protected var $dashedLineProp:Object;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal reference of the target object for this
		 * 	<code>Figure</code> instance.
		 */
		protected var $tgt:*;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal reference of the <code>Graphics</code> instance
		 * 	used within this <code>Figure</code> object.
		 */
		protected var $gfx:Graphics;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:*):void {
			//if Sprite || Shape
			$tgt = target;
			$gfx = target.graphics;
			$hasDashedLine = false;		
		}
		
		private function getRadius(radius:Number):Number {
			return radius > 0 ? radius : 0;
		}
		
		private function getDashedLineProperties():void {
			var o:Object = $dashedLineProp;
			$dashedLine.lineStyle(o.thickness, o.color, o.alpha, o.pixelHinting, o.scaleMode);
			$dashedLine.dashWidth = o.dashWidth;
			$dashedLine.gap = o.gap;
			/*
			_dashedLineProp.joints = o.joints)
			_dashedLineProp.miterLimit = o.miterLimit;*/
		}
	}
}