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

	import com.voxelengine.utils.Color;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.lighting.Light;
/**
 * ...
 * @author Robert Flesch
 */
public class Brightness extends BrightnessData {
	
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
	static private var _s_sb:Brightness = new Brightness(); // scratchBrightness
	static private var _s_sb2:Brightness = new Brightness(); // scratchBrightness 2
	static public function scratch():Brightness { return _s_sb; }

	private var _lastLight:String = "";
	public function get lastLight():String { return _lastLight; }
	public function set lastLight(value:String):void { _lastLight = value; }
	
	static public const FIXED:String = "FIXED";
	public const DEFAULT:Number = 0.2;
	public const DEFAULT_SIGMA:Number = 0.01;
	public const DEFAULT_ATTEN:Number = 0.1;
	public const DEFAULT_PER_DISTANCE:int = 16;
	public const DEFAULT_COLOR:int = 0xffffffff;
	private var _atten:Number = DEFAULT_ATTEN;  // down 1 per meter
	private var _sunlit:Boolean;
	public var _b000:Number = DEFAULT;
	public var _b001:Number = DEFAULT;
	public var _b100:Number = DEFAULT;
	public var _b101:Number = DEFAULT;
	public var _b010:Number = DEFAULT;
	public var _b011:Number = DEFAULT;
	public var _b110:Number = DEFAULT;
	public var _b111:Number = DEFAULT;
	//public var color:Vector3D = new Vector3D(1, 1, 1, 1);
	private var _color:uint = DEFAULT_COLOR;
	public function get color():uint { return _color; }
	public function set color( v:uint ):void { _color = v; }
	
	public function get b000():Number { return _b000; }
	public function get b001():Number { return _b001; }
	public function get b100():Number { return _b100; }
	public function get b101():Number { return _b101; }
	public function get b010():Number { return _b010; }
	public function get b011():Number { return _b011; }
	public function get b110():Number { return _b110; }
	public function get b111():Number { return _b111; }
	
	public function set b000( n:Number ):void { _b000 = setPrecision( n ); }
	public function set b001( n:Number ):void { _b001 = setPrecision( n ); }
	public function set b100( n:Number ):void { _b100 = setPrecision( n ); }
	public function set b101( n:Number ):void { _b101 = setPrecision( n ); }
	public function set b010( n:Number ):void { _b010 = setPrecision( n ); }
	public function set b011( n:Number ):void { _b011 = setPrecision( n ); }
	public function set b110( n:Number ):void { _b110 = setPrecision( n ); }
	public function set b111( n:Number ):void { _b111 = setPrecision( n ); }
	
	public function get sunlit():Boolean { return _sunlit; }
	// TODO this should be from the current sun object
	public function set sunlit(value:Boolean):void { true == value ? setAll( 1.0, Brightness.FIXED ): reset(); _sunlit = value;  }
	
	private function rnd( $val:Number ):Number { return int($val * 100) / 100; }
	
	// var number:Number = 10.98813311;
	// trace(setPrecision(number,1)); //Result is 10.9
	// trace(setPrecision(number,2)); //Result is 10.98
	// trace(setPrecision(number,3)); //Result is 10.988 and so on
	// http://stackoverflow.com/questions/632802/how-to-deal-with-number-precision-in-actionscript
	private function setPrecision( $number:Number, $precision:int = 3):Number {
		$precision = Math.pow(10, $precision);
		return Math.round( $number * $precision )/$precision;
	}

	
	public function toByteArray( $ba:ByteArray ):ByteArray {
		
		$ba.writeFloat( rnd( b000 ) );
		$ba.writeFloat( rnd( b001 ) );
		$ba.writeFloat( rnd( b100 ) );
		$ba.writeFloat( rnd( b101 ) );
		$ba.writeFloat( rnd( b010 ) );
		$ba.writeFloat( rnd( b011 ) );
		$ba.writeFloat( rnd( b110 ) );
		$ba.writeFloat( rnd( b111 ) );
		return $ba;
	}
	
