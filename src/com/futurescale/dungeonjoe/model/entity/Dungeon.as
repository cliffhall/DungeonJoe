/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.model.entity
{
	import com.futurescale.dungeonjoe.model.modelns;

	use namespace modelns;
	public class Dungeon
	{
		public var rooms:Array;		// room[location] map
		public var pits:Array;		// locations of the pits
		public var wyverns:Array;	// locations of the wyverns
		public var dragon:String	// location of dragon
		
		public function Dungeon( )
		{
		}
		
		/**
		 * Create a whole new set of empty rooms
		 * <P>
		 * Note: Use of modelns Namespace indicates only model classes should call.
		 * </P>
		 */
		modelns function create():void
		{
			rooms = [];
			pits = [];
			wyverns = [];
			dragon = "";
			for (var row:Number=0; row<10; row++) {
				for (var col:Number=0; col<10; col++) {
					var room:Room = new Room(row,col);
					rooms[room.location] = room;
				}  
			}  
		}
				
		/**
		 * Add an item to the dungeon at the given coordinates.
		 * <P>
		 * Note: Use of modelns Namespace indicates only model classes should call.
		 * </P>
		 */
		modelns function addItem( item:DungeonItem, location:String ):void
		{
			// add the item to the room
			var room:Room = rooms[location];
			room.addItem(item);
			// also, store the locations of the pits and wyverns
			switch (item.type) 
			{
				case DungeonItem.PIT:
					pits.push(location);
					break;
				
				case DungeonItem.WYVERN:
					wyverns.push(location);
					break;
				
				case DungeonItem.DRAGON:
					dragon = location;
					break;
				
			}
		}
		
		/**
		 * Remove an item from the dungeon.
		 * <P>
		 * Note: Use of modelns Namespace indicates only model classes should call.
		 * </P>
		 */
		modelns function removeItem( type:String, location:String ):void
		{
			// remove the item from the room
			var room:Room = getRoom(location);
			room.removeItem(type);
		}

		/** 
		 * Get the Room at the given location.
		 */
		public function getRoom( location:String ):Room
		{
			return rooms[ location ];
		}

		/** 
		 * Get the four orthanganally adjacent Rooms
		 * to a given room.
		 */
		public function getAdjacentRooms( room:Room ):Array
		{
			return [ getAdjacentRoomNorth( room ),
					 getAdjacentRoomSouth( room ),
					 getAdjacentRoomEast( room ),
					 getAdjacentRoomWest( room )
					];
		}
		
		/** 
		 * Get the north adjacent room
		 * <P>
		 * Used by character when moving.</P>
		 */
		public function getAdjacentRoomNorth( room:Room ):Room
		{
			var row:Number = room.row;
			row--;
			if (row <0) row = 9;
			return rooms[ Room.getLocation( row ,room.col ) ];
		}
		
		/** 
		 * Get the south adjacent room
		 * <P>
		 * Used by character when moving.</P>
		 */
		public function getAdjacentRoomSouth( room:Room ):Room
		{
			var row:Number = room.row;
			row++;
			if ( row > 9 ) row = 0;
			return rooms[ Room.getLocation( row , room.col ) ];
		}
		
		/** 
		 * Get the east adjacent room
		 * <P>
		 * Used by character when moving.</P>
		 */
		public function getAdjacentRoomEast( room:Room ):Room
		{
			var col:Number = room.col;
			col++;
			if ( col > 9 ) col = 0;
			return rooms[ Room.getLocation( room.row, col ) ];
		}
		
		/** 
		 * Get the west adjacent room
		 * <P>
		 * Used by character when moving.</P>
		 */
		public function getAdjacentRoomWest( room:Room ):Room
		{
			var col:Number = room.col;
			col--;
			if ( col < 0 ) col = 9;
			return rooms[ Room.getLocation( room.row, col ) ];
		}

		/** 
		 * Get a random adjacent room. 
		 * <P>
		 * Used by wyverns when moving.</P>
		 */
		public function getRandomAdjacentRoom( room:Room ):Room
		{
			var direction:Number = Math.floor( Math.random() * 4 );
			return getAdjacentRooms(room)[direction];
		}
		
		/**
		 * Get a Room from the Dungeon at random.
		 */
		public function getRandomRoom():Room
		{
			// choose a random room location
			var row:Number = Math.floor( Math.random() * 10 );
			var col:Number = Math.floor( Math.random() * 10 );
			
			// return the actual room
			return rooms[ Room.getLocation( row, col ) ];
		}

		/**
		 * Get an empty Room from the Dungeon at random.
		 */
		public function getRandomEmptyRoom():Room
		{
			var room:Room;
			do {
				room = getRandomRoom();
			} while ( !room.isEmpty() );
				
			return room;
		}
		
		/**
		 * Get an empty Room from the Dungeon at random.
		 */
		public function checkProximityForItem(type:String, room:Room ):Boolean
		{
			var found:Boolean = false;
			for each (var adjacentRoom:Room in getAdjacentRooms(room))
			{
				if (adjacentRoom.hasItem(type)) {
					found = true;
					break
				}
			}
			return found;
		}
	}
}