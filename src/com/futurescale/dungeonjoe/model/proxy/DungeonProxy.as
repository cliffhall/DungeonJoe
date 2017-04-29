/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.model.proxy
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
    import com.futurescale.dungeonjoe.model.entity.Dungeon;
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.entity.Room;
    import com.futurescale.dungeonjoe.model.modelns;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import mx.controls.Alert;
    
    import org.puremvc.as3.patterns.proxy.Proxy;
    import org.puremvc.as3.utilities.statemachine.StateMachine;
	
	use namespace modelns;
	
    public class DungeonProxy extends Proxy
    {
        public static const NAME:String 			= "DungeonProxy";

		public static const DUNGEON_CREATED:String	= NAME+"/dungeon/created";
		public static const ITEM_ADDED:String		= NAME+"/item/added";
		public static const ITEM_REMOVED:String		= NAME+"/item/removed";
		public static const WYVERN_MOVED:String		= NAME+"/wyvern/moved";
		public static const MOVE_WYVERNS:String		= NAME+"/move/wyverns";
		
        public function DungeonProxy( )
        {
            super( NAME, new Dungeon() );
        }

		/**
		 * Populate the Dungeon with all new, empty rooms.
		 * <P>
		 * Sends DungeonProxy.DUNGEON_CREATED
		 * </P>
		 */
		public function createDungeon():void
		{
			dungeon.create();
			sendNotification( DUNGEON_CREATED, dungeon );
		}

		/**
		 * Start the wyvern move timer.
		 */
		public function beginPlay():void
		{
			timer = new Timer( 10000, 100 );
			timer.addEventListener( TimerEvent.TIMER, moveWyverns );
			timer.start();
		}
		
		/**
		 * Stop the wyvern move timer.
		 */
		public function stopPlay():void
		{
			if (timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, moveWyverns );
				timer = null;
			}
		}
		
		/**
		 * Move the wyverns.
		 * <P>
		 * Every 10 seconds any or all wyverns may move to 
		 * adjacent rooms. Sends DungeonProxy.MOVE_WYVERNS
		 * to trigger MoveWyvernsCommand.
		 * </P>
		 */
		private function moveWyverns( event:TimerEvent ):void
		{
			sendNotification( MOVE_WYVERNS );
		}
		
		
		/**
		 * Add an item to a specified room (or a random empty room if no location specified).
		 * <P>
		 * Sends DungeonProxy.ITEM_ADDED
		 * </P>
		 * @return String the room into which the item was added.
		 */
		public function addItem( item:DungeonItem, proximityCheck:Boolean=false, location:String="" ):void
		{
			if (location=="") {
				var room:Room;
				if (proximityCheck) {
					do
					{
						room = dungeon.getRandomEmptyRoom();
					} 
					while ( dungeon.checkProximityForItem( item.type, room ) );
					
				} else {
					room = dungeon.getRandomEmptyRoom();
				}				
				dungeon.addItem( item, room.location );
				sendNotification( ITEM_ADDED, item, room.location );
			} else {
				dungeon.addItem( item, location );
				sendNotification( ITEM_ADDED, item, location );
			}
		}
		
		/**
		 * Remove an item from the Dungeon.
		 * <P>
		 * Sends DungeonProxy.ITEM_REMOVED
		 * </P>
		 */
		public function removeItem( type:String, location:String ):void
		{
			dungeon.removeItem( type, location );
			sendNotification( ITEM_REMOVED, null, type );
		}
		
		/**
		 * The Dungeon.
		 */
		public function get dungeon():Dungeon
		{
			return data as Dungeon;
		}
		
		/**
		 * Timer for wyvern moves.
		 */
		private var timer:Timer;
     }
}