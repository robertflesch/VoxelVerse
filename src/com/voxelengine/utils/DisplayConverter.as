package com.voxelengine.utils
{
	import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	
	
// **********************************************************************************
// **********************************************************************************


	/**
	 * Provides convenience conversion methods for Sprites and Bitmaps.
	 * 
	 * Open source. Free to use. Licensed under the MIT License.
	 * 
	 * @author	Nate Chatellier
	 * @see		http://blog.natejc.com
	 */
	public class DisplayConverter
	{
		
		
	// **********************************************************************************

		
		/**
		 * Constructs the DisplayConverter object.
		 */
		public function DisplayConverter()
		{
			trace("DisplayConverter is a static class and should not be instantiated");

		} // END CONSTRUCTOR
		
		
		
	// **********************************************************************************
	
	
		/**
		 * Converts a Bitmap to a Sprite.
		 *
		 * @param	bitmap		The Bitmap that should be converted.
		 * @param	smoothing	Whether or not the bitmap is smoothed when scaled.
		 * @return				The converted Sprite object.
		 * 
		 * @see					http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#smoothing
		 */
		public static function bitmapToSprite(bitmap:Bitmap, smoothing:Boolean = false):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.addChild( new Bitmap(bitmap.bitmapData.clone(), "auto", smoothing) );
			return sprite;

		} // END FUNCTION bitmapToSprite
		
		
	// **********************************************************************************
		
	
		/**
		 * Converts a Sprite to a Bitmap.
		 *
		 * @param	sprite		The Sprite that should be converted.
		 * @param	smoothing	Whether or not the bitmap is smoothed when scaled.
		 * @return				The converted Bitmap object.
		 * 
		 * @see					http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/BitmapData.html#draw()
		 */
		public static function spriteToBitmap(sprite:Sprite, smoothing:Boolean = false):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
			bitmapData.draw(sprite);
			
			return new Bitmap(bitmapData, "auto", smoothing);
			
		} // END FUNCTION spriteToBitmap
		

		public static function displayObjectToSprite(displayObj:DisplayObject):Sprite 
		{
			var sprite:Sprite = new Sprite();
			sprite.addChild( displayObjectToBitmap( displayObj ) );
			return sprite;
		}
		
		public static function displayObjectToBitmap(displayObj:DisplayObject):Bitmap
		{
			if (displayObj.width > 2880 || displayObj.height > 2880)
			{
				throw new Error("The size of display object exceeds 2880 px and cannot be rendered as bitmap");
				return;
			}
			else
			{
				var btmpData:BitmapData = new BitmapData(displayObj.width, displayObj.height, true, 0xffffff);
				var btmp:Bitmap = new Bitmap();
				var m:Matrix = new Matrix();
				var bounds:Rectangle = displayObj.getBounds(displayObj);
				var sprite:Sprite = new Sprite();
				m.translate(-bounds.x, -bounds.y);
				btmpData.draw(displayObj, m);
				btmp.bitmapData = btmpData;
				btmp.smoothing = true;
				btmp.transform = displayObj.transform;
				btmp.x += bounds.x;
				btmp.y += bounds.y;
			}
			return btmp;
		}		
		
// **********************************************************************************
// **********************************************************************************


	} // END CLASS DisplayConverter
} // END PACKAGE

