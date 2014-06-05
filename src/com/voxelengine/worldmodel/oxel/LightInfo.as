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

public class LightInfo
{
	public static const MAX:uint = 0xff;
	
	public var lightIs:Boolean = false;
	public var processed:Boolean = false;
	public var ID:uint
	public var color:uint;
	private var bLower:uint;
	private var bHigher:uint;
	
	
	public function LightInfo( $ID:uint, $color:uint, $attn:uint, $lightIs:Boolean ) {		
		ID = $ID;
		color = $color;
		lightIs = $lightIs;
		bLower = $attn;
		bHigher = $attn;
	}
	
	public function toByteArray( $ba:ByteArray ):ByteArray {
		$ba.writeBoolean( lightIs );
		$ba.writeUnsignedInt( ID );
		$ba.writeUnsignedInt( color );
		$ba.writeUnsignedInt( bLower );
		$ba.writeUnsignedInt( bHigher );
		return $ba;
	}
	
	public function fromByteArray( $ba:ByteArray ):ByteArray {
		lightIs = $ba.readBoolean();
		ID  	= $ba.readUnsignedInt();
		color	= $ba.readUnsignedInt();
		bLower	= $ba.readUnsignedInt();
		bHigher	= $ba.readUnsignedInt();
		return $ba;
	}
	
	public function toString():String {
		return (" LightInfo - ID: " + ID + " color: " + color + " bLower: " + bLower + " bHigher: " + bHigher);
	}

	public function copyFrom( $li:LightInfo ):void {
		ID = $li.ID;
		color = $li.color;
		bLower = $li.bLower;
		bHigher = $li.bHigher;
		lightIs = $li.lightIs;
	}
	
	public function get avg():uint {
		return (b000 + b010 + b011 + b001 + b100 + b110 +  b111 + b101)/8
	}

	public function setAll( $attn:uint ):void	{
		
		if ( LightInfo.MAX < $attn )
			throw new Error( "LightInfo.setAll - attn > MAX" );

		b000 = $attn;
		b001 = $attn;
		b100 = $attn;
		b101 = $attn;
		b010 = $attn;
		b011 = $attn;
		b110 = $attn;
		b111 = $attn;
	}
	
	public function vertexInfoGet( $vertex:uint ):uint {
		if (       Brightness.B000 == $vertex ) 
			return b000;
		else if (  Brightness.B001 == $vertex ) 
			return b001;
		else if (  Brightness.B100 == $vertex ) 
			return b100;
		else if (  Brightness.B101 == $vertex ) 
			return b101;
		else if (  Brightness.B010 == $vertex ) 
			return b010;
		else if (  Brightness.B011 == $vertex ) 
			return b011;
		else if (  Brightness.B110 == $vertex ) 
			return b110;
		else 
			return b111; // if (  Brightness.B111 ) 
		
		return 0xff;
	}
	
	public function get b000():uint { return ((bLower  & 0x000000ff)); }
	public function get b001():uint { return ((bLower  & 0x0000ff00) >> 8); }
	public function get b100():uint { return ((bLower  & 0x00ff0000) >> 16); }
	public function get b101():uint { return ((bLower  & 0xff000000) >>> 24); }
	public function get b010():uint { return ((bHigher & 0x000000ff)); }
	public function get b011():uint { return ((bHigher & 0x0000ff00) >> 8); }
	public function get b110():uint { return ((bHigher & 0x00ff0000) >> 16); }
	public function get b111():uint { return ((bHigher & 0xff000000) >>> 24); }
	
	public function set b000( attn:uint ):void { bLower  = ((bLower  & 0xffffff00) | attn); }
	public function set b001( attn:uint ):void { bLower  = ((bLower  & 0xffff00ff) | (attn << 8)); }
	public function set b100( attn:uint ):void { bLower  = ((bLower  & 0xff00ffff) | (attn << 16)); }
	public function set b101( attn:uint ):void { bLower  = ((bLower  & 0x00ffffff) | (attn << 24)); }
	public function set b010( attn:uint ):void { bHigher = ((bHigher & 0xffffff00) | attn); }
	public function set b011( attn:uint ):void { bHigher = ((bHigher & 0xffff00ff) | (attn << 8)); }
	public function set b110( attn:uint ):void { bHigher = ((bHigher & 0xff00ffff) | (attn << 16)); }
	public function set b111( attn:uint ):void { bHigher = ((bHigher & 0x00ffffff) | (attn << 24)); }
	
} // end of class LughtInfo
} // end of package
