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
    import com.futurescale.dungeonjoe.view.component.HealthAndTitle;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    /**
     * A Mediator for interacting with the Playfield.
     */
    public class HealthAndTitleMediator extends Mediator
    {

        public static const NAME:String = "HealthAndTitleMediator";

        public function HealthAndTitleMediator( viewComponent:HealthAndTitle )
        {
            super( NAME, viewComponent );
        }

        override public function listNotificationInterests():Array
        {
            return [
                FSMAnnounce.CHANGED_WELCOMING,
                FSMAnnounce.CHANGED_PREPARING_LEVEL,
                FSMAnnounce.CHANGED_SHOWING_SCORE,
                CharacterProxy.CHAR_HEALTH,
            ];
        }

        override public function handleNotification( note:INotification ):void
        {
            switch ( note.getName() ) {

                case FSMAnnounce.CHANGED_WELCOMING:
                case FSMAnnounce.CHANGED_SHOWING_SCORE:
                    healthAndTitle.setState( ViewStates.HEALTH_AND_TITLE_IDLE );
                    break;

                case FSMAnnounce.CHANGED_PREPARING_LEVEL:
                    healthAndTitle.setState( ViewStates.HEALTH_AND_TITLE_PLAY );
                    break;

                case CharacterProxy.CHAR_HEALTH:
                    healthAndTitle.setHealth( note.getBody() as Number );
                    break;
            }
        }

        protected function get healthAndTitle():HealthAndTitle
        {
            return viewComponent as HealthAndTitle;
        }

    }
}