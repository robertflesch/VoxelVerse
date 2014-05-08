package com.voxelengine.utils {

import flash.geom.Vector3D;
	
    public class Color {

		public static function combineRGBA( c1:Vector3D, c2:Vector3D ):Vector3D {
			// Determine RGBA colour received by combining two colours
			// http://stackoverflow.com/questions/10781953/determine-rgba-colour-received-by-combining-two-colours
			// Alpha result
			// αr = αa + αb (1 - αa)
			// Resulting color components:
			// Cr = (Ca αa + Cb αb (1 - αa)) / αr
			var αa:Number = c1.w;
			var αb:Number = c2.w;
			var newTint:Vector3D = new Vector3D();
			newTint.w = αa + αb * ( 1 - αa );
			newTint.x = (c1.x * αa + c2.x * αb * ( 1 - αa )) / newTint.w;
			newTint.y = (c1.y * αa + c2.y * αb * ( 1 - αa )) / newTint.w;
			newTint.z = (c1.z * αa + c2.z * αb * ( 1 - αa )) / newTint.w;
			
			return newTint;
		}
		
		public static function combineRGBAndIntensity( c1:Vector3D, c1Int:Number, c2:Vector3D, c2Int:Number ):Vector3D {
			// Determine RGBA colour received by combining two colours
			// http://stackoverflow.com/questions/10781953/determine-rgba-colour-received-by-combining-two-colours
			// Alpha result
			// αr = αa + αb (1 - αa)
			// Resulting color components:
			// Cr = (Ca αa + Cb αb (1 - αa)) / αr
			var αa:Number = c1Int;
			var αb:Number = c2Int;
			var newTint:Vector3D = new Vector3D();
			newTint.w = αa + αb * ( 1 - αa );
			newTint.x = (c1.x * αa + c2.x * αb * ( 1 - αa )) / newTint.w;
			newTint.y = (c1.y * αa + c2.y * αb * ( 1 - αa )) / newTint.w;
			newTint.z = (c1.z * αa + c2.z * αb * ( 1 - αa )) / newTint.w;
			
			return newTint;
		}
		
		public static function test( c1:Vector3D, c1Int:Number, c2:Vector3D, c2Int:Number ):Vector3D {
			var αa:Number = c1Int;
			var αb:Number = c2Int;
			var newTint:Vector3D = new Vector3D();
			newTint.w = 1;
			newTint.x = Math.max( c1.x * αa, c2.x * αb );
			newTint.y = Math.max( c1.y * αa, c2.y * αb );
			newTint.z = Math.max( c1.z * αa, c2.z * αb );
			
			return newTint;
		}

		public static function testInt( c1:uint, αa:Number, c2:uint, αb:Number, defaultColor:uint ):uint {
			var newTint:uint;
			newTint = RGBToHex( Math.max( extractRed(defaultColor),   Math.max( extractRed(c1) * αa, extractRed(c2) * αb ) )
			                  , Math.max( extractGreen(defaultColor), Math.max( extractGreen(c1) * αa, extractGreen(c2) * αb ) )
							  , Math.max( extractBlue(defaultColor), Math.max( extractBlue(c1) * αa, extractBlue(c2) * αb ) ) );
			
			return newTint;
		}
		
		public static function testCombineARGB( c1:uint, c2:uint ):uint {
			var αa:Number = Color.extractIntensity( c1 )/255;
			var αb:Number = Color.extractIntensity( c2 )/255;
			return ARGBToHex( (αa + αb * ( 1 - αa )) * 255
					 		, Math.max( extractRed(c1) * αa, extractRed(c2) * αb )
							, Math.max( extractGreen(c1) * αa, extractGreen(c2) * αb )
							, Math.max( extractBlue(c1) * αa, extractBlue(c2) * αb ) );
		}
		
		public static function combineRGB( c1:Vector3D, c2:Vector3D ):Vector3D {
			var newTint:Vector3D = new Vector3D(1,1,1,1);
			newTint.x = ( c1.x + c2.x ) / 2;
			newTint.y = ( c1.y + c2.y ) / 2;
			newTint.z = ( c1.z + c2.z ) / 2;
			
			return newTint;
		}
		
		public static function maxValuesARGB( c1:uint, c2:uint ):uint {
			return ARGBToHex ( Math.max( extractIntensity(c1), extractIntensity(c2) )
							, Math.max( extractRed(c1), extractRed(c2) )
							, Math.max( extractGreen(c1), extractGreen(c2) )
							, Math.max( extractBlue(c1), extractBlue(c2) ) );
		}
		
		public static function averageRGB( c1:uint, c2:uint ):uint {
			return RGBToHex( ( extractRed(c1) + extractRed(c2) )/ 2
			               , ( extractGreen(c1) + extractGreen(c2) )/ 2 
						   , ( extractBlue(c1) + extractBlue(c2) ) / 2 );
		}
		
		public static function toVector3D( tint:Vector3D, color:uint ):Vector3D
		{
			tint.w = extractAlpha(color)/255;
			tint.x = extractRed(color)/255;
			tint.y = extractGreen(color)/255;
			tint.z = extractBlue(color)/255;
			return tint;
		}
		
		public static function extractAlpha(c:uint):uint {
			return (( c >> 24 ) & 0xFF);
		}

		public static function extractIntensity(c:uint):uint {
			return (( c >> 24 ) & 0xFF);
		}
		
		public static function placeAlphaNumber( color:uint, value:Number ):uint
		{
			color = color & 0x00ffffff;
			var intValue:uint = value * 255;
			color = color | ( intValue << 24 );
			return color;
		}
		
		public static function placeAlpha( color:uint, value:uint ):uint
		{
			color = color & 0x00ffffff;
			color = color | ( value << 24 );
			return color;
		}
		
		public static function extractRed(c:uint):uint {
			return (( c >> 16 ) & 0xFF);
		}
		
		public static function placeRedNumber( color:uint, value:Number ):uint
		{
			color = color & 0xff00ffff;
			var intValue:uint = value * 255;
			color = color | ( intValue << 16 );
			return color;
		}

		public static function extractGreen(c:uint):uint {
			return ( (c >> 8) & 0xFF );
		}

		public static function placeGreenNumber( color:uint, value:Number ):uint
		{
			color = color & 0xffff00ff;
			var intValue:uint = value * 255;
			color = color | ( intValue << 8 );
			return color;
		}
		
		public static function extractBlue(c:uint):uint {
			return ( c & 0xFF );
		}		

		public static function placeBlueNumber( color:uint, value:Number ):uint
		{
			color = color & 0xffffff00;
			var intValue:uint = value * 255;
			color = color | ( intValue );
			return color;
		}
		
		public static function displayInHex(c:uint):String {
			var r:String=extractRed(c).toString(16).toUpperCase();
			var g:String=extractGreen(c).toString(16).toUpperCase();
			var b:String=extractBlue(c).toString(16).toUpperCase();
			var hs:String="";
			var zero:String="0";
			if(r.length==1){ r=zero.concat(r); }
			if (g.length == 1) { g = zero.concat(g); }
			if(b.length==1){ b=zero.concat(b);}
			hs=r+g+b;
			return hs;
		}		
		
		public static function RGBToHex(r:uint, g:uint, b:uint):uint
		{
			var hex:uint = (r << 16 | g << 8 | b);
			return hex;
		}
		 
		public static function ARGBToHex(a:uint, r:uint, g:uint, b:uint):uint
		{
			var hex:uint = (a << 25 | r << 16 | g << 8 | b);
			return hex;
		}
		
		public static function HexToRGB(hex:uint):Array
		{
			var rgb:Array = [];
			 
			var r:uint = hex >> 16 & 0xFF;
			var g:uint = hex >> 8 & 0xFF;
			var b:uint = hex & 0xFF;
			 
			rgb.push(r, g, b);
			return rgb;
		}
		
		public static function HexToDeci(hex:String):uint
		{
			if (hex.substr(0, 2) != "0x") {
				hex = "0x" + hex;
			}
			return new uint(hex);
		}
		
		public static function hexToHsv(color:uint):Array
		{
			var colors:Array = HexToRGB(color);
			return RGBtoHSV(colors[0], colors[1], colors[2]);
		}
		
		public static function hsvToHex(h:Number, s:Number, v:Number):uint
		{
			var colors:Array = HSVtoRGB(h, s, v);
			return RGBToHex(colors[0], colors[1], colors[2]);
		}
		
		
		
		/**
		 * Converts Red, Green, Blue to Hue, Saturation, Value
		 * @r channel between 0-255
		 * @s channel between 0-255
		 * @v channel between 0-255
		 */
		public static function RGBtoHSV(r:uint, g:uint, b:uint):Array
		{
			var max:uint = Math.max(r, g, b);
			var min:uint = Math.min(r, g, b);
			 
			var hue:Number = 0;
			var saturation:Number = 0;
			var value:Number = 0;
			 
			var hsv:Array = [];
			 
			//get Hue
			if(max == min){
				hue = 0;
				}else if(max == r){
				hue = (60 * (g-b) / (max-min) + 360) % 360;
				}else if(max == g){
				hue = (60 * (b-r) / (max-min) + 120);
				}else if(max == b){
				hue = (60 * (r-g) / (max-min) + 240);
			}
			 
			//get Value
			value = max;
			 
			//get Saturation
			if(max == 0){
				saturation = 0;
				}else{
				saturation = (max - min) / max;
			}
			 
			hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
			return hsv;
		}
		
		
		/**
		 * Converts Hue, Saturation, Value to Red, Green, Blue
		 * @h Angle between 0-360
		 * @s percent between 0-100
		 * @v percent between 0-100
		 */
		public static function HSVtoRGB(h:Number, s:Number, v:Number):Array
		{
			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;
			var rgb:Array = [];
			 
			var tempS:Number = s / 100;
			var tempV:Number = v / 100;
			 
			var hi:int = Math.floor(h/60) % 6;
			var f:Number = h/60 - Math.floor(h/60);
			var p:Number = (tempV * (1 - tempS));
			var q:Number = (tempV * (1 - f * tempS));
			var t:Number = (tempV * (1 - (1 - f) * tempS));
			 
			switch(hi)
			{
				case 0: r = tempV; g = t; b = p; break;
				case 1: r = q; g = tempV; b = p; break;
				case 2: r = p; g = tempV; b = t; break;
				case 3: r = p; g = q; b = tempV; break;
				case 4: r = t; g = p; b = tempV; break;
				case 5: r = tempV; g = p; b = q; break;
			}
			 
			rgb = [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
			return rgb;
		}
	}
}