/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import com.voxelengine.utils.ColorUtils;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.lighting.Light;
/**
 * ...
 * @author Robert Flesch
 */
public class Brightness  {  // extends BrightnessData
	
	/*
	 *           0,1,0  ___________ 1,1,0
	 *                /|          /|
	 *               / |   1,1,1 / |
	 *     ^  0,1,1 /__|________/  |   POSX ->
	 *     |       |   |        |  |
	 *    POSY     |   |________|__|
	 *             |  / 0,0,0   |  / 1,0,0
	 *             | /          | /
	 *             |/___________|/
	 *      POSZ   0,0,1        1,0,1
	 *        |
	 *        \/
	 */
	public static const MAX:uint = 0xff;
	public static const DEFAULT_SIGMA:uint = 2;
	public static const DEFAULT_ID:uint = 1;
	public static const DEFAULT_ATTEN:uint = 0x11; // out of 255
	//public static const DEFAULT_ATTEN:uint = 0x33; // out of 255
	//public static const DEFAULT_ATTEN:uint = 0xff; // out of 255
	public static const DEFAULT_PER_DISTANCE:int = 16;
	public static const DEFAULT_COLOR:uint = 0x00ffffff;

	static private var _s_sb:Brightness = new Brightness(); // scratchBrightness
	static public function scratch():Brightness { return _s_sb; }
	static public const FIXED_ID:uint = 1;

	private var _processed:Boolean = false; // This is used to keep track of whether or not a oxel has been processed in the light task
	public function get processed():Boolean { return _processed; }
	public function set processed(value:Boolean):void { _processed = value; }

	private var _lastLightID:uint;
	public function get lastLightID():uint { return _lastLightID; }
	public function set lastLightID(value:uint):void { _lastLightID = value; }
	
	private var _atten:uint = DEFAULT_ATTEN;  // down 1 per meter
	public function get atten():uint { return _atten; }
	private var _sunlit:Boolean;
	
	public var _b000:VertexColor;
	public var _b001:VertexColor;
	public var _b100:VertexColor;
	public var _b101:VertexColor;
	public var _b010:VertexColor;
	public var _b011:VertexColor;
	public var _b110:VertexColor;
	public var _b111:VertexColor;

	public function get b000():uint { return _b000.attnGet( _lastLightID ); }
	public function get b001():uint { return _b001.attnGet( _lastLightID ); }
	public function get b100():uint { return _b100.attnGet( _lastLightID ); }
	public function get b101():uint { return _b101.attnGet( _lastLightID ); }
	public function get b010():uint { return _b010.attnGet( _lastLightID ); }
	public function get b011():uint { return _b011.attnGet( _lastLightID ); }
	public function get b110():uint { return _b110.attnGet( _lastLightID ); }
	public function get b111():uint { return _b111.attnGet( _lastLightID ); }
	
	public function set b000( attn:uint ):void { _b000.attnSet( _lastLightID, attn ); }
	public function set b001( attn:uint ):void { _b001.attnSet( _lastLightID, attn ); }
	public function set b100( attn:uint ):void { _b100.attnSet( _lastLightID, attn ); }
	public function set b101( attn:uint ):void { _b101.attnSet( _lastLightID, attn ); }
	public function set b010( attn:uint ):void { _b010.attnSet( _lastLightID, attn ); }
	public function set b011( attn:uint ):void { _b011.attnSet( _lastLightID, attn ); }
	public function set b110( attn:uint ):void { _b110.attnSet( _lastLightID, attn ); }
	public function set b111( attn:uint ):void { _b111.attnSet( _lastLightID, attn ); }
	
	public function get sunlit():Boolean { return _sunlit; }
	// TODO this should be from the current sun object
	public function set sunlit(value:Boolean):void { true == value ? setAll( FIXED_ID, MAX ): reset(); _sunlit = value;  }
	
	private function rnd( $val:uint ):uint { return int($val * 100) / 100; }
	
	public function Brightness():void {
		lastLightID = DEFAULT_ID;
		// Could get the default color and atten from the config manager.
		_b000 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b001 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b100 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b101 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b010 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b011 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b110 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		_b111 = new VertexColor( DEFAULT_ID, ColorUtils.placeAlpha( DEFAULT_COLOR, DEFAULT_ATTEN ) );
		
	}
	
	// var number:Number = 10.98813311;
	// trace(setPrecision(number,1)); //Result is 10.9
	// trace(setPrecision(number,2)); //Result is 10.98
	// trace(setPrecision(number,3)); //Result is 10.988 and so on
	// http://stackoverflow.com/questions/632802/how-to-deal-with-number-precision-in-actionscript
	//private function setPrecision( $number:Number, $precision:int = 3):Number {
		//$precision = Math.pow(10, $precision);
		//return Math.round( $number * $precision )/$precision;
	//}

	
	public function toByteArray( $ba:ByteArray ):ByteArray {
		
		Log.out( "Brightness.toByteArray - This does not take into account color data", Log.ERROR );
		$ba.writeInt( rnd( b000 ) );
		$ba.writeInt( rnd( b001 ) );
		$ba.writeInt( rnd( b100 ) );
		$ba.writeInt( rnd( b101 ) );
		$ba.writeInt( rnd( b010 ) );
		$ba.writeInt( rnd( b011 ) );
		$ba.writeInt( rnd( b110 ) );
		$ba.writeInt( rnd( b111 ) );
		return $ba;
	}
	
	public function fromByteArray( $ba:ByteArray ):ByteArray {
		
//		Log.out( "Brightness.fromByteArray - This does not take into account color data", Log.ERROR );
		//var b000 = rnd( $ba.readInt() );
		//trace( "Brightness.fromByteArray b000: " + b000 );
		b000 = $ba.readInt();
		b001 = $ba.readInt();
		b100 = $ba.readInt();
		b101 = $ba.readInt();
		b010 = $ba.readInt();
		b011 = $ba.readInt();
		b110 = $ba.readInt();
		b111 = $ba.readInt();
		return $ba;
	}

	public function toString():String {
		return  "  lastLightID: " + _lastLightID +
		        "  b000: " + b000 +
				"  b001: " + b001 +
				"  b100: " + b100 +
				"  b101: " + b101 +
				"  b010: " + b010 +
				"  b011: " + b011 +
				"  b110: " + b110 +
				"  b111: " + b111 +
				"  colorCount: "  + _b000.colorCount();
	}
	
