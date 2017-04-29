/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.controller.command
{    
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMActions;
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMAnnounce;
	import com.futurescale.dungeonjoe.controller.constant.fsm.FSMStates;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.utilities.statemachine.FSMInjector;
	
	/**
	 * Create and inject the StateMachine.
	 */
	public class InjectFSMCommand extends SimpleCommand
	{
		override public function execute ( note:INotification ) : void
		{
			var fsm:XML = 
			<fsm initial={FSMStates.WELCOMING}>
			
				<!-- WELCOMING -->
				<state name={FSMStates.WELCOMING}
					   changed={FSMAnnounce.CHANGED_WELCOMING}
					   exiting={FSMAnnounce.EXIT_WELCOMING}
					   entering={FSMAnnounce.ENTER_WELCOMING}>

				   <transition action={FSMActions.BEGIN} target={FSMStates.PREPARING_LEVEL}/>
				   <transition action={FSMActions.QUIT} target={FSMStates.QUITTING}/>
		
				</state>
				
				<!-- SHOWING SCORE -->
				<state name={FSMStates.SHOWING_SCORE}
					   changed={FSMAnnounce.CHANGED_SHOWING_SCORE}
					   entering={FSMAnnounce.ENTER_SHOWING_SCORE}
					   exiting={FSMAnnounce.EXIT_SHOWING_SCORE}>
				
					<transition action={FSMActions.BEGIN} 		target={FSMStates.PREPARING_LEVEL}/>
					<transition action={FSMActions.RESTART}		target={FSMStates.WELCOMING}/>
					<transition action={FSMActions.QUIT} 		target={FSMStates.QUITTING}/>
				
				</state>
			
				
				<!-- PREPARING LEVEL -->
				<state name={FSMStates.PREPARING_LEVEL}
					   changed={FSMAnnounce.CHANGED_PREPARING_LEVEL}
					   exiting={FSMAnnounce.EXIT_PREPARING_LEVEL}
					   entering={FSMAnnounce.ENTER_PREPARING_LEVEL}>

				   <transition action={FSMActions.WIN} 			target={FSMStates.SHOWING_SCORE}/>
				   <transition action={FSMActions.MOVE} 		target={FSMStates.MOVING_CHARACTER}/>
				   <transition action={FSMActions.QUIT} 		target={FSMStates.QUITTING}/>

				</state>
			
				<!-- MOVING CHARACTER -->
				<state name={FSMStates.MOVING_CHARACTER}
					   changed={FSMAnnounce.CHANGED_MOVING_CHARACTER}>

					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.CAPTURED}	target={FSMStates.BEING_CARRIED}/>
					<transition action={FSMActions.MOVED}		target={FSMStates.WAITING_IN_ROOM}/>
					<transition action={FSMActions.PITFALL}		target={FSMStates.WAITING_IN_PIT}/>
					<transition action={FSMActions.QUIT}		target={FSMStates.QUITTING}/>
		
				</state>
			
				<!-- WAITING IN ROOM -->
				<state name={FSMStates.WAITING_IN_ROOM}
					   changed={FSMAnnounce.CHANGED_WAITING_IN_ROOM}>

					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.MOVE} 		target={FSMStates.MOVING_CHARACTER}/>
					<transition action={FSMActions.CAPTURED}	target={FSMStates.BEING_CARRIED}/>
					<transition action={FSMActions.TAKE_ITEM}	target={FSMStates.TAKING_ITEM}/>
					<transition action={FSMActions.USE_ITEM}	target={FSMStates.USING_ITEM}/>
				    <transition action={FSMActions.RESTART}		target={FSMStates.WELCOMING}/>
					<transition action={FSMActions.QUIT}		target={FSMStates.QUITTING}/>

				</state>

				<!-- WAITING IN PIT -->
				<state name={FSMStates.WAITING_IN_PIT}
					   changed={FSMAnnounce.CHANGED_WAITING_IN_PIT}>
			
					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.USE_ITEM}	target={FSMStates.USING_ITEM}/>
					<transition action={FSMActions.CAPTURED}	target={FSMStates.BEING_CARRIED}/>
				    <transition action={FSMActions.RESTART}		target={FSMStates.WELCOMING}/>
				   	<transition action={FSMActions.QUIT} 		target={FSMStates.QUITTING}/>
		
			   	</state>
			
				<!-- BEING CARRIED -->
				<state name={FSMStates.BEING_CARRIED}
					   changed={FSMAnnounce.CHANGED_BEING_CARRIED}>

					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.DROPPED}		target={FSMStates.MOVING_CHARACTER}/>
					<transition action={FSMActions.QUIT}		target={FSMStates.QUITTING}/>
		
				</state>

				<!-- USING ITEM -->
				<state name={FSMStates.USING_ITEM}
					   changed={FSMAnnounce.CHANGED_USING_ITEM}
					   entering={FSMAnnounce.ENTER_USING_ITEM}>
		
					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.NEXT_LEVEL}	target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.USED} 		target={FSMStates.WAITING_IN_ROOM}/>
				   	<transition action={FSMActions.QUIT}		target={FSMStates.QUITTING}/>
			
			   	</state>
			
				<!-- TAKING ITEM -->
				<state name={FSMStates.TAKING_ITEM}
					   changed={FSMAnnounce.CHANGED_TAKING_ITEM}>

					<transition action={FSMActions.DIE} 		target={FSMStates.SHOWING_SCORE}/>
					<transition action={FSMActions.TAKEN}		target={FSMStates.WAITING_IN_ROOM}/>
				   	<transition action={FSMActions.QUIT}		target={FSMStates.QUITTING}/>
		
			   	</state>

				<!-- QUITTING -->
				<state name={FSMStates.QUITTING}
					   changed={FSMAnnounce.CHANGED_QUITTING}/>
				
			</fsm>;
			
			var injector:FSMInjector = new FSMInjector( fsm );
			injector.inject();
		}
	}
}
