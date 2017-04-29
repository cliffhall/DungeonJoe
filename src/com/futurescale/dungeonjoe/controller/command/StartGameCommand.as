/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Start the game, resetting the character to the first level.
	 */
    public class StartGameCommand extends SimpleCommand
    {
		private var cp:CharacterProxy;
		
        override public function execute( note:INotification ) : void
        {
			// Create the character 
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );
			cp.createCharacter();
			cp.character.level=0;

			// advance the character to the next level (first, if starting)
			cp.advanceToNextLevel();
			
			
		}
		
    }
}