	public function copyFrom( $b:Brightness ):void {
		if ( sunlit )
			return;
		if ( 1 < _b000.colorCount() )	
			reset();	
		_lastLightID = $b.lastLightID;

		_b000.copyColors( $b._b000.colors() );
		_b001.copyColors( $b._b001.colors() ); 
		_b010.copyColors( $b._b010.colors() );
		_b011.copyColors( $b._b011.colors() );
		_b100.copyColors( $b._b100.colors() );
		_b101.copyColors( $b._b101.colors() ); 
		_b110.copyColors( $b._b110.colors() ); 
		_b111.copyColors( $b._b111.colors() );
		
		_atten = $b._atten;
		// _sunlit - left empty
		// _processed - left empty
	}
	
	public function setAll( $lightID:uint, $attn:uint ):void	{
		if ( Brightness.MAX < $attn )
			throw new Error( "Brightness.setAll - attn too high" );
		if ( sunlit )
			return;
		if ( true == _b000.colorHas( $lightID ) ) {
			_lastLightID = $lightID;
			b000 = $attn;
			b001 = $attn;
			b100 = $attn;
			b101 = $attn;
			b010 = $attn;
			b011 = $attn;
			b110 = $attn;
			b111 = $attn;
		}
		else
			throw new Error( "Brightness.setAll - Color not defined" );
	}
	
