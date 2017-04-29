/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{
    import com.futurescale.dungeonjoe.view.mediator.ApplicationMediator;
    import com.futurescale.dungeonjoe.view.mediator.AreaMediator;
    import com.futurescale.dungeonjoe.view.mediator.HealthAndTitleMediator;
    import com.futurescale.dungeonjoe.view.mediator.IconMediator;
    import com.futurescale.dungeonjoe.view.mediator.JoeMediator;
    import com.futurescale.dungeonjoe.view.mediator.LevelContentsMediator;
    import com.futurescale.dungeonjoe.view.mediator.LocationMediator;
    import com.futurescale.dungeonjoe.view.mediator.PlayfieldMediator;
    import com.futurescale.dungeonjoe.view.mediator.ScoreDisplayMediator;
    
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Register the Mediators.
	 * <P>
	 * Mediate the app's view components. 
	 * </P> 
	 */
    public class PrepareViewCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) : void    
        {
	    	var app:DungeonJoe = note.getBody() as DungeonJoe;
			
            facade.registerMediator( new ApplicationMediator( 		app ) );
			facade.registerMediator( new ScoreDisplayMediator( 		app.playfield.scoreDisplay ) );
			facade.registerMediator( new AreaMediator( 				app.playfield.area ) );
			facade.registerMediator( new PlayfieldMediator( 		app.playfield ) );
			facade.registerMediator( new LevelContentsMediator( 	app.playfield.levelContents ) );
			facade.registerMediator( new HealthAndTitleMediator( 	app.playfield.healthAndTitle ) );
			facade.registerMediator( new LocationMediator( 			app.playfield.location ) );
			facade.registerMediator( new JoeMediator( 				app.playfield.joe ) );
			facade.registerMediator( new IconMediator( 				app.playfield.crystalBall ) );
			facade.registerMediator( new IconMediator( 				app.playfield.damsel ) );
			facade.registerMediator( new IconMediator( 				app.playfield.dragon ) );
			facade.registerMediator( new IconMediator( 				app.playfield.pit ) );
			facade.registerMediator( new IconMediator( 				app.playfield.rope ) );
			facade.registerMediator( new IconMediator( 				app.playfield.sword ) );
			facade.registerMediator( new IconMediator( 				app.playfield.treasure ) );
			facade.registerMediator( new IconMediator( 				app.playfield.wyvern ) );
		}
    }
}