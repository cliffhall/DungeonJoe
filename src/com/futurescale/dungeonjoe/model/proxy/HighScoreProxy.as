/*
	Dungeon Joe
	By Cliff Hall <clifford.hall@futurescale.com>
	Copyright(c) 2010, Futurescale, Inc. Some rights reserved.
*/
package com.futurescale.dungeonjoe.model.proxy
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * Proxy for persisting the high score.
	 */
	public class HighScoreProxy extends Proxy
	{
		public static const NAME:String = 'HighScoreProxy';
		
		public function HighScoreProxy( ) 
		{
			super ( NAME, 0 );
		}
		
		override public function onRegister():void
		{
			initialize( "DungeonJoeScore", File.applicationStorageDirectory );
		}

		public function get highScore( ):Number
		{
			return retrieve( );
		}

		public function set highScore( score:Number ):void
		{
			store( score );
		}

		protected function store( score:Number ):void
		{
			setData( score );
			var fileStream:FileStream = new FileStream();
			fileStream.open(fileRef,FileMode.WRITE);
			fileStream.writeInt(score);
			fileStream.close();
		} 

		protected function retrieve( ):Number
		{
			var score:Number;
			if ( cachedScore > 0 ) 
			{
				score = cachedScore;
			} else {
				var fileStream:FileStream;
				fileStream = new FileStream();
				fileStream.open( fileRef, FileMode.READ );
				score = fileStream.readInt();
				fileStream.close();
			}
			return score;
		}

		/**
		 * Initialize the file.
		 */
		public function initialize( fname:String, location:File ):void
		{
			// Determine the database file location 	
			fileName = fname;		
			fileRef = location.resolvePath( fname );
			
			// Seed with a score			
			if (!fileRef.exists)
			{
				store( cachedScore );
			}
		}
		
		protected function get cachedScore():Number
		{
			return data as Number;
		}
		
		// the data file reference
		protected var fileRef:File;

		// The data file name
		protected var fileName:String;
		

	}
}