package com.voxelengine.worldmodel.models
{
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.utils.GameTime;
	import com.voxelengine.utils.Gravity;
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
    import flash.geom.Vector3D;
	import flash.display3D.Context3D;
	import flash.geom.Matrix3D;


    public class Avatar extends VoxelModel
    {
		public function Avatar( instanceInfo:InstanceInfo, mi:ModelInfo ) 
		{ 
			trace( "Avatar CREATED" );
			super( instanceInfo, mi );
		}
	}
}