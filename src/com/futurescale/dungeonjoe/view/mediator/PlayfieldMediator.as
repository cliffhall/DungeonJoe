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
    import com.futurescale.dungeonjoe.model.entity.Character;
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    import com.futurescale.dungeonjoe.view.component.Playfield;
    
    import flash.events.Event;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.utilities.statemachine.StateMachine;
    
    /**
     * A Mediator for interacting with the Playfield.
     */
    public class PlayfieldMediator extends Mediator
    {
       
		public static const NAME:String = "PlayfieldMediator";

        public function PlayfieldMediator( viewComponent:Playfield ) 
        {
            super( NAME, viewComponent );
    
			// Listen for events from the view component 
			playfield.addEventListener( Playfield.BUTTON_EXIT, 		onButtonExit );
			playfield.addEventListener( Playfield.BUTTON_START, 	onButtonStart );
			playfield.addEventListener( Playfield.BUTTON_RESTART, 	onButtonRestart );
        }

		protected function onButtonExit( event:Event ):void
		{
			playfield.stage.nativeWindow.close();
		}
		
		protected function onButtonStart( event:Event ):void
		{
			sendNotification( StateMachine.ACTION, null, FSMActions.BEGIN );
		}
		
		protected function onButtonRestart( event:Event ):void
		{
			sendNotification( StateMachine.ACTION, null, FSMActions.RESTART );
		}
		
		override public function listNotificationInterests():Array 
        {
            return [ 
					FSMAnnounce.CHANGED_WELCOMING,
					FSMAnnounce.CHANGED_PREPARING_LEVEL,
					FSMAnnounce.EXIT_PREPARING_LEVEL,
					FSMAnnounce.CHANGED_SHOWING_SCORE,
					CharacterProxy.LEVEL_CHANGED,
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
			switch ( note.getName() ) {
                
				case FSMAnnounce.CHANGED_WELCOMING:
					playfield.setState ( ViewStates.PLAYFIELD_WELCOME );
					break;
				
				case CharacterProxy.LEVEL_CHANGED:
					var level:String = note.getBody() as String;
					if (level == CharacterProxy.GAME_OVER) playfield.gameOver = true;
					break;

				case FSMAnnounce.CHANGED_SHOWING_SCORE:
					playfield.setState ( ViewStates.PLAYFIELD_SCORE );
					break;

				case FSMAnnounce.CHANGED_PREPARING_LEVEL:
					playfield.setState ( ViewStates.PLAYFIELD_LEVEL );
					break;
				
				case FSMAnnounce.EXIT_PREPARING_LEVEL:
					playfield.setState ( ViewStates.PLAYFIELD_PLAY );
					break;
				
            }
        }

        protected function get playfield():Playfield
        {
            return viewComponent as Playfield;
        }

		private var cp:CharacterProxy;
    }
}