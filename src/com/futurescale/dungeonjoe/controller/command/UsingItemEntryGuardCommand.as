/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.entity.Room;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * Make sure that the player can use the item.
	 */
   public class UsingItemEntryGuardCommand extends SimpleCommand
    {
		private var dp:DungeonProxy;
		private var cp:CharacterProxy;
		
        override public function execute( note:INotification ) : void    
        {
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );

			var room:Room = dp.dungeon.getRoom(cp.character.location);
			var type:String = note.getBody() as String;
			var cancel:Boolean = false;
			
			switch (type) 
			{
				case DungeonItem.BALL:
					break;
				
				case DungeonItem.ROPE:
					if ( !room.hasPit() ) cancel = true;
					break;

				case DungeonItem.SWORD:
					if ( !room.hasDragon() ) cancel = true;
					break;
			}
			
			if (cancel) sendNotification( StateMachine.CANCEL );
			
		}
   }
}