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

	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.utils.ColorUtils;
	
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
	//public static const DEFAULT_ATTEN:uint = 0x11; // out of 255 - VERY DARK
	public static const DEFAULT_ATTEN:uint = 0x33; // out of 255
	//public static const DEFAULT_ATTEN:uint = 0xff; // out of 255
	public static const DEFAULT_PER_DISTANCE:int = 16;
	public static const DEFAULT_COLOR:uint = 0x00ffffff;

	static public const B000:uint = 0;
	static public const B001:uint = 1;
	static public const B100:uint = 2;
	static public const B101:uint = 3;
	static public const B010:uint = 4;
	static public const B011:uint = 5;
	static public const B110:uint = 6;
	static public const B111:uint = 7;
	
	static private var _s_sb:Brightness = new Brightness(); // scratchBrightness
	static public function scratch():Brightness { return _s_sb; }
	static public const FIXED_ID:uint = 1;

	private var _composite:uint;

	private var _lastLightID:uint;
	public function get lastLightID():uint { return _lastLightID; }
	public function set lastLightID(value:uint):void { _lastLightID = value; }
	
	private var _atten:uint = DEFAULT_ATTEN;  // down 1 per meter
	public function get atten():uint { return _atten; }
	public function set atten( val:uint ):void { _atten = val; }
	
	//private function rnd( $val:uint ):uint { return int($val * 100) / 100; }
	
	public function Brightness():void {
		lastLightID = DEFAULT_ID;
		lightAdd( DEFAULT_ID, DEFAULT_COLOR );
	}
	
	public function toByteArray( $ba:ByteArray ):ByteArray {
		throw new Error( "Brightness.toByteArray - NOT IMPLEMENTED" );
		/*
		Log.out( "Brightness.toByteArray - This does not take into account color data", Log.ERROR );
		$ba.writeInt( rnd( b000 ) );
		$ba.writeInt( rnd( b001 ) );
		$ba.writeInt( rnd( b100 ) );
		$ba.writeInt( rnd( b101 ) );
		$ba.writeInt( rnd( b010 ) );
		$ba.writeInt( rnd( b011 ) );
		$ba.writeInt( rnd( b110 ) );
		$ba.writeInt( rnd( b111 ) );
		*/
		return $ba;
		
	}
	
	public function fromByteArray( $ba:ByteArray ):ByteArray {
		throw new Error( "Brightness.fromByteArray - NOT IMPLEMENTED" );
		/*
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
		*/
		return $ba;
	}

	public function toString():String {
		
		var outputString:String = "";
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li ) {
				outputString += "light: " + i + "  " + li.toString();
			}
		}
		return outputString;
	}
	
	
	public function copyFrom( $b:Brightness ):void {
		
		// Copy all of the light data from the passed in Brightness
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var bli:LightInfo = $b._lights[i];
			if ( null != bli )
				_lights[i].copyFrom( bli );
			else 
				_lights[i] = null;
		}
	}
	
	public function setAll( $ID:uint, $attn:uint ):void	{
		
		var li:LightInfo =  lightGet( $ID );
		
		if ( null == li )
			throw new Error( "Brightness.setAll - light not defined" );
			
		if ( Brightness.MAX < $attn )
			throw new Error( "Brightness.setAll - attn too high" );

		li.setAll( $attn );
	}
	
	public function valuesHas():Boolean	{

		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li )
				if ( DEFAULT_ATTEN + DEFAULT_SIGMA < li.avg )
					return true
		}
		
		return false;
	}
	
	public function reset():void {
		
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li )
				li.setAll( DEFAULT_ATTEN );
		}

		_lastLightID = DEFAULT_ID;
		_atten = DEFAULT_ATTEN;
	}

	public function childAdd( $childID:uint, $b:Brightness, $grainUnits:uint ):void {	

		// This is special case which needs to take into account atten
		var localAtten:uint = _atten * $grainUnits/DEFAULT_PER_DISTANCE
		var sqrAtten:Number =  Math.sqrt( 2 * (localAtten * localAtten) );
		var csqrAtten:Number =  Math.sqrt( (localAtten * localAtten) + (sqrAtten * sqrAtten) );
		
		if ( !lightHas( $b.lastLightID ) )
			lightAdd( $b.lastLightID, $b.lightGet( $b.lastLightID ).color );
		
		if ( lastLightID != $b.lastLightID )
			lastLightID = $b.lastLightID;
		
		var li:LightInfo =  lightGet( $b.lastLightID );		
		var bli:LightInfo =  $b.lightGet( $b.lastLightID );		
		if ( null == li )
			throw new Error( "Brightness.childAdd - light not defined" );
		
		// The corner that the child is in is always the most accurate data, everything else is a guess
		if ( 0 == $childID ) {
			li.b000 = bli.b000;
			if ( li.b001 < bli.b001 - localAtten )  li.b001 = bli.b001 - localAtten;
			if ( li.b100 < bli.b100 - localAtten )  li.b100 = bli.b100 - localAtten;
			if ( li.b101 < bli.b101 - sqrAtten )  	li.b101 = bli.b101 - sqrAtten;
			
			if ( li.b010 < bli.b010 - localAtten )  li.b010 = bli.b010 - localAtten;
			if ( li.b011 < bli.b011 - sqrAtten )  	li.b011 = bli.b011 - sqrAtten;
			if ( li.b110 < bli.b110 - sqrAtten )  	li.b110 = bli.b110 - sqrAtten;
			if ( li.b111 < bli.b111 - csqrAtten )  	li.b111 = bli.b111 - csqrAtten;
		}
		else if ( 1 == $childID ) {
			if ( li.b000 < bli.b000 - localAtten )  li.b000 = bli.b000 - localAtten;
			if ( li.b001 < bli.b001 - sqrAtten )  	li.b001 = bli.b001 - sqrAtten;
			li.b100 = bli.b100;
			if ( li.b101 < bli.b101 - localAtten )  li.b101 = bli.b101 - localAtten;
			       
			if ( li.b010 < bli.b010 - sqrAtten )  	li.b010 = bli.b010 - sqrAtten;
			if ( li.b011 < bli.b011 - csqrAtten )  	li.b011 = bli.b011 - csqrAtten;
			if ( li.b110 < bli.b110 - localAtten )  li.b110 = bli.b110 - localAtten;
			if ( li.b111 < bli.b111 - sqrAtten )  	li.b111 = bli.b111 - sqrAtten;
		}
		else if ( 2 == $childID ) {
			if ( li.b000 < bli.b000 - localAtten )  li.b000 = bli.b000 - localAtten;
			if ( li.b001 < bli.b001 - sqrAtten )  	li.b001 = bli.b001 - sqrAtten;
			if ( li.b100 < bli.b100 - sqrAtten )  	li.b100 = bli.b100 - sqrAtten;
			if ( li.b101 < bli.b101 - csqrAtten )  	li.b101 = bli.b101 - csqrAtten;
			       
			li.b010 = bli.b010;
			if ( li.b011 < bli.b011 - localAtten )  li.b011 = bli.b011 - localAtten;
			if ( li.b110 < bli.b110 - localAtten )  li.b110 = bli.b110 - localAtten;
			if ( li.b111 < bli.b111 - sqrAtten )  	li.b111 = bli.b111 - sqrAtten;
		}
		else if ( 3 == $childID ) {
			if ( li.b000 < bli.b000 - sqrAtten )  	li.b000 = bli.b000 - sqrAtten;
			if ( li.b001 < bli.b001 - csqrAtten )  	li.b001 = bli.b001 - csqrAtten;
			if ( li.b100 < bli.b100 - localAtten )  li.b100 = bli.b100 - localAtten;
			if ( li.b101 < bli.b101 - sqrAtten )  	li.b101 = bli.b101 - sqrAtten;
			       
			if ( li.b010 < bli.b010 - localAtten )  li.b010 = bli.b010 - localAtten;
			if ( li.b011 < bli.b011 - sqrAtten )  	li.b011 = bli.b011 - sqrAtten;
			li.b110 = bli.b110;
			if ( li.b111 < bli.b111 - localAtten )  li.b111 = bli.b111 - localAtten;
		}
		else if ( 4 == $childID ) {
			if ( li.b000 < bli.b000 - localAtten )  li.b000 = bli.b000 - localAtten;
			li.b001 = bli.b001;
			if ( li.b100 < bli.b100 - sqrAtten )  	li.b100 = bli.b100 - sqrAtten;
			if ( li.b101 < bli.b101 - localAtten )  li.b101 = bli.b101 - localAtten;
			       
			if ( li.b010 < bli.b010 - sqrAtten )  	li.b010 = bli.b010 - sqrAtten;
			if ( li.b011 < bli.b011 - localAtten )  li.b011 = bli.b011 - localAtten;
			if ( li.b110 < bli.b110 - csqrAtten )  	li.b110 = bli.b110 - csqrAtten;
			if ( li.b111 < bli.b111 - sqrAtten )  	li.b111 = bli.b111 - sqrAtten;
		}
		else if ( 5 == $childID ) {
			if ( li.b000 < bli.b000 - sqrAtten )  	li.b000 = bli.b000 - sqrAtten;
			if ( li.b001 < bli.b001 - localAtten )  li.b001 = bli.b001 - localAtten;
			if ( li.b100 < bli.b100 - csqrAtten )  	li.b100 = bli.b100 - localAtten;
			li.b101 = bli.b101;
			       
			if ( li.b010 < bli.b010 - csqrAtten )  	li.b010 = bli.b010 - csqrAtten;
			if ( li.b011 < bli.b011 - sqrAtten )  	li.b011 = bli.b011 - sqrAtten;
			if ( li.b110 < bli.b110 - sqrAtten )  	li.b110 = bli.b110 - sqrAtten;
			if ( li.b111 < bli.b111 - localAtten )  li.b111 = bli.b111 - localAtten;
		}
		else if ( 6 == $childID ) {
			if ( li.b000 < bli.b000 - sqrAtten )  	li.b000 = bli.b000 - sqrAtten;
			if ( li.b001 < bli.b001 - localAtten )  li.b001 = bli.b001 - localAtten;
			if ( li.b100 < bli.b100 - csqrAtten )  	li.b100 = bli.b100 - csqrAtten;
			if ( li.b101 < bli.b101 - sqrAtten )  	li.b101 = bli.b101 - sqrAtten;
			       
			if ( li.b010 < bli.b010 - localAtten )  li.b010 = bli.b010 - localAtten;
			li.b011 = bli.b011;
			if ( li.b110 < bli.b110 - sqrAtten )  	li.b110 = bli.b110 - sqrAtten;
			if ( li.b111 < bli.b111 - localAtten )  li.b111 = bli.b111 - localAtten;
		}
		else if ( 7 == $childID ) {
			if ( li.b000 < bli.b000 - csqrAtten )  	li.b000 = bli.b000 - csqrAtten;
			if ( li.b001 < bli.b001 - sqrAtten )  	li.b001 = bli.b001 - sqrAtten;
			if ( li.b100 < bli.b100 - sqrAtten )  	li.b100 = bli.b100 - sqrAtten;
			if ( li.b101 < bli.b101 - localAtten )  li.b101 = bli.b101 - localAtten;
			       
			if ( li.b010 < bli.b010 - sqrAtten )  	li.b010 = bli.b010 - sqrAtten;
			if ( li.b011 < bli.b011 - localAtten )  li.b011 = bli.b011 - localAtten;
			if ( li.b110 < bli.b110 - localAtten )  li.b110 = bli.b110 - localAtten;
			li.b111 = bli.b111;
		}
	}
	
	// creates a virtual brightness(light) the light from a parent to a child brightness
	public function childGet( $childID:int, $nb:Brightness ):void {
		
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var li:LightInfo = _lights[i];
			if ( null != li )
			{
				if ( !$nb.lightHas( li.ID ) )
					$nb.lightAdd( li.ID, li.color );
				var bli:LightInfo = $nb.lightGet( li.ID );
				if ( null == bli )
					throw new Error( "Brightness.childGet - $nb does not have light info for lightID: " + li.ID )
				
				// I think the diagonals should be averaged between both corners
				if ( 0 == $childID ) { // b000
					bli.b000 = li.b000;
					bli.b001 = ( li.b001 + li.b000) / 2;
					bli.b010 = ( li.b010 + li.b000) / 2;				// average edge for edge points
					bli.b011 = ( li.b011 + li.b001 + li.b010 + li.b000) / 4; // average of all four on face for points on face
					bli.b100 = ( li.b100 + li.b000) / 2;
					bli.b101 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
					bli.b110 = ( li.b110 + li.b100 + li.b000 + li.b010) / 4;
					bli.b111 = li.avg; 							// average of all eight for center points
				}
				else if ( 1 == $childID )	{ // b100
					bli.b000 = ( li.b000 + li.b100) / 2;
					bli.b001 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
					bli.b010 = ( li.b000 + li.b100 + li.b010 + li.b110) / 4;
					bli.b011 = li.avg;
					bli.b100 = li.b100;
					bli.b101 = ( li.b101 + li.b100) / 2;
					bli.b110 = ( li.b100 + li.b110) / 2;
					bli.b111 = ( li.b100 + li.b110 + li.b101 + li.b111) / 4;
				}
				else if ( 2 == $childID )	{ // b010
					bli.b000 = ( li.b000 + li.b010) / 2;
					bli.b001 = ( li.b000 + li.b010 + li.b001 + li.b011) / 4;
					bli.b010 = li.b010;
					bli.b011 = ( li.b011 + li.b010) / 2;
					bli.b100 = ( li.b000 + li.b010 + li.b100 + li.b110) / 4;
					bli.b101 = li.avg;
					bli.b110 = ( li.b110 + li.b010) / 2;
					bli.b111 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
				}
				else if ( 3 == $childID ) { // b110
					bli.b000 = ( li.b000 + li.b010 + li.b110 + li.b100 ) / 4;
					bli.b001 = li.avg;
					bli.b010 = ( li.b010 + li.b110) / 2;
					bli.b011 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
					bli.b100 = ( li.b100 + li.b110) / 2;
					bli.b101 = ( li.b100 + li.b110 + li.b111 + li.b101 ) / 4;
					bli.b110 = li.b110;
					bli.b111 = ( li.b111 + li.b110) / 2;
				}
				else if ( 4 == $childID )	{ // b001
					bli.b000 = ( li.b000 + li.b001) / 2;
					bli.b001 = li.b001;
					bli.b010 = ( li.b000 + li.b010 + li.b001 + li.b011) / 4;
					bli.b011 = ( li.b011 + li.b001) / 2;
					bli.b100 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
					bli.b101 = ( li.b101 + li.b001) / 2;
					bli.b110 = li.avg;
					bli.b111 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
				}
				else if ( 5 == $childID )	{ // b101
					bli.b000 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
					bli.b001 = ( li.b001 + li.b101) / 2;
					bli.b010 = li.avg;
					bli.b011 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
					bli.b100 = ( li.b100 + li.b101) / 2;
					bli.b101 = li.b101;
					bli.b110 = ( li.b100 + li.b110 + li.b101 + li.b111) / 4;
					bli.b111 = ( li.b111 + li.b101) / 2;
				}
				else if ( 6 == $childID )	{ // b011
					bli.b000 = ( li.b000 + li.b010 + li.b011 + li.b001) / 4;
					bli.b001 = ( li.b001 + li.b011) / 2;
					bli.b010 = ( li.b010 + li.b011) / 2;
					bli.b011 = li.b011;
					bli.b100 = li.avg;
					bli.b101 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
					bli.b110 = ( li.b010 + li.b011 + li.b110 + li.b111) / 4;
					bli.b111 = ( li.b111 + li.b011) / 2;
				}
				else if ( 7 == $childID )	{ // b111
					bli.b000 = li.avg;
					bli.b001 = ( li.b001 + li.b011 + li.b101 + li.b111 ) / 4;
					bli.b010 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
					bli.b011 = ( li.b011 + li.b111) / 2;
					bli.b100 = ( li.b100 + li.b110 + li.b101 + li.b111 ) / 4;
					bli.b101 = ( li.b101 + li.b111) / 2;
					bli.b110 = ( li.b110 + li.b111) / 2;
					bli.b111 = li.b111;
				}					
			}
		}
	}