	public function fromByteArray( $ba:ByteArray ):ByteArray {
		
		//var b000 = rnd( $ba.readFloat() );
		//trace( "Brightness.fromByteArray b000: " + b000 );
		b000 = $ba.readFloat();
		b001 = $ba.readFloat();
		b100 = $ba.readFloat();
		b101 = $ba.readFloat();
		b010 = $ba.readFloat();
		b011 = $ba.readFloat();
		b110 = $ba.readFloat();
		b111 = $ba.readFloat();
		return $ba;
	}

	public function toString():String {
		return  "  b000: " + b000 +
				"  b001: " + b001 +
				"  b100: " + b100 +
				"  b101: " + b101 +
				"  b010: " + b010 +
				"  b011: " + b011 +
				"  b110: " + b110 +
				"  b111: " + b111;
	}
	
	public function copyFrom( $b:Brightness ):void {
		if ( sunlit )
			return;
		_lastLight = $b.lastLight;
		_color = $b.color;
		b000 = $b.b000;
		b001 = $b.b001; 
		b010 = $b.b010; 
		b011 = $b.b011; 
		b100 = $b.b100;
		b101 = $b.b101; 
		b110 = $b.b110; 
		b111 = $b.b111;
		_atten = $b._atten;
	}
	
	public function setAll( $val:Number, $id:String ):void	{
		if ( sunlit )
			return;
		_lastLight = $id;
		b000 = $val;
		b001 = $val;
		b100 = $val;
		b101 = $val;
		b010 = $val;
		b011 = $val;
		b110 = $val;
		b111 = $val;
	}
	
