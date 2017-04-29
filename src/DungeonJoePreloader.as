package
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    
    import mx.events.FlexEvent;
    import mx.preloaders.DownloadProgressBar;

    /**
     * This class extends the lightweight DownloadProgressBar class.  This class
     * uses an embedded MovieClip symbol to show preloading.
     * 
     * @author jessewarden
     * 
     */    
    public class DungeonJoePreloader extends DownloadProgressBar
    {
        
        /**
        * The Flash 8 MovieClip embedded as a Class.
        */        
        [Embed(source="assets/preloader/FS-Logo-Dark-Preloader.swf", symbol="Preloader")]
        private var FlashPreloaderSymbol:Class;
        
        private var clip:MovieClip;
        
        public function DungeonJoePreloader()
        {
            super();
            
            // instantiate the Flash MovieClip, show it, and stop it.
            // Remember, AS2 is removed when you embed SWF's, 
            // even "stop();", so you have to call it manually if you embed.
            clip = new FlashPreloaderSymbol();
			
            addChild(clip);
            clip.gotoAndStop("start");
        }
        
        public override function set preloader(preloader:Sprite):void 
        {                   
            preloader.addEventListener( ProgressEvent.PROGRESS ,     onSWFDownloadProgress );    
            preloader.addEventListener( Event.COMPLETE ,             onSWFDownloadComplete );
            preloader.addEventListener( FlexEvent.INIT_PROGRESS ,     onFlexInitProgress );
            preloader.addEventListener( FlexEvent.INIT_COMPLETE ,     onFlexInitComplete );
			preloader.x = (super.stage.stageWidth / 2) - (clip.width / 2);
			preloader.y = (super.stage.stageHeight / 2) - (clip.height / 2);
            
        }
        
        /**
         * As the SWF (frame 2 usually) downloads, this event gets called.
         * You can use the values from this event to update your preloader.
         * @param event
         * 
         */        
        private function onSWFDownloadProgress( event:ProgressEvent ):void
        {
            var t:Number = event.bytesTotal;
            var l:Number = event.bytesLoaded;
            var p:Number = Math.round( (l / t) * 50);
            clip.preloader.gotoAndStop(p);
            //clip.preloader.amount_txt.text = String(p) + "%";
        }
        
        /**
         * When the download of frame 2
         * is complete, this event is called.  
         * This is called before the initializing is done.
         * @param event
         * 
         */        
        private function onSWFDownloadComplete( event:Event ):void
        {
               clip.preloader.gotoAndStop(33);
           // clip.preloader.amount_txt.text = "100%";
        }
        
        /**
         * When Flex starts initilizating your application.
         * @param event
         * 
         */        
        private function onFlexInitProgress( event:FlexEvent ):void
        {
			initPhase+=33;
			if (initPhase>67) initPhase=67;
            clip.preloader.gotoAndStop(33+initPhase);
        }
        private var initPhase:Number=0;
		
        /**
         * When Flex is done initializing, and ready to run your app,
         * this function is called.
         * 
         * You're supposed to dispatch a complete event when you are done.
         * I chose not to do this immediately, and instead fade out the 
         * preloader in the MovieClip.  As soon as that is done,
         * I then dispatch the event.  This gives time for the preloader
         * to finish it's animation.
         * @param event
         * 
         */        
        private function onFlexInitComplete( event:FlexEvent ):void 
        {
            clip.addFrameScript(30, onDoneAnimating);
            clip.gotoAndPlay("fade out");
        }
        
        /**
         * If the Flash MovieClip is done playing it's animation,
         * I stop it and dispatch my event letting Flex know I'm done.
         * @param event
         * 
         */        
        private function onDoneAnimating():void
        {
            clip.stop();
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
        
    }
}
