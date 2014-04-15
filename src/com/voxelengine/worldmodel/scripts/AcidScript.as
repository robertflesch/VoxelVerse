package com.voxelengine.worldmodel.scripts 
{
import flash.geom.Vector3D;

import com.voxelengine.Globals;
import com.voxelengine.Log;
import com.voxelengine.worldmodel.models.VoxelModel;
import com.voxelengine.worldmodel.weapons.Ammo;
import com.voxelengine.events.ImpactEvent;


/**
 * ...
 * @author Bob
 */

 
public class AcidScript extends ImpactScript 
{
	
	public function AcidScript( $ammo:Ammo ) 
	{
		super( $ammo );
	}
	
	override public function impact( $wsLoc:Vector3D ):void
	{
		var vm:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
		if ( vm )
			vm.instanceInfo.dead = true;

		Log.out( "AcidScript.impact - at x: " + $wsLoc.x + " y: " + $wsLoc.y + "  z: " + $wsLoc.z );
		
		Globals.g_app.dispatchEvent( new ImpactEvent( ImpactEvent.ACID, $wsLoc, _ammo.grain * 4, _ammo.grain * 2, instanceGuid ) );
		
		impactSound();
	}
}
}