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
	// DashedLine.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 17/12/2008 18:59
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * 	The <code>DashedLine</code> class creates objects that gives the API for
	 * 	drawing dashed lines within the Flash Player.
	 * 
	 * 	<p>Dashed lines are composed of a succssion of plain dashes and blank gaps
	 * 	as follow: <code>&#0151;&#0151;  &#0151;&#0151;  &#0151;&#0151;  &#0151;&#0151;</code></p>
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DashedLine {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DashedLine</code> isntance.
		 * 
		 * 	@param	target	A <code>Sprite</code> or a <code>Shape</code> where the
		 * 					<code>DashedLine</code> object is drawn.
		 * 	@param	dashWidth	The width of dashes for this <code>DashedLine</code> object.
		 * 	@param	gap	The width of gaps within this <code>DashedLine</code> object.
		 */
		public function DashedLine(target:*, dashWidth:Number = 4, gap:Number = 4) {
			super();
			initObj(target, dashWidth, gap);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter peoperties
		//
		//--------------------------------------------------------------------------
		
		private var _gap:Number;
		/**
		 * 	Sets or gets the width of the gaps between each dash within this 
		 * 	<code>DashedLine</code> object.
		 * 
		 * 	@default 4
		 * 
		 * 	@see #dashWidth
		 */
		public function get gap():Number {
			return _gap;
		}
		public function set gap(value:Number):void {
			_gap = value;
		}
		
		private var _dashWidth:Number;
		/**
		 * 	Sets or gets the width of the dashes drawn within this <code>DashedLine</code>
		 * 	object.
		 * 
		 * 	@default 4
		 * 
		 * 	@see #gap
		 */
		public function get dashWidth():Number {
			return _dashWidth;
		}
		public function set dashWidth(value:Number):void {
			_dashWidth = value;
		}
		
		/**
		 *  Returns a reference to the <code>Sprite</code> or the <code>Shape</code>
		 * 	container where the <code>DashedLine</code> object is drawn.
		 */
		public function get target():* {
			return _target;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Clears the graphics that were drawn to this <code>DashedLine</code> object,
		 * 	and resets fill and line style settings.
		 * 
		 * 	@see #endFill()
		 */
		public function clear():void {
			_g.clear();
		}
		
		/**
		 * 	Specifies a line style to be used for subsequent calls to <code>DashedLine</code>
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
			_g.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
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
			_g.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * 	Applies a fill to the lines and curves that were added since the last call
		 * 	to the <code>DashedLine</code> methods. If the current drawing position does
		 * 	not equal the previous position and a fill is defined, the path is closed
		 * 	with a line.
		 * 
		 * 	@see #clear()
		 */
		public function endFill():void {
			_g.endFill();
		}
		
		/**
		 * 	Draws a dashed line from specified start to end points.
		 * 	
		 * 	@param	from	A <code>Point</code>; the start point of the dashed line.
		 * 	@param	to	A <code>Point</code>; the end point of the dashed line.
		 */
		public function drawLine(from:Point, to:Point):void {
			if (Point.distance(from, to) < .5) return;
			var inclination:Number = (to.y < from.y) ? -1 : 1;
			var l:Number = Point.distance(from, to);
			var angle:Number = Math.acos((to.x - from.x) / l) * inclination;
			_start.x = from.x, _start.y = from.y;
			do {
				_end.x = _start.x + Math.cos(angle) * (_dashWidth + _gap);;
				_end.y = _start.y + Math.sin(angle) * (_dashWidth + _gap);;
				var currentLength:Number = Math.sqrt(Math.pow(_end.x - from.x, 2) + Math.pow(_end.y - from.y, 2));
				if (l < currentLength) {
					_g.moveTo(_start.x, _start.y);
					_g.lineTo(to.x, to.y);
				} else {
					_g.moveTo(_start.x, _start.y);
					_g.lineTo(_start.x + Math.cos(angle) * _dashWidth, _start.y + Math.sin(angle) * _dashWidth);
					_start.x = _end.x, _start.y = _end.y;
				}
			} while (l > currentLength);
			_g.endFill();
		}
		
		/**
		 * 	Draws a dashed line that represents a triangle defined by the three points
		 * 	specified by the <code>a</code>, <code>b</code> and <code>c</code>
		 * 	parameters. These points define the vertice coordinates of the triangle
		 * 	as shown below:
		 * <pre>
		 * A ------ B
		 *  \      /
		 *   \    /
		 *    \  /
		 *     C</pre>
		 * 
		 * 	@param	a	A <code>Point</code>; the first point to define the triangle.
		 * 	@param	b	A <code>Point</code>; the intermediary point to define the triangle.
		 * 	@param	c	A <code>Point</code>; the last point to define the triangle.
		 */
		public function drawTriangle(a:Point, b:Point, c:Point):void {
			var ptA:Point = new Point(a.x, a.y);
			var ptB:Point = new Point(b.x, b.y);
			var ptC:Point = new Point(c.x, c.y);
			drawLine(ptA, ptB);
			drawLine(ptB, ptC);
			drawLine(ptC, ptA);
		}
		
		/**
		 * 	Draws a dashed line, that represents a rectangle, from the top left-hand corner
		 * 	<code>Point</code> to the bottom right-hand corner <code>Point</code>.
		 * 	These points define the coordinates of the rectangle as shown below:
		 * <pre>
		 * (P1.x,P1.y) ----------------- (P1.x,P2.y)
		 *           |                   |
		 *           |                   |
		 *           |                   |
		 *           |                   |
		 *           |                   |          
		 *           |                   |
		 * (P1.x,P2.y) ----------------- (P2.x,P2.y)</pre>
		 * 	
		 * 	@param	from	The top left-hand corner <code>Point</code>.
		 * 	@param	to		The bottom right-hand corner <code>Point</code>.
		 */
		public function drawRectangle(from:Point, to:Point):void {
			var ptA:Point = new Point(from.x, from.y);
			var ptB:Point = new Point(to.x, from.y);
			var ptC:Point = new Point(to.x, to.y);
			var ptD:Point = new Point(from.x, to.y);
			if(from.x != to.x) drawLine(ptA, ptB), drawLine(ptC, ptD);
			if(from.y != to.y) drawLine(ptD, ptA), drawLine(ptB, ptC);
			//if(from.x != to.x) drawLine(new Point(from.x, from.y), new Point(to.x, from.y)), drawLine(new Point(to.x, to.y), new Point(from.x, to.y));
			//if(from.y != to.y) drawLine(new Point(from.x, to.y), new Point(from.x, from.y)), drawLine(new Point(to.x, from.y), new Point(to.x, to.y));
		}
		
		/**
		 * 	Uses a dashed line to draw a circle.
		 * 
		 * 	@param	center	A <code>Point</code>; the center coordinates of the circle.
		 * 	@param	radius	The radius value of the circle.	
		 * 	@param	useCurvedDash A <code>Boolean</code> value that indicates whether
		 * 	dashes used to draw this circle are curved (<code>true</code>) or not
		 * 	<code>false</code>. Drawing is rendered faster if <code>false</code>.
		 * 
		 * 	@see #drawArc()
		 */
		public function drawCircle(center:Point, radius:Number = 100, useCurvedDash:Boolean = false):void {
			drawArc(center, 0, 2*Math.PI, radius, useCurvedDash);
			/*_start.x = center.x+radius, _start.y = center.y;
			var angle:Number = _dashWidth/radius;
			var angleDelay:Number = _gap/radius;
			var nextAngle:Number = 0;
			if(useCurvedDash) {
				var control:Point = new Point();
				var middle:Point = new Point();
			}
			do {
				_end.x = center.x+Math.cos(angle+nextAngle)*radius;
				_end.y = center.y+Math.sin(angle+nextAngle)*radius;
				_g.moveTo(_start.x, _start.y);
				if(useCurvedDash) {
					if(angle+nextAngle<=2*Math.PI) {
						middle.x = center.x+Math.cos(angle/2+nextAngle)*radius;
						middle.y = center.y+Math.sin(angle/2+nextAngle)*radius;
						control.x = 2*middle.x-.5*(_start.x+_end.x);
						control.y = 2*middle.y-.5*(_start.y+_end.y);
						_g.curveTo(control.x, control.y, _end.x, _end.y);
						setNextDashProperties();
					} else {
						middle.x = center.x+Math.cos(nextAngle+(-2*Math.PI-nextAngle)/2)*radius;
						middle.y = center.y+Math.sin(nextAngle+(-2*Math.PI-nextAngle)/2)*radius;
						control.x = 2*middle.x-.5*(_start.x+center.x+radius);
						control.y = 2*middle.y-.5*(_start.y+center.y);
						_g.curveTo(control.x, control.y, center.x+radius, center.y);
						break;
					}
				} else {
					if(angle+nextAngle<=2*Math.PI) {
						_g.lineTo(_end.x, _end.y);
						setNextDashProperties();
					} else { _g.lineTo(center.x+radius, center.y); break; }
				}
			} while (nextAngle<2*Math.PI);
			_g.endFill();
			function setNextDashProperties():void {
				nextAngle += angle+angleDelay;
				_start.x = center.x+Math.cos(nextAngle)*radius;
				_start.y = center.y+Math.sin(nextAngle)*radius;
			}*/
		}
		
		/**
		 * 	Uses a dashed line to draw a curved portion of a circle (arc).
		 * 	
		 * 	@param	center	A <code>Point</code>; the center coordinates of the circle
		 * 					that defines this arc.
		 * 	@param	startAngle	The start angle of this arc, in degrees.
		 * 	@param	finalAngle	The final angle of this arc, in degrees.
		 * 	@param	radius	The radius value of the circle that defines this arc.	
		 * 	@param	useCurvedDash A <code>Boolean</code> value that indicates whether
		 * 	dashes used to draw this arc are curved (<code>true</code>) or not
		 * 	<code>false</code>. Drawing is rendered faster if <code>false</code>.
		 * 
		 * 	@see #drawCircle()
		 */
		public function drawArc(center:Point, startAngle:Number, finalAngle:Number, radius:Number = 100, useCurvedDash:Boolean = false):void {
			_start.x = center.x + Math.cos(startAngle) * radius;
			_start.y = center.y + Math.sin(startAngle) * radius;
			var dashAngle:Number = _dashWidth / radius;
			var angleDelay:Number = _gap / radius;
			var nextAngle:Number = startAngle;
			if(useCurvedDash) {
				var control:Point = new Point();
				var middle:Point = new Point();
			}
			do {
				_end.x = center.x + Math.cos(dashAngle + nextAngle) * radius;
				_end.y = center.y + Math.sin(dashAngle + nextAngle) * radius;
				_g.moveTo(_start.x, _start.y);
				if(useCurvedDash) {
					if(dashAngle+nextAngle<=startAngle+finalAngle) {
						middle.x = center.x + Math.cos(dashAngle / 2 + nextAngle) * radius;
						middle.y = center.y + Math.sin(dashAngle / 2 + nextAngle) * radius;
						control.x = 2 * middle.x - .5 * (_start.x + _end.x);
						control.y = 2 * middle.y - .5 * (_start.y + _end.y);
						_g.curveTo(control.x, control.y, _end.x, _end.y);
						setNextDashProperties();
					} else {
						/*middle.x = center.x+Math.cos(nextAngle+(-2*Math.PI-nextAngle)/2)*radius;
						middle.y = center.y+Math.sin(nextAngle+(-2*Math.PI-nextAngle)/2)*radius;
						control.x = 2*middle.x-.5*(_start.x+center.x+radius);
						control.y = 2*middle.y-.5*(_start.y+center.y);
						_g.curveTo(control.x, control.y, center.x + radius, center.y);*/
						break;
					}
				} else {
					if(dashAngle+nextAngle<=startAngle+finalAngle) {
						_g.lineTo(_end.x, _end.y);
						setNextDashProperties();
					} else {
						if (finalAngle == 2 * Math.PI) {
							_g.lineTo(center.x + radius, center.y);
							break;
						}
					}
				}
			} while (nextAngle < startAngle + finalAngle);
			_g.endFill();
			
			function setNextDashProperties():void {
				nextAngle += dashAngle+angleDelay;
				_start.x = center.x+Math.cos(nextAngle)*radius;
				_start.y = center.y+Math.sin(nextAngle)*radius;
			}
		}
		
		/**
		 * 	Draws a dashed line, that represents a rounded corners rectangle, 
		 * 	from the top left-hand corner <code>Point</code> to the bottom 
		 * 	right-hand corner <code>Point</code>. These points define the
		 * 	coordinates of the rectangle as shown below:
		 * <pre>
		 * (P1.x,P1.y) ----------------- (P1.x,P2.y)
		 *           |                   |
		 *           |                   |
		 *           |                   |
		 *           |                   |
		 *           |                   |          
		 *           |                   |
		 * (P1.x,P2.y) ----------------- (P2.x,P2.y)</pre>
		 * 
		 * 	<p>Each corner radiuses of a rounded rounded can be separately set.</p>
		 * 	
		 * 	@param	from	The top left-hand corner <code>Point</code>.
		 * 	@param	to		The bottom right-hand corner <code>Point</code>.
		 * 	@param	topLeftRadius	The top left-hand corner radius, in pixels.
		 * 	@param	topRightRadius	The top right-hand corner radius, in pixels.
		 * 	@param	bottomRightRadius	he bottom right-hand corner radius, in pixels.
		 * 	@param	bottomLeftRadius	The bottom left-hand corner radius, in pixels.
		 */
		public function drawRoundedBox(from:Point, to:Point, topLeftRadius:Number, topRightRadius:Number,  
										bottomRightRadius:Number, bottomLeftRadius:Number):void {
			var ptA1:Point = new Point(from.x, from.y + topLeftRadius);;
			var ptA2:Point = new Point(from.x + topLeftRadius, from.y);
			if (topLeftRadius > 0.5) 
				var ctrA:Point = new Point(from.x + topLeftRadius, from.y + topLeftRadius);
			
			var ptB1:Point = new Point(from.x + to.x - topRightRadius, from.y);
			var ptB2:Point = new Point(from.x + to.x, from.y + topRightRadius);
			if (topRightRadius > 0.5)
				var ctrB:Point = new Point(from.x + to.x - topRightRadius, from.y + topRightRadius);
			
			var ptC1:Point = new Point(from.x+to.x, from.y+to.y-bottomRightRadius);
			var ptC2:Point = new Point(from.x+to.x-bottomRightRadius, from.y+to.y);
			if (bottomRightRadius > 0.5)
				var ctrC:Point = new Point(from.x + to.x - bottomRightRadius, from.y + to.y - bottomRightRadius);
						
			var ptD1:Point = new Point(from.x+bottomLeftRadius, from.y+to.y);
			var ptD2:Point = new Point(from.x, from.y+to.y-bottomLeftRadius);
			if (bottomLeftRadius > 0.5)
				var ctrD:Point = new Point(from.x + bottomLeftRadius, from.y + to.y - bottomLeftRadius);
			
			drawLine(ptA2, ptB1);
			if (topRightRadius > 0.5) drawArc(ctrB, -Math.PI / 2, Math.PI / 2, topRightRadius, true);
			drawLine(ptB2, ptC1);
			if (bottomRightRadius > 0.5) drawArc(ctrC, 0, Math.PI / 2, bottomRightRadius, true);
			drawLine(ptC2, ptD1);
			if (bottomLeftRadius > 0.5) drawArc(ctrD, Math.PI / 2, Math.PI / 2, bottomLeftRadius, true);
			drawLine(ptD2, ptA1);
			if (topLeftRadius > 0.5) drawArc(ctrA, Math.PI, Math.PI / 2, topLeftRadius, true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _alpha:Number;
		private var _thickness:Number;
		private var _color:*;
		private var _g:Graphics;
		private var _start:Point;
		private var _end:Point;
		private var _target:*;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:*, dashWidth:Number, gap:Number):void {
			_target = target;
			_g = _target.graphics;
			_gap = gap;
			_dashWidth = dashWidth;
			_start = new Point();
			_end = new Point();
			lineStyle();
		}
	}
}
