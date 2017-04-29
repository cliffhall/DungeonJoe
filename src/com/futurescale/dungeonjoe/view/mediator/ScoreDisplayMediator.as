/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.view.mediator
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
    import com.futurescale.dungeonjoe.controller.constant.view.ViewStates;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.HighScoreProxy;
    import com.futurescale.dungeonjoe.view.component.ScoreDisplay;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    /**
     * A Mediator for interacting with the Score display.
     */
    public class ScoreDisplayMediator extends Mediator
    {
       
		public static const NAME:String = "ScoreDisplayMediator";

        public function ScoreDisplayMediator( viewComponent:ScoreDisplay ) 
        {
            super( NAME, viewComponent );
        }

		override public function onRegister():void
		{
			cp = CharacterProxy(facade.retrieveProxy(CharacterProxy.NAME));
			hsp = HighScoreProxy(facade.retrieveProxy(HighScoreProxy.NAME));
		}
		

		override public function listNotificationInterests():Array 
        {
            return [ 
					FSMAnnounce.EXIT_SHOWING_SCORE,
					FSMAnnounce.CHANGED_SHOWING_SCORE,
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
			switch ( note.getName() ) {
                
				case FSMAnnounce.EXIT_SHOWING_SCORE:
					scoreDisplay.setState( ViewStates.SCORE_DISPLAY_IDLE );
					break;
				
				case FSMAnnounce.CHANGED_SHOWING_SCORE:
					cp.advanceToNextLevel();
					if ( cp.character.finalScore() > hsp.highScore ) hsp.highScore = cp.character.finalScore();
					scoreDisplay.populateDisplay( cp.character, hsp.highScore );
					scoreDisplay.setState( ViewStates.SCORE_DISPLAY_SCORE );
					break;
				
            }
        }

        protected function get scoreDisplay():ScoreDisplay
        {
            return viewComponent as ScoreDisplay;
        }

		private var cp:CharacterProxy;
		private var hsp:HighScoreProxy;
    }
}