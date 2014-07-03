/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.worldmodel.oxel.*;
/**
 * ...
 * @author Robert Flesch
 */
public class BrightnessTests  { 
	
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

		static public function allTests():void {
			resetTests();
			setAllTests();
			colorAddTests();
			influenceAddTests();
			childAddTests();
			childGetTests();
		}
		
		static public function resetTests():void {
			
			Log.out( "BrightnessTests.resetTests	START" );

			const ResetString:String = "  lastLightID: 1  b000: 51  b001: 51  b100: 51  b101: 51  b010: 51  b011: 51  b110: 51  b111: 51  colorCount: 1"
			const DefaultMax:String = "  lastLightID: 1  b000: 255  b001: 255  b100: 255  b101: 255  b010: 255  b011: 255  b110: 255  b111: 255  colorCount: 1"
			var bt:Brightness = BrightnessPool.poolGet();
			bt.reset();
			if ( ResetString == bt.toString() )
				Log.out( "BrightnessTests.resetTests	Pass 1" );
			else	
				Log.out( "BrightnessTests.resetTests	FAIL 1", Log.ERROR );

			bt.setAll( 1, Brightness.MAX_LIGHT_LEVEL ); 
			if ( DefaultMax == bt.toString() )
				Log.out( "BrightnessTests.resetTests	Pass 2" );
			else	
				Log.out( "BrightnessTests.resetTests	FAIL 2", Log.ERROR );
				
			BrightnessPool.poolReturn( bt );
			Log.out( "BrightnessTests.resetTests	END" );
		}

		static public function colorAddTests():void {
			
		}
		
		static public function setAllTests():void {

			Log.out( "BrightnessTests.setAllTests	START" );
			
			const ColorNotDefined:String = "Brightness.setAll - Color not defined"
			const OneOhOneMax:String = "  lastLightID: 101  b000: 255  b001: 255  b100: 255  b101: 255  b010: 255  b011: 255  b110: 255  b111: 255  colorCount: 2"

			//public function setAll( $lightID:uint, $attn:uint ):void	{
			// bad conditions
			// $lightId - doesnt have id
			// $attn overvalue or 0

			var bt:Brightness = BrightnessPool.poolGet();
			bt.reset();
			// bad conditions
			// $lightId - doesnt have id
			var lightId:uint = 101;
			try {
				bt.setAll( lightId, Brightness.MAX_LIGHT_LEVEL ); 
			} catch (e:Error) {
				if ( ColorNotDefined == e.message )
					Log.out( "BrightnessTests.setAllTests	pass 1" );
				else
					Log.out( "BrightnessTests.setAllTests	FAIL 1", Log.ERROR );
			}

			bt.reset();
			try {
				bt.setAll( Brightness.DEFAULT_LIGHT_ID, Brightness.MAX_LIGHT_LEVEL );
				Log.out( "BrightnessTests.setAllTests	pass 2" );
			} catch (e:Error) {
				Log.out( "BrightnessTests.setAllTests	FAIL 2", Log.ERROR );
			}
			
			bt.reset();
			bt.add( lightId, 0x00ff0000, Brightness.MAX_LIGHT_LEVEL );
			bt.setAll( lightId, Brightness.MAX_LIGHT_LEVEL );
			if ( OneOhOneMax == bt.toString() )
				Log.out( "BrightnessTests.setAllTests	pass 3" );
			else
				Log.out( "BrightnessTests.setAllTests	FAIL 3", Log.ERROR );

			BrightnessPool.poolReturn( bt );				
			Log.out( "BrightnessTests.setAllTests	END" );
		}

