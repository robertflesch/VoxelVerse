/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer {

import flash.geom.Vector3D;
	
public class Lamp extends ShaderLight {
	
	public function Lamp( r:Number = 1, g:Number = 0.9, b:Number = 0 ) {
		color.setTo( r, g, b );
		endDistance = 200;
	}
}
}

