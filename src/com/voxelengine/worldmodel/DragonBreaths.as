/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and prStringed documentation which are original works of
  authorship protected under uStringed States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel
{
import com.voxelengine.Globals;
import com.voxelengine.Log;
/**
 * ...
 * @author Bob
 */
public class DragonBreaths
{
	private var _fire:String = "AIR";
	private var _ice:String = "AIR";
	private var _acid:String = "AIR"; 
	private var _water:String = "AIR"; 
	private var _air:String = "AIR";
	private var _earth:String = "AIR";
	public function DragonBreaths() { ;}
	
	public function fromJson( db:Object ):void
	{
		fire = db.fire;
		ice = db.ice;
		water = db.water; 
		air = db.air;
		earth = db.earth;
		acid = db.acid;
	}
	
	public function get earth():String 
	{
		return _earth;
	}
	
	public function set earth(value:String):void 
	{
		_earth = value;
	}
	
	public function get air():String 
	{
		return _air;
	}
	
	public function set air(value:String):void 
	{
		_air = value;
	}
	
	public function get water():String 
	{
		return _water;
	}
	
	public function set water(value:String):void 
	{
		_water = value;
	}
	
	public function get ice():String 
	{
		return _ice;
	}
	
	public function set ice(value:String):void 
	{
		_ice = value;
	}
	
	public function get fire():String 
	{
		return _fire;
	}
	
	public function set fire(value:String):void 
	{
		_fire = value;
	}
	
	public function get acid():String 
	{
		return _acid;
	}
	
	public function set acid(value:String):void 
	{
		_acid = value;
	}
}
}