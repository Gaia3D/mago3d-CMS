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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./IndexDatatype-d9fd3d17","./GeometryOffsetAttribute-0abfa3f6","./VertexFormat-b4c6d1c2","./EllipsoidGeometry-77382ae1"],function(a,e,t,i,r,o,n,s,d,c,l,m,f,u,p,y,G){"use strict";function k(e){var t=i.defaultValue(e.radius,1),r={radii:new o.Cartesian3(t,t,t),stackPartitions:e.stackPartitions,slicePartitions:e.slicePartitions,vertexFormat:e.vertexFormat};this._ellipsoidGeometry=new G.EllipsoidGeometry(r),this._workerName="createSphereGeometry"}k.packedLength=G.EllipsoidGeometry.packedLength,k.pack=function(e,t,r){return G.EllipsoidGeometry.pack(e._ellipsoidGeometry,t,r)};var v=new G.EllipsoidGeometry,b={radius:void 0,radii:new o.Cartesian3,vertexFormat:new y.VertexFormat,stackPartitions:void 0,slicePartitions:void 0};return k.unpack=function(e,t,r){var i=G.EllipsoidGeometry.unpack(e,t,v);return b.vertexFormat=y.VertexFormat.clone(i._vertexFormat,b.vertexFormat),b.stackPartitions=i._stackPartitions,b.slicePartitions=i._slicePartitions,a.defined(r)?(o.Cartesian3.clone(i._radii,b.radii),r._ellipsoidGeometry=new G.EllipsoidGeometry(b),r):(b.radius=i._radii.x,new k(b))},k.createGeometry=function(e){return G.EllipsoidGeometry.createGeometry(e._ellipsoidGeometry)},function(e,t){return a.defined(t)&&(e=k.unpack(e,t)),k.createGeometry(e)}});
