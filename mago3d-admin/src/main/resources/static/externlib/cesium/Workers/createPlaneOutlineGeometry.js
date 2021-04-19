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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51"],function(r,e,t,n,a,i,o,u,c,f,s,y,m){"use strict";function p(){this._workerName="createPlaneOutlineGeometry"}p.packedLength=0,p.pack=function(e,t){return t},p.unpack=function(e,t,n){return r.defined(n)?n:new p};var d=new i.Cartesian3(-.5,-.5,0),b=new i.Cartesian3(.5,.5,0);return p.createGeometry=function(){var e=new m.GeometryAttributes,t=new Uint16Array(8),n=new Float64Array(12);return n[0]=d.x,n[1]=d.y,n[2]=d.z,n[3]=b.x,n[4]=d.y,n[5]=d.z,n[6]=b.x,n[7]=b.y,n[8]=d.z,n[9]=d.x,n[10]=b.y,n[11]=d.z,e.position=new s.GeometryAttribute({componentDatatype:f.ComponentDatatype.DOUBLE,componentsPerAttribute:3,values:n}),t[0]=0,t[1]=1,t[2]=1,t[3]=2,t[4]=2,t[5]=3,t[6]=3,t[7]=0,new s.Geometry({attributes:e,indices:t,primitiveType:s.PrimitiveType.LINES,boundingSphere:new o.BoundingSphere(i.Cartesian3.ZERO,Math.sqrt(2))})},function(e,t){return r.defined(t)&&(e=p.unpack(e,t)),p.createGeometry(e)}});
