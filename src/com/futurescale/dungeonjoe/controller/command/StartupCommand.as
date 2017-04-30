/*
 Dungeon Joe
 By Cliff Hall <clifford.hall@futurescale.com>
 Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
 */
package com.futurescale.dungeonjoe.controller.command
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	/**
	 * Prepare the Model and View, then inject the State Machine
	 */
	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void
		{
			// Prepare the Model
			this.addSubCommand( PrepareModelCommand );

			// Prepare the View
			this.addSubCommand( PrepareViewCommand );

			// Create and Inject the State Machine
			this.addSubCommand( InjectFSMCommand );
		}
	}
}