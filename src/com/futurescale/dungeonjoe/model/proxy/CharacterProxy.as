/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.model.proxy
{
    import com.futurescale.dungeonjoe.model.entity.Character;
    import com.futurescale.dungeonjoe.model.entity.Dungeon;
    import com.futurescale.dungeonjoe.model.entity.DungeonItem;
    import com.futurescale.dungeonjoe.model.modelns;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import org.puremvc.as3.patterns.proxy.Proxy;
	
	use namespace modelns;

    public class CharacterProxy extends Proxy
    {
        public static const NAME:String = 'CharacterProxy';

		public static const LEVEL_1:String 		= "Level 1";
		public static const LEVEL_2:String 		= "Level 2";
		public static const LEVEL_3:String 		= "Level 3";
		public static const LEVEL_4:String 		= "Level 4";
		public static const GAME_OVER:String 	= "Game Over";
		public static const LEVELS:Array 		= [LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4, GAME_OVER];	
		
		public static const LEVEL_CHANGED:String	= NAME+"/level/changed";
		public static const ITEM_TAKEN:String		= NAME+"/item/taken";
		public static const ITEM_USED:String		= NAME+"/item/used";
		public static const CHAR_DIED:String		= NAME+"/character/died";
		public static const CHAR_HEALTH:String		= NAME+"/character/health";
		
        public function CharacterProxy( )
        {
            super( NAME );
        }
		
		public function createCharacter():void
		{
			setData( new Character() );	
		}
		
		/**
		 * Advance the character to the next level.
		 */
		public function advanceToNextLevel():String
		{
			// If character has already played one or more levels, 
			// we need to tally stuff and reset things
			if (character.level > 0) 
			{
				character.levelDamsel[character.level] 		= Boolean(character.damsel);
				character.levelTreasure[character.level] 	= Boolean(character.treasure);
				character.levelBooty[character.level] 		= (Boolean(character.damsel)?500:0) + (Boolean(character.treasure)?500:0);
				character.levelHealth[character.level] 		= character.health;
				character.health 	= 100;
				character.damsel 	= null;
				character.treasure 	= null;
				character.rope 		= null;
				character.ball 		= null;
				character.sword 	= null;

			}
			
			// Set the level and send notification of the change.
			var level:String = getLevel();
			
			if (!character.dead) {
				character.level++;
				level = getLevel();
				sendNotification( LEVEL_CHANGED, level );
			}

			return level;
		}
		
		public function getLevel():String 
		{
			return LEVELS[ character.level - 1 ];
		}
		
		/**
		 * Start the character's health timer.
		 */
		public function beginPlay():void
		{
			timer = new Timer( 5000, 100 );
			timer.addEventListener( TimerEvent.TIMER, reduceHealth );
			timer.start();
		}
		
		/**
		 * Stop the character health timer.
		 */
		public function stopPlay():void
		{
			if (timer){
				timer.stop();
				timer.removeEventListener( TimerEvent.TIMER, reduceHealth );
				timer = null;
			}
		}

		/**
		 * Character has fallen into well without rope or found dragon without sword.
		 */
		public function succumbToThreat():void
		{
			stopPlay();
			timer = new Timer( 3000, 100 );
			timer.addEventListener( TimerEvent.TIMER, succumbToThreatComplete );
			timer.start();
		}
		
		/**
		 * Character has succumbed to the threat.
		 */
		private function succumbToThreatComplete( event:TimerEvent ):void
		{
			if (timer){
				timer.stop();
				timer.removeEventListener( TimerEvent.TIMER, succumbToThreatComplete );
				timer = null;
			}
			kill();
		}
		
		
		/**
		 * Kill the character.
		 */
		public function kill():void
		{
			stopPlay();
			character.reduceHealth( character.health );
			sendNotification( LEVEL_CHANGED, GAME_OVER );
			sendNotification( CHAR_DIED );
		}

		/**
		 * Reduce the character health by a given number of points.
		 * <P>
		 * Called by the kill method, and by the health timer.
		 * Sends CharacterProxy.CHAR_HEALTH and conditionally
		 * CHAR_DIED if health falls below 1.
		 * </P>
		 */
		private function reduceHealth( event:TimerEvent ):void
		{
			var newHealth:Number = character.health - 1;
			if (newHealth < 1) { 
				sendNotification( CHAR_HEALTH, 0 );
				kill();
			} else {
				sendNotification( CHAR_HEALTH, character.reduceHealth( 1 ) );
			} 
		}
		
		/**
		 * Take an item.
		 * <P>
		 * Sends CharacterProxy.ITEM_TAKEN if successful.
		 * </P>
		 */
		public function takeItem( type:String ):void
		{
			var item:DungeonItem = new DungeonItem(type);
			if ( character.takeItem( item ) ) sendNotification( ITEM_TAKEN, item, item.type );
		}
		
		/**
		 * Use an item.
		 * <P>
		 * Sends CharacterProxy.ITEM_USED if successful.
		 * </P>
		 */
		public function useItem( type:String ):void
		{
			var item:DungeonItem = new DungeonItem(type);
			if ( character.useItem(item) ) sendNotification( ITEM_USED, item, item.type );
		}
		
		/**
		 * The Character.
		 */
		public function get character():Character
		{
			return data as Character;
		}
		
		/**
		 * Timer for character life - 99 five second intervals
		 */
		private var timer:Timer;
     }
}