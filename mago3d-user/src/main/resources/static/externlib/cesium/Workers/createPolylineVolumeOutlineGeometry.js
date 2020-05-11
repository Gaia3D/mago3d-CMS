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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./IndexDatatype-d9fd3d17","./IntersectionTests-e0f27278","./Plane-9e603d64","./arrayRemoveDuplicates-1efed288","./BoundingRectangle-96022c82","./EllipsoidTangentPlane-ba96ba3d","./EllipsoidRhumbLine-078646a4","./PolygonPipeline-7c2859c5","./PolylineVolumeGeometryLibrary-d3f9c65b","./EllipsoidGeodesic-220adcef","./PolylinePipeline-c1da261a"],function(d,e,i,c,t,u,y,a,n,f,h,r,g,m,o,l,s,p,v,E,P,_,k,C){"use strict";function b(e){var i=(e=c.defaultValue(e,c.defaultValue.EMPTY_OBJECT)).polylinePositions,a=e.shapePositions;this._positions=i,this._shape=a,this._ellipsoid=u.Ellipsoid.clone(c.defaultValue(e.ellipsoid,u.Ellipsoid.WGS84)),this._cornerType=c.defaultValue(e.cornerType,_.CornerType.ROUNDED),this._granularity=c.defaultValue(e.granularity,t.CesiumMath.RADIANS_PER_DEGREE),this._workerName="createPolylineVolumeOutlineGeometry";var n=1+i.length*u.Cartesian3.packedLength;n+=1+a.length*u.Cartesian2.packedLength,this.packedLength=n+u.Ellipsoid.packedLength+2}b.pack=function(e,i,a){var n;a=c.defaultValue(a,0);var t=e._positions,r=t.length;for(i[a++]=r,n=0;n<r;++n,a+=u.Cartesian3.packedLength)u.Cartesian3.pack(t[n],i,a);var o=e._shape;for(r=o.length,i[a++]=r,n=0;n<r;++n,a+=u.Cartesian2.packedLength)u.Cartesian2.pack(o[n],i,a);return u.Ellipsoid.pack(e._ellipsoid,i,a),a+=u.Ellipsoid.packedLength,i[a++]=e._cornerType,i[a]=e._granularity,i};var L=u.Ellipsoid.clone(u.Ellipsoid.UNIT_SPHERE),T={polylinePositions:void 0,shapePositions:void 0,ellipsoid:L,height:void 0,cornerType:void 0,granularity:void 0};b.unpack=function(e,i,a){var n;i=c.defaultValue(i,0);var t=e[i++],r=new Array(t);for(n=0;n<t;++n,i+=u.Cartesian3.packedLength)r[n]=u.Cartesian3.unpack(e,i);t=e[i++];var o=new Array(t);for(n=0;n<t;++n,i+=u.Cartesian2.packedLength)o[n]=u.Cartesian2.unpack(e,i);var l=u.Ellipsoid.unpack(e,i,L);i+=u.Ellipsoid.packedLength;var s=e[i++],p=e[i];return d.defined(a)?(a._positions=r,a._shape=o,a._ellipsoid=u.Ellipsoid.clone(l,a._ellipsoid),a._cornerType=s,a._granularity=p,a):(T.polylinePositions=r,T.shapePositions=o,T.cornerType=s,T.granularity=p,new b(T))};var D=new p.BoundingRectangle;return b.createGeometry=function(e){var i=e._positions,a=s.arrayRemoveDuplicates(i,u.Cartesian3.equalsEpsilon),n=e._shape;if(n=_.PolylineVolumeGeometryLibrary.removeDuplicatesFromShape(n),!(a.length<2||n.length<3)){P.PolygonPipeline.computeWindingOrder2D(n)===P.WindingOrder.CLOCKWISE&&n.reverse();var t=p.BoundingRectangle.fromPoints(n,D);return function(e,i){var a=new g.GeometryAttributes;a.position=new h.GeometryAttribute({componentDatatype:f.ComponentDatatype.DOUBLE,componentsPerAttribute:3,values:e});var n,t,r=i.length,o=a.position.values.length/3,l=e.length/3/r,s=m.IndexDatatype.createTypedArray(o,2*r*(1+l)),p=0,d=(n=0)*r;for(t=0;t<r-1;t++)s[p++]=t+d,s[p++]=t+d+1;for(s[p++]=r-1+d,s[p++]=d,d=(n=l-1)*r,t=0;t<r-1;t++)s[p++]=t+d,s[p++]=t+d+1;for(s[p++]=r-1+d,s[p++]=d,n=0;n<l-1;n++){var c=r*n,u=c+r;for(t=0;t<r;t++)s[p++]=t+c,s[p++]=t+u}return new h.Geometry({attributes:a,indices:m.IndexDatatype.createTypedArray(o,s),boundingSphere:y.BoundingSphere.fromVertices(e),primitiveType:h.PrimitiveType.LINES})}(_.PolylineVolumeGeometryLibrary.computePositions(a,n,t,e,!1),n)}},function(e,i){return d.defined(i)&&(e=b.unpack(e,i)),e._ellipsoid=u.Ellipsoid.clone(e._ellipsoid),b.createGeometry(e)}});
