/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.view.mediator
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
    import com.futurescale.dungeonjoe.controller.constant.view.ViewStates;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.view.component.HealthAndTitle;
    import com.futurescale.dungeonjoe.view.component.Joe;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.utilities.statemachine.StateMachine;
    
    /**
     * A Mediator for interacting with Joe, the Character icon display.
     */
    public class JoeMediator extends Mediator
    {
       
		public static const NAME:String = "JoeMediator";

        public function JoeMediator( viewComponent:Joe ) 
        {
            super( NAME, viewComponent );
        }

		override public function listNotificationInterests():Array 
        {
            return [ 
					FSMAnnounce.CHANGED_WELCOMING,
					FSMAnnounce.CHANGED_PREPARING_LEVEL,
					CharacterProxy.CHAR_DIED,
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
			switch ( note.getName() ) {
                
				case FSMAnnounce.CHANGED_WELCOMING:
					character.setState( ViewStates.CHARACTER_IDLE );
					break;
				
				case FSMAnnounce.CHANGED_PREPARING_LEVEL:
					character.setState( ViewStates.CHARACTER_PLAY );
					break;
				
				case CharacterProxy.CHAR_DIED:
					character.setState( ViewStates.CHARACTER_DEAD );
					sendNotification( StateMachine.ACTION, null, FSMActions.DIE );
                    break;

            }
        }

        protected function get character():Joe
        {
            return viewComponent as Joe;
        }

    }
}