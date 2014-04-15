/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer {

import flash.geom.Vector3D;
	
public class ShaderLight {
	public var position:Vector3D = new Vector3D();
	public var color:Vector3D = new Vector3D( 1, 1, 0.6, 1 );
	public var endDistance:Number = 400;
	public var nearDistance:Number = 1;
}
}

