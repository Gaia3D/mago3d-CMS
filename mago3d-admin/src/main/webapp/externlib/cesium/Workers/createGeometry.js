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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./AttributeCompression-5ee93a38","./GeometryPipeline-03f56e11","./EncodedCartesian3-9ab2586f","./IndexDatatype-d9fd3d17","./IntersectionTests-e0f27278","./Plane-9e603d64","./PrimitivePipeline-d883f7b2","./WebMercatorProjection-ecf80563","./createTaskProcessorWorker"],function(u,e,r,t,n,a,i,o,f,s,c,d,b,m,l,p,y,P,k,v,C,h){"use strict";var G={};function W(e){var r=G[e];return u.defined(r)||("object"==typeof exports?G[r]=r=require("Workers/"+e):require(["Workers/"+e],function(e){G[r=e]=e})),r}return h(function(e,r){for(var t=e.subTasks,n=t.length,a=new Array(n),i=0;i<n;i++){var o=t[i],f=o.geometry,s=o.moduleName;if(u.defined(s)){var c=W(s);a[i]=c(f,o.offset)}else a[i]=f}return d.when.all(a,function(e){return v.PrimitivePipeline.packCreateGeometryResults(e,r)})})});
