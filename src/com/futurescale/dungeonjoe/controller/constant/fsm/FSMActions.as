/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.constant.fsm
{
	import com.futurescale.dungeonjoe.model.entity.DungeonItem;

	public class FSMActions
	{
		// FSM Action namespace
		private static const FSM_ACTION:String = "FSM/action/";

		// Begin the Game
		public static const BEGIN:String       = FSM_ACTION+"begin";

		// Restart the Game
		public static const RESTART:String     = FSM_ACTION+"restart";

		// Quit the game
		public static const QUIT:String        = FSM_ACTION+"quit";

		// Move to another room
		public static const MOVE:String        = FSM_ACTION+"move";
		public static const MOVED:String       = FSM_ACTION+"moved";

		// Captured by a Wyvern
		public static const CAPTURED:String    = FSM_ACTION+"captured";

		// Dropped by a Wyvern
		public static const DROPPED:String     = FSM_ACTION+"dropped";

		// Fall into the pit
		public static const PITFALL:String     = FSM_ACTION+"pitfall";

		// Die - Dragon killed
		public static const DIE:String         = FSM_ACTION+"die";

		// Go to next level
		public static const NEXT_LEVEL:String  = FSM_ACTION+"next/level";

		// Win - last level completed!
		public static const WIN:String         = FSM_ACTION+"win";

		// Take an item from the room
		public static const TAKE_ITEM:String   = FSM_ACTION+"take/item";
		public static const TAKEN:String       = FSM_ACTION+"taken";

		// Use an item
		public static const USE_ITEM:String    = FSM_ACTION+"use/item";
		public static const USED:String        = FSM_ACTION+"used";
	}
}