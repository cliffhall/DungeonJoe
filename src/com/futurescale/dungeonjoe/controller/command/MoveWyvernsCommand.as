/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
    import com.futurescale.dungeonjoe.controller.util.AsyncUtil;
    import com.futurescale.dungeonjoe.model.entity.Dungeon;
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.entity.Room;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * Move the wyverns.
	 * <P>
	 * Every 10 seconds any or all wyverns may move to 
	 * adjacent rooms. Sends DungeonProxy.WYVERN_MOVED
	 * when a wyvern moves.
	 * </P>
	 */
    public class MoveWyvernsCommand extends SimpleCommand
    {
		private var dp:DungeonProxy;

		override public function execute( note:INotification ) : void    
        {
			// get proxies
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			var dungeon:Dungeon = dp.dungeon;	
			
			// Build a list of the new locations of all wyverns
			var newWyvernLocations:Array = [];
			
			// Did a move catch the character?
			var caughtJoe:Boolean = false;
			
			// Flip a coin for each wyvern and try to move it if heads.
			for each ( var location:String in dungeon.wyverns )
			{
				// get the current room
				var currentRoom:Room = dungeon.getRoom( location );
				var newRoom:Room;
				
				// Flip coin to decide if we want to move
				if (Math.random() > .5) 
				{
					// look for an adjacent room with no wyvern, dragon or pit occupying it
					var adjacentRooms:Array = dungeon.getAdjacentRooms(currentRoom);
					newRoom = null;
					do {
						newRoom = adjacentRooms.shift();
						
						// If joe is in the adjacent room, we smell him and go there 
						if ( newRoom.hasJoe() ) break; 

						// flip coin to decide if we want to move into the selected room
						if ( Math.random() < .5 || !newRoom.isEmpty() ) newRoom = null;

					} while ( newRoom == null && adjacentRooms.length > 0 );
					
					// if suitable room is found, move the wyvern
					if (newRoom) 
					{
						var wyvern:DungeonItem = new DungeonItem( DungeonItem.WYVERN ); 
						currentRoom.removeItem( DungeonItem.WYVERN );
						newRoom.addItem( wyvern );
						newWyvernLocations.push( newRoom.location );
						sendNotification( DungeonProxy.WYVERN_MOVED, newRoom );
						if ( newRoom.hasJoe() ) caughtJoe = true;
					} else {
						newWyvernLocations.push( currentRoom.location ); // if it couldn't find a suitable room 
					}
					
				} else {
					newWyvernLocations.push( currentRoom.location ); // if it didn't move at all
				}								
			}
			
			dungeon.wyverns = newWyvernLocations;
			if (caughtJoe) AsyncUtil.callLater( sendNotification,[ StateMachine.ACTION, null, FSMActions.CAPTURED ] );

		}
    }
}