		static public function influenceAddTests():void {
			
			Log.out( "BrightnessTests.addInfluenceTests	START" );
			
			const addResult:Vector.<String> = new <String>[ "  lastLightID: 101  b000: 255  b001: 255  b100: 204  b101: 204  b010: 255  b011: 255  b110: 204  b111: 204  colorCount: 2"
														   ,"  lastLightID: 101  b000: 204  b001: 204  b100: 255  b101: 255  b010: 204  b011: 204  b110: 255  b111: 255  colorCount: 2"
														   ,"  lastLightID: 101  b000: 255  b001: 255  b100: 255  b101: 255  b010: 204  b011: 204  b110: 204  b111: 204  colorCount: 2"
														   ,"  lastLightID: 101  b000: 204  b001: 204  b100: 204  b101: 204  b010: 255  b011: 255  b110: 255  b111: 255  colorCount: 2"
														   ,"  lastLightID: 101  b000: 255  b001: 204  b100: 255  b101: 204  b010: 255  b011: 204  b110: 255  b111: 204  colorCount: 2"
														   ,"  lastLightID: 101  b000: 204  b001: 255  b100: 204  b101: 255  b010: 204  b011: 255  b110: 204  b111: 255  colorCount: 2" ];
			
			var lob:Brightness = BrightnessPool.poolGet();
			var lightId:uint = 101;
			lob.add( lightId, 0x00ff0000, Brightness.MAX_LIGHT_LEVEL );
			lob.setAll( lightId, Brightness.MAX_LIGHT_LEVEL );
			var grainUnits:uint = 16;
			
			var bt:Brightness = BrightnessPool.poolGet();
			bt.reset();
			var faceOnly:Boolean = false;
			for ( var faceTest:int = Globals.POSX; faceTest <= Globals.NEGZ; faceTest++ ) {
				bt.reset();
				//public function influenceAdd( $ID:uint, $lob:Brightness, $faceFrom:int, $faceOnly:Boolean, $grainUnits:int ):Boolean
				bt.influenceAdd( lightId, lob, faceTest, faceOnly, grainUnits )
				//trace(addResult[faceTest]);
				//trace(bt.toString());
				if ( addResult[faceTest] == bt.toString() )
					Log.out( "BrightnessTests.addInfluenceTests	pass " + faceTest );
				else	
					Log.out( "BrightnessTests.addInfluenceTests	FAIL " + faceTest, Log.ERROR );
			}
			
			BrightnessPool.poolReturn( bt );
			
			Log.out( "BrightnessTests.addInfluenceTests	END" );
		}
		
		static public function childAddTests():void {
			
			Log.out( "BrightnessTests.childAddTests	START - incomplete" );
			var bt:Brightness = BrightnessPool.poolGet();
			var btp:Brightness = BrightnessPool.poolGet();
			bt.setAll( Brightness.DEFAULT_LIGHT_ID, Brightness.MAX_LIGHT_LEVEL );
			const grainUnits:uint = 16;
			for ( var childID:uint = 0; childID < 8; childID++ ) {	
				btp.reset();
				// now extend the brightness child onto its parent!
				//public function childAdd( $ID:uint, $childID:uint, $b:Brightness, $grainUnits:uint ):void {	
				btp.childAdd(  Brightness.DEFAULT_LIGHT_ID, childID, bt, grainUnits );
				//bt.copyFrom( btp );
				//grainUnits *= 2;
				trace( btp.toString() );
			}
			Log.out( "BrightnessTests.childAddTests	END" );
		}

		static public function childGetTests():void { 
			Log.out( "BrightnessTests.childGetTests	START" );
			
			var lob:Brightness = BrightnessPool.poolGet();
			var lightId:uint = 101;
			lob.add( lightId, 0x00ff0000, Brightness.MAX_LIGHT_LEVEL );
			lob.setAll( lightId, Brightness.MAX_LIGHT_LEVEL );
			
			var btp:Brightness = BrightnessPool.poolGet();
			// make the btp (parent) grain 5, and add a light to it.
			// so each face has four children.
			var btResult:Brightness = BrightnessPool.poolGet();
			for ( var faceTest:int = Globals.POSX; faceTest <= Globals.NEGZ; faceTest++ ) {
				trace( "------------------------------" );
				btp.reset();
				btp.influenceAdd( lightId, lob, (faceTest + 2) % 6, false, 32 );
				trace( faceTest + "  " + btp.toString() );
				for ( var childIndex:int = 0; childIndex < 8; childIndex++ ) {
					btResult.reset();
					btp.childGet( lightId, childIndex, btResult );
					trace( childIndex + "  " + btResult.toString() );
				}
				trace( "------------------------------" );
			}
			Log.out( "BrightnessTests.childGetTests	END" );
		}
		
		static public function toBtyeArrayTests():void { }
		static public function fromBtyeArrayTests():void { }
		static public function copyFromTests():void { }
		static public function valuesHasTests():void { }
		static public function colorGetTests():void { }
		static public function fullBrightTests():void { }
		static public function balanceAttnTests():void { }
		static public function addBrightnessTests():void { }
	 
} // end of class FlowInfo
} // end of package
