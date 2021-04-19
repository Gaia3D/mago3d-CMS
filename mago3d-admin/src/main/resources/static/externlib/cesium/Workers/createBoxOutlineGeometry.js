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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./GeometryOffsetAttribute-0abfa3f6"],function(c,e,t,u,a,d,p,n,i,l,y,r,C,b){"use strict";var A=new d.Cartesian3;function m(e){var t=(e=u.defaultValue(e,u.defaultValue.EMPTY_OBJECT)).minimum,a=e.maximum;this._min=d.Cartesian3.clone(t),this._max=d.Cartesian3.clone(a),this._offsetAttribute=e.offsetAttribute,this._workerName="createBoxOutlineGeometry"}m.fromDimensions=function(e){var t=(e=u.defaultValue(e,u.defaultValue.EMPTY_OBJECT)).dimensions,a=d.Cartesian3.multiplyByScalar(t,.5,new d.Cartesian3);return new m({minimum:d.Cartesian3.negate(a,new d.Cartesian3),maximum:a,offsetAttribute:e.offsetAttribute})},m.fromAxisAlignedBoundingBox=function(e){return new m({minimum:e.minimum,maximum:e.maximum})},m.packedLength=2*d.Cartesian3.packedLength+1,m.pack=function(e,t,a){return a=u.defaultValue(a,0),d.Cartesian3.pack(e._min,t,a),d.Cartesian3.pack(e._max,t,a+d.Cartesian3.packedLength),t[a+2*d.Cartesian3.packedLength]=u.defaultValue(e._offsetAttribute,-1),t};var o=new d.Cartesian3,f=new d.Cartesian3,s={minimum:o,maximum:f,offsetAttribute:void 0};return m.unpack=function(e,t,a){t=u.defaultValue(t,0);var n=d.Cartesian3.unpack(e,t,o),i=d.Cartesian3.unpack(e,t+d.Cartesian3.packedLength,f),r=e[t+2*d.Cartesian3.packedLength];return c.defined(a)?(a._min=d.Cartesian3.clone(n,a._min),a._max=d.Cartesian3.clone(i,a._max),a._offsetAttribute=-1===r?void 0:r,a):(s.offsetAttribute=-1===r?void 0:r,new m(s))},m.createGeometry=function(e){var t=e._min,a=e._max;if(!d.Cartesian3.equals(t,a)){var n=new C.GeometryAttributes,i=new Uint16Array(24),r=new Float64Array(24);r[0]=t.x,r[1]=t.y,r[2]=t.z,r[3]=a.x,r[4]=t.y,r[5]=t.z,r[6]=a.x,r[7]=a.y,r[8]=t.z,r[9]=t.x,r[10]=a.y,r[11]=t.z,r[12]=t.x,r[13]=t.y,r[14]=a.z,r[15]=a.x,r[16]=t.y,r[17]=a.z,r[18]=a.x,r[19]=a.y,r[20]=a.z,r[21]=t.x,r[22]=a.y,r[23]=a.z,n.position=new y.GeometryAttribute({componentDatatype:l.ComponentDatatype.DOUBLE,componentsPerAttribute:3,values:r}),i[0]=4,i[1]=5,i[2]=5,i[3]=6,i[4]=6,i[5]=7,i[6]=7,i[7]=4,i[8]=0,i[9]=1,i[10]=1,i[11]=2,i[12]=2,i[13]=3,i[14]=3,i[15]=0,i[16]=0,i[17]=4,i[18]=1,i[19]=5,i[20]=2,i[21]=6,i[22]=3,i[23]=7;var u=d.Cartesian3.subtract(a,t,A),m=.5*d.Cartesian3.magnitude(u);if(c.defined(e._offsetAttribute)){var o=r.length,f=new Uint8Array(o/3),s=e._offsetAttribute===b.GeometryOffsetAttribute.NONE?0:1;b.arrayFill(f,s),n.applyOffset=new y.GeometryAttribute({componentDatatype:l.ComponentDatatype.UNSIGNED_BYTE,componentsPerAttribute:1,values:f})}return new y.Geometry({attributes:n,indices:i,primitiveType:y.PrimitiveType.LINES,boundingSphere:new p.BoundingSphere(d.Cartesian3.ZERO,m),offsetAttribute:e._offsetAttribute})}},function(e,t){return c.defined(t)&&(e=m.unpack(e,t)),m.createGeometry(e)}});
