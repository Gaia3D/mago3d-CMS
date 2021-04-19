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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./AttributeCompression-5ee93a38","./GeometryPipeline-03f56e11","./EncodedCartesian3-9ab2586f","./IndexDatatype-d9fd3d17","./IntersectionTests-e0f27278","./Plane-9e603d64","./GeometryInstance-c09ff781","./arrayRemoveDuplicates-1efed288","./EllipsoidTangentPlane-ba96ba3d","./OrientedBoundingBox-c01fd912","./CoplanarPolygonGeometryLibrary-f9caed86","./ArcType-c72d871a","./EllipsoidRhumbLine-078646a4","./PolygonPipeline-7c2859c5","./PolygonGeometryLibrary-6fe547ec"],function(a,e,t,i,r,c,p,n,o,s,u,y,d,l,f,m,g,h,b,P,G,v,L,C,T,E,k,H){"use strict";function w(e){for(var t=e.length,r=new Float64Array(3*t),n=g.IndexDatatype.createTypedArray(t,2*t),o=0,a=0,i=0;i<t;i++){var y=e[i];r[o++]=y.x,r[o++]=y.y,r[o++]=y.z,n[a++]=i,n[a++]=(i+1)%t}var l=new d.GeometryAttributes({position:new u.GeometryAttribute({componentDatatype:s.ComponentDatatype.DOUBLE,componentsPerAttribute:3,values:r})});return new u.Geometry({attributes:l,indices:n,primitiveType:u.PrimitiveType.LINES})}function A(e){var t=(e=i.defaultValue(e,i.defaultValue.EMPTY_OBJECT)).polygonHierarchy;this._polygonHierarchy=t,this._workerName="createCoplanarPolygonOutlineGeometry",this.packedLength=H.PolygonGeometryLibrary.computeHierarchyPackedLength(t)+1}A.fromPositions=function(e){return new A({polygonHierarchy:{positions:(e=i.defaultValue(e,i.defaultValue.EMPTY_OBJECT)).positions}})},A.pack=function(e,t,r){return r=i.defaultValue(r,0),t[r=H.PolygonGeometryLibrary.packPolygonHierarchy(e._polygonHierarchy,t,r)]=e.packedLength,t};var I={polygonHierarchy:{}};return A.unpack=function(e,t,r){t=i.defaultValue(t,0);var n=H.PolygonGeometryLibrary.unpackPolygonHierarchy(e,t);t=n.startingIndex,delete n.startingIndex;var o=e[t];return a.defined(r)||(r=new A(I)),r._polygonHierarchy=n,r.packedLength=o,r},A.createGeometry=function(e){var t=e._polygonHierarchy,r=t.positions;if(!((r=G.arrayRemoveDuplicates(r,c.Cartesian3.equalsEpsilon,!0)).length<3)&&C.CoplanarPolygonGeometryLibrary.validOutline(r)){var n=H.PolygonGeometryLibrary.polygonOutlinesFromHierarchy(t,!1);if(0!==n.length){for(var o=[],a=0;a<n.length;a++){var i=new P.GeometryInstance({geometry:w(n[a])});o.push(i)}var y=f.GeometryPipeline.combineInstances(o)[0],l=p.BoundingSphere.fromPoints(t.positions);return new u.Geometry({attributes:y.attributes,indices:y.indices,primitiveType:y.primitiveType,boundingSphere:l})}}},function(e,t){return a.defined(t)&&(e=A.unpack(e,t)),e._ellipsoid=c.Ellipsoid.clone(e._ellipsoid),A.createGeometry(e)}});
