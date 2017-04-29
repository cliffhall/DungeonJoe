/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.constant.view
{
	import com.futurescale.dungeonjoe.model.entity.DungeonItem;

	public class ViewStates
	{
		// Character View States
		public static const CHARACTER_IDLE:String			= "Idle";
		public static const CHARACTER_DEAD:String			= "Dead";
		public static const CHARACTER_PLAY:String			= "Play";
		
		// Dungeon Area View States
		public static const DUNGEON_AREA_IDLE:String		= "Idle";
		public static const DUNGEON_AREA_PLAY:String		= "Play";
		public static const DUNGEON_AREA_FULL:String		= "Full";

		// Health and Title View States
		public static const HEALTH_AND_TITLE_IDLE:String	= "Idle";
		public static const HEALTH_AND_TITLE_PLAY:String	= "Play";
		public static const HEALTH_AND_TITLE_SCORE:String	= "Score";
		
		// Icon View States
		public static const ICON_IDLE:String				= "Idle";
		public static const ICON_SLOT:String				= "Slot";
		public static const ICON_HAVE:String				= "Have";
		public static const ICON_ROOM:String				= "Room";
		public static const ICON_WARN:String				= "Warn";

		// Location View States
		public static const LOCATION_IDLE:String			= "Idle";
		public static const LOCATION_LEVEL:String			= "Level";
		public static const LOCATION_PLAY:String			= "Play";

		// Level Contents View States
		public static const LEVEL_CONTENTS_IDLE:String		= "Idle";
		public static const LEVEL_CONTENTS_LEVEL:String		= "Level";
		
		// Score Display View States
		public static const SCORE_DISPLAY_IDLE:String		= "Idle";
		public static const SCORE_DISPLAY_SCORE:String		= "Score";
		
		// Playfield View States
		public static const PLAYFIELD_WELCOME:String		= "Welcome";
		public static const PLAYFIELD_LEVEL:String			= "Level";
		public static const PLAYFIELD_PLAY:String			= "Play";
		public static const PLAYFIELD_SCORE:String			= "Score";
	}
}