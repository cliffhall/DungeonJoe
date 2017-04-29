/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    import com.futurescale.dungeonjoe.model.proxy.HighScoreProxy;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Register the Proxies.
	 */
    public class PrepareModelCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) : void    
        {
			facade.registerProxy( new CharacterProxy() );
			facade.registerProxy( new DungeonProxy() );
			facade.registerProxy( new HighScoreProxy() );
        }
    }
}