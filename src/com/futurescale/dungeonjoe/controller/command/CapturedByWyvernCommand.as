/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
    import com.futurescale.dungeonjoe.controller.util.AsyncUtil;
    import com.futurescale.dungeonjoe.model.entity.Room;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.utilities.statemachine.StateMachine;

	/**
	 * Move the character to a random room, irrespective of content
	 */
   public class CapturedByWyvernCommand extends SimpleCommand
    {
		private var dp:DungeonProxy;
	   	private var cp:CharacterProxy;
		private var timer:Timer;
		private var screenTime:Number = 3000;
		
        override public function execute( note:INotification ) : void    
        {
			// get proxies
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );
			
			timer = AsyncUtil.callbackAfter( dropInRoom, screenTime );
			
		}
		
		private function dropInRoom( event:TimerEvent ):void
		{
			timer = AsyncUtil.stopCalling( timer, dropInRoom );
			
			// Pick a random room
			var room:Room = dp.dungeon.getRandomRoom();

			// Drop the character
			sendNotification( StateMachine.ACTION, room.location, FSMActions.DROPPED );
			//sendNotification( StateMachine.ACTION, dp.dungeon.dragon, FSMActions.DROPPED );
		}	
    }
}