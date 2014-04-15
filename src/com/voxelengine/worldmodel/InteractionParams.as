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
public class InteractionParams
{
	private var _type:String = "AIR";
	private var _effectiveness:Number = 0;
	private var _script:String = "destroy";
	private var _belongsTo:String;
	
	public function InteractionParams( $belongsTo:String )
	{ 
		_belongsTo = $belongsTo; 
	}
	
	public function setDefault():void
	{
		_type = "AIR";
		_effectiveness = 100;
		_script = "destroyOxel";
	}
	
	public function fromJson( $interactionJson:Object ):void
	{
		if ( 3 == $interactionJson.length )
		{
			_type = $interactionJson[0];
			_effectiveness = $interactionJson[1];
			_script = $interactionJson[2];
		}
		else
		{
			Log.out( "InteractionParams.fromJson for " + _belongsTo + " invalid length", Log.ERROR );
			for ( var i:int = 0; i < $interactionJson.length; i++ )
			{
				Log.out( "InteractionParams.fromJson param[ " + i + " ]: " + $interactionJson[i], Log.ERROR );
			}
		}
	}
	
	public function get type():String 
	{
		return _type;
	}
	
	public function get effectiveness():Number 
	{
		return _effectiveness;
	}
	
	public function get script():String 
	{
		return _script;
	}
}
}