/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.constant.fsm
{
	/**
	 * Announcements sent from the StateMachine
	 * <P>
	 * These are notification names sent as State-specific
	 * entering and exiting guard announcements and
	 * state changed announcements and
	 */
	public class FSMAnnounce
	{
		// FSM Announcement namespace
		private static const FSM_ANNOUNCE:String            = "FSM/announce/";
		private static const CHANGED:String                 = FSM_ANNOUNCE+"changed/";
		private static const GUARD:String                   = FSM_ANNOUNCE+"guard/";
		private static const ENTER:String                   = GUARD+"enter/";
		private static const EXIT:String                    = GUARD+"exit/";

		// State-specific 'changed' announcements (sent when the transition to the new state is complete)
		public static const CHANGED_BEING_CARRIED:String    =  CHANGED + FSMStates.BEING_CARRIED;
		public static const CHANGED_MOVING_CHARACTER:String =  CHANGED + FSMStates.MOVING_CHARACTER;
		public static const CHANGED_PREPARING_LEVEL:String  =  CHANGED + FSMStates.PREPARING_LEVEL;
		public static const CHANGED_QUITTING:String         =  CHANGED + FSMStates.QUITTING;
		public static const CHANGED_SHOWING_SCORE:String    =  CHANGED + FSMStates.SHOWING_SCORE;
		public static const CHANGED_TAKING_ITEM:String      =  CHANGED + FSMStates.TAKING_ITEM;
		public static const CHANGED_USING_ITEM:String       =  CHANGED + FSMStates.USING_ITEM;
		public static const CHANGED_WAITING_IN_PIT:String   =  CHANGED + FSMStates.WAITING_IN_PIT;
		public static const CHANGED_WAITING_IN_ROOM:String  =  CHANGED + FSMStates.WAITING_IN_ROOM;
		public static const CHANGED_WELCOMING:String        =  CHANGED + FSMStates.WELCOMING;

		// State-specific 'exiting' announcements (sent when the transition from the current state begins)
		public static const EXIT_WELCOMING:String           =  EXIT + FSMStates.WELCOMING;
		public static const EXIT_PREPARING_LEVEL:String     =  EXIT + FSMStates.PREPARING_LEVEL;
		public static const EXIT_SHOWING_SCORE:String       =  EXIT + FSMStates.SHOWING_SCORE;

		// State-specific 'entering' announcements (sent before the transition to the next state state ends)
		public static const ENTER_WELCOMING:String          =  ENTER + FSMStates.WELCOMING;
		public static const ENTER_PREPARING_LEVEL:String    =  ENTER + FSMStates.PREPARING_LEVEL;
		public static const ENTER_SHOWING_SCORE:String      =  ENTER + FSMStates.SHOWING_SCORE;
		public static const ENTER_USING_ITEM:String         =  ENTER + FSMStates.USING_ITEM;
	}
}