/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.view.mediator
{
    import com.futurescale.dungeonjoe.model.proxy.CharacterProxy;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    /**
     * A Mediator for interacting with the Application.
     */
    public class ApplicationMediator extends Mediator implements IMediator
    {
       
		public static const NAME:String = "ApplicationMediator";
		
        public function ApplicationMediator( viewComponent:DungeonJoe ) 
        {
            super( NAME, viewComponent );
    
			// Listen for events from the view component 
			//app.addEventListener( Playfield.SPRITE_DIVIDE, onSpriteDivide );
        }

		override public function listNotificationInterests():Array 
        {
            return [ 
            		// ApplicationFacade.SPRITE_SCALE,
					// ApplicationFacade.SPRITE_DROP
                   ];
        }

        override public function handleNotification( note:INotification ):void 
        {
           // switch ( note.getName() ) {
           //     
           //     case ApplicationFacade.SPRITE_DROP:
		   //		helloSprite.dropSprite();
           //         break;
           //}
        }
		

        protected function get app():DungeonJoe
        {
            return viewComponent as DungeonJoe;
        }

		private var characterProxy:CharacterProxy;
    }
}