	public function valuesHas():Boolean	{
		if ( sunlit )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b000 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b001 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b100 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b101 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b010 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b011 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b110 )
			return true;
		if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < b111 )
			return true;
		//if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < Color.extractRed( color ) )
			//return true;
		//if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < Color.extractGreen( color ) )
			//return true;
		//if ( ( DEFAULT_ATTEN + DEFAULT_SIGMA ) < Color.extractBlue( color ) )
			//return true;
			
		return false;
	}
	
	public function checkForSolidOxels( $o:Oxel ):void	{
		// now we have to check for solid children, and set those vertices to default value
		var kids:Vector.<Oxel> = $o.children
		for each ( var kid:Oxel in kids ) {
			if ( kid.isSolid )
				resetFromChildID( kid.gc.childId() );
		}
		
	}

	// This resets the corner identified by child id to default values.
	public function resetFromChildID( $childID:int ):void {	

		if ( 0 == $childID )
			b000 = DEFAULT_ATTEN;
		else if ( 1 == $childID )
			b100 = DEFAULT_ATTEN;
		else if ( 2 == $childID )
			b010 = DEFAULT_ATTEN;
		else if ( 3 == $childID )
			b110 = DEFAULT_ATTEN;
		else if ( 4 == $childID )
			b001 = DEFAULT_ATTEN;
		else if ( 5 == $childID )
			b101 = DEFAULT_ATTEN;
		else if ( 6 == $childID )
			b011 = DEFAULT_ATTEN;
		else if ( 7 == $childID )
			b111 = DEFAULT_ATTEN;
	}

	public function reset():void	{
		
		_lastLightID = DEFAULT_ID;
		_b000.reset();
		_b001.reset();
		_b100.reset();
		_b101.reset();
		_b010.reset();
		_b011.reset();
		_b110.reset();
		_b111.reset();
		
		_atten = DEFAULT_ATTEN;
		_sunlit = false;
	}

	public function childAdd( $childID:uint, $bt:Brightness, $grainUnits:uint ):void {	

		// This is special case which needs to take into account atten
		var localAtten:uint = _atten * $grainUnits/DEFAULT_PER_DISTANCE
		var sqrAtten:Number =  Math.sqrt( 2 * (localAtten * localAtten) );
		var csqrAtten:Number =  Math.sqrt( (localAtten * localAtten) + (sqrAtten * sqrAtten) );
		
		var colors:Dictionary = $bt._b000.colors();
		for (var lightID:String in colors )
		{
			var color:uint = colors[lightID];
			lightAdd( uint(lightID), color );
		}
		
		if ( lastLightID != $bt.lastLightID ) {	
			lastLightID = $bt.lastLightID;
			processed = false;
		}
		// The corner that the child is in is always the most accurate data, everything else is a guess
		if ( 0 == $childID ) {
			b000 = $bt.b000;
			if ( b001 < $bt.b001 - localAtten ) b001 = $bt.b001 - localAtten;
			if ( b100 < $bt.b100 - localAtten ) b100 = $bt.b100 - localAtten;
			if ( b101 < $bt.b101 - sqrAtten ) 	b101 = $bt.b101 - sqrAtten;
			
			if ( b010 < $bt.b010 - localAtten ) b010 = $bt.b010 - localAtten;
			if ( b011 < $bt.b011 - sqrAtten ) 	b011 = $bt.b011 - sqrAtten;
			if ( b110 < $bt.b110 - sqrAtten ) 	b110 = $bt.b110 - sqrAtten;
			if ( b111 < $bt.b111 - csqrAtten ) 	b111 = $bt.b111 - csqrAtten;
		}
		else if ( 1 == $childID ) {
			if ( b000 < $bt.b000 - localAtten ) b000 = $bt.b000 - localAtten;
			if ( b001 < $bt.b001 - sqrAtten ) 	b001 = $bt.b001 - sqrAtten;
			b100 = $bt.b100;
			if ( b101 < $bt.b101 - localAtten ) b101 = $bt.b101 - localAtten;
			       
			if ( b010 < $bt.b010 - sqrAtten ) 	b010 = $bt.b010 - sqrAtten;
			if ( b011 < $bt.b011 - csqrAtten ) 	b011 = $bt.b011 - csqrAtten;
			if ( b110 < $bt.b110 - localAtten ) b110 = $bt.b110 - localAtten;
			if ( b111 < $bt.b111 - sqrAtten ) 	b111 = $bt.b111 - sqrAtten;
		}
		else if ( 2 == $childID ) {
			if ( b000 < $bt.b000 - localAtten ) b000 = $bt.b000 - localAtten;
			if ( b001 < $bt.b001 - sqrAtten ) 	b001 = $bt.b001 - sqrAtten;
			if ( b100 < $bt.b100 - sqrAtten ) 	b100 = $bt.b100 - sqrAtten;
			if ( b101 < $bt.b101 - csqrAtten ) 	b101 = $bt.b101 - csqrAtten;
			       
			b010 = $bt.b010;
			if ( b011 < $bt.b011 - localAtten ) b011 = $bt.b011 - localAtten;
			if ( b110 < $bt.b110 - localAtten ) b110 = $bt.b110 - localAtten;
			if ( b111 < $bt.b111 - sqrAtten ) 	b111 = $bt.b111 - sqrAtten;
		}
		else if ( 3 == $childID ) {
			if ( b000 < $bt.b000 - sqrAtten ) 	b000 = $bt.b000 - sqrAtten;
			if ( b001 < $bt.b001 - csqrAtten ) 	b001 = $bt.b001 - csqrAtten;
			if ( b100 < $bt.b100 - localAtten ) b100 = $bt.b100 - localAtten;
			if ( b101 < $bt.b101 - sqrAtten ) 	b101 = $bt.b101 - sqrAtten;
			       
			if ( b010 < $bt.b010 - localAtten ) b010 = $bt.b010 - localAtten;
			if ( b011 < $bt.b011 - sqrAtten ) 	b011 = $bt.b011 - sqrAtten;
			b110 = $bt.b110;
			if ( b111 < $bt.b111 - localAtten ) b111 = $bt.b111 - localAtten;
		}
		else if ( 4 == $childID ) {
			if ( b000 < $bt.b000 - localAtten ) b000 = $bt.b000 - localAtten;
			b001 = $bt.b001;
			if ( b100 < $bt.b100 - sqrAtten ) 	b100 = $bt.b100 - sqrAtten;
			if ( b101 < $bt.b101 - localAtten ) b101 = $bt.b101 - localAtten;
			       
			if ( b010 < $bt.b010 - sqrAtten ) 	b010 = $bt.b010 - sqrAtten;
			if ( b011 < $bt.b011 - localAtten ) b011 = $bt.b011 - localAtten;
			if ( b110 < $bt.b110 - csqrAtten ) 	b110 = $bt.b110 - csqrAtten;
			if ( b111 < $bt.b111 - sqrAtten ) 	b111 = $bt.b111 - sqrAtten;
		}
		else if ( 5 == $childID ) {
			if ( b000 < $bt.b000 - sqrAtten ) 	b000 = $bt.b000 - sqrAtten;
			if ( b001 < $bt.b001 - localAtten ) b001 = $bt.b001 - localAtten;
			if ( b100 < $bt.b100 - csqrAtten ) b100 = $bt.b100 - localAtten;
			b101 = $bt.b101;
			       
			if ( b010 < $bt.b010 - csqrAtten ) 	b010 = $bt.b010 - csqrAtten;
			if ( b011 < $bt.b011 - sqrAtten ) 	b011 = $bt.b011 - sqrAtten;
			if ( b110 < $bt.b110 - sqrAtten ) 	b110 = $bt.b110 - sqrAtten;
			if ( b111 < $bt.b111 - localAtten ) b111 = $bt.b111 - localAtten;
		}
		else if ( 6 == $childID ) {
			if ( b000 < $bt.b000 - sqrAtten ) 	b000 = $bt.b000 - sqrAtten;
			if ( b001 < $bt.b001 - localAtten ) b001 = $bt.b001 - localAtten;
			if ( b100 < $bt.b100 - csqrAtten ) 	b100 = $bt.b100 - csqrAtten;
			if ( b101 < $bt.b101 - sqrAtten ) 	b101 = $bt.b101 - sqrAtten;
			       
			if ( b010 < $bt.b010 - localAtten ) b010 = $bt.b010 - localAtten;
			b011 = $bt.b011;
			if ( b110 < $bt.b110 - sqrAtten ) 	b110 = $bt.b110 - sqrAtten;
			if ( b111 < $bt.b111 - localAtten ) b111 = $bt.b111 - localAtten;
		}
		else if ( 7 == $childID ) {
			if ( b000 < $bt.b000 - csqrAtten ) 	b000 = $bt.b000 - csqrAtten;
			if ( b001 < $bt.b001 - sqrAtten ) 	b001 = $bt.b001 - sqrAtten;
			if ( b100 < $bt.b100 - sqrAtten ) 	b100 = $bt.b100 - sqrAtten;
			if ( b101 < $bt.b101 - localAtten ) b101 = $bt.b101 - localAtten;
			       
			if ( b010 < $bt.b010 - sqrAtten ) 	b010 = $bt.b010 - sqrAtten;
			if ( b011 < $bt.b011 - localAtten ) b011 = $bt.b011 - localAtten;
			if ( b110 < $bt.b110 - localAtten ) b110 = $bt.b110 - localAtten;
			b111 = $bt.b111;
		}
	}
	
	// grabs the light from a parent to a child brightness
	public function childGet( $childID:int, $nb:Brightness ):void {
		
		var colors:Dictionary = _b000.colors();
		for (var lightIDString:String in colors )
		{
			var color:uint = colors[lightIDString];
			var lightID:uint = uint(lightIDString);
			if ( DEFAULT_ID != lightID ) {
				$nb.lightAdd( lightID, color );
				$nb.lastLightID = lightID;
				
				// I think the diagonals should be averaged between both corners
				if ( 0 == $childID ) { // b000
					$nb.b000 = b000;
					$nb.b001 = (b001 + b000) / 2;
					$nb.b010 = (b010 + b000) / 2;				// average edge for edge points
					$nb.b011 = (b011 + b001 + b010 + b000) / 4; // average of all four on face for points on face
					$nb.b100 = (b100 + b000) / 2;
					$nb.b101 = (b101 + b000 + b100 + b001) / 4;
					$nb.b110 = (b110 + b100 + b000 + b010) / 4;
					$nb.b111 = avg; 							// average of all eight for center points
				}
				else if ( 1 == $childID )	{ // b100
					$nb.b000 = (b000 + b100) / 2;
					$nb.b001 = (b101 + b000 + b100 + b001) / 4;
					$nb.b010 = (b000 + b100 + b010 + b110) / 4;
					$nb.b011 = avg;
					$nb.b100 = b100;
					$nb.b101 = (b101 + b100) / 2;
					$nb.b110 = (b100 + b110) / 2;
					$nb.b111 = (b100 + b110 + b101 + b111) / 4;
				}
				else if ( 2 == $childID )	{ // b010
					$nb.b000 = (b000 + b010) / 2;
					$nb.b001 = (b000 + b010 + b001 + b011) / 4;
					$nb.b010 = b010;
					$nb.b011 = (b011 + b010) / 2;
					$nb.b100 = (b000 + b010 + b100 + b110) / 4;
					$nb.b101 = avg;
					$nb.b110 = (b110 + b010) / 2;
					$nb.b111 = (b111 + b010 + b110 + b011 ) / 4;
				}
				else if ( 3 == $childID ) { // b110
					$nb.b000 = (b000 + b010 + b110 + b100 ) / 4;
					$nb.b001 = avg;
					$nb.b010 = (b010 + b110) / 2;
					$nb.b011 = (b111 + b010 + b110 + b011 ) / 4;
					$nb.b100 = (b100 + b110) / 2;
					$nb.b101 = (b100 + b110 + b111 + b101 ) / 4;
					$nb.b110 = b110;
					$nb.b111 = (b111 + b110) / 2;
				}
				else if ( 4 == $childID )	{ // b001
					$nb.b000 = (b000 + b001) / 2;
					$nb.b001 = b001;
					$nb.b010 = (b000 + b010 + b001 + b011) / 4;
					$nb.b011 = (b011 + b001) / 2;
					$nb.b100 = (b101 + b000 + b100 + b001) / 4;
					$nb.b101 = (b101 + b001) / 2;
					$nb.b110 = avg;
					$nb.b111 = (b001 + b011 + b101 + b111) / 4;
				}
				else if ( 5 == $childID )	{ // b101
					$nb.b000 = (b101 + b000 + b100 + b001) / 4;
					$nb.b001 = (b001 + b101) / 2;
					$nb.b010 = avg;
					$nb.b011 = (b001 + b011 + b101 + b111) / 4;
					$nb.b100 = (b100 + b101) / 2;
					$nb.b101 = b101;
					$nb.b110 = (b100 + b110 + b101 + b111) / 4;
					$nb.b111 = (b111 + b101) / 2;
				}
				else if ( 6 == $childID )	{ // b011
					$nb.b000 = (b000 + b010 + b011 + b001) / 4;
					$nb.b001 = (b001 + b011) / 2;
					$nb.b010 = (b010 + b011) / 2;
					$nb.b011 = b011;
					$nb.b100 = avg;
					$nb.b101 = (b001 + b011 + b101 + b111) / 4;
					$nb.b110 = (b010 + b011 + b110 + b111) / 4;
					$nb.b111 = (b111 + b011) / 2;
				}
				else if ( 7 == $childID )	{ // b111
					$nb.b000 = avg;
					$nb.b001 = (b001 + b011 + b101 + b111 ) / 4;
					$nb.b010 = (b111 + b010 + b110 + b011 ) / 4;
					$nb.b011 = (b011 + b111) / 2;
					$nb.b100 = (b100 + b110 + b101 + b111 ) / 4;
					$nb.b101 = (b101 + b111) / 2;
					$nb.b110 = (b110 + b111) / 2;
					$nb.b111 = b111;
				}
			}
		}
	}

	// if changed return true, which can add a new light task for AIR oxels
	private function equals( $b:Brightness ):Boolean {
		if ( b000 == $b.b000 
		  && b010 == $b.b010 
		  && b011 == $b.b011 
		  && b001 == $b.b001 
		  && b100 == $b.b100 
		  && b110 == $b.b110 
		  && b111 == $b.b111 
		  && b101 == $b.b101 ) return true;
		 
		return false;  
	}

	private function get avg():uint {
		
		return (b000 + b010 + b011 + b001 + b100 + b110 +  b111 + b101)/8
	}
	
	private function get max():uint {
		
		var max:uint = DEFAULT_ATTEN;
		if ( max < b000 )
			max = b000;
		if ( max < b001 )
			max = b001;
		if ( max < b010 )
			max = b010;
		if ( max < b011 )
			max = b011;
		if ( max < b100 )
			max = b100;
		if ( max < b101 )
			max = b101;
		if ( max < b110 )
			max = b110;
		if ( max < b111 )
			max = b111;

		return max;	
	}
	
	private function get maxVertex():VertexColor {
		
		var max:uint = DEFAULT_ATTEN;
		var maxVert:VertexColor;
		if ( max < b000 ) {
			max = b000;
			maxVert = _b000;
		}
		if ( max < b001 ) {
			max = b001;
			maxVert = _b001;
		}
		if ( max < b010 ) {
			max = b010;
			maxVert = _b010;
		}
		if ( max < b011 ) {
			max = b011;
			maxVert = _b011;
		}
		if ( max < b100 ) {
			max = b100;
			maxVert = _b100;
		}
		if ( max < b101 ) {
			max = b101;
			maxVert = _b101;
		}
		if ( max < b110 ) {
			max = b110;
			maxVert = _b110;
		}
		if ( max < b111 ) {
			max = b111;
			maxVert = _b111;
		}

		return maxVert;	
	}
	
	public function colorGet( $lightID:uint ):uint {
		if ( true == _b000.colorHas( $lightID ) )
			return _b000.colorGet( $lightID );
			
		return 0;
	}
	
	public function lightAdd( $lightID:uint, $lightColor:uint, isLight:Boolean = false ):void {
		
		// if one has this last light id, then all should have it.
		if ( false == _b000.colorHas( $lightID ) )
		{
			// If this is not the light its self, set default attn to 0 of 255
			var val:uint = $lightColor;
			if ( false == isLight ) {
				val &= 0x00ffffff;
				val |= DEFAULT_ATTEN << 24;
			}
			
			_b000.colorAdd( $lightID, val );
			_b001.colorAdd( $lightID, val );
			_b100.colorAdd( $lightID, val );
			_b101.colorAdd( $lightID, val );
			_b010.colorAdd( $lightID, val );
			_b011.colorAdd( $lightID, val );
			_b110.colorAdd( $lightID, val );
			_b111.colorAdd( $lightID, val );
		}
	}
	
	public function fullBright():void {
		
		_b000.attnSet( 1, 255 );
		_b001.attnSet( 1, 255 );
		_b100.attnSet( 1, 255 );
		_b101.attnSet( 1, 255 );
		_b010.attnSet( 1, 255 );
		_b011.attnSet( 1, 255 );
		_b110.attnSet( 1, 255 );
		_b111.attnSet( 1, 255 );
	}
	
	public function influenceAdd( $lob:Brightness, $faceFrom:int, $faceOnly:Boolean, $grainUnits:int ):Boolean
	{
		var c:Boolean = false;
		var lightColor:uint = $lob._b000.colorGet( $lob.lastLightID );		
		
		lightAdd( $lob.lastLightID, lightColor );
		if ( lastLightID != $lob.lastLightID ) {
			lastLightID = $lob.lastLightID;
			processed = false;
		}
		
		const attenScaled:uint = _atten * ($grainUnits/16);
		if ( Globals.POSX == $faceFrom ) {
			
			if ( b000 < $lob.b100 ) { b000 = $lob.b100; c = true; }
			if ( b010 < $lob.b110 ) { b010 = $lob.b110; c = true; }
			if ( b011 < $lob.b111 ) { b011 = $lob.b111; c = true; }
			if ( b001 < $lob.b101 ) { b001 = $lob.b101; c = true; }
		}
		else if ( Globals.NEGX == $faceFrom ) {

			if ( b100 < $lob.b000 ) { b100 = $lob.b000; c = true; }
			if ( b110 < $lob.b010 ) { b110 = $lob.b010; c = true; }
			if ( b111 < $lob.b011 ) { b111 = $lob.b011; c = true; }
			if ( b101 < $lob.b001 ) { b101 = $lob.b001; c = true; }
		}
		else if ( Globals.POSY == $faceFrom ) {

			if ( b000 < $lob.b010 ) { b000 = $lob.b010; c = true; }
			if ( b100 < $lob.b110 ) { b100 = $lob.b110; c = true; }
			if ( b101 < $lob.b111 ) { b101 = $lob.b111; c = true; }
			if ( b001 < $lob.b011 ) { b001 = $lob.b011; c = true; }
		}
		else if ( Globals.NEGY == $faceFrom ) {

			if ( b010 < $lob.b000 ) { b010 = $lob.b000; c = true; }
			if ( b110 < $lob.b100 ) { b110 = $lob.b100; c = true; }
			if ( b111 < $lob.b101 ) { b111 = $lob.b101; c = true; }
			if ( b011 < $lob.b001 ) { b011 = $lob.b001; c = true; }
		}
		else if ( Globals.POSZ == $faceFrom ) {

			if ( b000 < $lob.b001 ) { b000 = $lob.b001; c = true; }
			if ( b010 < $lob.b011 ) { b010 = $lob.b011; c = true; }
			if ( b110 < $lob.b111 ) { b110 = $lob.b111; c = true; }
			if ( b100 < $lob.b101 ) { b100 = $lob.b101; c = true; }
		}
		else if ( Globals.NEGZ == $faceFrom ) {
			
			if ( b001 < $lob.b000 ) { b001 = $lob.b000; c = true; }
			if ( b011 < $lob.b010 ) { b011 = $lob.b010; c = true; }
			if ( b111 < $lob.b110 ) { b111 = $lob.b110; c = true; }
			if ( b101 < $lob.b100 ) { b101 = $lob.b100; c = true; }
		}
		
		//if ( !$faceOnly && max - attenScaled > avg ) {
		if ( !$faceOnly ) {
			var result:Boolean = balanceAttn( attenScaled );
			c = c || result;
		}
		
		return c;
	}
	/*
	 *           0,1,0  ___________ 1,1,0
	 *                /|          /|
	 *               / |   1,1,1 / |
	 *     ^  0,1,1 /__|________/  |   POSX ->
	 *     |       |   |        |  |
	 *    POSY     |   |________|__|
	 *             |  / 0,0,0   |  / 1,0,0
	 *             | /          | /
	 *             |/___________|/
	 *      POSZ   0,0,1        1,0,1
	 *        |
	 *        \/
	 */
	public function balanceAttn( $attenScaled:uint ):Boolean {
		var c:Boolean = false;
		const sqAtten:Number = Math.sqrt( 2 * ($attenScaled * $attenScaled) );
		const qrAtten:Number = Math.sqrt( 3 * ($attenScaled * $attenScaled) );
		// Do this for each adject vertice
		if ( b000 > b001 + $attenScaled ) { b001 = b000 - $attenScaled; c = true; }
		if ( b000 > b010 + $attenScaled ) { b010 = b000 - $attenScaled; c = true; }
		if ( b000 > b011 + sqAtten ) 	  { b011 = b000 - sqAtten; c = true; }
		if ( b000 > b100 + $attenScaled ) { b100 = b000 - $attenScaled; c = true; }
		if ( b000 > b101 + sqAtten ) 	  { b101 = b000 - sqAtten; c = true; }
		if ( b000 > b110 + sqAtten ) 	  { b110 = b000 - sqAtten; c = true; }
		if ( b000 > b111 + qrAtten ) 	  { b111 = b000 - qrAtten; c = true; }
		
		if ( b001 > b000 + $attenScaled ) { b000 = b001 - $attenScaled; c = true; }
		if ( b001 > b010 + sqAtten ) 	  { b010 = b001 - sqAtten; c = true; }
		if ( b001 > b011 + $attenScaled ) { b011 = b001 - $attenScaled; c = true; }
		if ( b001 > b100 + sqAtten ) 	  { b100 = b001 - sqAtten; c = true; }
		if ( b001 > b101 + $attenScaled ) { b101 = b001 - $attenScaled; c = true; }
		if ( b000 > b110 + qrAtten ) 	  { b110 = b001 - qrAtten; c = true; }
		if ( b001 > b111 + sqAtten ) 	  { b111 = b001 - sqAtten; c = true; }
		
		if ( b010 > b000 + $attenScaled ) { b000 = b010 - $attenScaled; c = true; }
		if ( b010 > b001 + sqAtten ) 	  { b001 = b010 - sqAtten; c = true; }
		if ( b010 > b011 + $attenScaled ) { b011 = b010 - $attenScaled; c = true; }
		if ( b010 > b100 + sqAtten ) 	  { b100 = b010 - sqAtten; c = true; }
		if ( b010 > b101 + qrAtten ) 	  { b101 = b010 - qrAtten; c = true; }
		if ( b010 > b110 + $attenScaled ) { b110 = b010 - $attenScaled; c = true; }
		if ( b010 > b111 + sqAtten ) 	  { b111 = b010 - sqAtten; c = true; }
		
		if ( b011 > b000 + sqAtten ) 	  { b000 = b011 - sqAtten; c = true; }
		if ( b011 > b001 + $attenScaled ) { b001 = b011 - $attenScaled; c = true; }
		if ( b011 > b010 + $attenScaled ) { b010 = b011 - $attenScaled; c = true; }
		if ( b011 > b100 + qrAtten )      { b100 = b011 - qrAtten; c = true; }
		if ( b011 > b101 + sqAtten )      { b101 = b011 - sqAtten; c = true; }
		if ( b011 > b110 + sqAtten )      { b110 = b011 - sqAtten; c = true; }
		if ( b011 > b111 + $attenScaled ) { b111 = b011 - $attenScaled; c = true; }

		if ( b100 > b000 + $attenScaled ) { b000 = b100 - $attenScaled; c = true; }
		if ( b100 > b001 + sqAtten ) 	  { b001 = b100 - sqAtten; c = true; }
		if ( b100 > b010 + sqAtten ) 	  { b010 = b100 - sqAtten; c = true; }
		if ( b100 > b011 + qrAtten ) 	  { b011 = b100 - qrAtten; c = true; }
		if ( b100 > b101 + $attenScaled ) { b101 = b100 - $attenScaled; c = true; }
		if ( b100 > b110 + $attenScaled ) { b110 = b100 - $attenScaled; c = true; }
		if ( b100 > b111 + sqAtten ) 	  { b111 = b100 - sqAtten; c = true; }
		
		if ( b101 > b000 + sqAtten ) 	  { b000 = b101 - sqAtten; c = true; }
		if ( b101 > b001 + $attenScaled ) { b001 = b101 - $attenScaled; c = true; }
		if ( b101 > b010 + qrAtten ) 	  { b010 = b101 - qrAtten; c = true; }
		if ( b101 > b011 + sqAtten ) 	  { b011 = b101 - sqAtten; c = true; }
		if ( b101 > b100 + $attenScaled ) { b100 = b101 - $attenScaled; c = true; }
		if ( b101 > b110 + sqAtten ) 	  { b110 = b101 - sqAtten; c = true; }
		if ( b101 > b111 + $attenScaled ) { b111 = b101 - $attenScaled; c = true; }
		
		if ( b110 > b000 + sqAtten )	  { b000 = b110 - sqAtten; c = true; }
		if ( b110 > b001 + qrAtten )	  { b001 = b110 - qrAtten; c = true; }
		if ( b110 > b010 + $attenScaled ) { b010 = b110 - $attenScaled; c = true; }
		if ( b110 > b011 + sqAtten )	  { b011 = b110 - sqAtten; c = true; }
		if ( b110 > b100 + $attenScaled ) { b100 = b110 - $attenScaled; c = true; }
		if ( b110 > b101 + sqAtten )	  { b101 = b110 - sqAtten; c = true; }
		if ( b110 > b111 + $attenScaled ) { b111 = b110 - $attenScaled; c = true; }

		if ( b111 > b000 + qrAtten ) 	  { b000 = b111 - qrAtten; c = true; }
		if ( b111 > b001 + sqAtten ) 	  { b001 = b111 - sqAtten; c = true; }
		if ( b111 > b010 + sqAtten ) 	  { b010 = b111 - sqAtten; c = true; }
		if ( b111 > b011 + $attenScaled ) { b011 = b111 - $attenScaled; c = true; }
		if ( b111 > b100 + sqAtten ) 	  { b100 = b111 - sqAtten; c = true; }
		if ( b111 > b101 + $attenScaled ) { b101 = b111 - $attenScaled; c = true; }
		if ( b111 > b110 + $attenScaled ) { b110 = b111 - $attenScaled; c = true; }

		return c;
	}
	
	public function addBrightness( $lob:Brightness, $bt:Brightness ):Boolean {
		
		lastLightID = $lob.lastLightID
		lightAdd( lastLightID, $lob.colorGet( lastLightID ) );
		
		var c:Boolean;
		if ( b000 < $bt.b000 )	  { b000 = $bt.b000; c = true; }
		if ( b001 < $bt.b001 )	  { b001 = $bt.b001; c = true; }
		if ( b010 < $bt.b010 )	  { b010 = $bt.b010; c = true; }
		if ( b011 < $bt.b011 )	  { b011 = $bt.b011; c = true; }
		if ( b100 < $bt.b100 )	  { b100 = $bt.b100; c = true; }
		if ( b101 < $bt.b101 )	  { b101 = $bt.b101; c = true; }
		if ( b110 < $bt.b110 )	  { b110 = $bt.b110; c = true; }
		if ( b111 < $bt.b111 )	  { b111 = $bt.b111; c = true; }
		return c;
	}
	
	/*
	public function setByFace( $face:int, $val:uint, $id:uint, size:int ):void {
		if ( sunlit )
			return;

		_lastLightID = $id;	
		var localAtten:uint = _atten * size/DEFAULT_PER_DISTANCE

		if ( Globals.POSX == $face ) {
			b100 = $val;
			b110 = $val;
			b111 = $val;
			b101 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b010 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b011 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b001 = Math.max( $val - localAtten, DEFAULT_ATTEN ); 
		}
		else if ( Globals.NEGX == $face ) {
			b000 = $val;
			b010 = $val;
			b011 = $val;
			b001 = $val; 

			b100 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b110 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b111 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b101 = Math.max( $val - localAtten, DEFAULT_ATTEN ); 
		}
		else if ( Globals.POSY == $face ) {
			b010 = $val;
			b110 = $val;
			b111 = $val;
			b011 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b100 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b101 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b001 = Math.max( $val - localAtten, DEFAULT_ATTEN ); 
		}
		else if ( Globals.NEGY == $face ) {
			b000 = $val;
			b100 = $val;
			b101 = $val;
			b001 = $val; 
			
			b010 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b110 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b111 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b011 = Math.max( $val - localAtten, DEFAULT_ATTEN ); 
		}
		else if ( Globals.POSZ == $face ) {
			b001 = $val;
			b011 = $val;
			b111 = $val;
			b101 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b010 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b110 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b100 = Math.max( $val - localAtten, DEFAULT_ATTEN ); 
		}
		else if ( Globals.NEGZ == $face ) {
			b000 = $val;
			b010 = $val;
			b110 = $val;
			b100 = $val; 

			b001 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b011 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b111 = Math.max( $val - localAtten, DEFAULT_ATTEN );
			b101 = Math.max( $val - localAtten, DEFAULT_ATTEN );
		}
	}
*/
	/*
	// This creates a virtual larger face that is then applied to the larger no.
	public function setFromSmallerOxel( $no:Oxel, $lo:Oxel, $faceFrom:int, $lightColor:uint ):Boolean {
		//Log.out( "setFromSmallerOxel" );
		// small lo being applied to larger no
		// I need to find the position offset, by
		var loGrain:int = $lo.gc.grain;
		var noGrain:int = $no.gc.grain;
		var gct:GrainCursor = GrainCursorPool.poolGet( noGrain );
		var sizeDiff:int = noGrain - loGrain;
		gct.copyFrom( $lo.gc );
		gct.become_ancestor( sizeDiff ); // This loses the odd bits
		gct.become_decendant( sizeDiff )
		//gct.become_child( sizeDiff );  // now I have the origin grain from that ancestor, same size as lo
		// create a virtual parent, of the same size as the neighbor
		// that has the scaled values, I only care about the face that I am getting values from
		// now 
		// This gets me the position of the pos x face
		// on a 16 lo projecting on a 64 no, I might get a 16,32 offset
		// coordinate effected would be 1,0,0  1,1,0, 1,0,1, and 1,1,1
		// that would subtract a 16 * _atten to one coordinate, and n - size
		//
		var x:int = $lo.gc.getModelX() - gct.getModelX();
		var y:int = $lo.gc.getModelY() - gct.getModelY();
		var z:int = $lo.gc.getModelZ() - gct.getModelZ();
		var loSize:int = $lo.gc.size();
		var noSize:int = $no.gc.size();
		var lob:Brightness = $lo.brightness;
		_s_sb.reset();
		_s_sb.colorAdd( lob.lastLightID, $lightColor );
		_s_sb.lastLightID = lob.lastLightID;	

		if ( Globals.POSX == $faceFrom ) {
			_s_sb.b100 = Math.min( lob.b100 - ( _atten * (z / loSize) )
							     , lob.b100 - ( _atten * (y / loSize) ) );
								 
			_s_sb.b101 = Math.min( lob.b101 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
			                     , lob.b110 - ( _atten * (y / loSize) ) );
								 
			_s_sb.b110 = Math.min( lob.b110 - ( _atten * ((noSize - (y + loSize)) / loSize ) )
			                     , lob.b100 - ( _atten * (z / loSize) ) );
			
			// RSF appear to be bug here when the 101 oxel is projecting
			_s_sb.b111 = Math.max( lob.b111 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
								 , lob.b111 - ( _atten * ((noSize - (y + loSize)) / loSize ) ) );
		}
		else if ( Globals.NEGX == $faceFrom ) {
			_s_sb.b000 = Math.min( lob.b000 - ( _atten * ( z / loSize ) )
								 , lob.b000 - ( _atten * ( y / loSize ) ) );
								 
			_s_sb.b001 = Math.min( lob.b001 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
			                     , lob.b010 - ( _atten * (y / loSize ) ) );
								 
			_s_sb.b010 = Math.min( lob.b010 - ( _atten * ((noSize - (y + loSize)) / loSize ) )
			                     , lob.b000 - ( _atten * (z / loSize ) ) );
								 
			_s_sb.b011 = Math.max( lob.b011 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
								 , lob.b011 - ( _atten * ((noSize - (y + loSize)) / loSize ) ) );
		}
		else if ( Globals.POSY == $faceFrom ) {
			_s_sb.b010 = Math.min( lob.b010 - ( _atten * ( z / loSize ) )
								 , lob.b010 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b110 = Math.min( lob.b110 - ( _atten * (z / loSize ) )
								 , lob.b110 - ( _atten * ((noSize - (x + loSize)) / loSize ) ) );
								 
			_s_sb.b111 = Math.min( lob.b111 - ( _atten * ((noSize - (x + loSize)) / loSize ) ) 
								 , lob.b111 - ( _atten * ((noSize - (z + loSize)) / loSize ) ) );
			
			_s_sb.b011 = Math.min( lob.b011 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
			                     , lob.b110 - ( _atten * (x / loSize ) ) );
		}
		else if ( Globals.NEGY == $faceFrom ) {
			_s_sb.b000 = Math.min( lob.b000 - ( _atten * ( z / loSize ) )
								 , lob.b000 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b100 = Math.min(( lob.b100 - ( _atten * (z / loSize ) ) )
								 ,( lob.b100 - ( _atten * ((noSize - (x + loSize)) / loSize ) ) ) );
								 
			_s_sb.b101 = Math.min( lob.b101 - ( _atten * ((noSize - (x + loSize)) / loSize ) )
								 , lob.b101 - ( _atten * ((noSize - (z + loSize)) / loSize ) ) );
			
			_s_sb.b001 = Math.min( lob.b001 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
			                     , lob.b100 - ( _atten * (x / loSize ) ) );
		}
		else if ( Globals.POSZ == $faceFrom ) {
			
			_s_sb.b001 = Math.min( lob.b001 - ( _atten * ( y / loSize ) )
								 , lob.b001 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b011 = Math.min( lob.b011 - ( _atten * ((noSize - (y + loSize)) / loSize ) )
								 , lob.b011 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b111 = Math.max( lob.b111 - ( _atten * ((noSize - (x + loSize)) / loSize ) )
								 , lob.b111 - ( _atten * ((noSize - (y + loSize)) / loSize ) ) );
			
			_s_sb.b101 = Math.min( lob.b101 - ( _atten * ( y / loSize ) )
								 , lob.b101 - ( _atten * ((noSize - (x + loSize)) / loSize ) ) );
		}
		else if ( Globals.NEGZ == $faceFrom ) {
			_s_sb.b000 = Math.min( lob.b000 - ( _atten * ( y / loSize ) )
								 , lob.b000 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b010 = Math.min( lob.b010 - ( _atten * ((noSize - (y + loSize)) / loSize ) )
								 , lob.b010 - ( _atten * ( x / loSize ) ) );
								 
			_s_sb.b110 = Math.max( lob.b110 - ( _atten * ((noSize - (x + loSize)) / loSize ) )
								 , lob.b110 - ( _atten * ((noSize - (y + loSize)) / loSize ) ) );
			
			_s_sb.b100 = Math.min( lob.b100 - ( _atten * ( y / loSize ) )
								 , lob.b100 - ( _atten * ((noSize - (x + loSize)) / loSize ) ) );

		}
		Log.out( "Brightness.setFromSmallerOxel                     " + $no.toStringShort() + " brightness: " + _s_sb.toString() );		
		var faceOnly:Boolean = !$no.hasAlpha;
		return influenceAdd( _s_sb, $faceFrom, faceOnly, $no.gc.size() );
		//return rebuildFace( $faceFrom, _s_sb, $no );
	}
	*/
	/*
	// Brightness uses passed in value, which allows it to reuse a brightness
	public function subfaceGet( $face:int, $child:int, $nb:Brightness ):void {
		
		$nb.reset();
		var colors:Dictionary = _b000.colors();
		for (var lightID:String in colors )
		{
			var color:uint = colors[lightID];
			$nb.colorAdd( uint(lightID), color );
		}
		$nb.lastLightID = lastLightID;
		
		if ( Globals.POSX == $face ) {
			if ( 0 == $child ) {
				$nb.b100 = b100;
				$nb.b110 = (b110 + b100) / 2;
				$nb.b111 = (b111 + b100) / 2;
				$nb.b101 = (b101 + b100) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b100 = (b110 + b100) / 2;;
				$nb.b110 = b110;
				$nb.b111 = (b111 + b110) / 2;
				$nb.b101 = (b111 + b100) / 2;
			}
			else if ( 2 == $child )	{
				$nb.b100 = (b101 + b100) / 2;;
				$nb.b110 = (b111 + b100) / 2;
				$nb.b111 = (b111 + b101) / 2;
				$nb.b101 = b101;
			}
			else if ( 3 == $child )	{
				$nb.b100 = (b111 + b100) / 2;;
				$nb.b110 = (b111 + b110) / 2;
				$nb.b111 = b111;
				$nb.b101 = (b111 + b101) / 2;
			}
		}
		else if ( Globals.NEGX == $face ) {
			if ( 0 == $child ) {
				$nb.b000 = b000;
				$nb.b010 = (b010 + b000) / 2;
				$nb.b011 = (b011 + b000) / 2;
				$nb.b001 = (b001 + b000) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b000 = (b010 + b000) / 2;;
				$nb.b010 = b010;
				$nb.b011 = (b011 + b010) / 2;
				$nb.b001 = (b011 + b000) / 2;
			}
			else if ( 2 == $child )	{
				$nb.b000 = (b001 + b000) / 2;;
				$nb.b010 = (b011 + b000) / 2;
				$nb.b011 = (b011 + b001) / 2;
				$nb.b001 = b001;
			}
			else if ( 3 == $child )	{
				$nb.b000 = (b011 + b000) / 2;;
				$nb.b010 = (b011 + b010) / 2;
				$nb.b011 = b011;
				$nb.b001 = (b011 + b001) / 2;
			}
		}		
		else if ( Globals.POSY == $face ) {
			if ( 0 == $child ) {
				$nb.b010 = b010;
				$nb.b110 = (b110 + b010) / 2;
				$nb.b111 = (b111 + b010) / 2;
				$nb.b011 = (b011 + b010) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b010 = (b110 + b010) / 2;;
				$nb.b110 = b110;
				$nb.b111 = (b111 + b110) / 2;
				$nb.b011 = (b111 + b010) / 2;
			}
			else if ( 2 == $child )	{
				$nb.b010 = (b011 + b010) / 2;;
				$nb.b110 = (b111 + b010) / 2;
				$nb.b111 = (b111 + b011) / 2;
				$nb.b011 = b011;
			}
			else if ( 3 == $child )	{
				$nb.b010 = (b111 + b010) / 2;;
				$nb.b110 = (b111 + b110) / 2;
				$nb.b111 = b111;
				$nb.b011 = (b111 + b011) / 2;
			}
		}				
		else if ( Globals.NEGY == $face ) {
			if ( 0 == $child ) {
				$nb.b000 = b000;
				$nb.b100 = (b100 + b000) / 2;
				$nb.b101 = (b101 + b000) / 2;
				$nb.b001 = (b001 + b000) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b000 = (b100 + b000) / 2;;
				$nb.b100 = b100;
				$nb.b101 = (b101 + b100) / 2;
				$nb.b001 = (b101 + b000) / 2;
			}
			else if ( 2 == $child )	{
				$nb.b000 = (b001 + b000) / 2;;
				$nb.b100 = (b101 + b000) / 2;
				$nb.b101 = (b101 + b001) / 2;
				$nb.b001 = b001;
			}
			else if ( 3 == $child )	{
				$nb.b000 = (b101 + b000) / 2;;
				$nb.b100 = (b101 + b100) / 2;
				$nb.b101 = b101;
				$nb.b001 = (b101 + b001) / 2;
			}
		}				
		else if ( Globals.POSZ == $face ) {
			if ( 0 == $child ) {
				$nb.b001 = b001;
				$nb.b011 = (b011 + b001) / 2;
				$nb.b111 = (b111 + b001) / 2;
				$nb.b101 = (b101 + b001) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b001 = (b101 + b001) / 2;
				$nb.b011 = (b111 + b001) / 2;
				$nb.b111 = (b111 + b101) / 2;
				$nb.b101 = b101;
			}
			else if ( 2 == $child )	{
				$nb.b001 = (b011 + b001) / 2;
				$nb.b011 = b011;
				$nb.b111 = (b111 + b011) / 2;
				$nb.b101 = (b111 + b001) / 2;
			}
			else if ( 3 == $child )	{
				$nb.b001 = (b111 + b001) / 2;
				$nb.b011 = (b111 + b011) / 2;
				$nb.b111 = b111;
				$nb.b101 = (b111 + b101) / 2;
			}
		}				
		else if ( Globals.NEGZ == $face ) {
			if ( 0 == $child ) {
				$nb.b000 = b000;
				$nb.b010 = (b010 + b000) / 2;
				$nb.b110 = (b110 + b000) / 2;
				$nb.b100 = (b100 + b000) / 2;
			}
			else if ( 1 == $child )	{
				$nb.b000 = (b100 + b000) / 2;
				$nb.b010 = (b110 - b000) / 2;
				$nb.b110 = (b110 - b100) / 2;
				$nb.b100 = b100;
			}
			else if ( 2 == $child )	{
				$nb.b000 = (b010 + b000) / 2;
				$nb.b010 = b010;
				$nb.b110 = (b110 + b010) / 2;
				$nb.b100 = (b110 + b000) / 2;
			}
			else if ( 3 == $child )	{
				$nb.b000 = (b110 + b000) / 2;
				$nb.b010 = (b110 + b010) / 2;
				$nb.b110 = b110;
				$nb.b100 = (b110 + b100) / 2;
			}
		}				
		else	
			Log.out( "Brightness.subfaceGet: ERROR child index: " + $child );
	}
	*/
	
} // end of class FlowInfo
} // end of package
