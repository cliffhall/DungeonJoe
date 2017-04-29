/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.model.entity
{
	import com.futurescale.dungeonjoe.model.modelns;

	use namespace modelns;
	
	public class Character extends DungeonItem
	{

		public function Character()
		{
			super(JOE);	
		}
		
		public var health:Number 		= 100;
		public var level:Number 		= 0;
		public var location:String;
		public var dead:Boolean			= false;
		
		public var levelHealth:Array	= [];
		public var levelBooty:Array 	= [];
		public var levelDamsel:Array 	= [];
		public var levelTreasure:Array 	= [];
		
		public var rope:DungeonItem;
		public var ball:DungeonItem;
		public var sword:DungeonItem;
		
		public var treasure:DungeonItem;
		public var damsel:DungeonItem;
		public var dragon:DungeonItem;

		
		/**
		 * Calculate the final score.
		 */
		public function finalScore():Number
		{
			var score:Number = 0;
			for ( var l:Number=1; l<level; l++)
			{
				score += levelScore(l);
			}
			return score;
		}
		
		/**
		 * Calculate the score for a given level.
		 */
		public function levelScore( l:Number ):Number
		{
			return l * ( levelHealth[l] + levelBooty[l] );
		}
		
		public function hasItem( type:String ):Boolean
		{
			var has:Boolean = false;
			switch ( type ) 
			{
				case DungeonItem.BALL:
					has = (ball != null);
					break;
				
				case DungeonItem.DAMSEL:
					has = (damsel != null);
					break;
				
				case DungeonItem.ROPE:
					has = (rope != null);
					break;
				
				case DungeonItem.SWORD:
					has = (sword != null);
					break;
				
				case DungeonItem.TREASURE:
					has = (treasure != null);
					break;
				
				default:
					has = false;
					break;
			}
			
			return has;
		}

		modelns function takeItem( item:DungeonItem ):Boolean
		{
			var taken:Boolean = true;
			switch ( item.type ) 
			{
				case DungeonItem.BALL:
					ball = item;
					break;
				
				case DungeonItem.DAMSEL:
					damsel = item;
					break;
				
				case DungeonItem.ROPE:
					rope = item;
					break;
				
				case DungeonItem.SWORD:
					sword = item;
					break;
				
				case DungeonItem.TREASURE:
					treasure = item;
					break;
				
				default:
					taken = false;
					break;
			}
			
			return taken;
		}
		
		modelns function useItem( item:DungeonItem ):Boolean
		{
			var used:Boolean = true;
			switch ( item.type ) 
			{
				case DungeonItem.BALL:
					if (ball) ball = null;
					break;
				
				case DungeonItem.ROPE:
					if (rope) rope = null;
					break;
				
				case DungeonItem.SWORD:
					if (sword) sword = null;
					break;
				
				default:
					used = false;
					break;
			}
			return used;
			
		}
		
		modelns function reduceHealth( points:Number = 1 ):Number
		{
			health = health - points;
			if (health <= 0) dead = true;
			return health;
		}
		
		
		
	}
}