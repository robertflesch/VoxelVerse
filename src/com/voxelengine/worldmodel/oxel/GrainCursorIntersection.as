package com.voxelengine.worldmodel.oxel
{
import com.voxelengine.Globals;
import flash.geom.Vector3D;
import com.voxelengine.worldmodel.models.VoxelModel;

public class GrainCursorIntersection
{
	public var point:Vector3D = new Vector3D();
	public var oxel:Oxel = null;
	public var model:VoxelModel = null;
	public var gc:GrainCursor = new GrainCursor();
	public var axis:int;
	public var near:Boolean = true;
	
	public final function toString():String
	{
		if ( gc && model )
			return " GCI Info: point: " + point + " gc: " + gc + " model: " + model.instanceInfo.templateName; 
		if ( gc )
			return " GCI Info: point: " + point + " gc: " + gc; 
		else			
			return " GCI Info: point: " + point; 
	}
}
}