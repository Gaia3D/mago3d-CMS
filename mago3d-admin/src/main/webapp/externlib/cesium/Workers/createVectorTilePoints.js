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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./when-c208a7cf","./AttributeCompression-5ee93a38","./createTaskProcessorWorker"],function(e,a,r,t,v,y,n,A,i){"use strict";var M=32767,R=new y.Cartographic,x=new y.Cartesian3,z=new y.Rectangle,D=new y.Ellipsoid,E={min:void 0,max:void 0};return i(function(e,a){var r=new Uint16Array(e.positions);!function(e){e=new Float64Array(e);var a=0;E.min=e[a++],E.max=e[a++],y.Rectangle.unpack(e,a,z),a+=y.Rectangle.packedLength,y.Ellipsoid.unpack(e,a,D)}(e.packedBuffer);var t=z,n=D,i=E.min,s=E.max,o=r.length/3,c=r.subarray(0,o),u=r.subarray(o,2*o),f=r.subarray(2*o,3*o);A.AttributeCompression.zigZagDeltaDecode(c,u,f);for(var p=new Float64Array(r.length),l=0;l<o;++l){var h=c[l],d=u[l],m=f[l],C=v.CesiumMath.lerp(t.west,t.east,h/M),b=v.CesiumMath.lerp(t.south,t.north,d/M),g=v.CesiumMath.lerp(i,s,m/M),w=y.Cartographic.fromRadians(C,b,g,R),k=n.cartographicToCartesian(w,x);y.Cartesian3.pack(k,p,3*l)}return a.push(p.buffer),{positions:p.buffer}})});
