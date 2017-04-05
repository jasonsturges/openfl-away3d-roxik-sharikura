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

import away3d.entities.Entity;
import away3d.lights.DirectionalLight;
import away3d.materials.ColorMaterial;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.primitives.SphereGeometry;
import away3d.primitives.WireframeCube;

import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;


class Main extends Away3dViewport {

    //------------------------------
    //  model
    //------------------------------

    private var _ambientLight:DirectionalLight;
    private var _lightPicker:StaticLightPicker;
    private var _sphereMaterial:Array<ColorMaterial> = new Array<ColorMaterial>();
    private var _cube:Entity;
    private var _models:Array<ModelMesh> = new Array<ModelMesh>();
    private var _motion:MotionController = new MotionController();
    private var _cameraController:CameraController = new CameraController();
    public static inline var MAX = 8;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
    }

    override public function initializeCamera():Void {
        super.initializeCamera();

        camera.lens.near = 0.001;
        camera.x = 2;
        camera.y = 2;
        camera.z = -2;

        _cameraController.camera = camera;
    }

    override public function initializeLights():Void {
        super.initializeLights();

        _ambientLight = new DirectionalLight(-10, 10, -10);
        _ambientLight.color = 0x9090aa;
        _ambientLight.ambient = 80;
        _ambientLight.diffuse = 2;

        _lightPicker = new StaticLightPicker([ _ambientLight ]);
    }

    override public function initializeMaterials():Void {
        super.initializeMaterials();

        var colors:Array<Int> = [0x97350b, 0x266ea5, 0x00847f, 0x2f818e, 0x08917c, 0x08917c, 0x6b458c, 0x7a4526];
        var ambient:Array<Int> = [0xff6109, 0x4ebeff, 0x05edec, 0x5deeff, 0x0cffe7, 0xe67ae4, 0xb476ea, 0xf78849];

        for (i in 0 ... 8) {
            var mat:ColorMaterial = new ColorMaterial(colors[i]);
            mat.ambientColor = ambient[i];
            mat.ambient = 1;
            mat.specular = 0.5;
            mat.gloss = 0.75;
            mat.lightPicker = _lightPicker;
            _sphereMaterial.push(mat);
        }
    }

    override public function initializeObjects():Void {
        super.initializeObjects();

        var bet:Float = 0.7;
        var offset:Float = (((MAX - 1) * bet) * 0.5);

        for (i in 0 ... MAX) {
            for (j in 0 ... MAX) {
                for (k in 0 ... MAX) {
                    var m:ModelMesh = new ModelMesh(new SphereGeometry(0.3), _sphereMaterial[Math.floor(Math.random() * 8)]);
                    m.x = ((i * bet) - offset);
                    m.y = ((j * bet) - offset);
                    m.z = ((k * bet) - offset);
                    _models.push(m);

                    view.scene.addChild(m);
                }
            }
        }

        _cube = new WireframeCube(18, 18, 18, 0xdddddd, 1);
        view.scene.addChild(_cube);

        _cameraController.models = _models;
        _motion.models = _models;
        _motion.changeScene(MotionController.CYLINDER);
    }

    override public function prerender():Void {
        super.prerender();

        _cameraController.step();
        _motion.step();
    }

    override public function keyDownHandler(event:KeyboardEvent):Void {
        switch (event.keyCode) {
            case Keyboard.NUMBER_1:
                _motion.changeScene(MotionController.CYLINDER, 100);
            case Keyboard.NUMBER_2:
                _motion.changeScene(MotionController.SPHERE, 100);
            case Keyboard.NUMBER_3:
                _motion.changeScene(MotionController.CUBE, 100);
            case Keyboard.NUMBER_4:
                _motion.changeScene(MotionController.TUBE, 100);
            case Keyboard.NUMBER_5:
                _motion.changeScene(MotionController.WAVE, 100);
            case Keyboard.NUMBER_6:
                _motion.changeScene(MotionController.GRAVITY, 100);
            case Keyboard.NUMBER_7:
                _motion.changeScene(MotionController.ANTIGRAVITY, 100);
        }
    }

}