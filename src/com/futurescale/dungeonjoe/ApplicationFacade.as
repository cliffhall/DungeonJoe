/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe
{
    import com.futurescale.dungeonjoe.controller.command.CapturedByWyvernCommand;
    import com.futurescale.dungeonjoe.controller.command.MoveCharacterCommand;
    import com.futurescale.dungeonjoe.controller.command.MoveWyvernsCommand;
    import com.futurescale.dungeonjoe.controller.command.PrepareLevelCommand;
    import com.futurescale.dungeonjoe.controller.command.StartGameCommand;
    import com.futurescale.dungeonjoe.controller.command.StartupCommand;
    import com.futurescale.dungeonjoe.controller.command.StopTimersCommand;
    import com.futurescale.dungeonjoe.controller.command.TakingItemCommand;
    import com.futurescale.dungeonjoe.controller.command.UsingItemCommand;
    import com.futurescale.dungeonjoe.controller.command.UsingItemEntryGuardCommand;
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    
    import org.puremvc.as3.patterns.facade.Facade;
    
    public class ApplicationFacade extends Facade
    {
		/**
		 * Notification used to startup the PureMVC apparatus.
		 */
		public static const STARTUP:String = "startup";
		
		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade {
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
			
			// Bootstrap the PureMVC apparatus
			registerCommand( STARTUP, 								StartupCommand );
			registerCommand( DungeonProxy.MOVE_WYVERNS,				MoveWyvernsCommand );
			
			// When we have transitioned to these States, execute this state-specific logic
			registerCommand( FSMAnnounce.CHANGED_PREPARING_LEVEL, 	PrepareLevelCommand );
			registerCommand( FSMAnnounce.CHANGED_MOVING_CHARACTER, 	MoveCharacterCommand );
			registerCommand( FSMAnnounce.CHANGED_BEING_CARRIED, 	CapturedByWyvernCommand );
			registerCommand( FSMAnnounce.CHANGED_USING_ITEM, 		UsingItemCommand );
			registerCommand( FSMAnnounce.CHANGED_TAKING_ITEM, 		TakingItemCommand );

			// States that may need to be canceled
			registerCommand( FSMAnnounce.ENTER_USING_ITEM, 			UsingItemEntryGuardCommand );

			// For the States that we exit gameplay to, stop the gameplay timers 
			registerCommand( FSMAnnounce.ENTER_WELCOMING, 			StopTimersCommand );
			registerCommand( FSMAnnounce.ENTER_PREPARING_LEVEL, 	StopTimersCommand );
			registerCommand( FSMAnnounce.ENTER_SHOWING_SCORE, 		StopTimersCommand );
			
			// When we are about to exit these States, execute this state-specific logic
			registerCommand( FSMAnnounce.EXIT_WELCOMING, 			StartGameCommand );
			
        }
        
		/**
		 * Convenience method for starting up 
		 * PureMVC from the main app.
		 */
        public function startup( app:DungeonJoe ):void
        {
        	sendNotification( STARTUP, app );
        }
    }
}