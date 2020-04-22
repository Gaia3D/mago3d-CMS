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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./Plane-9e603d64","./VertexFormat-b4c6d1c2","./FrustumGeometry-afebd58d"],function(s,e,t,p,r,m,d,n,a,h,g,u,_,i,o,k){"use strict";var f=0,c=1;function l(e){var t,r,n=e.frustum,a=e.orientation,u=e.origin,i=p.defaultValue(e._drawNearPlane,!0);n instanceof k.PerspectiveFrustum?(t=f,r=k.PerspectiveFrustum.packedLength):n instanceof k.OrthographicFrustum&&(t=c,r=k.OrthographicFrustum.packedLength),this._frustumType=t,this._frustum=n.clone(),this._origin=m.Cartesian3.clone(u),this._orientation=d.Quaternion.clone(a),this._drawNearPlane=i,this._workerName="createFrustumOutlineGeometry",this.packedLength=2+r+m.Cartesian3.packedLength+d.Quaternion.packedLength}l.pack=function(e,t,r){r=p.defaultValue(r,0);var n=e._frustumType,a=e._frustum;return(t[r++]=n)===f?(k.PerspectiveFrustum.pack(a,t,r),r+=k.PerspectiveFrustum.packedLength):(k.OrthographicFrustum.pack(a,t,r),r+=k.OrthographicFrustum.packedLength),m.Cartesian3.pack(e._origin,t,r),r+=m.Cartesian3.packedLength,d.Quaternion.pack(e._orientation,t,r),t[r+=d.Quaternion.packedLength]=e._drawNearPlane?1:0,t};var y=new k.PerspectiveFrustum,v=new k.OrthographicFrustum,F=new d.Quaternion,w=new m.Cartesian3;return l.unpack=function(e,t,r){t=p.defaultValue(t,0);var n,a=e[t++];a===f?(n=k.PerspectiveFrustum.unpack(e,t,y),t+=k.PerspectiveFrustum.packedLength):(n=k.OrthographicFrustum.unpack(e,t,v),t+=k.OrthographicFrustum.packedLength);var u=m.Cartesian3.unpack(e,t,w);t+=m.Cartesian3.packedLength;var i=d.Quaternion.unpack(e,t,F),o=1===e[t+=d.Quaternion.packedLength];if(!s.defined(r))return new l({frustum:n,origin:u,orientation:i,_drawNearPlane:o});var c=a===r._frustumType?r._frustum:void 0;return r._frustum=n.clone(c),r._frustumType=a,r._origin=m.Cartesian3.clone(u,r._origin),r._orientation=d.Quaternion.clone(i,r._orientation),r._drawNearPlane=o,r},l.createGeometry=function(e){var t=e._frustumType,r=e._frustum,n=e._origin,a=e._orientation,u=e._drawNearPlane,i=new Float64Array(24);k.FrustumGeometry._computeNearFarPlanes(n,a,t,r,i);for(var o,c,s=new _.GeometryAttributes({position:new g.GeometryAttribute({componentDatatype:h.ComponentDatatype.DOUBLE,componentsPerAttribute:3,values:i})}),p=u?2:1,m=new Uint16Array(8*(1+p)),f=u?0:1;f<2;++f)c=4*f,m[o=u?8*f:0]=c,m[o+1]=c+1,m[o+2]=c+1,m[o+3]=c+2,m[o+4]=c+2,m[o+5]=c+3,m[o+6]=c+3,m[o+7]=c;for(f=0;f<2;++f)c=4*f,m[o=8*(p+f)]=c,m[o+1]=c+4,m[o+2]=c+1,m[o+3]=c+5,m[o+4]=c+2,m[o+5]=c+6,m[o+6]=c+3,m[o+7]=c+7;return new g.Geometry({attributes:s,indices:m,primitiveType:g.PrimitiveType.LINES,boundingSphere:d.BoundingSphere.fromVertices(i)})},function(e,t){return s.defined(t)&&(e=l.unpack(e,t)),l.createGeometry(e)}});
