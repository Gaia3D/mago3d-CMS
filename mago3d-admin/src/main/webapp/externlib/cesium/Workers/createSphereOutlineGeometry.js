/**
 * Cesium - https://github.com/CesiumGS/cesium
 *
 * Copyright 2011-2020 Cesium Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Columbus View (Pat. Pend.)
 *
 * Portions licensed separately.
 * See https://github.com/CesiumGS/cesium/blob/master/LICENSE.md for full licensing details.
 */
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./IndexDatatype-d9fd3d17","./GeometryOffsetAttribute-0abfa3f6","./EllipsoidOutlineGeometry-967cce4b"],function(n,e,i,r,t,a,s,o,d,l,u,c,f,m,p,y){"use strict";function G(e){var i=r.defaultValue(e.radius,1),t={radii:new a.Cartesian3(i,i,i),stackPartitions:e.stackPartitions,slicePartitions:e.slicePartitions,subdivisions:e.subdivisions};this._ellipsoidGeometry=new y.EllipsoidOutlineGeometry(t),this._workerName="createSphereOutlineGeometry"}G.packedLength=y.EllipsoidOutlineGeometry.packedLength,G.pack=function(e,i,t){return y.EllipsoidOutlineGeometry.pack(e._ellipsoidGeometry,i,t)};var b=new y.EllipsoidOutlineGeometry,k={radius:void 0,radii:new a.Cartesian3,stackPartitions:void 0,slicePartitions:void 0,subdivisions:void 0};return G.unpack=function(e,i,t){var r=y.EllipsoidOutlineGeometry.unpack(e,i,b);return k.stackPartitions=r._stackPartitions,k.slicePartitions=r._slicePartitions,k.subdivisions=r._subdivisions,n.defined(t)?(a.Cartesian3.clone(r._radii,k.radii),t._ellipsoidGeometry=new y.EllipsoidOutlineGeometry(k),t):(k.radius=r._radii.x,new G(k))},G.createGeometry=function(e){return y.EllipsoidOutlineGeometry.createGeometry(e._ellipsoidGeometry)},function(e,i){return n.defined(i)&&(e=G.unpack(e,i)),G.createGeometry(e)}});