/*
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
*/
	private function avg( $ID:uint ):uint {
		
		var li:LightInfo = lightGet( $ID );
		return (li.b000 + li.b010 + li.b011 + li.b001 + li.b100 + li.b110 +  li.b111 + li.b101)/8
	}

	// New TAG
	public function lightGet( $ID:uint ):LightInfo {
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var lightInfo:LightInfo = _lights[i];
			if ( null != lightInfo ) {
				if ( $ID == lightInfo.ID ) {
					return lightInfo;
				}
			}
		}
		return null;
	}
	
	// New TAG
	private var _lights:Vector.<LightInfo> = new Vector.<LightInfo>(4, true);
	static private const LIGHTS_MAX:int = 4;
	private var _lightCount:int;
	public function lightHas( $ID:uint ):Boolean {
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var lightInfo:LightInfo = _lights[i];
			if ( null != lightInfo ) {
				if ( $ID == lightInfo.ID )
					return true;
			}
		}
		return false;
	}
	
	// New TAG
	public function lightAdd( $ID:uint, $color:uint, $isLight:Boolean = false ):void {
		
		if ( lightHas( $ID ) )
			return;
		
		if ( _lightCount < LIGHTS_MAX ) {
			
			for ( var i:int; i < LIGHTS_MAX; i++ ) {
				if ( null == _lights[i] ) {
					_lights[i] = new LightInfo( $ID, $color );	
					if ( true == $isLight )
						_lights[i].setAll( 255 );
					_lightCount++;
					break;
				}
			}
		}
		else {
			Log.out( "Brightness.lightAdd - NEED TO WRITE LIGHT EVAL AND REPLACEMENT WITH BRIGHTEST LIGHT CODE HERE", Log.ERROR );
		}
	}
	
	// New TAG
	public function lightRemove( $ID:uint ):void {
		
		if ( !lightHas( $ID ) )
			return;
		
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var lightInfo:LightInfo = _lights[i];
			if ( null != lightInfo ) {
				if ( $ID == lightInfo.ID ) {
					_lights[i] = null;
					_lightCount--;
					break;
				}
			}
		}
	}
	
	// New TAG
	public function lightFullBright():void {
		
		var li:LightInfo = lightGet( Brightness.DEFAULT_ID );
		li.setAll( 255 );
	}
	
	public function influenceAdd( $lob:Brightness, $faceFrom:int, $faceOnly:Boolean, $grainUnits:int ):Boolean
	{
		var c:Boolean = false;
		
		var bli:LightInfo = $lob.lightGet( $lob.lastLightID );
		if ( !lightHas( $lob.lastLightID ) )
			lightAdd( bli.ID, bli.color );
		var li:LightInfo = lightGet( $lob.lastLightID );
		if ( null == li )
			throw new Error( "Brightness.influenceAdd - lightInfo not found" );
		
		lastLightID = $lob.lastLightID;
		
		const attenScaled:uint = _atten * ($grainUnits/16);
		if ( Globals.POSX == $faceFrom ) {
			
			if ( li.b000 < bli.b100 ) { li.b000 = bli.b100; c = true; }
			if ( li.b010 < bli.b110 ) { li.b010 = bli.b110; c = true; }
			if ( li.b011 < bli.b111 ) { li.b011 = bli.b111; c = true; }
			if ( li.b001 < bli.b101 ) { li.b001 = bli.b101; c = true; }
		}
		else if ( Globals.NEGX == $faceFrom ) {

			if ( li.b100 < bli.b000 ) { li.b100 = bli.b000; c = true; }
			if ( li.b110 < bli.b010 ) { li.b110 = bli.b010; c = true; }
			if ( li.b111 < bli.b011 ) { li.b111 = bli.b011; c = true; }
			if ( li.b101 < bli.b001 ) { li.b101 = bli.b001; c = true; }
		}
		else if ( Globals.POSY == $faceFrom ) {

			if ( li.b000 < bli.b010 ) { li.b000 = bli.b010; c = true; }
			if ( li.b100 < bli.b110 ) { li.b100 = bli.b110; c = true; }
			if ( li.b101 < bli.b111 ) { li.b101 = bli.b111; c = true; }
			if ( li.b001 < bli.b011 ) { li.b001 = bli.b011; c = true; }
		}
		else if ( Globals.NEGY == $faceFrom ) {

			if ( li.b010 < bli.b000 ) { li.b010 = bli.b000; c = true; }
			if ( li.b110 < bli.b100 ) { li.b110 = bli.b100; c = true; }
			if ( li.b111 < bli.b101 ) { li.b111 = bli.b101; c = true; }
			if ( li.b011 < bli.b001 ) { li.b011 = bli.b001; c = true; }
		}
		else if ( Globals.POSZ == $faceFrom ) {

			if ( li.b000 < bli.b001 ) { li.b000 = bli.b001; c = true; }
			if ( li.b010 < bli.b011 ) { li.b010 = bli.b011; c = true; }
			if ( li.b110 < bli.b111 ) { li.b110 = bli.b111; c = true; }
			if ( li.b100 < bli.b101 ) { li.b100 = bli.b101; c = true; }
		}
		else if ( Globals.NEGZ == $faceFrom ) {
			
			if ( li.b001 < bli.b000 ) { li.b001 = bli.b000; c = true; }
			if ( li.b011 < bli.b010 ) { li.b011 = bli.b010; c = true; }
			if ( li.b111 < bli.b110 ) { li.b111 = bli.b110; c = true; }
			if ( li.b101 < bli.b100 ) { li.b101 = bli.b100; c = true; }
		}
		
		//if ( !$faceOnly && max - attenScaled > avg ) {
		if ( !$faceOnly ) {
			var result:Boolean = balanceAttn( lastLightID, attenScaled );
			c = c || result;
		}
		
		return c;
	}

	public function balanceAttn( $ID:uint, $attenScaled:uint ):Boolean {
		var c:Boolean = false;
		const li:LightInfo = lightGet( $ID );
		const sqAtten:Number = Math.sqrt( 2 * ($attenScaled * $attenScaled) );
		const qrAtten:Number = Math.sqrt( 3 * ($attenScaled * $attenScaled) );
		// Do this for each adject vertice
		if ( li.b000 > li.b001 + $attenScaled ) { li.b001 = li.b000 - $attenScaled; c = true; }
		if ( li.b000 > li.b010 + $attenScaled ) { li.b010 = li.b000 - $attenScaled; c = true; }
		if ( li.b000 > li.b011 + sqAtten ) 	  	{ li.b011 = li.b000 - sqAtten; c = true; }
		if ( li.b000 > li.b100 + $attenScaled ) { li.b100 = li.b000 - $attenScaled; c = true; }
		if ( li.b000 > li.b101 + sqAtten ) 	  	{ li.b101 = li.b000 - sqAtten; c = true; }
		if ( li.b000 > li.b110 + sqAtten ) 	  	{ li.b110 = li.b000 - sqAtten; c = true; }
		if ( li.b000 > li.b111 + qrAtten ) 	  	{ li.b111 = li.b000 - qrAtten; c = true; }
		
		if ( li.b001 > li.b000 + $attenScaled ) { li.b000 = li.b001 - $attenScaled; c = true; }
		if ( li.b001 > li.b010 + sqAtten ) 	  	{ li.b010 = li.b001 - sqAtten; c = true; }
		if ( li.b001 > li.b011 + $attenScaled ) { li.b011 = li.b001 - $attenScaled; c = true; }
		if ( li.b001 > li.b100 + sqAtten ) 	  	{ li.b100 = li.b001 - sqAtten; c = true; }
		if ( li.b001 > li.b101 + $attenScaled ) { li.b101 = li.b001 - $attenScaled; c = true; }
		if ( li.b000 > li.b110 + qrAtten ) 	  	{ li.b110 = li.b001 - qrAtten; c = true; }
		if ( li.b001 > li.b111 + sqAtten ) 	  	{ li.b111 = li.b001 - sqAtten; c = true; }
		
		if ( li.b010 > li.b000 + $attenScaled ) { li.b000 = li.b010 - $attenScaled; c = true; }
		if ( li.b010 > li.b001 + sqAtten ) 	  	{ li.b001 = li.b010 - sqAtten; c = true; }
		if ( li.b010 > li.b011 + $attenScaled ) { li.b011 = li.b010 - $attenScaled; c = true; }
		if ( li.b010 > li.b100 + sqAtten ) 	  	{ li.b100 = li.b010 - sqAtten; c = true; }
		if ( li.b010 > li.b101 + qrAtten ) 	  	{ li.b101 = li.b010 - qrAtten; c = true; }
		if ( li.b010 > li.b110 + $attenScaled ) { li.b110 = li.b010 - $attenScaled; c = true; }
		if ( li.b010 > li.b111 + sqAtten ) 	  	{ li.b111 = li.b010 - sqAtten; c = true; }
		
		if ( li.b011 > li.b000 + sqAtten ) 	  	{ li.b000 = li.b011 - sqAtten; c = true; }
		if ( li.b011 > li.b001 + $attenScaled ) { li.b001 = li.b011 - $attenScaled; c = true; }
		if ( li.b011 > li.b010 + $attenScaled ) { li.b010 = li.b011 - $attenScaled; c = true; }
		if ( li.b011 > li.b100 + qrAtten )      { li.b100 = li.b011 - qrAtten; c = true; }
		if ( li.b011 > li.b101 + sqAtten )      { li.b101 = li.b011 - sqAtten; c = true; }
		if ( li.b011 > li.b110 + sqAtten )      { li.b110 = li.b011 - sqAtten; c = true; }
		if ( li.b011 > li.b111 + $attenScaled ) { li.b111 = li.b011 - $attenScaled; c = true; }

		if ( li.b100 > li.b000 + $attenScaled ) { li.b000 = li.b100 - $attenScaled; c = true; }
		if ( li.b100 > li.b001 + sqAtten ) 	  	{ li.b001 = li.b100 - sqAtten; c = true; }
		if ( li.b100 > li.b010 + sqAtten ) 	  	{ li.b010 = li.b100 - sqAtten; c = true; }
		if ( li.b100 > li.b011 + qrAtten ) 	  	{ li.b011 = li.b100 - qrAtten; c = true; }
		if ( li.b100 > li.b101 + $attenScaled ) { li.b101 = li.b100 - $attenScaled; c = true; }
		if ( li.b100 > li.b110 + $attenScaled ) { li.b110 = li.b100 - $attenScaled; c = true; }
		if ( li.b100 > li.b111 + sqAtten ) 	  	{ li.b111 = li.b100 - sqAtten; c = true; }
		
		if ( li.b101 > li.b000 + sqAtten ) 	  	{ li.b000 = li.b101 - sqAtten; c = true; }
		if ( li.b101 > li.b001 + $attenScaled ) { li.b001 = li.b101 - $attenScaled; c = true; }
		if ( li.b101 > li.b010 + qrAtten ) 	  	{ li.b010 = li.b101 - qrAtten; c = true; }
		if ( li.b101 > li.b011 + sqAtten ) 	  	{ li.b011 = li.b101 - sqAtten; c = true; }
		if ( li.b101 > li.b100 + $attenScaled ) { li.b100 = li.b101 - $attenScaled; c = true; }
		if ( li.b101 > li.b110 + sqAtten ) 	  	{ li.b110 = li.b101 - sqAtten; c = true; }
		if ( li.b101 > li.b111 + $attenScaled ) { li.b111 = li.b101 - $attenScaled; c = true; }
		
		if ( li.b110 > li.b000 + sqAtten )	  	{ li.b000 = li.b110 - sqAtten; c = true; }
		if ( li.b110 > li.b001 + qrAtten )	  	{ li.b001 = li.b110 - qrAtten; c = true; }
		if ( li.b110 > li.b010 + $attenScaled ) { li.b010 = li.b110 - $attenScaled; c = true; }
		if ( li.b110 > li.b011 + sqAtten )	  	{ li.b011 = li.b110 - sqAtten; c = true; }
		if ( li.b110 > li.b100 + $attenScaled ) { li.b100 = li.b110 - $attenScaled; c = true; }
		if ( li.b110 > li.b101 + sqAtten )	  	{ li.b101 = li.b110 - sqAtten; c = true; }
		if ( li.b110 > li.b111 + $attenScaled ) { li.b111 = li.b110 - $attenScaled; c = true; }

		if ( li.b111 > li.b000 + qrAtten ) 	  	{ li.b000 = li.b111 - qrAtten; c = true; }
		if ( li.b111 > li.b001 + sqAtten ) 	  	{ li.b001 = li.b111 - sqAtten; c = true; }
		if ( li.b111 > li.b010 + sqAtten ) 	  	{ li.b010 = li.b111 - sqAtten; c = true; }
		if ( li.b111 > li.b011 + $attenScaled ) { li.b011 = li.b111 - $attenScaled; c = true; }
		if ( li.b111 > li.b100 + sqAtten ) 	  	{ li.b100 = li.b111 - sqAtten; c = true; }
		if ( li.b111 > li.b101 + $attenScaled ) { li.b101 = li.b111 - $attenScaled; c = true; }
		if ( li.b111 > li.b110 + $attenScaled ) { li.b110 = li.b111 - $attenScaled; c = true; }

		return c;
	}
	
	// Add the influcence of a virtual cube the same size
	public function brightnessMerge( $b:Brightness ):Boolean {
		
		var bli:LightInfo = $b.lightGet( $b.lastLightID );
		if ( !lightHas( $b.lastLightID ) )
			lightAdd( bli.ID, bli.color );
		var li:LightInfo = lightGet( $b.lastLightID );
		if ( null == li )
			throw new Error( "Brightness.brightnessMerge  - lightInfo not found" );
		
		var c:Boolean;
		if ( li.b000 < bli.b000 )	  { li.b000 = bli.b000; c = true; }
		if ( li.b001 < bli.b001 )	  { li.b001 = bli.b001; c = true; }
		if ( li.b010 < bli.b010 )	  { li.b010 = bli.b010; c = true; }
		if ( li.b011 < bli.b011 )	  { li.b011 = bli.b011; c = true; }
		if ( li.b100 < bli.b100 )	  { li.b100 = bli.b100; c = true; }
		if ( li.b101 < bli.b101 )	  { li.b101 = bli.b101; c = true; }
		if ( li.b110 < bli.b110 )	  { li.b110 = bli.b110; c = true; }
		if ( li.b111 < bli.b111 )	  { li.b111 = bli.b111; c = true; }
		return c;
	}
	
	// this returns a composite color made of default color plus any additional colors
	public function lightGetComposite( $vertex:uint ):uint {
		_composite = 0;
		
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var li:LightInfo = _lights[i];
			if ( null != li )
				_composite = ColorUtils.testCombineARGB( _composite, li.color, li.vertexInfoGet( $vertex ) );
		}
		
		return _composite;
	}
	
	
} // end of class Brightness
} // end of package
