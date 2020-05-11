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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./AttributeCompression-5ee93a38","./GeometryPipeline-03f56e11","./EncodedCartesian3-9ab2586f","./IndexDatatype-d9fd3d17","./IntersectionTests-e0f27278","./Plane-9e603d64","./GeometryOffsetAttribute-0abfa3f6","./VertexFormat-b4c6d1c2","./EllipseGeometryLibrary-7793f4dd","./GeometryInstance-c09ff781","./EllipseGeometry-fa2ba554"],function(o,e,t,r,i,a,n,l,s,d,m,u,c,p,y,_,f,h,G,x,g,v,E,w){"use strict";function b(e){var t=(e=r.defaultValue(e,r.defaultValue.EMPTY_OBJECT)).radius,i={center:e.center,semiMajorAxis:t,semiMinorAxis:t,ellipsoid:e.ellipsoid,height:e.height,extrudedHeight:e.extrudedHeight,granularity:e.granularity,vertexFormat:e.vertexFormat,stRotation:e.stRotation,shadowVolume:e.shadowVolume};this._ellipseGeometry=new w.EllipseGeometry(i),this._workerName="createCircleGeometry"}b.packedLength=w.EllipseGeometry.packedLength,b.pack=function(e,t,i){return w.EllipseGeometry.pack(e._ellipseGeometry,t,i)};var A=new w.EllipseGeometry({center:new a.Cartesian3,semiMajorAxis:1,semiMinorAxis:1}),C={center:new a.Cartesian3,radius:void 0,ellipsoid:a.Ellipsoid.clone(a.Ellipsoid.UNIT_SPHERE),height:void 0,extrudedHeight:void 0,granularity:void 0,vertexFormat:new g.VertexFormat,stRotation:void 0,semiMajorAxis:void 0,semiMinorAxis:void 0,shadowVolume:void 0};return b.unpack=function(e,t,i){var r=w.EllipseGeometry.unpack(e,t,A);return C.center=a.Cartesian3.clone(r._center,C.center),C.ellipsoid=a.Ellipsoid.clone(r._ellipsoid,C.ellipsoid),C.height=r._height,C.extrudedHeight=r._extrudedHeight,C.granularity=r._granularity,C.vertexFormat=g.VertexFormat.clone(r._vertexFormat,C.vertexFormat),C.stRotation=r._stRotation,C.shadowVolume=r._shadowVolume,o.defined(i)?(C.semiMajorAxis=r._semiMajorAxis,C.semiMinorAxis=r._semiMinorAxis,i._ellipseGeometry=new w.EllipseGeometry(C),i):(C.radius=r._semiMajorAxis,new b(C))},b.createGeometry=function(e){return w.EllipseGeometry.createGeometry(e._ellipseGeometry)},b.createShadowVolume=function(e,t,i){var r=e._ellipseGeometry._granularity,o=e._ellipseGeometry._ellipsoid,a=t(r,o),n=i(r,o);return new b({center:e._ellipseGeometry._center,radius:e._ellipseGeometry._semiMajorAxis,ellipsoid:o,stRotation:e._ellipseGeometry._stRotation,granularity:r,extrudedHeight:a,height:n,vertexFormat:g.VertexFormat.POSITION_ONLY,shadowVolume:!0})},Object.defineProperties(b.prototype,{rectangle:{get:function(){return this._ellipseGeometry.rectangle}},textureCoordinateRotationPoints:{get:function(){return this._ellipseGeometry.textureCoordinateRotationPoints}}}),function(e,t){return o.defined(t)&&(e=b.unpack(e,t)),e._ellipseGeometry._center=a.Cartesian3.clone(e._ellipseGeometry._center),e._ellipseGeometry._ellipsoid=a.Ellipsoid.clone(e._ellipseGeometry._ellipsoid),b.createGeometry(e)}});
