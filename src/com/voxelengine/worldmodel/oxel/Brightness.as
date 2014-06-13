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
	public static const MAX_LIGHT_LEVEL:uint = 0xff;
	public static const DEFAULT_LIGHT_ID:uint = 1;
	
	private static const DEFAULT_PER_DISTANCE:int = 16;
	private static const DEFAULT_COLOR:uint = 0x00ffffff;
	private static const DEFAULT_BASE_LIGHT_LEVEL:uint = 0x37; // out of 255
	private static const DEFAULT_FALL_OFF_PER_METER:uint = 0x32; // how much attn per unit meter
	private static const DEFAULT_SIGMA:uint = 2;
	private static const DEFAULT_LIGHT_LEVEL_SETTER:uint = 0x37373737;

	static public const B000:uint = 0;
	static public const B001:uint = 1;
	static public const B100:uint = 2;
	static public const B101:uint = 3;
	static public const B010:uint = 4;
	static public const B011:uint = 5;
	static public const B110:uint = 6;
	static public const B111:uint = 7;
	
	// Just a convience value to prevent the recalculation of the color values unless needed
	private var _compositeColor:uint;

	 // default attenuation per meter, TODO, to be used per meter.
	private var _fallOffPerMeter:uint = DEFAULT_FALL_OFF_PER_METER; 
	public function get fallOffPerMeter():uint { return _fallOffPerMeter; }
	public function set fallOffPerMeter( val:uint ):void { _fallOffPerMeter = val; }
	
	static private const LIGHTS_MAX:int = 4;
	private var _lights:Vector.<LightInfo> = new Vector.<LightInfo>(4, true);
	private var _lightCount:int;
	
	//private function rnd( $val:uint ):uint { return int($val * 100) / 100; }
	
	public function Brightness():void {
		lightAdd( DEFAULT_LIGHT_ID, DEFAULT_COLOR, DEFAULT_BASE_LIGHT_LEVEL );
	}
	
	public function toByteArray( $ba:ByteArray ):ByteArray {

		// calculate how many lights this oxel is influcence by
		var lightCount:uint;
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			if ( null != _lights[i] )
				lightCount++;
		}
		// now write the count of lights to the byte array
		$ba.writeByte( lightCount );

		// now for each light, write its contents to the byte array
		for ( var j:int; j < LIGHTS_MAX; j++ ) {
			var li:LightInfo = _lights[j];
			if ( null != li ) {
				$ba = li.toByteArray( $ba );
			}
		}
		return $ba;
	}
	
	public function fromByteArray( $version:String, $ba:ByteArray ):ByteArray {
		if ( Globals.VERSION_001 == $version ) {
			// Old style, Just throw away this information.
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();
			$ba.readInt();			
		}
		else {
			// How many light do I need to read?
			var lightCount:int = $ba.readByte();
			// Now read each light
			for ( var i:int = 0; i < lightCount; i++ ) {
				_lights[i] = new LightInfo(0, 0, DEFAULT_LIGHT_LEVEL_SETTER, false );
				_lights[i].fromByteArray( $ba );
			}
		}
		return $ba;
	}

	public function toString():String {
		var outputString:String = "";
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li ) {
				outputString += "\tlight: " + i + "  " + li.toString();
			}
		}
		return outputString;
	}
	
	public function copyFrom( $b:Brightness ):void {
		
		// Copy all of the light data from the passed in Brightness
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var sli:LightInfo = $b._lights[i];
			if ( null != sli )
				_lights[i].copyFrom( sli );
			else 
				_lights[i] = null;
		}
	}
	
	public function setAll( $ID:uint, $attn:uint ):void	{
		
		var li:LightInfo =  lightGet( $ID );
		
		if ( null == li )
			throw new Error( "Brightness.setAll - light not defined" );
			
		if ( Brightness.MAX_LIGHT_LEVEL < $attn )
			throw new Error( "Brightness.setAll - attn too high" );

		li.setAll( $attn );
	}
	
	public function valuesHas():Boolean	{

		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li ) {
				//if ( DEFAULT_BASE_LIGHT_LEVEL + DEFAULT_SIGMA < li.avg )
				if ( DEFAULT_BASE_LIGHT_LEVEL < li.avg )
					return true;
			}
		}
		
		return false;
	}
	
	public function valuesHasForFace( $ID:uint, $face:uint ):Boolean	{

		if ( !lightHas( $ID ) )
			return false;
			
		var li:LightInfo = lightGet( $ID );
		if ( null != li )
		{
			//const THRESHOLD:uint = DEFAULT_BASE_LIGHT_LEVEL + DEFAULT_SIGMA;
			const THRESHOLD:uint = DEFAULT_BASE_LIGHT_LEVEL;
			if ( Globals.POSX == $face ) {
				
				if ( THRESHOLD <= li.b100 ) { return true }
				if ( THRESHOLD <= li.b110 ) { return true }
				if ( THRESHOLD <= li.b111 ) { return true }
				if ( THRESHOLD <= li.b101 ) { return true }
			}
			else if ( Globals.NEGX == $face ) {

				if ( THRESHOLD <= li.b000 ) { return true }
				if ( THRESHOLD <= li.b010 ) { return true }
				if ( THRESHOLD <= li.b011 ) { return true }
				if ( THRESHOLD <= li.b001 ) { return true }
			}
			else if ( Globals.POSY == $face ) {

				if ( THRESHOLD <= li.b010 ) { return true }
				if ( THRESHOLD <= li.b110 ) { return true }
				if ( THRESHOLD <= li.b111 ) { return true }
				if ( THRESHOLD <= li.b011 ) { return true }
			}
			else if ( Globals.NEGY == $face ) {

				if ( THRESHOLD <= li.b000 ) { return true }
				if ( THRESHOLD <= li.b100 ) { return true }
				if ( THRESHOLD <= li.b101 ) { return true }
				if ( THRESHOLD <= li.b001 ) { return true }
			}
			else if ( Globals.POSZ == $face ) {

				if ( THRESHOLD <= li.b001 ) { return true }
				if ( THRESHOLD <= li.b011 ) { return true }
				if ( THRESHOLD <= li.b111 ) { return true }
				if ( THRESHOLD <= li.b101 ) { return true }
			}
			else if ( Globals.NEGZ == $face ) {
				
				if ( THRESHOLD <= li.b000 ) { return true }
				if ( THRESHOLD <= li.b010 ) { return true }
				if ( THRESHOLD <= li.b110 ) { return true }
				if ( THRESHOLD <= li.b100 ) { return true }
			}
		}
		return false;
	}
	
	public function reset():void {
		
		for ( var i:int = 1; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li )
				lightRemove( li.ID );
		}

		fallOffPerMeter = DEFAULT_FALL_OFF_PER_METER;
	}

	public function childAddAll( $childID:uint, $b:Brightness, $grainUnits:uint ):void {	
		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li && DEFAULT_BASE_LIGHT_LEVEL < li.avg )
				childAdd( li.ID, $childID, $b, $grainUnits );
		}
	}
	
	public function childAdd( $ID:uint, $childID:uint, $b:Brightness, $grainUnits:uint ):void {	

		var sli:LightInfo =  $b.lightGet( $ID );	
		if ( null == sli )
			throw new Error( "Brightness.childAdd - SOURCE light not defined" );
		if ( DEFAULT_BASE_LIGHT_LEVEL == sli.avg )
			return;
			
		// This is special case which needs to take into account attn
		var localattn:uint = fallOffPerMeter * $grainUnits/DEFAULT_PER_DISTANCE
		var sqrattn:Number =  Math.sqrt( 2 * (localattn * localattn) );
		var csqrattn:Number =  Math.sqrt( (localattn * localattn) + (sqrattn * sqrattn) );
		
		if ( !lightAdd( $ID, sli.color, sli.avg ) )
			return; // failed to add the light, This is a valid condition, if the light added is lower then the existing lights, it will not be added
		var li:LightInfo =  lightGet( $ID );		
		
		// The corner that the child is in is always the most accurate data, everything else is a guess
		if ( 0 == $childID ) {
			li.b000 = sli.b000;
			if ( li.b001 < sli.b001 - localattn )  li.b001 = sli.b001 - localattn;
			if ( li.b100 < sli.b100 - localattn )  li.b100 = sli.b100 - localattn;
			if ( li.b101 < sli.b101 - sqrattn )  	li.b101 = sli.b101 - sqrattn;
			
			if ( li.b010 < sli.b010 - localattn )  li.b010 = sli.b010 - localattn;
			if ( li.b011 < sli.b011 - sqrattn )  	li.b011 = sli.b011 - sqrattn;
			if ( li.b110 < sli.b110 - sqrattn )  	li.b110 = sli.b110 - sqrattn;
			if ( li.b111 < sli.b111 - csqrattn )  	li.b111 = sli.b111 - csqrattn;
		}
		else if ( 1 == $childID ) {
			if ( li.b000 < sli.b000 - localattn )  li.b000 = sli.b000 - localattn;
			if ( li.b001 < sli.b001 - sqrattn )  	li.b001 = sli.b001 - sqrattn;
			li.b100 = sli.b100;
			if ( li.b101 < sli.b101 - localattn )  li.b101 = sli.b101 - localattn;
			       
			if ( li.b010 < sli.b010 - sqrattn )  	li.b010 = sli.b010 - sqrattn;
			if ( li.b011 < sli.b011 - csqrattn )  	li.b011 = sli.b011 - csqrattn;
			if ( li.b110 < sli.b110 - localattn )  li.b110 = sli.b110 - localattn;
			if ( li.b111 < sli.b111 - sqrattn )  	li.b111 = sli.b111 - sqrattn;
		}
		else if ( 2 == $childID ) {
			if ( li.b000 < sli.b000 - localattn )  li.b000 = sli.b000 - localattn;
			if ( li.b001 < sli.b001 - sqrattn )  	li.b001 = sli.b001 - sqrattn;
			if ( li.b100 < sli.b100 - sqrattn )  	li.b100 = sli.b100 - sqrattn;
			if ( li.b101 < sli.b101 - csqrattn )  	li.b101 = sli.b101 - csqrattn;
			       
			li.b010 = sli.b010;
			if ( li.b011 < sli.b011 - localattn )  li.b011 = sli.b011 - localattn;
			if ( li.b110 < sli.b110 - localattn )  li.b110 = sli.b110 - localattn;
			if ( li.b111 < sli.b111 - sqrattn )  	li.b111 = sli.b111 - sqrattn;
		}
		else if ( 3 == $childID ) {
			if ( li.b000 < sli.b000 - sqrattn )  	li.b000 = sli.b000 - sqrattn;
			if ( li.b001 < sli.b001 - csqrattn )  	li.b001 = sli.b001 - csqrattn;
			if ( li.b100 < sli.b100 - localattn )  li.b100 = sli.b100 - localattn;
			if ( li.b101 < sli.b101 - sqrattn )  	li.b101 = sli.b101 - sqrattn;
			       
			if ( li.b010 < sli.b010 - localattn )  li.b010 = sli.b010 - localattn;
			if ( li.b011 < sli.b011 - sqrattn )  	li.b011 = sli.b011 - sqrattn;
			li.b110 = sli.b110;
			if ( li.b111 < sli.b111 - localattn )  li.b111 = sli.b111 - localattn;
		}
		else if ( 4 == $childID ) {
			if ( li.b000 < sli.b000 - localattn )  li.b000 = sli.b000 - localattn;
			li.b001 = sli.b001;
			if ( li.b100 < sli.b100 - sqrattn )  	li.b100 = sli.b100 - sqrattn;
			if ( li.b101 < sli.b101 - localattn )  li.b101 = sli.b101 - localattn;
			       
			if ( li.b010 < sli.b010 - sqrattn )  	li.b010 = sli.b010 - sqrattn;
			if ( li.b011 < sli.b011 - localattn )  li.b011 = sli.b011 - localattn;
			if ( li.b110 < sli.b110 - csqrattn )  	li.b110 = sli.b110 - csqrattn;
			if ( li.b111 < sli.b111 - sqrattn )  	li.b111 = sli.b111 - sqrattn;
		}
		else if ( 5 == $childID ) {
			if ( li.b000 < sli.b000 - sqrattn )  	li.b000 = sli.b000 - sqrattn;
			if ( li.b001 < sli.b001 - localattn )  li.b001 = sli.b001 - localattn;
			if ( li.b100 < sli.b100 - csqrattn )  	li.b100 = sli.b100 - localattn;
			li.b101 = sli.b101;
			       
			if ( li.b010 < sli.b010 - csqrattn )  	li.b010 = sli.b010 - csqrattn;
			if ( li.b011 < sli.b011 - sqrattn )  	li.b011 = sli.b011 - sqrattn;
			if ( li.b110 < sli.b110 - sqrattn )  	li.b110 = sli.b110 - sqrattn;
			if ( li.b111 < sli.b111 - localattn )  li.b111 = sli.b111 - localattn;
		}
		else if ( 6 == $childID ) {
			if ( li.b000 < sli.b000 - sqrattn )  	li.b000 = sli.b000 - sqrattn;
			if ( li.b001 < sli.b001 - localattn )  li.b001 = sli.b001 - localattn;
			if ( li.b100 < sli.b100 - csqrattn )  	li.b100 = sli.b100 - csqrattn;
			if ( li.b101 < sli.b101 - sqrattn )  	li.b101 = sli.b101 - sqrattn;
			       
			if ( li.b010 < sli.b010 - localattn )  li.b010 = sli.b010 - localattn;
			li.b011 = sli.b011;
			if ( li.b110 < sli.b110 - sqrattn )  	li.b110 = sli.b110 - sqrattn;
			if ( li.b111 < sli.b111 - localattn )  li.b111 = sli.b111 - localattn;
		}
		else if ( 7 == $childID ) {
			if ( li.b000 < sli.b000 - csqrattn )  	li.b000 = sli.b000 - csqrattn;
			if ( li.b001 < sli.b001 - sqrattn )  	li.b001 = sli.b001 - sqrattn;
			if ( li.b100 < sli.b100 - sqrattn )  	li.b100 = sli.b100 - sqrattn;
			if ( li.b101 < sli.b101 - localattn )  li.b101 = sli.b101 - localattn;
			       
			if ( li.b010 < sli.b010 - sqrattn )  	li.b010 = sli.b010 - sqrattn;
			if ( li.b011 < sli.b011 - localattn )  li.b011 = sli.b011 - localattn;
			if ( li.b110 < sli.b110 - localattn )  li.b110 = sli.b110 - localattn;
			li.b111 = sli.b111;
		}
		
		if ( li.b000 < DEFAULT_BASE_LIGHT_LEVEL ) li.b000 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b001 < DEFAULT_BASE_LIGHT_LEVEL ) li.b001 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b010 < DEFAULT_BASE_LIGHT_LEVEL ) li.b010 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b011 < DEFAULT_BASE_LIGHT_LEVEL ) li.b011 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b100 < DEFAULT_BASE_LIGHT_LEVEL ) li.b100 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b101 < DEFAULT_BASE_LIGHT_LEVEL ) li.b101 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b110 < DEFAULT_BASE_LIGHT_LEVEL ) li.b110 = DEFAULT_BASE_LIGHT_LEVEL;
		if ( li.b111 < DEFAULT_BASE_LIGHT_LEVEL ) li.b111 = DEFAULT_BASE_LIGHT_LEVEL;
	}
	
	// creates a virtual brightness(light) the light from a parent to a child brightness with all lights
	public function childGetAllLights( $childID:int, $b:Brightness ):void {

		for ( var i:int; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li )
				childGet( li.ID, $childID, $b );
		}
	}
	
	// creates a virtual brightness(light) the light from a parent to a child brightness, with only light specified
	public function childGet( $ID:uint, $childID:int, $b:Brightness ):void {
		
		if ( !lightHas( $ID ) )
			throw new Error( "Brightness.childGet - No light for ID: " + $ID );
			
		var li:LightInfo =  lightGet( $ID );		
		if ( !$b.lightAdd( $ID, li.color, li.avg ) )
			throw new Error( "Brightness.childGet - $b does not have light info for lightID: " + $ID )
		var sli:LightInfo =  $b.lightGet( $ID );	
				
		// I think the diagonals should be averaged between both corners
		if ( 0 == $childID ) { // b000
			sli.b000 = li.b000;
			sli.b001 = ( li.b001 + li.b000) / 2;
			sli.b010 = ( li.b010 + li.b000) / 2;				// average edge for edge points
			sli.b011 = ( li.b011 + li.b001 + li.b010 + li.b000) / 4; // average of all four on face for points on face
			sli.b100 = ( li.b100 + li.b000) / 2;
			sli.b101 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
			sli.b110 = ( li.b110 + li.b100 + li.b000 + li.b010) / 4;
			sli.b111 = li.avg; 							// average of all eight for center points
		}
		else if ( 1 == $childID )	{ // b100
			sli.b000 = ( li.b000 + li.b100) / 2;
			sli.b001 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
			sli.b010 = ( li.b000 + li.b100 + li.b010 + li.b110) / 4;
			sli.b011 = li.avg;
			sli.b100 = li.b100;
			sli.b101 = ( li.b101 + li.b100) / 2;
			sli.b110 = ( li.b100 + li.b110) / 2;
			sli.b111 = ( li.b100 + li.b110 + li.b101 + li.b111) / 4;
		}
		else if ( 2 == $childID )	{ // b010
			sli.b000 = ( li.b000 + li.b010) / 2;
			sli.b001 = ( li.b000 + li.b010 + li.b001 + li.b011) / 4;
			sli.b010 = li.b010;
			sli.b011 = ( li.b011 + li.b010) / 2;
			sli.b100 = ( li.b000 + li.b010 + li.b100 + li.b110) / 4;
			sli.b101 = li.avg;
			sli.b110 = ( li.b110 + li.b010) / 2;
			sli.b111 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
		}
		else if ( 3 == $childID ) { // b110
			sli.b000 = ( li.b000 + li.b010 + li.b110 + li.b100 ) / 4;
			sli.b001 = li.avg;
			sli.b010 = ( li.b010 + li.b110) / 2;
			sli.b011 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
			sli.b100 = ( li.b100 + li.b110) / 2;
			sli.b101 = ( li.b100 + li.b110 + li.b111 + li.b101 ) / 4;
			sli.b110 = li.b110;
			sli.b111 = ( li.b111 + li.b110) / 2;
		}
		else if ( 4 == $childID )	{ // b001
			sli.b000 = ( li.b000 + li.b001) / 2;
			sli.b001 = li.b001;
			sli.b010 = ( li.b000 + li.b010 + li.b001 + li.b011) / 4;
			sli.b011 = ( li.b011 + li.b001) / 2;
			sli.b100 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
			sli.b101 = ( li.b101 + li.b001) / 2;
			sli.b110 = li.avg;
			sli.b111 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
		}
		else if ( 5 == $childID )	{ // b101
			sli.b000 = ( li.b101 + li.b000 + li.b100 + li.b001) / 4;
			sli.b001 = ( li.b001 + li.b101) / 2;
			sli.b010 = li.avg;
			sli.b011 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
			sli.b100 = ( li.b100 + li.b101) / 2;
			sli.b101 = li.b101;
			sli.b110 = ( li.b100 + li.b110 + li.b101 + li.b111) / 4;
			sli.b111 = ( li.b111 + li.b101) / 2;
		}
		else if ( 6 == $childID )	{ // b011
			sli.b000 = ( li.b000 + li.b010 + li.b011 + li.b001) / 4;
			sli.b001 = ( li.b001 + li.b011) / 2;
			sli.b010 = ( li.b010 + li.b011) / 2;
			sli.b011 = li.b011;
			sli.b100 = li.avg;
			sli.b101 = ( li.b001 + li.b011 + li.b101 + li.b111) / 4;
			sli.b110 = ( li.b010 + li.b011 + li.b110 + li.b111) / 4;
			sli.b111 = ( li.b111 + li.b011) / 2;
		}
		else if ( 7 == $childID )	{ // b111
			sli.b000 = li.avg;
			sli.b001 = ( li.b001 + li.b011 + li.b101 + li.b111 ) / 4;
			sli.b010 = ( li.b111 + li.b010 + li.b110 + li.b011 ) / 4;
			sli.b011 = ( li.b011 + li.b111) / 2;
			sli.b100 = ( li.b100 + li.b110 + li.b101 + li.b111 ) / 4;
			sli.b101 = ( li.b101 + li.b111) / 2;
			sli.b110 = ( li.b110 + li.b111) / 2;
			sli.b111 = li.b111;
		}					
	}

	public function get avg():uint {
		var count:int;
		var avgTotal:uint;
		// I need to know the average attn, but I dont know it here....
		for ( var j:int; j < LIGHTS_MAX; j++ ) {
			var li:LightInfo = _lights[j];
			if ( null != li ) { // new light avg is greater then this lights avg, replace it.
				avgTotal += li.avg;
				count++;
			}
		}
		
		return avgTotal/count;
	}

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

	// Gets the ID of the light here
	public function lightIDGet():uint {
		for ( var i:int = 1; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( li && li.lightIs )
				return li.ID;
		}
		return 1;
	}

	// Gets the ID of the light here
	public function lightIDNonDefaultUsedGet():Vector.<uint> {
		var lightIDs:Vector.<uint> = new Vector.<uint>;
		for ( var i:int = 1; i < LIGHTS_MAX; i++ ) {
			var li:LightInfo = _lights[i];
			if ( null != li )
				lightIDs.push( li.ID );
		}
		return lightIDs;
	}
	
	public function lightBrightestGet():LightInfo {
		var maxAttn:uint = DEFAULT_BASE_LIGHT_LEVEL;
		var maxAttnIndex:uint;
		// I need to know the average attn, but I dont know it here....
		for ( var j:int; j < LIGHTS_MAX; j++ ) {
			var li:LightInfo = _lights[j];
			if ( null != li ) { // new light avg is greater then this lights avg, replace it.
				if ( maxAttn < li.avg ) {
					maxAttn = li.avg;
					maxAttnIndex = j;
				}
			}
		}
		
		return _lights[maxAttnIndex];
	}
	
	public function lightAdd( $ID:uint, $color:uint, $avgAttn:uint, $isLight:Boolean = false ):Boolean {
		
		if ( lightHas( $ID ) )
			return true;
		
		if ( DEFAULT_LIGHT_ID != $ID && DEFAULT_BASE_LIGHT_LEVEL == $avgAttn )
			return false;
		
		if ( _lightCount < LIGHTS_MAX ) {
			
			for ( var i:int; i < LIGHTS_MAX; i++ ) {
				if ( null == _lights[i] ) {
					_lights[i] = new LightInfo( $ID, $color, DEFAULT_LIGHT_LEVEL_SETTER, $isLight );	
					if ( true == $isLight )
						_lights[i].setAll( 255 );
					_lightCount++;
					return true;
				}
			}
		}
		else {
			var lowAttn:uint = DEFAULT_BASE_LIGHT_LEVEL;
			var lowAttnIndex:uint;
			// I need to know the average attn, but I dont know it here....
			for ( var j:int; j < LIGHTS_MAX; j++ ) {
				var li:LightInfo = _lights[j];
				if ( null != li ) { // new light avg is greater then this lights avg, replace it.
					if ( lowAttn < li.avg ) {
						lowAttn = li.avg;
						lowAttnIndex = j;
					}
				}
			}
			// see if new light is stronger
			if ( lowAttn < $avgAttn ) {
				_lights[lowAttnIndex] = null;
				_lights[lowAttnIndex] = new LightInfo( $ID, $color, DEFAULT_LIGHT_LEVEL_SETTER, $isLight );	
				return true;
			}
		}
		
		return false;
	}
	
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
	
	public function lightFullBright():void {
		
		var li:LightInfo = lightGet( Brightness.DEFAULT_LIGHT_ID );
		li.setAll( 255 );
	}

	// this returns a composite color made of default color plus any additional colors for the indicated corner
	public function lightGetComposite( $corner:uint ):uint {
		_compositeColor = 0;
		
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var li:LightInfo = _lights[i];
			if ( null != li )
				_compositeColor = ColorUtils.testCombineARGB( _compositeColor, li.color, li.attnLevelGet( $corner ) );
		}
		
		return _compositeColor;
	}
		
	public function influenceAdd( $ID:uint, $lob:Brightness, $faceFrom:int, $faceOnly:Boolean, $grainUnits:int ):Boolean
	{
		// Check to make sure this FACE has values, not the whole oxel
		if ( !$lob.valuesHasForFace( $ID, $faceFrom ) ) 
			return false;

		var sli:LightInfo = $lob.lightGet( $ID );
		if ( null == sli )
			return false; // This should not really occur
		if ( !lightAdd( $ID, sli.color, sli.avg ) )
			return false;
		var li:LightInfo = lightGet( $ID );
		
		var c:Boolean = false;
		const attnScaled:uint = fallOffPerMeter * ($grainUnits/16);
		if ( Globals.POSX == $faceFrom ) {
			
			if ( li.b000 < sli.b100 ) { li.b000 = sli.b100; c = true; }
			if ( li.b010 < sli.b110 ) { li.b010 = sli.b110; c = true; }
			if ( li.b011 < sli.b111 ) { li.b011 = sli.b111; c = true; }
			if ( li.b001 < sli.b101 ) { li.b001 = sli.b101; c = true; }
		}
		else if ( Globals.NEGX == $faceFrom ) {

			if ( li.b100 < sli.b000 ) { li.b100 = sli.b000; c = true; }
			if ( li.b110 < sli.b010 ) { li.b110 = sli.b010; c = true; }
			if ( li.b111 < sli.b011 ) { li.b111 = sli.b011; c = true; }
			if ( li.b101 < sli.b001 ) { li.b101 = sli.b001; c = true; }
		}
		else if ( Globals.POSY == $faceFrom ) {

			if ( li.b000 < sli.b010 ) { li.b000 = sli.b010; c = true; }
			if ( li.b100 < sli.b110 ) { li.b100 = sli.b110; c = true; }
			if ( li.b101 < sli.b111 ) { li.b101 = sli.b111; c = true; }
			if ( li.b001 < sli.b011 ) { li.b001 = sli.b011; c = true; }
		}
		else if ( Globals.NEGY == $faceFrom ) {

			if ( li.b010 < sli.b000 ) { li.b010 = sli.b000; c = true; }
			if ( li.b110 < sli.b100 ) { li.b110 = sli.b100; c = true; }
			if ( li.b111 < sli.b101 ) { li.b111 = sli.b101; c = true; }
			if ( li.b011 < sli.b001 ) { li.b011 = sli.b001; c = true; }
		}
		else if ( Globals.POSZ == $faceFrom ) {

			if ( li.b000 < sli.b001 ) { li.b000 = sli.b001; c = true; }
			if ( li.b010 < sli.b011 ) { li.b010 = sli.b011; c = true; }
			if ( li.b110 < sli.b111 ) { li.b110 = sli.b111; c = true; }
			if ( li.b100 < sli.b101 ) { li.b100 = sli.b101; c = true; }
		}
		else if ( Globals.NEGZ == $faceFrom ) {
			
			if ( li.b001 < sli.b000 ) { li.b001 = sli.b000; c = true; }
			if ( li.b011 < sli.b010 ) { li.b011 = sli.b010; c = true; }
			if ( li.b111 < sli.b110 ) { li.b111 = sli.b110; c = true; }
			if ( li.b101 < sli.b100 ) { li.b101 = sli.b100; c = true; }
		}
		
		//if ( !$faceOnly && max - attnScaled > avg ) {
		if ( !$faceOnly ) {
			var result:Boolean = balanceAttn( $ID, attnScaled );
			c = c || result;
		}
		
		return c;
	}

	public function balanceAttnAll( $attnScaled:uint ):Boolean {
		var c:Boolean = false;
		for ( var i:int; i < LIGHTS_MAX; i++ )
		{
			var li:LightInfo = _lights[i];
			if ( null != li ) {
				var result:Boolean = balanceAttn( li.ID, $attnScaled ) ;
				c = c || result;
			}
		}
		return c;
	}
	
	public function balanceAttn( $ID:uint, $attnScaled:uint ):Boolean {
		var c:Boolean = false;
		const li:LightInfo = lightGet( $ID );
		const sqattn:Number = Math.sqrt( 2 * ($attnScaled * $attnScaled) );
		const qrattn:Number = Math.sqrt( 3 * ($attnScaled * $attnScaled) );
		// Do this for each adject vertice
		if ( li.b000 > li.b001 + $attnScaled ) { li.b001 = li.b000 - $attnScaled; c = true; }
		if ( li.b000 > li.b010 + $attnScaled ) { li.b010 = li.b000 - $attnScaled; c = true; }
		if ( li.b000 > li.b011 + sqattn ) 	  	{ li.b011 = li.b000 - sqattn; c = true; }
		if ( li.b000 > li.b100 + $attnScaled ) { li.b100 = li.b000 - $attnScaled; c = true; }
		if ( li.b000 > li.b101 + sqattn ) 	  	{ li.b101 = li.b000 - sqattn; c = true; }
		if ( li.b000 > li.b110 + sqattn ) 	  	{ li.b110 = li.b000 - sqattn; c = true; }
		if ( li.b000 > li.b111 + qrattn ) 	  	{ li.b111 = li.b000 - qrattn; c = true; }
		
		if ( li.b001 > li.b000 + $attnScaled ) { li.b000 = li.b001 - $attnScaled; c = true; }
		if ( li.b001 > li.b010 + sqattn ) 	  	{ li.b010 = li.b001 - sqattn; c = true; }
		if ( li.b001 > li.b011 + $attnScaled ) { li.b011 = li.b001 - $attnScaled; c = true; }
		if ( li.b001 > li.b100 + sqattn ) 	  	{ li.b100 = li.b001 - sqattn; c = true; }
		if ( li.b001 > li.b101 + $attnScaled ) { li.b101 = li.b001 - $attnScaled; c = true; }
		if ( li.b000 > li.b110 + qrattn ) 	  	{ li.b110 = li.b001 - qrattn; c = true; }
		if ( li.b001 > li.b111 + sqattn ) 	  	{ li.b111 = li.b001 - sqattn; c = true; }
		
		if ( li.b010 > li.b000 + $attnScaled ) { li.b000 = li.b010 - $attnScaled; c = true; }
		if ( li.b010 > li.b001 + sqattn ) 	  	{ li.b001 = li.b010 - sqattn; c = true; }
		if ( li.b010 > li.b011 + $attnScaled ) { li.b011 = li.b010 - $attnScaled; c = true; }
		if ( li.b010 > li.b100 + sqattn ) 	  	{ li.b100 = li.b010 - sqattn; c = true; }
		if ( li.b010 > li.b101 + qrattn ) 	  	{ li.b101 = li.b010 - qrattn; c = true; }
		if ( li.b010 > li.b110 + $attnScaled ) { li.b110 = li.b010 - $attnScaled; c = true; }
		if ( li.b010 > li.b111 + sqattn ) 	  	{ li.b111 = li.b010 - sqattn; c = true; }
		
		if ( li.b011 > li.b000 + sqattn ) 	  	{ li.b000 = li.b011 - sqattn; c = true; }
		if ( li.b011 > li.b001 + $attnScaled ) { li.b001 = li.b011 - $attnScaled; c = true; }
		if ( li.b011 > li.b010 + $attnScaled ) { li.b010 = li.b011 - $attnScaled; c = true; }
		if ( li.b011 > li.b100 + qrattn )      { li.b100 = li.b011 - qrattn; c = true; }
		if ( li.b011 > li.b101 + sqattn )      { li.b101 = li.b011 - sqattn; c = true; }
		if ( li.b011 > li.b110 + sqattn )      { li.b110 = li.b011 - sqattn; c = true; }
		if ( li.b011 > li.b111 + $attnScaled ) { li.b111 = li.b011 - $attnScaled; c = true; }

		if ( li.b100 > li.b000 + $attnScaled ) { li.b000 = li.b100 - $attnScaled; c = true; }
		if ( li.b100 > li.b001 + sqattn ) 	  	{ li.b001 = li.b100 - sqattn; c = true; }
		if ( li.b100 > li.b010 + sqattn ) 	  	{ li.b010 = li.b100 - sqattn; c = true; }
		if ( li.b100 > li.b011 + qrattn ) 	  	{ li.b011 = li.b100 - qrattn; c = true; }
		if ( li.b100 > li.b101 + $attnScaled ) { li.b101 = li.b100 - $attnScaled; c = true; }
		if ( li.b100 > li.b110 + $attnScaled ) { li.b110 = li.b100 - $attnScaled; c = true; }
		if ( li.b100 > li.b111 + sqattn ) 	  	{ li.b111 = li.b100 - sqattn; c = true; }
		
		if ( li.b101 > li.b000 + sqattn ) 	  	{ li.b000 = li.b101 - sqattn; c = true; }
		if ( li.b101 > li.b001 + $attnScaled ) { li.b001 = li.b101 - $attnScaled; c = true; }
		if ( li.b101 > li.b010 + qrattn ) 	  	{ li.b010 = li.b101 - qrattn; c = true; }
		if ( li.b101 > li.b011 + sqattn ) 	  	{ li.b011 = li.b101 - sqattn; c = true; }
		if ( li.b101 > li.b100 + $attnScaled ) { li.b100 = li.b101 - $attnScaled; c = true; }
		if ( li.b101 > li.b110 + sqattn ) 	  	{ li.b110 = li.b101 - sqattn; c = true; }
		if ( li.b101 > li.b111 + $attnScaled ) { li.b111 = li.b101 - $attnScaled; c = true; }
		
		if ( li.b110 > li.b000 + sqattn )	  	{ li.b000 = li.b110 - sqattn; c = true; }
		if ( li.b110 > li.b001 + qrattn )	  	{ li.b001 = li.b110 - qrattn; c = true; }
		if ( li.b110 > li.b010 + $attnScaled ) { li.b010 = li.b110 - $attnScaled; c = true; }
		if ( li.b110 > li.b011 + sqattn )	  	{ li.b011 = li.b110 - sqattn; c = true; }
		if ( li.b110 > li.b100 + $attnScaled ) { li.b100 = li.b110 - $attnScaled; c = true; }
		if ( li.b110 > li.b101 + sqattn )	  	{ li.b101 = li.b110 - sqattn; c = true; }
		if ( li.b110 > li.b111 + $attnScaled ) { li.b111 = li.b110 - $attnScaled; c = true; }

		if ( li.b111 > li.b000 + qrattn ) 	  	{ li.b000 = li.b111 - qrattn; c = true; }
		if ( li.b111 > li.b001 + sqattn ) 	  	{ li.b001 = li.b111 - sqattn; c = true; }
		if ( li.b111 > li.b010 + sqattn ) 	  	{ li.b010 = li.b111 - sqattn; c = true; }
		if ( li.b111 > li.b011 + $attnScaled ) { li.b011 = li.b111 - $attnScaled; c = true; }
		if ( li.b111 > li.b100 + sqattn ) 	  	{ li.b100 = li.b111 - sqattn; c = true; }
		if ( li.b111 > li.b101 + $attnScaled ) { li.b101 = li.b111 - $attnScaled; c = true; }
		if ( li.b111 > li.b110 + $attnScaled ) { li.b110 = li.b111 - $attnScaled; c = true; }

		return c;
	}
	
	// Add the influcence of a virtual cube the same size
	public function brightnessMerge( $ID:uint, $b:Brightness ):Boolean {
		
		if ( !$b.lightHas( $ID ) )
			return false; // if there is no value for the light, it is not added
		var sli:LightInfo = $b.lightGet( $ID );
		if ( !lightAdd( sli.ID, sli.color, sli.avg ) )
			return false;
		var li:LightInfo = lightGet( $ID );
		
		var c:Boolean;
		if ( li.b000 < sli.b000 )	  { li.b000 = sli.b000; c = true; }
		if ( li.b001 < sli.b001 )	  { li.b001 = sli.b001; c = true; }
		if ( li.b010 < sli.b010 )	  { li.b010 = sli.b010; c = true; }
		if ( li.b011 < sli.b011 )	  { li.b011 = sli.b011; c = true; }
		if ( li.b100 < sli.b100 )	  { li.b100 = sli.b100; c = true; }
		if ( li.b101 < sli.b101 )	  { li.b101 = sli.b101; c = true; }
		if ( li.b110 < sli.b110 )	  { li.b110 = sli.b110; c = true; }
		if ( li.b111 < sli.b111 )	  { li.b111 = sli.b111; c = true; }
		return c;
	}
	
} // end of class Brightness
} // end of package
