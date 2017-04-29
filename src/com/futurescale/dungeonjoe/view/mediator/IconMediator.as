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
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.model.proxy.DungeonProxy;
    import com.futurescale.dungeonjoe.view.component.CrystalBall;
    import com.futurescale.dungeonjoe.view.component.Damsel;
    import com.futurescale.dungeonjoe.view.component.Dragon;
    import com.futurescale.dungeonjoe.view.component.Icon;
    import com.futurescale.dungeonjoe.view.component.Pit;
    import com.futurescale.dungeonjoe.view.component.Rope;
    import com.futurescale.dungeonjoe.view.component.Sword;
    import com.futurescale.dungeonjoe.view.component.Treasure;
    import com.futurescale.dungeonjoe.view.component.Wyvern;
    
    import flash.events.Event;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.utilities.statemachine.StateMachine;
    
    /**
     * A Mediator for interacting with the Icons on the sides of the Playfield.
     */
    public class IconMediator extends Mediator
    {
       
		public static const NAME:String = "IconMediator";

        public function IconMediator( viewComponent:Icon ) 
        {
            super( NAME+"/"+viewComponent.type, viewComponent );
        }

		override public function onRegister():void
		{
			cp = CharacterProxy( facade.retrieveProxy( CharacterProxy.NAME ) );
			icon.addEventListener( Icon.USE, onUse );	
		}
		
		private function onUse( event:Event ):void
		{
			sendNotification( StateMachine.ACTION,  icon.type, FSMActions.USE_ITEM );
		}
		
		override public function listNotificationInterests():Array 
        {
            return [
					FSMAnnounce.CHANGED_WELCOMING,
					FSMAnnounce.CHANGED_SHOWING_SCORE,
					FSMAnnounce.CHANGED_PREPARING_LEVEL,
					FSMAnnounce.CHANGED_WAITING_IN_ROOM,
					FSMAnnounce.CHANGED_WAITING_IN_PIT,
					FSMAnnounce.CHANGED_BEING_CARRIED,
					DungeonProxy.WYVERN_MOVED,
					CharacterProxy.ITEM_TAKEN,
					CharacterProxy.ITEM_USED,
					Icon.ITEM_NEARBY,
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
			switch ( note.getName() ) {
                
				case FSMAnnounce.CHANGED_WELCOMING:
					icon.setState( ( isWarning() ) ? ViewStates.ICON_WARN : ViewStates.ICON_HAVE );
					break;

				case FSMAnnounce.CHANGED_SHOWING_SCORE:
				case FSMAnnounce.CHANGED_PREPARING_LEVEL:
					icon.setState( ViewStates.ICON_IDLE );
					break;
				
				case FSMAnnounce.CHANGED_WAITING_IN_ROOM:
				case FSMAnnounce.CHANGED_WAITING_IN_PIT:
					icon.setState( cp.character.hasItem( icon.type ) ? ViewStates.ICON_HAVE : ViewStates.ICON_IDLE );
					break;
				
				case FSMAnnounce.CHANGED_BEING_CARRIED:
				case DungeonProxy.WYVERN_MOVED:
					if (icon.type == DungeonItem.WYVERN)
						icon.setState( ViewStates.ICON_IDLE );
					break;
				
				case CharacterProxy.ITEM_TAKEN:
					if (icon.type == note.getType())
						icon.setState( ViewStates.ICON_HAVE );
					break;
				
				case CharacterProxy.ITEM_USED:
					if (icon.type == note.getType() || note.getType() == DungeonItem.BALL )
						icon.setState( ViewStates.ICON_IDLE );
					break;
				
				case Icon.ITEM_NEARBY:
					if (icon.type == Icon(note.getBody()).type)
					{
						switch(icon.type) 
						{
							case Damsel.NAME:
							case Treasure.NAME:
							case Sword.NAME:
							case CrystalBall.NAME:
							case Rope.NAME:
								icon.setState( ViewStates.ICON_SLOT );
								break;
							
							case Dragon.NAME:
							case Pit.NAME:
							case Wyvern.NAME:
								icon.setState( ViewStates.ICON_WARN );
								break;
						}
					}
					break;
			}
        }

		private function isWarning():Boolean
		{
			return (icon is Dragon ||
					icon is Wyvern ||
					icon is Pit); 
		}
		
        private function get icon():Icon
        {
            return viewComponent as Icon;
        }
		
		private var cp:CharacterProxy;

    }
}