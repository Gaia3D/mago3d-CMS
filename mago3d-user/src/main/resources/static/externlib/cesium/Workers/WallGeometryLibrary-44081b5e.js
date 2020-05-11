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
define(["exports","./defined-b9ff0e39","./Math-92bd3539","./Cartesian2-12797039","./EllipsoidTangentPlane-ba96ba3d","./PolygonPipeline-7c2859c5","./PolylinePipeline-c1da261a"],function(e,C,A,w,b,E,O){"use strict";var i={};var M=new w.Cartographic,L=new w.Cartographic;var F=new Array(2),H=new Array(2),T={positions:void 0,height:void 0,granularity:void 0,ellipsoid:void 0};i.computePositions=function(e,i,t,n,r,o){var a=function(e,i,t,n){var r=i.length;if(!(r<2)){var o=C.defined(n),a=C.defined(t),l=!0,s=new Array(r),h=new Array(r),g=new Array(r),p=i[0];s[0]=p;var d=e.cartesianToCartographic(p,M);a&&(d.height=t[0]),l=l&&d.height<=0,h[0]=d.height,g[0]=o?n[0]:0;for(var P,c,u=1,v=1;v<r;++v){var f=i[v],y=e.cartesianToCartographic(f,L);a&&(y.height=t[v]),l=l&&y.height<=0,P=d,c=y,A.CesiumMath.equalsEpsilon(P.latitude,c.latitude,A.CesiumMath.EPSILON14)&&A.CesiumMath.equalsEpsilon(P.longitude,c.longitude,A.CesiumMath.EPSILON14)?d.height<y.height&&(h[u-1]=y.height):(s[u]=f,h[u]=y.height,g[u]=o?n[v]:0,w.Cartographic.clone(y,d),++u)}if(!(l||u<2))return s.length=u,h.length=u,g.length=u,{positions:s,topHeights:h,bottomHeights:g}}}(e,i,t,n);if(C.defined(a)){if(i=a.positions,t=a.topHeights,n=a.bottomHeights,3<=i.length){var l=b.EllipsoidTangentPlane.fromPoints(i,e).projectPointsOntoPlane(i);E.PolygonPipeline.computeWindingOrder2D(l)===E.WindingOrder.CLOCKWISE&&(i.reverse(),t.reverse(),n.reverse())}var s,h,g=i.length,p=g-2,d=A.CesiumMath.chordLength(r,e.maximumRadius),P=T;if(P.minDistance=d,P.ellipsoid=e,o){var c,u=0;for(c=0;c<g-1;c++)u+=O.PolylinePipeline.numberOfPoints(i[c],i[c+1],d)+1;s=new Float64Array(3*u),h=new Float64Array(3*u);var v=F,f=H;P.positions=v,P.height=f;var y=0;for(c=0;c<g-1;c++){v[0]=i[c],v[1]=i[c+1],f[0]=t[c],f[1]=t[c+1];var m=O.PolylinePipeline.generateArc(P);s.set(m,y),f[0]=n[c],f[1]=n[c+1],h.set(O.PolylinePipeline.generateArc(P),y),y+=m.length}}else P.positions=i,P.height=t,s=new Float64Array(O.PolylinePipeline.generateArc(P)),P.height=n,h=new Float64Array(O.PolylinePipeline.generateArc(P));return{bottomPositions:h,topPositions:s,numCorners:p}}},e.WallGeometryLibrary=i});
