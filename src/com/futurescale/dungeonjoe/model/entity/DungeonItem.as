/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.model.entity
{
	public class DungeonItem
	{
		public static const JOE:String 		= "Dungeon Joe";

		public static const TREASURE:String = "Hidden Treasure";
		public static const DAMSEL:String 	= "Damsel in Distress";

		public static const SWORD:String 	= "Magic Sword";
		public static const BALL:String 	= "Crystal Ball";
		public static const ROPE:String 	= "Enchanted Rope";

		public static const WYVERN:String 	= "Wyvern";
		public static const PIT:String 		= "Pit";
		public static const DRAGON:String 	= "Dragon";

		public function DungeonItem( type:String )
		{
			this.type = type;
		}

		public var type:String;

	}
}