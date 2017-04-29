/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Stop the timers.
	 */
    public class StopTimersCommand extends SimpleCommand
    {
		private var dp:DungeonProxy;
		private var cp:CharacterProxy;
		
        override public function execute( note:INotification ) : void    
        {
			// Stop the dungeon's wyvern move timer.
			dp = DungeonProxy( facade.retrieveProxy( DungeonProxy.NAME ) );
			dp.stopPlay();
			
			// Stop the character's health timer.
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );
			cp.stopPlay();
		}
    }
}