/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.landscapetasks
{
	import com.developmentarc.core.tasks.tasks.AbstractTask;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class ParticleTask extends AbstractTask 
	{		
		protected var _vm:VoxelModel;
		protected var _startTime:int;
		
		public static const TASK_TYPE:String = "PARTICLE_TASK";
        public static const TASK_PRIORITY:int = 2;
		
		public function ParticleTask( $vm:VoxelModel, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			_startTime = getTimer();
			_vm = $vm;	
			super($taskType, $taskPriority);
		}
		
	}
}