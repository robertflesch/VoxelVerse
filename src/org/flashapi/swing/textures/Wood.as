package org.flashapi.swing.textures {
	
	/**
	 * @author Joel May 
	 * www.connectedpixel.com 
	 * All original source code listed here is licensed under a Creative Commons License. 
	 */
	
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
 
//////////////////////////////////////////////////////////////////////////
// Renders a wood texture to a bitmap.  Uses perlin noise and the folumula
// pixval = fraction(nTreeRings * perlin(x,y))
//////////////////////////////////////////////////////////////////////////

	/**
	 * 	The <code>Wood</code> class creates a programmatic <code>Texture</code>
	 * 	object which renders a wood effect.
	 * 
	 * 	<p>The class is based on Joel MAY work:
	 * 	<a href="www.connectedpixel.com/" title="marble effect">
	 * 	www.connectedpixel.com/</a>.</p>
	 * 
	 *  @includeExample WoodExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Wood implements Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>Wood</code> instance.
		 */
		public function Wood() {
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
			return "Wood";
		}
		
		private var _baseX:Number = 400;
		/**
		 * 	Sets or gets the frequency to use in the <code>x</code> direction of the wood 
		 * 	texture.
		 * 
		 * 	@default 400
		 * 
		 * 	@see #perlinBaseY
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
		
		private var _baseY:Number = 120;	
		/**
		 * 	Sets or gets the frequency to use in the <code>y</code> direction of the wood 
		 * 	texture.
		 * 
		 * 	@default 120
		 * 
		 * 	@see #perlinBaseX
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
		
		private var _nOctaves:Number = 1; 
		/**
		 * 	Number of octaves or individual noise functions to combine to create this <code>Texture</code>
		 * 	Larger numbers of octaves create images with greater detail. Larger numbers of octaves
		 * 	also require more processing time.
		 * 
		 * 	@default 2
		 */
		public function get octaves():Number {
			return _nOctaves;
		}
		public function set octaves(nOct:Number):void {
			_nOctaves = nOct;
		}
		
		private var _nGrainLayers:Number = 15;
		/**
		 * 	Sets or gets the number of wood veins for this <code>Texture</code>. The higher this property
		 * 	is, more realistic the texture is rendered; larger numbers of veins also require more processing
		 * 	time.
		 * 
		 * 	@default 15
		 */
		public function get grainLayers():Number {
			return _nGrainLayers;
		}
		public function set grainLayers(nLayers:Number):void {
			_nGrainLayers = nLayers;
		}
		
		private var _rgb0:Number = 0xaa5522;
		/**
		 * 	Sets of gets the color used to render the veins of this <code>Wood</code>
		 * 	texture.
		 * 
		 * 	@default 0xaa5522
		 * 
		 * 	@see #color
		 */
		public function get veinColor():Number {
			return _rgb0;
		}
		public function set veinColor(rgb:Number):void { 
			_rgb0 = rgb;
			invalidateWoodColorFilter();
		}
		
		private var _rgb1:Number = 0xee9922;
		/**
		 * 	Sets of gets the color used to render the main color of this <code>Wood</code>
		 * 	texture.
		 * 
		 * 	@default 0xee9922
		 * 
		 * 	@see #veinColor
		 */
		public function get color():Number {
			return _rgb1;
		}
		public function set color(rgb:Number):void { 
			_rgb1 = rgb;
			invalidateWoodColorFilter();
		}
		
		private var _randomSeed:Number = 128;
		/**
		 * 	Sets or gets the random seed number to use to render the wood texture.
		 * 	when <code>enableDistortion</code> is <code>true</code>. The <code>Wood</code>
		 * 	class uses a mapping function, not a true random-number generation function,
		 * 	so it creates the same results each time from the same random seed.
		 * 
		 * 	@default 128
		 */
		public function get seed():Number {
			return _randomSeed;
		}
		public function set seed(s:Number):void {
			_randomSeed = s;
		}
		
		private var _bTile:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value. If the value is <code>true</code>, the texture
		 * 	attempts to smooth the transition edges of the image to create seamless textures.
		 * 
		 * 	@default false
		 */
		public function get tileable():Boolean {
			return _bTile;
		}
		public function set tileable(bTile:Boolean):void {
			_bTile = bTile;
		}
		
		private var _bFractalNoise:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>Texture</code>
		 * 	generates turbulence (<code>false</code>), or  fractal noise (<code>false</code>). 
		 * 	An image with turbulence has visible discontinuities in the gradient.
		 * 
		 * 	@default false
		 */
		public function get fractalNoise():Boolean {
			return _bFractalNoise;
		}
		public function set fractalNoise(bFractal:Boolean):void {
			_bFractalNoise = bFractal;
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
			_woodColorFilter = null;
			_blurFilter = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function createBitmap(width:Number, height:Number):BitmapData {
			var wood:BitmapData = new BitmapData(width, height, false, 0x000000);
			render(wood);
			return wood;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function render(bmp:BitmapData):void {
			var w:Number = bmp.width;
			var h:Number = bmp.height;
			
			// Will hold perlin noise.
			var srcNoise_bmp:BitmapData = new BitmapData(w, h, false, 0xffffffff);
			
			var buffer:BitmapData = new BitmapData(w, h, false, 0xffffffff);
			
			// channelOptions - 1 - Red only
			// grayscale - false
			srcNoise_bmp.perlinNoise(_baseX,_baseY,_nOctaves,_randomSeed,_bTile,_bFractalNoise,1,false);
			
			// Needed in some of the following flash api calls.		
			var rect:Rectangle = new Rectangle(0,0,w,h);	
			var origin:Point = new Point(0,0);
			
			// For each tree ring.
			for (var iLayer:Number = 0 ; iLayer < _nGrainLayers ; iLayer++){
				
				// After multiplying, the signal needs to be shifted into the
				// 0 to 255 range.	
				var offset:Number = - iLayer * 256;	
				
				// Amplify and shift the pixels.
				var matrix:Array = [_nGrainLayers, 0, 0, 0, offset,
											   0, 0, 0, 0,      0, 
											   0, 0, 0, 0,      0, 
											   0, 0, 0, 1,      0 ];
				
				var filter:BitmapFilter = new ColorMatrixFilter(matrix);
				buffer.applyFilter(srcNoise_bmp,rect,origin,filter);			
				
				// Set the brightest to be black. Following layers will write
				// only on the black.
				buffer.threshold(buffer, rect, origin, "==", 0x00ff0000, 0xff000000, 0x00ff0000, false);
				
				// Copy the tmp on to the dest bitmap.
				bmp.draw(buffer, _identityMatrix, _identityColorTrans, "lighten");
			}
			// Don't need the temporary bitmaps anymore
			buffer.dispose();
			srcNoise_bmp.dispose();
			
			// Change it from black and red to the desired colors.
			bmp.applyFilter(bmp,rect, origin, getWoodColorFilter());		
			
			// Blur it to remove the jaggies.	
			bmp.applyFilter(bmp,rect,origin,getBlurFilter());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _blurX:Number;
		private var _blurY:Number;
		private var _identityMatrix:Matrix;
		private var _identityColorTrans:ColorTransform;
		private var _woodColorFilter:ColorMatrixFilter;
		private var _blurFilter:BlurFilter;
		
		//--------------------------------------------------------------------------
		//
		// 	Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_identityMatrix	= new Matrix();
			_identityColorTrans = new ColorTransform();
			_blurX = _blurY = 5;
		}
		
		private function getBlurFilter():BlurFilter {
			if (_blurFilter != null){
				return _blurFilter;
			}
			_blurFilter = new BlurFilter(_blurX,_blurY,1);
			return _blurFilter;
		}
		
		private function invalidateWoodColorFilter():void {
			_woodColorFilter = null;
		}
		
		/*private function invalidateBlurFilter():void {
			_blurFilter = null;	
		}*/
		
		private function getWoodColorFilter():ColorMatrixFilter {
			if (_woodColorFilter != null){
				return _woodColorFilter; 
			}	
			// Apply the desired colors to the bitmap.
			var r0:Number = (_rgb0 >> 16) & 0xff;
			var g0:Number = (_rgb0 >> 8 ) & 0xff;
			var b0:Number = _rgb0 & 0xff;
			var r1:Number = (_rgb1 >> 16) & 0xff;
			var g1:Number = (_rgb1 >> 8 ) & 0xff;
			var b1:Number = _rgb1 & 0xff;
			
			var woodColor:Array = [(r1-r0)/255, 0, 0, 0, r0,
								   (g1-g0)/255, 0, 0, 0, g0,
								   (b1-b0)/255, 0, 0, 0, b0,
								   0   , 0, 0, 1,    0 ];
								   
			_woodColorFilter= new ColorMatrixFilter(woodColor);
			
			return _woodColorFilter;
		}	
	}
}