	public function valuesHas():Boolean	{
		if ( sunlit )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b000 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b001 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b100 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b101 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b010 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b011 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b110 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < b111 )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < Color.extractRed( color ) )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < Color.extractGreen( color ) )
			return true;
		if ( ( DEFAULT + DEFAULT_SIGMA ) < Color.extractBlue( color ) )
			return true;
			
		return false;
	}
	
	public function setFromChildOxel( $lob:Brightness, $childId:int ):void {	

		if ( 0 == $childId ) {
			b000 = $lob.b000;
			child0 = true; }
		else if ( 1 == $childId ) {
			b100 = $lob.b100;
			child1 = true; }
		else if ( 2 == $childId ) {
			b010 = $lob.b010;
			child2 = true; }
		else if ( 3 == $childId ) {
			b110 = $lob.b110;
			child3 = true; }
		else if ( 4 == $childId ) {
			b001 = $lob.b001;
			child4 = true; }
		else if ( 5 == $childId ) {
			b101 = $lob.b101;
			child5 = true; }
		else if ( 6 == $childId ) {
			b011 = $lob.b011;
			child6 = true; }
		else if ( 7 == $childId ) {
			b111 = $lob.b111;
			child7 = true; }
	}
	
	public function restoreDefault( $id:String, $no:Oxel, $faceFrom:int ):Boolean	{
		//Log.out( "Brightness.setDefault - id: " + $id + " no: " + $no.toStringShort() + toString() );			
		if ( sunlit )
			return false;
		var c:Boolean;	
		if ( valuesHas() )
		{
			Log.out( "Brightness.restoreDefault - resetting id: " + $id + " no: " + $no.toStringShort() + toString() );
			_lastLight = $id;	
			if ( b000 != DEFAULT
			  || b001 != DEFAULT
			  || b100 != DEFAULT
			  || b101 != DEFAULT
			  || b010 != DEFAULT
			  || b011 != DEFAULT
			  || b110 != DEFAULT
			  || b111 != DEFAULT )
				c = true;

			b000 = DEFAULT;
			b001 = DEFAULT;
			b100 = DEFAULT;
			b101 = DEFAULT;
			b010 = DEFAULT;
			b011 = DEFAULT;
			b110 = DEFAULT;
			b111 = DEFAULT;
			
			if ( c )
			{
				var faceOnly:Boolean = true;
				if ( Globals.hasAlpha( $no.type ) )
					faceOnly = false;
					
				if ( faceOnly )
					$no.quadDeleteFace( Oxel.face_get_opposite( $faceFrom ) );
				else
					$no.quadsDeleteAll( $no.type ); // All of the quads may have changed...
			}
		}
		return c;
	}

	public function reset():void	{
		b000 = DEFAULT;
		b001 = DEFAULT;
		b100 = DEFAULT;
		b101 = DEFAULT;
		b010 = DEFAULT;
		b011 = DEFAULT;
		b110 = DEFAULT;
		b111 = DEFAULT;
		
		_lastLight = "";
		_atten = DEFAULT_ATTEN;
		_sunlit = false;
		color = DEFAULT_COLOR;
	}
	
	public function setByFace( $face:int, $val:Number, $id:String, size:int ):void {
		if ( sunlit )
			return;

		_lastLight = $id;	
		var localAtten:Number = _atten * size/DEFAULT_PER_DISTANCE

		if ( Globals.POSX == $face ) {
			b100 = $val;
			b110 = $val;
			b111 = $val;
			b101 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT );
			b010 = Math.max( $val - localAtten, DEFAULT );
			b011 = Math.max( $val - localAtten, DEFAULT );
			b001 = Math.max( $val - localAtten, DEFAULT ); 
		}
		else if ( Globals.NEGX == $face ) {
			b000 = $val;
			b010 = $val;
			b011 = $val;
			b001 = $val; 

			b100 = Math.max( $val - localAtten, DEFAULT );
			b110 = Math.max( $val - localAtten, DEFAULT );
			b111 = Math.max( $val - localAtten, DEFAULT );
			b101 = Math.max( $val - localAtten, DEFAULT ); 
		}
		else if ( Globals.POSY == $face ) {
			b010 = $val;
			b110 = $val;
			b111 = $val;
			b011 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT );
			b100 = Math.max( $val - localAtten, DEFAULT );
			b101 = Math.max( $val - localAtten, DEFAULT );
			b001 = Math.max( $val - localAtten, DEFAULT ); 
		}
		else if ( Globals.NEGY == $face ) {
			b000 = $val;
			b100 = $val;
			b101 = $val;
			b001 = $val; 
			
			b010 = Math.max( $val - localAtten, DEFAULT );
			b110 = Math.max( $val - localAtten, DEFAULT );
			b111 = Math.max( $val - localAtten, DEFAULT );
			b011 = Math.max( $val - localAtten, DEFAULT ); 
		}
		else if ( Globals.POSZ == $face ) {
			b001 = $val;
			b011 = $val;
			b111 = $val;
			b101 = $val; 
			
			b000 = Math.max( $val - localAtten, DEFAULT );
			b010 = Math.max( $val - localAtten, DEFAULT );
			b110 = Math.max( $val - localAtten, DEFAULT );
			b100 = Math.max( $val - localAtten, DEFAULT ); 
		}
		else if ( Globals.NEGZ == $face ) {
			b000 = $val;
			b010 = $val;
			b110 = $val;
			b100 = $val; 

			b001 = Math.max( $val - localAtten, DEFAULT );
			b011 = Math.max( $val - localAtten, DEFAULT );
			b111 = Math.max( $val - localAtten, DEFAULT );
			b101 = Math.max( $val - localAtten, DEFAULT );
		}
	}

	
	public function restoreDefaultFromChildOxel( $id:String, $no:Oxel, $faceFrom:int ):Boolean {
		return restoreDefault( $id, $no, $faceFrom );
	}
	
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
		_s_sb.lastLight = lob.lastLight;
		//_s_sb.colorMix( lob, $lightColor );
		if ( Globals.POSX == $faceFrom ) {
			_s_sb.b100 = Math.min( lob.b100 - ( _atten * (z / loSize) )
							     , lob.b100 - ( _atten * (y / loSize) ) );
								 
			_s_sb.b101 = Math.min( lob.b101 - ( _atten * ((noSize - (z + loSize)) / loSize ) )
			                     , lob.b110 - ( _atten * (y / loSize) ) );
								 
			_s_sb.b110 = Math.min( lob.b110 - ( _atten * ((noSize - (y + loSize)) / loSize ) )
			                     , lob.b100 - ( _atten * (z / loSize) ) );
			
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
		return addInfluence( _s_sb, $faceFrom, faceOnly, $no.gc.size(), $lightColor );
		//return rebuildFace( $faceFrom, _s_sb, $no );
	}
	
	// Brightness uses passed in value, which allows it to reuse a brightness
	public function subfaceGet( $face:int, $child:int, $nb:Brightness ):void {
		
		$nb.lastLight = lastLight;
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
		$nb.color = color;	
	}
	
	// grabs the light from a parent to a child brightness
	public function childGet( $child:int, nb:Brightness ):void {
		
		if ( 0 == $child ) { // b000
			nb.b000 = b000;
			nb.b001 = (b001 + b000) / 2;
			nb.b010 = (b010 + b000) / 2;
			nb.b011 = (b011 + b000) / 2;
			nb.b100 = (b100 + b000) / 2;
			nb.b101 = (b101 + b000) / 2;
			nb.b110 = (b110 + b000) / 2;
			nb.b111 = (b111 + b000) / 2;
		}
		else if ( 1 == $child )	{ // b100
			nb.b000 = (b000 + b100) / 2;
			nb.b001 = (b001 + b100) / 2;
			nb.b010 = (b010 + b100) / 2;
			nb.b011 = (b011 + b100) / 2;
			nb.b100 = (b100 + b100) / 2;
			nb.b101 = (b101 + b100) / 2;
			nb.b110 = (b110 + b100) / 2;
			nb.b111 = (b111 + b100) / 2;
		}
		else if ( 2 == $child )	{ // b010
			nb.b000 = (b000 + b010) / 2;
			nb.b001 = (b001 + b010) / 2;
			nb.b010 = (b010 + b010) / 2;
			nb.b011 = (b011 + b010) / 2;
			nb.b100 = (b100 + b010) / 2;
			nb.b101 = (b101 + b010) / 2;
			nb.b110 = (b110 + b010) / 2;
			nb.b111 = (b111 + b010) / 2;
		}
		else if ( 3 == $child ) { // b110
			nb.b000 = (b000 + b110) / 2;
			nb.b001 = (b001 + b110) / 2;
			nb.b010 = (b010 + b110) / 2;
			nb.b011 = (b011 + b110) / 2;
			nb.b100 = (b100 + b110) / 2;
			nb.b101 = (b101 + b110) / 2;
			nb.b110 = (b110 + b110) / 2;
			nb.b111 = (b111 + b110) / 2;
		}
		else if ( 4 == $child )	{ // b001
			nb.b000 = (b000 + b001) / 2;
			nb.b001 = (b001 + b001) / 2;
			nb.b010 = (b010 + b001) / 2;
			nb.b011 = (b011 + b001) / 2;
			nb.b100 = (b100 + b001) / 2;
			nb.b101 = (b101 + b001) / 2;
			nb.b110 = (b110 + b001) / 2;
			nb.b111 = (b111 + b001) / 2;
		}
		else if ( 5 == $child )	{ // b101
			nb.b000 = (b000 + b101) / 2;
			nb.b001 = (b001 + b101) / 2;
			nb.b010 = (b010 + b101) / 2;
			nb.b011 = (b011 + b101) / 2;
			nb.b100 = (b100 + b101) / 2;
			nb.b101 = (b101 + b101) / 2;
			nb.b110 = (b110 + b101) / 2;
			nb.b111 = (b111 + b101) / 2;
		}
		else if ( 6 == $child )	{ // b011
			nb.b000 = (b000 + b011) / 2;
			nb.b001 = (b001 + b011) / 2;
			nb.b010 = (b010 + b011) / 2;
			nb.b011 = (b011 + b011) / 2;
			nb.b100 = (b100 + b011) / 2;
			nb.b101 = (b101 + b011) / 2;
			nb.b110 = (b110 + b011) / 2;
			nb.b111 = (b111 + b011) / 2;
		}
		else if ( 7 == $child )	{ // b111
			nb.b000 = (b000 + b111) / 2;
			nb.b001 = (b001 + b111) / 2;
			nb.b010 = (b010 + b111) / 2;
			nb.b011 = (b011 + b111) / 2;
			nb.b100 = (b100 + b111) / 2;
			nb.b101 = (b101 + b111) / 2;
			nb.b110 = (b110 + b111) / 2;
			nb.b111 = (b111 + b111) / 2;
		}
	}

	// if changed return true, which can add a new light task for AIR oxels
	private function equals( $b:Brightness ):Boolean 
	{
		if ( b000 == $b.b000 
		  && b010 == $b.b010 
		  && b011 == $b.b011 
		  && b001 == $b.b001 
		  && b100 == $b.b100 
		  && b110 == $b.b110 
		  && b111 == $b.b111 
		  && b101 == $b.b101
		  && color == $b.color ) return true;
		 
		return false;  
	}

	private function get avg():Number {
		
		return (b000 + b010 + b011 + b001 + b100 + b110 +  b111 + b101)/8
	}
	
	private function get max():Number {
		
		var max:Number = DEFAULT;
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
	
	private function colorMix( $lob:Brightness, $lightColor:uint ):void {
		
		// want to mix the default color * DEFAULT (intensity) + lob.color * $lob.avg
		//color = Color.combineRGBAndIntensity( color, DEFAULT, $lob.color, $lob.avg );
		Log.out( "Brightness.colorMix premix: " + Color.displayInHex( color ) + "  lightColor: " + Color.displayInHex( $lightColor ) );
		//color = Color.test( color, DEFAULT, $lightColor, $lob.max );
		color = Color.testInt( color, DEFAULT, $lightColor, $lob.max );
		Log.out( "Brightness.colorMix postmx: " + Color.displayInHex( color ) );
	}
	
	public function addInfluence( $lob:Brightness, $faceFrom:int, $faceOnly:Boolean, $grainUnits:int, $lightColor:uint ):Boolean
	{
		_s_sb2.copyFrom( this );		
		lastLight = $lob.lastLight;
		
		colorMix( $lob, $lightColor );
		
		const attenScaled:Number = _atten * ($grainUnits/16);
		if ( Globals.POSX == $faceFrom ) {
			
			if ( b000 < $lob.b100 ) { b000 = $lob.b100; }
			if ( b010 < $lob.b110 ) { b010 = $lob.b110; }
			if ( b011 < $lob.b111 ) { b011 = $lob.b111; }
			if ( b001 < $lob.b101 ) { b001 = $lob.b101; }
			if ( !$faceOnly ) {
				if ( b100 < ( b000 - attenScaled ) ) { b100 = ( b000 - attenScaled ); }
				if ( b110 < ( b010 - attenScaled ) ) { b110 = ( b010 - attenScaled ); }
				if ( b111 < ( b011 - attenScaled ) ) { b111 = ( b011 - attenScaled ); }
				if ( b101 < ( b001 - attenScaled ) ) { b101 = ( b001 - attenScaled ); }
			}
		}
		else if ( Globals.NEGX == $faceFrom ) {

			if ( b100 < $lob.b000 ) { b100 = $lob.b000; }
			if ( b110 < $lob.b010 ) { b110 = $lob.b010; }
			if ( b111 < $lob.b011 ) { b111 = $lob.b011; }
			if ( b101 < $lob.b001 ) { b101 = $lob.b001; }
			if ( !$faceOnly ) {
				if ( b000 < ( b100 - attenScaled ) ) { b000 = ( b100 - attenScaled ); }
				if ( b010 < ( b110 - attenScaled ) ) { b010 = ( b110 - attenScaled ); }
				if ( b011 < ( b111 - attenScaled ) ) { b011 = ( b111 - attenScaled ); }
				if ( b001 < ( b101 - attenScaled ) ) { b001 = ( b101 - attenScaled ); }
			}
		}
		else if ( Globals.POSY == $faceFrom ) {

			if ( b000 < $lob.b010 ) { b000 = $lob.b010; }
			if ( b100 < $lob.b110 ) { b100 = $lob.b110; }
			if ( b101 < $lob.b111 ) { b101 = $lob.b111; }
			if ( b001 < $lob.b011 ) { b001 = $lob.b011; }
			if ( !$faceOnly ) {
				if ( b010 < ( b000 - attenScaled ) ) { b010 = ( b000 - attenScaled ); }
				if ( b110 < ( b100 - attenScaled ) ) { b110 = ( b100 - attenScaled ); }
				if ( b111 < ( b101 - attenScaled ) ) { b111 = ( b101 - attenScaled ); }
				if ( b011 < ( b001 - attenScaled ) ) { b011 = ( b001 - attenScaled ); }
			}
		}
		else if ( Globals.NEGY == $faceFrom ) {

			if ( b010 < $lob.b000 ) { b010 = $lob.b000; }
			if ( b110 < $lob.b100 ) { b110 = $lob.b100; }
			if ( b111 < $lob.b101 ) { b111 = $lob.b101; }
			if ( b011 < $lob.b001 ) { b011 = $lob.b001; }
			if ( !$faceOnly ) {
				if ( b000 < ( b010 - attenScaled ) ) { b000 = ( b010 - attenScaled ); }
				if ( b100 < ( b110 - attenScaled ) ) { b100 = ( b110 - attenScaled ); }
				if ( b101 < ( b111 - attenScaled ) ) { b101 = ( b111 - attenScaled ); }
				if ( b001 < ( b011 - attenScaled ) ) { b001 = ( b011 - attenScaled ); }
			}
		}
		else if ( Globals.POSZ == $faceFrom ) {

			if ( b000 < $lob.b001 ) { b000 = $lob.b001; }
			if ( b010 < $lob.b011 ) { b010 = $lob.b011; }
			if ( b110 < $lob.b111 ) { b110 = $lob.b111; }
			if ( b100 < $lob.b101 ) { b100 = $lob.b101; }
			if ( !$faceOnly ) {
				if ( b001 < ( b000 - attenScaled ) ) { b001 = ( b000 - attenScaled ); }
				if ( b011 < ( b010 - attenScaled ) ) { b011 = ( b010 - attenScaled ); }
				if ( b111 < ( b110 - attenScaled ) ) { b111 = ( b110 - attenScaled ); }
				if ( b101 < ( b100 - attenScaled ) ) { b101 = ( b100 - attenScaled ); }
			}
		}
		else if ( Globals.NEGZ == $faceFrom ) {
			
			if ( b001 < $lob.b000 ) { b001 = $lob.b000; }
			if ( b011 < $lob.b010 ) { b011 = $lob.b010; }
			if ( b111 < $lob.b110 ) { b111 = $lob.b110; }
			if ( b101 < $lob.b100 ) { b101 = $lob.b100; }
			if ( !$faceOnly ) {
				if ( b000 < ( b001 - attenScaled ) ) { b000 = ( b001 - attenScaled ); }
				if ( b010 < ( b011 - attenScaled ) ) { b010 = ( b011 - attenScaled ); }
				if ( b110 < ( b111 - attenScaled ) ) { b110 = ( b111 - attenScaled ); }
				if ( b100 < ( b101 - attenScaled ) ) { b100 = ( b101 - attenScaled ); }
			}
		}
		
		var changed:Boolean = !_s_sb2.equals( this );
		return changed;
	}
	
} // end of class FlowInfo
} // end of package
