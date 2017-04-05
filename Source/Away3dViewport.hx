/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Jason Sturges, http://jasonsturges.com
*/
package;

import away3d.cameras.Camera3D;
import away3d.containers.View3D;
import away3d.containers.Scene3D;
import away3d.debug.AwayStats;

import openfl.display.Sprite;
import openfl.display.StageDisplayState;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;


class Away3dViewport extends Sprite {

    //------------------------------
    //  model
    //------------------------------

    public var antiAlias:UInt = 4;
    public var awayStats:AwayStats;

    public var camera:Camera3D;
    public var scene:Scene3D;
    public var view:View3D;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        initialize();
    }

    public function initialize():Void {
        initializeEngine();
        initializeCamera();
        initializeLights();
        initializeMaterials();
        initializeObjects();
        initializeFilters();
        initializeListeners();
    }

    public function initializeEngine():Void {
        view = new View3D();
        view.antiAlias = antiAlias;
        view.backgroundColor = 0xfefefe;
        addChild(view);

        scene = view.scene;

        awayStats = new AwayStats(view);
        addChild(awayStats);
    }

    public function initializeCamera():Void {
        camera = view.camera;
    }

    public function initializeLights():Void {
    }

    public function initializeMaterials():Void {
    }

    public function initializeObjects():Void {
    }

    public function initializeFilters():Void {
    }

    public function initializeListeners():Void {
        view.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        view.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        view.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);

        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);

        stage.addEventListener(Event.RESIZE, resizeHandler);
        stage.addEventListener(Event.FRAME_CONSTRUCTED, render);
    }

    public function resizeHandler(event:Event):Void {
        view.width = stage.stageWidth;
        view.height = stage.stageHeight;
    }

    public function fullScreen(interactive:Bool = true):Void {
        #if flash
        switch (interactive) {
            case true:
                if (stage.allowsFullScreenInteractive)
                    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            case false:
                #end
                if (stage.allowsFullScreen)
                    stage.displayState = StageDisplayState.FULL_SCREEN;
            #if flash
        }
        #end
    }

    public function prerender():Void {
    }

    public function render(event:Event):Void {
        prerender();

        view.render();
    }

    public function dispose():Void {
        view.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        view.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        view.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);

        stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);

        stage.removeEventListener(Event.RESIZE, resizeHandler);
        stage.addEventListener(Event.FRAME_CONSTRUCTED, render);

        removeChild(view);
        removeChild(awayStats);
    }

    public function mouseDownHandler(event:MouseEvent):Void {
        stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
    }

    public function mouseUpHandler(event:MouseEvent):Void {
        stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
    }

    public function mouseLeaveHandler(event:Event):Void {
        stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
    }

    public function mouseWheelHandler(event:MouseEvent):Void {
    }

    public function keyDownHandler(event:KeyboardEvent):Void {
        switch (event.keyCode) {
            case Keyboard.F:
                fullScreen(false);
        }
    }

    public function keyUpHandler(event:KeyboardEvent):Void {
    }

}
