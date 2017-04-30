/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.view.mediator
{
    import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
    import com.futurescale.dungeonjoe.controller.constant.view.ViewStates;
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    import com.futurescale.dungeonjoe.view.component.LevelContents;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    /**
     * A Mediator for interacting with the LevelContents display.
     */
    public class LevelContentsMediator extends Mediator
    {
        public static const NAME:String = "LevelContentsMediator";

        public function LevelContentsMediator( viewComponent:LevelContents )
        {
            super( NAME, viewComponent );
        }

        override public function listNotificationInterests():Array
        {
            return [
                FSMAnnounce.ENTER_PREPARING_LEVEL,
                FSMAnnounce.CHANGED_PREPARING_LEVEL,
                FSMAnnounce.EXIT_PREPARING_LEVEL,
                DungeonProxy.ITEM_ADDED,
            ];
        }

        override public function handleNotification( note:INotification ):void
        {
            switch ( note.getName() )
            {
                case FSMAnnounce.ENTER_PREPARING_LEVEL:
                    levelContents.clearContentDisplays();
                    break;

                case FSMAnnounce.CHANGED_PREPARING_LEVEL:
                    levelContents.setState( ViewStates.LEVEL_CONTENTS_LEVEL );
                    break;

                case FSMAnnounce.EXIT_PREPARING_LEVEL:
                    levelContents.setState( ViewStates.LEVEL_CONTENTS_IDLE );
                    break;

                case DungeonProxy.ITEM_ADDED:
                    levelContents.addItem( DungeonItem(note.getBody()), note.getType());
                    break;
            }
        }

        protected function get levelContents():LevelContents
        {
            return viewComponent as LevelContents;
        }
    }
}