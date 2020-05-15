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
define(["./defined-b9ff0e39","./Check-e6691f86","./freezeObject-2d5b18ce","./defaultValue-199f5aa8","./Math-92bd3539","./Cartesian2-12797039","./Transforms-1175e52c","./RuntimeError-d5522ee3","./WebGLConstants-1819379c","./ComponentDatatype-a270fa7e","./GeometryAttribute-9396e1af","./when-c208a7cf","./GeometryAttributes-c3465b51","./IndexDatatype-d9fd3d17","./GeometryOffsetAttribute-0abfa3f6","./EllipseGeometryLibrary-7793f4dd","./EllipseOutlineGeometry-36c38d93"],function(r,e,t,n,i,a,f,l,o,d,c,s,u,b,m,p,y){"use strict";return function(e,t){return r.defined(t)&&(e=y.EllipseOutlineGeometry.unpack(e,t)),e._center=a.Cartesian3.clone(e._center),e._ellipsoid=a.Ellipsoid.clone(e._ellipsoid),y.EllipseOutlineGeometry.createGeometry(e)}});
