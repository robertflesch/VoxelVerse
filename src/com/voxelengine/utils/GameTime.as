/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.utils
{
 
    /**
    *   A Vector3D with extended functionality
    *   @author 
    */
    // Summary:
    //     Snapshot of the game timing state expressed in values that can be used by
    //     variable-step (real time) or fixed-step (game time) games.
    public class GameTime
    {
        // Summary:
        //     Creates a new instance of GameTime.
        public function GameTime():void
		{
		}
        //
        // Summary:
        //     Creates a new instance of GameTime.
        //
        // Parameters:
        //   totalGameTime:
        //     The amount of game time since the start of the game.
        //
        //   elapsedGameTime:
        //     The amount of elapsed game time since the last update.
        //public function GameTime(TimeSpan totalGameTime, TimeSpan elapsedGameTime):void
		//{
		//}
		//
        // Summary:
        //     Creates a new instance of GameTime.
        //
        // Parameters:
        //   totalGameTime:
        //     The amount of game time since the start of the game.
        //
        //   elapsedGameTime:
        //     The amount of elapsed game time since the last update.
        //
        //   isRunningSlowly:
        //     Whether the game is running multiple updates this frame.
        //public GameTime(TimeSpan totalGameTime, TimeSpan elapsedGameTime, bool isRunningSlowly):void
		//{
		//}

        // Summary:
        //     The amount of elapsed game time since the last update.
        public function elapsedGameTime():int { return 1; }
        //
        // Summary:
        //     Gets a value indicating that the game loop is taking longer than its TargetElapsedTime.
        //     In this case, the game loop can be considered to be running too slowly and
        //     should do something to "catch up."
        //public bool IsRunningSlowly { get; }
        //
        // Summary:
        //     The amount of game time since the start of the game.
        public function TotalGameTime():int { return 1; }
    }
}