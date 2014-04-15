package com.voxelengine.worldmodel.scripts 
{
	import com.voxelengine.worldmodel.SoundBank;
	import com.voxelengine.worldmodel.weapons.Ammo;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Bob
	 */
	
	 
	public class ImpactScript extends Script 
	{
		
		protected var _ammo:Ammo 		= null;
		
		public function ImpactScript( $ammo:Ammo ) 
		{
			_ammo = $ammo;
		}
		
		public function impact( wsLoc:Vector3D ):void
		{
			throw new Error( "ImpactScript.impact - ERROR this function needs to be overridden" );
		}
		
		protected function impactSound():void
		{
			SoundBank.playSound( SoundBank.getSound( _ammo.impactSoundFile ) );
		}
		
		
	}

}