package org.flashapi.swing.textures {
	
	/**
	 * @author jmay
	 * www.connectedpixel.com 
	 * All original source code listed here is licensed under a Creative Commons License. 
	*/
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 	The <code>Marble</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a marble effect.
	 * 
	 * 	<p>The class is based on Joel MAY work:
	 * 	<a href="www.connectedpixel.com/" title="marble effect">
	 * 	www.connectedpixel.com/</a>.</p>
	 * 
	 *  @includeExample MarbleExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Marble implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>Marble</code> instance.
		 */
		public function Marble() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get name():String {
			return "Marble";
		}
		
		// Sinusoidal or Perlin floor
		private var _bSinusoidalFloor:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether to use a Sinusoidal
		 * 	algorithm (<code>true</code>), or a Perlin floor algorithm (<code>false</code>),
		 * 	to render this <code>Texture</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #waveLength
		 * 	@see #sinColorPointRatio
		 * 	@see #sinContrast
		 */
		public function get sinusoidalFloor():Boolean {
			return _bSinusoidalFloor;
		}
		public function set sinusoidalFloor(bSin:Boolean):void {
			_bSinusoidalFloor = bSin;
		}
		
		// Sinusoidal floor parameters
		private var _waveLength:Number = 100;
		/**
		 * 	Sets or gets the length of the sinusoidal floor when <code>sinusoidalFloor</code>
		 * 	is <code>true</code>. Valid values range from <code>2</code> to <code>1000</code>
		 * 	(and values outside of that range are rounded to <code>2</code> or <code>1000</code>).
		 * 
		 * 	@default 100
		 * 
		 * 	@see #sinusoidalFloor
		 * 	@see #sinColorPointRatio
		 * 	@see #sinContrast
		 */
		public function get waveLength():Number {
			return _waveLength;
		}   
		public function set waveLength(len:Number):void { 
			if (isNaN(len)) return;
			if (len < 2) len = 2;
			if (len > 1000) len = 1000;
			_waveLength = len; 
		}
		
		private var _sinMidColorPt:Number = 128;
		/**
		 * 	A number that controls the location of the focal point of the sinusoidal floor
		 * 	when <code>sinusoidalFloor</code> is <code>true</code>. Valid values range
		 * 	from <code>10</code> to <code>246</code> (and values outside of that range
		 * 	are rounded to <code>10</code> or <code>246</code>).
		 * 
		 * 	@default 128
		 * 
		 * 	@see #sinusoidalFloor
		 * 	@see #waveLength
		 * 	@see #sinContrast
		 */
		public function get sinColorPointRatio():Number {
			return _sinMidColorPt;
		} 
		public function set sinColorPointRatio(val:Number):void { 
			if (isNaN(val)) return;
			if (val < 10) val = 10;
			if (val > 246) val = 246;
			_sinMidColorPt = val; 
		}
		
		private var _sinContrastMultiplier:Number = 1.0;
		/**
		 * 	Sets or gets the contrast value of the focal point of the sinusoidal floor
		 * 	when <code>sinusoidalFloor</code> is <code>true</code>. Valid values range
		 * 	from <code>0.1</code> to <code>10.0</code> (and values outside of that range
		 * 	are rounded to <code>0.1</code> or <code>10.0</code>).
		 * 
		 * 	@default 1.0
		 * 
		 * 	@see #sinusoidalFloor
		 * 	@see #sinColorPointRatio
		 * 	@see #sinContrast
		 */
		public function get sinContrast():Number {
			return _sinContrastMultiplier;
		}
		public function set sinContrast(contrast:Number):void { 
			if (contrast < 0.1 ) contrast = 0.1;
			if (contrast > 10.0) contrast = 10.0;
			_sinContrastMultiplier = contrast; 
		}
		
		// Perlin floor parameters
		private var _perlinMidColorPt:Number = 128;
		/**
		 * 	A number that controls the location of the focal point of the perlin floor
		 * 	when <code>sinusoidalFloor</code> is <code>false</code>. Valid values range
		 * 	from <code>10</code> to <code>246</code> (and values outside of that range
		 * 	are rounded to <code>10</code> or <code>246</code>).
		 * 
		 * 	@default 128
		 * 
		 * 	@see #perlinContrast
		 */
		public function get perlinColorPointRatio():Number {
			return _perlinMidColorPt;
		}  
		public function set perlinColorPointRatio(val:Number):void { 
			if (isNaN(val)) return;
			if (val < 10) val = 10;
			if (val > 246) val = 246;
			_perlinMidColorPt = val; 
		}
		
		private var _perlinContrastMultiplier:Number = 2.0;
		/**
		 * 	Sets or gets the contrast value of the focal point of the perlin floor
		 * 	when <code>sinusoidalFloor</code> is <code>false</code>. Valid values range
		 * 	from <code>0.1</code> to <code>10.0</code> (and values outside of that range
		 * 	are rounded to <code>0.1</code> or <code>10.0</code>).
		 * 
		 * 	@default 2.0
		 * 
		 * 	@see #perlinColorPointRatio
		 */
		public function get perlinContrast():Number {
			return _perlinContrastMultiplier;
		}
		public function set perlinContrast(contrast:Number):void { 
			if (contrast < 0.1 ) contrast = 0.1;
			if (contrast > 10.0) contrast = 10.0;
			_perlinContrastMultiplier = contrast; 
		}
		
		private var _bPerlinFloorBaseX:Number = 50;
		/**
		 * 	Sets or gets the frequency to use in the <code>x</code> direction of the perlin floor
		 * 	when <code>sinusoidalFloor</code> is <code>false</code>.
		 * 
		 * 	@default 50
		 * 
		 * 	@see #floorBaseY
		 * 	@see #floorRandomSeed
		 */
		public function get floorBaseX():Number {
			return _bPerlinFloorBaseX;
		}
		public function set floorBaseX(bx:Number):void {
			_bPerlinFloorBaseX = bx;
		}
		
		private var _bPerlinFloorBaseY:Number = 150;
		/**
		 * 	Sets or gets the frequency to use in the <code>y</code> direction of the perlin floor
		 * 	when <code>sinusoidalFloor</code> is <code>false</code>.
		 * 
		 * 	@default 150
		 * 
		 * 	@see #floorBaseX
		 * 	@see #floorRandomSeed
		 */
		public function get floorBaseY():Number {
			return _bPerlinFloorBaseY;
		}
		public function set floorBaseY(by:Number):void {
			_bPerlinFloorBaseY = by;
		}
		
		private var _floorRandomSeed:Number = 317;
		/**
		 * 	Sets or gets the random seed number to use to render the perlin floor.
		 * 	when <code>sinusoidalFloor</code> is <code>false</code>. The <code>Marble</code>
		 * 	class uses a mapping function, not a true random-number generation function,
		 * 	so it creates the same results each time from the same random seed.
		 * 
		 * 	@default 317
		 * 
		 * 	@see #floorBaseY
		 * 	@see #floorBaseX
		 */
		public function get floorRandomSeed():Number {
			return _floorRandomSeed;
		} 
		public function set floorRandomSeed(seed:Number):void {
			_floorRandomSeed = seed;
		} 
		
		// Marble Distortion parameters
		private var _bEnableDistortion:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether to use a distortion
		 * 	algorithm to render this <code>Texture</code> (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get enableDistortion():Boolean {
			return _bEnableDistortion;
		}
		public function set enableDistortion(bEnab:Boolean):void {
			_bEnableDistortion = bEnab;
		}
		
		private var _baseX:Number = 20;
		/**
		 * 	Sets or gets the frequency to use in the <code>x</code> direction of the perlin 
		 * 	floor when <code>enableDistortion</code> is <code>true</code>.
		 * 
		 * 	@default 20
		 */
		public function get perlinBaseX():Number {
			return _baseX;
		}
		public function set perlinBaseX(bx:Number):void { 
			if (isNaN(bx)) return;
			if (bx < 3) bx = 3;
			if (bx > 1000) bx = 1000;
			_baseX = bx; 
		}
		
		private var _baseY:Number = 20; 
		/**
		 * 	Sets or gets the frequency to use in the <code>y</code> direction of the perlin 
		 * 	floor when <code>enableDistortion</code> is <code>true</code>.
		 * 
		 * 	@default 20
		 */
		public function get perlinBaseY():Number {
			return _baseY;
		}
		public function set perlinBaseY(by:Number):void { 
			if (isNaN(by)) return;
			if (by < 3) by = 3;
			if (by > 1000) by = 1000;
			_baseY = by; 
		}
		
		private var _nOctaves:Number = 2; 
		/**
		 * 	Number of octaves or individual noise functions to combine to create this <code>Texture</code>
		 * 	when <code>enableDistortion</code> is <code>true</code>. Larger numbers of octaves create 
		 * 	images with greater detail. Larger numbers of octaves also require more processing time.
		 * 
		 * 	@default 2
		 */
		public function get octaves():Number {
			return _nOctaves;
		}
		public function set octaves(nOct:Number):void {
			_nOctaves = nOct;
		}
		
		private var _randomSeed:Number = 147;
		/**
		 * 	Sets or gets the random seed number to use to render the perlin floor.
		 * 	when <code>enableDistortion</code> is <code>true</code>. The <code>Marble</code>
		 * 	class uses a mapping function, not a true random-number generation function,
		 * 	so it creates the same results each time from the same random seed.
		 * 
		 * 	@default 147
		 */
		public function get seed():Number {
			return _randomSeed;
		}
		public function set seed(s:Number):void {
			_randomSeed = s;
		}
		
		private var _bFractalNoise:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>Texture</code>
		 * 	generates turbulence when <code>enableDistortion</code> is <code>true</code>
		 * 	(<code>false</code>), or  fractal noise (<code>false</code>). An image with
		 * 	turbulence has visible discontinuities in the gradient.
		 * 
		 * 	@default false
		 */
		public function get fractalNoise():Boolean {
			return _bFractalNoise;
		}
		public function set fractalNoise(bFractal:Boolean):void {
			_bFractalNoise = bFractal;
		}
		
		// Distortion strength
		private var _displacementScaleX:Number = 150;
		/**
		 * 	Sets or gets the strength of the distortion when <code>enableDistortion</code> is
		 * 	<code>true</code>. Valid values range from <code>1</code> to <code>256</code>
		 * 	(and values outside of that range are rounded to <code>1</code> or <code>256</code>).
		 * 
		 * 	@default 150
		 */
		public function get displacementScaleX():Number {
			return _displacementScaleX;
		}
		public function set displacementScaleX(dx:Number):void { 
			if (isNaN(dx)) return;
			if (dx < 1) dx = 1;
			if (dx > 256) dx = 256;
			_displacementScaleX = dx; 
		}
		
		// Color mapping
		private var _rgb0:Number = 0x1c2a1f;
		/**
		 * 	Sets of gets the color used to render the veins of this <code>Marble</code>
		 * 	texture.
		 * 
		 * 	@default 0x1c2a1f
		 * 
		 * 	@see #color
		 */
		public function get veinColor():Number {
			return _rgb0;
		}
		public function set veinColor(rgb:Number):void { 
			_rgb0 = rgb;
			invalidateMarbleColorFilter();
		}
		
		private var _rgb1:Number = 0xadc8b4;
		/**
		 * 	Sets of gets the color used to render the main color of this <code>Marble</code>
		 * 	texture.
		 * 
		 * 	@default 0x1c2a1f
		 * 
		 * 	@see #veinColor
		 */
		public function get color():Number { 
			return _rgb1;
		}
		public function set color(rgb:Number):void { 
			_rgb1 = rgb;
			invalidateMarbleColorFilter();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_identityMatrix = null;
			_identityColorTrans = null;
			_marbleColorFilter = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function createBitmap(width:Number, height:Number):BitmapData {
			var marble:BitmapData = new BitmapData(width, height, false, 0x000000);
			render(marble);
			return marble;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			var w:Number = bmp.width;
			var h:Number = bmp.height;
			
			// Needed in some of the following flash api calls.        
			var rect:Rectangle = new Rectangle(0,0,w,h);    
			var origin:Point = new Point(0,0);
			
			var mid:Number;
			var mult:Number;
			
			// The source bitmap needs to be larger than the destination bitmap because
			// DisplacementMapFilter will grab pixels from a larger area.
			
			var paddingX:Number = _displacementScaleX + 8; // Add 16 as slop
			
			var floor_bmp:BitmapData = new BitmapData(w+paddingX,h,false,0x000000);
			if (_bSinusoidalFloor){
				drawSine(floor_bmp, _waveLength);
				
				mid = _sinMidColorPt;
				mult = _sinContrastMultiplier;
			}
			else{
				floor_bmp.perlinNoise(_bPerlinFloorBaseX,_bPerlinFloorBaseY,1,_floorRandomSeed,false,true,4,false);
				mult = _perlinContrastMultiplier;
				mid = _perlinMidColorPt;
			}
			var offset:Number = mult * (mid-128);
			var ampColor:Array = [1, 0, 0, 0,   0,
								  0, 1, 0, 0,   0,
								  0, 0, mult, 0, offset,
								  0, 0, 0, 1,   0 ];
								   
			var ampColorFilter:ColorMatrixFilter = new ColorMatrixFilter(ampColor);
			floor_bmp.applyFilter(floor_bmp, new Rectangle(0, 0, floor_bmp.width, floor_bmp.height), origin, ampColorFilter);        
			
			/////////////////////////////////////////////////////////
			// Add the marble distortion.
			if (_bEnableDistortion){
				// Will hold perlin noise.
				var srcNoise_bmp:BitmapData = new BitmapData(w+paddingX, h, false, 0xffffffff);
				
				// channelOptions - 4 - blue only
				// grayscale - false
				srcNoise_bmp.perlinNoise(_baseX,_baseY,_nOctaves,_randomSeed,false,_bFractalNoise,4,false);
				
				var filter:DisplacementMapFilter  = new DisplacementMapFilter(srcNoise_bmp,origin,4,1,_displacementScaleX,0);
				
				var r:Rectangle = new Rectangle(paddingX/2,0,w,h);
				bmp.applyFilter(floor_bmp,r,new Point(0,0),filter);
				
				srcNoise_bmp.dispose();
			}
			else{
				bmp.copyPixels(floor_bmp,rect,origin);	
			}
			floor_bmp.dispose(); 
			
			// Change it from black and blue to the desired colors.
			bmp.applyFilter(bmp,rect, origin, getMarbleColorFilter());        
		}   
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _identityMatrix:Matrix;
		private var _identityColorTrans:ColorTransform;
		private var _marbleColorFilter:ColorMatrixFilter;
		
		// Perlin floor modifiers
		/*private var _contrastMultiplier:Number = 1.0;
		private var _colorMidLevel:Number = 128;  // offset
		private var _veinAngleDeg:Number = 0; 
		private var _blurX          :Number = 5;
		private var _blurY          :Number = 5;*/
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_identityMatrix = new Matrix();
			_identityColorTrans = new ColorTransform();
		}
		
		private function drawSine(floor_bmp:BitmapData, wavelength:Number):void {
			var w:Number = floor_bmp.width;
			
			// 1-pixel high bitmap.
			var buffer:BitmapData = new BitmapData(w, 1);
			
			var phaseInc:Number = 2 * Math.PI / wavelength;
			var phase:Number = 0;
			
			for (var x:Number = 0 ; x < w ; x++){
				phase += phaseInc;
				var colVal:Number = 127 * Math.cos(phase) + 128;
				colVal = Math.round(colVal);
				// We're dealing with blue only here.
				buffer.setPixel(x,0,colVal);
			}
			
			var stretchMatrix:Matrix = new Matrix();
			stretchMatrix.scale(1,floor_bmp.height);
			
			// Now, draw the movieclip onto the floor_bmp
			floor_bmp.draw(buffer,stretchMatrix,_identityColorTrans, BlendMode.NORMAL);
			
			// Clean up.
			buffer.dispose();
		}
		
		///////////////////////////////////////////////////////////////////////
		// Map the black to blue colors to the desired Marble colors.
		///////////////////////////////////////////////////////////////////////
		
		private function getMarbleColorFilter():ColorMatrixFilter {
			if (_marbleColorFilter != null){
				return _marbleColorFilter; 
			}    
			// Apply the desired colors to the bitmap.
			var r0:Number = (_rgb0 >> 16) & 0xff;
			var g0:Number = (_rgb0 >> 8 ) & 0xff;
			var b0:Number = _rgb0 & 0xff;
			var r1:Number = (_rgb1 >> 16) & 0xff;
			var g1:Number = (_rgb1 >> 8 ) & 0xff;
			var b1:Number = _rgb1 & 0xff;
			
			var marbleColor:Array = [0, 0, (r1-r0)/255, 0, r0,
									 0, 0, (g1-g0)/255, 0, g0,
									 0, 0, (b1-b0)/255, 0, b0,
									 0, 0, 0, 1,    0 ];
								   
			_marbleColorFilter= new ColorMatrixFilter(marbleColor);
			
			return _marbleColorFilter;
		}
		
		private function invalidateMarbleColorFilter():void {
			_marbleColorFilter = null;    
		}
    }
}