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

import openfl.geom.Vector3D;


class CameraController {

//------------------------------
//  model
//------------------------------

    public var camera:Camera3D;
    public var models:Array<ModelMesh>;

    private var _frame:Int = 1000;
    private var _sceneLimit = 90;
    private var _tm:ModelMesh;
    private var _target:Vector3D = new Vector3D();
    private var _cs:Float = 0;
    private var _gy:Float = 0;
    private var _l:Float = 0;
    private var _bl:Float = 6;
    private var _ts:Float = 0;
    private var _r:Float = 0;
    private var _rp:Float = 0.03;


//------------------------------
//  lifecycle
//------------------------------

    public function new() {
    }

    public function step():Void {
        if (++_frame > _sceneLimit) {
            _frame = 0;
            _sceneLimit = Math.floor((Math.random() * 60) + 30);
            _tm = models[Math.floor(Math.random() * models.length)];
            _ts = 0;
            _cs = 0;
            _gy = ((Math.random() * 8) - 4);
            _rp = ((Math.random() * 0.06) - 0.03);
            _bl = ((Math.random() * 4) + 7);
        }

        if (_ts < 0.5)
            _ts += 0.005;

        if (_cs < 0.5)
            _cs += 0.005;

        _target.x += ((_tm.x - _target.x) * _ts);
        _target.y += ((_tm.y - _target.y) * _ts);
        _target.z += ((_tm.z - _target.z) * _ts);

        camera.lookAt(_target);

        _r += _rp;
        _l += ((_bl - _l) * 0.1);
        camera.x += ((((Math.cos(_r) * _l) + _tm.x) - camera.x) * _cs);
        camera.y += (((_tm.y + _gy) - camera.y) * _cs);
        camera.z += ((((Math.sin(_r) * _l) + _tm.z) - camera.z) * _cs);
    }
}
