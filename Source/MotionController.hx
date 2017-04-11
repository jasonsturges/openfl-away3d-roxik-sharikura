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


class MotionController {

    //------------------------------
    //  model
    //------------------------------

    // TODO: intro
    public static inline var CYLINDER:Int = 0;
    public static inline var SPHERE:Int = 1;
    public static inline var CUBE:Int = 2;
    public static inline var TUBE:Int = 3;
    public static inline var WAVE:Int = 4;
    public static inline var GRAVITY:Int = 5;
    public static inline var ANTIGRAVITY:Int = 6;

    public var models:Array<ModelMesh>;

    private var _scene:Int = CYLINDER;
    private var _sceneLimit = 100;
    private var _frame:Int = 0;
    private var _cutoff:Int = 0;
    private var _r:Float;
    private var _r0:Float;
    private var _rp:Float;
    private var _rl:Float;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
    }

    public function changeScene(scene:Int, limit:Int = -1) {
        _cutoff = 0;
        _scene = scene;
        _frame = 0;

        if (limit < 0)
            _sceneLimit = Math.floor((Math.random() * 140) + 3);
        else
            _sceneLimit = limit;

        switch(scene) {
            case CYLINDER:
                cylinder();
            case SPHERE:
                sphere();
            case CUBE:
                cube();
            case TUBE:
                tube();
            case WAVE:
                wave();
            case GRAVITY:
                gravity();
            case ANTIGRAVITY:
                antigravity();
        }
    }

    public function cylinder():Void {
        var n:Float = 0;
        var r:Float = ((Math.PI * 2) / models.length);
        var d:Float = (r * (Math.floor((Math.random() * 40) + 1)));

        for (i in 0 ... models.length) {
            var m:ModelMesh = models[i];
            m.speed = 0;
            m.accel = ((Math.random() * 0.05) + 0.022);
            m.animate = false;

            if (i < (models.length - 50)) {
                m.dest.x = (Math.cos(n) * 4);
                m.dest.y = ((i * 0.008) - ((models.length - 50) * 0.004));
                m.dest.z = (Math.sin(n) * 4);
            } else {
                m.dest.x = ((Math.random() * 14) - 7);
                m.dest.y = ((Math.random() * 14) - 7);
                m.dest.z = ((Math.random() * 14) - 7);
            }

            n = (n + d);
        }
    }

    public function sphere():Void {
        var s:Float = 0;
        var c:Float = 0;
        var r:Float = ((Math.PI * 2) / models.length);
        var d:Float = r * (Math.floor((Math.random() * 40) + 1));
        var d2:Float = (Math.random() * 5) + 3;

        for (i in 0 ... models.length) {
            var m:ModelMesh = models[i];
            m.speed = 0;
            m.accel = (Math.random() * 0.05) + 0.022;
            m.animate = false;

            var d1:Float = (Math.cos(s) * d2);

            if (Math.random() > 0.06) {
                m.dest.x = Math.cos(c) * d1;
                m.dest.y = Math.sin(s) * d2;
                m.dest.z = Math.sin(c) * d1;
            } else {
                m.dest.x = (Math.random() * 7) - 7;
                m.dest.y = (Math.random() * 7) - 7;
                m.dest.z = (Math.random() * 7) - 7;
            }

            s = s + r;
            c = c + d;
        }
    }

    public function cube():Void {
        var a:Float = ((Math.random() * 0.05) + 0.022);
        var n:Int = 0;
        var l:Int = 1;

        while (true) {
            if (((l * l) * l) > models.length) {
                l--;
                break;
            }

            l++;
        }

        for (i in 0 ... l) {
            for (j in 0 ... l) {
                for (k in 0 ... l) {
                    var m:ModelMesh = models[n++];
                    m.speed = 0;
                    m.accel = a;
                    m.animate = false;
                    m.dest.x = ((i * 0.8) + ((-((l - 1)) * 0.8) * 0.5));
                    m.dest.y = ((j * 0.8) + ((-((l - 1)) * 0.8) * 0.5));
                    m.dest.z = ((k * 0.8) + ((-((l - 1)) * 0.8) * 0.5));
                }
            }
        }

        while (n < models.length) {
            var m:ModelMesh = models[n];
            m.speed = 0;
            m.accel = a;
            m.animate = false;
            m.dir.x = ((Math.random() * 1) - 0.5);
            m.dir.y = ((Math.random() * 1) - 0.5);
            m.dir.z = ((Math.random() * 1) - 0.5);
            m.dest.x = ((Math.random() * 14) - 7);
            m.dest.y = ((Math.random() * 14) - 7);
            m.dest.z = ((Math.random() * 14) - 7);

            n++;
        }
    }

    public function tube():Void {
        var a:Float = ((Math.random() * 0.05) + 0.022);
        var v:Float = (0.02 + (Math.random() * 0.025));
        var dx:Float = ((-(v) * models.length) * 0.44);
        var d:Float = (1.2 + (Math.random() * 1));

        for (i in 0 ... models.length) {
            var m:ModelMesh = models[i];
            m.speed = 0;
            m.accel = a;
            m.animate = false;
            if (Math.random() > 0.05) {
                m.dest.x = ((i * v) + dx);
                m.dest.y = ((Math.random() * d) - (d * 0.5));
                m.dest.z = ((Math.random() * d) - (d * 0.5));
            } else {
                m.dest.x = ((Math.random() * 14) - 7);
                m.dest.y = ((Math.random() * 14) - 7);
                m.dest.z = ((Math.random() * 14) - 7);
            }
        }
    }

    public function wave():Void {
        var a:Float = (Math.random() * 0.05) + 0.022;
        var n:Int = 0;
        var l:Int = Math.floor(Math.sqrt(models.length));
        var d:Float = ((-((l - 1)) * 0.55) * 0.5);
        var r:Float = 0;
        var t:Float = (Math.random() * 0.3) + 0.05;
        var s:Float = (Math.random() * 1) + 1;

        _r = 0;
        _r0 = 0;
        _rl = (Math.random() * 1) + 1;
        _rp = (Math.random() * 0.3) + 0.1;

        for (i in 0 ... l) {
            var ty = Math.cos(r) * s;
            r += t;

            for (j in 0 ... l) {
                n += 1;
                var m:ModelMesh = models[n - 1];
                m.speed = 0;
                m.accel = a;
                m.animate = false;
                m.dir.x = (m.dir.y = (m.dir.z = 0));
                m.dest.x = ((i * 0.55) + d);
                m.dest.y = ty;
                m.dest.z = ((j * 0.55) + d);
            }
        }

        while (n < models.length) {
            var m:ModelMesh = models[n];
            m.speed = 0;
            m.accel = a;
            m.animate = false;
            m.dest.x = ((Math.random() * 14) - 7);
            m.dest.y = ((Math.random() * 14) - 7);
            m.dest.z = ((Math.random() * 14) - 7);
            n++;
        }
    }

    public function gravity():Void {
        _sceneLimit = 60;

        for (i in 0 ... models.length) {
            var m:ModelMesh = models[i];
            m.speed = 0;
            m.accel = 0.5;
            m.animate = false;
            m.dir.y = (Math.random() * -0.2);
        }
    }

    public function antigravity():Void {
        for (i in 0 ... models.length) {
            var m:ModelMesh = models[i];
            m.speed = 0;
            m.accel = 0.5;
            m.animate = false;
            m.dir.x = ((Math.random() * 0.25) - 0.125);
            m.dir.y = ((Math.random() * 0.25) - 0.125);
            m.dir.z = ((Math.random() * 0.25) - 0.125);
        }
    }

    public function step():Void {
        var m:ModelMesh;

        switch (_scene) {
            case CYLINDER, SPHERE, CUBE, TUBE:
                for (i in 0 ... _cutoff) {
                    m = models[i];

                    if (!m.animate) {
                        if (m.speed < 0.8) {
                            m.speed = (m.speed + m.accel);
                        }

                        var c0:Float = (m.dest.x - m.x);
                        var c1:Float = (m.dest.y - m.y);
                        var c2:Float = (m.dest.z - m.z);
                        m.x = (m.x + (c0 * m.speed));
                        m.y = (m.y + (c1 * m.speed));
                        m.z = (m.z + (c2 * m.speed));
                        if ((((((Math.abs(c0) < 0.05)) && ((Math.abs(c1) < 0.05)))) && ((Math.abs(c2) < 0.05)))) {
                            m.animate = true;
                            m.x = m.dest.x;
                            m.y = m.dest.y;
                            m.z = m.dest.z;
                        };
                    }
                }

                var maxp:Int = Math.floor(models.length / 40);
                _cutoff += maxp;
                if (_cutoff > models.length)
                    _cutoff = models.length;

            case WAVE:
                var cos:Float = 0;
                var _max:Int = Math.floor(Math.sqrt(models.length));
                var cc:Int = 0;

                for (i in 0 ... _max) {
                    cos = (Math.cos(_r) * _rl);
                    _r = (_r + _rp);
                    for (j in 0 ... _max) {
                        m = models[cc++];
                        m.dest.y = cos;
                    }
                }

                _r0 += 0.11;
                _r = _r0;

                for (i in 0 ... _cutoff) {
                    m = models[i];
                    if (m.speed < 0.5) {
                        m.speed += m.accel;
                    }

                    m.x = (m.x + ((m.dest.x - m.x) * m.speed));
                    m.y = (m.y + ((m.dest.y - m.y) * m.speed));
                    m.z = (m.z + ((m.dest.z - m.z) * m.speed));
                }

                var maxp:Int = Math.floor(models.length / 40);
                _cutoff += maxp;
                if (_cutoff > models.length)
                    _cutoff = models.length;

            case GRAVITY:
                for (i in 0 ... models.length) {
                    m = models[i];
                    m.y = m.y + m.dir.y;
                    m.dir.y = m.dir.y - 0.06;
                    if (m.y < -9) {
                        m.y = -9;
                        m.dir.y = (m.dir.y * -(m.accel));
                        m.accel = (m.accel * 0.9);
                    }
                }

            case ANTIGRAVITY:
                for (i in 0 ... _cutoff) {
                    m = models[i];
                    m.x = m.x + m.dir.x;
                    m.y = m.y + m.dir.y;
                    m.z = m.z + m.dir.z;
                }

                _cutoff += 30;
                if (_cutoff > models.length)
                    _cutoff = models.length;
        }


        if (++_frame > _sceneLimit)
            changeScene(Math.floor(Math.random() * 7));
    }

}
