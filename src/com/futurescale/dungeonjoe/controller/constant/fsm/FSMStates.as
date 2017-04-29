/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.constant.fsm
{
	public class FSMStates
	{
		// FSM States namespace
		private static const FSM_STATE:String			= "FSM/state/";
		
		// Showing the welcome screen
		public static const WELCOMING:String 			= FSM_STATE+"welcoming";

		// Quitting the game
		public static const QUITTING:String 			= FSM_STATE+"quitting";
		
		// Preparing the level about to be played
		public static const PREPARING_LEVEL:String 		= FSM_STATE+"preparing/level";
		
		// Showing the score after the user has died or completed the last level
		public static const SHOWING_SCORE:String 		= FSM_STATE+"showing/score";

		// Character is Waiting in a Room
		public static const WAITING_IN_ROOM:String 		= FSM_STATE+"waiting/in/room";
		
		// Character is Waiting in Pit
		public static const WAITING_IN_PIT:String 		= FSM_STATE+"waiting/in/pit";

		// Character is being carried through the dungeon by a wyvern
		public static const BEING_CARRIED:String 		= FSM_STATE+"being/carried";
		
		// Character is Moving 
		public static const MOVING_CHARACTER:String 	= FSM_STATE+"moving/character";
		
		// Using the Sword, Rope or Crystal Ball
		public static const USING_ITEM:String 			= FSM_STATE+"using/item";
		
		// Taking the Treasure, Damsel, Rope, Sword or Crystal Ball
		public static const TAKING_ITEM:String 			= FSM_STATE+"taking/item";
		
	}
}