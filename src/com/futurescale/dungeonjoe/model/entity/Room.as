/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.model.entity
{
	public class Room
	{
		public var row:Number;
		public var col:Number;
		public var items:Array;
		
		public function Room( row:Number, col:Number )
		{
			this.row = row;
			this.col = col;
			this.items = [];
		}
		
		public function isEmpty():Boolean
		{
			return (items.length == 0);
		}
		
		/**
		 * Add an item to the room.
		 */
		public function addItem( item:DungeonItem ):void
		{
			items.push( item );
		}
		
		/**
		 * Does the room have an item of the given type?
		 */
		public function hasItem( type:String ):Boolean
		{
			var has:Boolean = false;
			for each (var item:DungeonItem in items)
			{
				if (item.type == type) has=true;
				break;
			}
			return has;
		}
		
		/**
		 * Remove the item of the given type from the room.
		 */
		public function removeItem( type:String ):Boolean
		{
			var removed:Boolean = false;
			for (var i:int=0; i<items.length; i++)
			{
				if (DungeonItem(items[i]).type == type) {
					items.splice(i,1);
					removed = true;
					break;
				}
			}
			return removed;
		}
		
		/**
		 * Get the location of this room.
		 */
		public function get location():String
		{
			return getLocation( this.row, this.col );
		}
		
		public function hasJoe():Boolean
		{
			return hasItem(DungeonItem.JOE);
		}
		
		public function hasSword():Boolean
		{
			return hasItem(DungeonItem.SWORD);
		}
		
		public function hasRope():Boolean
		{
			return hasItem(DungeonItem.ROPE);
		}
		
		public function hasBall():Boolean
		{
			return hasItem(DungeonItem.BALL);
		}

		public function hasDragon():Boolean
		{
			return hasItem(DungeonItem.DRAGON);
		}
		
		public function hasPit():Boolean
		{
			return hasItem(DungeonItem.PIT);
		}
		
		public function hasWyvern():Boolean
		{
			return hasItem(DungeonItem.WYVERN);
		}
		
		public function hasTreasure():Boolean
		{
			return hasItem(DungeonItem.TREASURE);
		}
		
		public function hasDamsel():Boolean
		{
			return hasItem(DungeonItem.DAMSEL);
		}
		
		/**
		 * Class method to get a location string from coordinates.
		 */
		public static function getLocation( row:Number, col:Number ):String
		{
			return rows[row]+String(col);
		}
		
		/**
		 * Class method to get coordinates from location string.
		 */
		public static function getCoords( location:String ):Array
		{
			var coords:Array = [];
			var r:String = location.charAt(0); 	// row
			var c:String = location.charAt(1); 	// col
			for (var i:int; i<10; i++) { 		// convert the row char
				if (rows[i] == r) {
					coords.push(i);				// store row num
					break;
				}
			}
			coords.push(Number(c));				// store col num
			return coords;
		}
		
		// The alpha characters representing rows 0-9
		private static const rows:Array = [ 'A', 'B','C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' ];
	}
}