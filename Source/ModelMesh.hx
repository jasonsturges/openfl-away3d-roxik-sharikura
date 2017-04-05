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

import away3d.core.base.Geometry;
import away3d.entities.Mesh;
import away3d.materials.MaterialBase;

import openfl.geom.Vector3D;


class ModelMesh extends Mesh {

//------------------------------
//  model
//------------------------------

    public var dest:Vector3D;
    public var dir:Vector3D;
    public var speed:Float;
    public var accel:Float;
    public var animate:Bool;


//------------------------------
//  lifecycle
//------------------------------

    public function new(geometry:Geometry, material:MaterialBase = null) {
        super(geometry, material);

        dest = new Vector3D();
        dir = new Vector3D();
    }
}
