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
define(["exports","./defined-b9ff0e39","./Check-e6691f86","./defaultValue-199f5aa8","./Math-92bd3539"],function(e,l,t,h,f){"use strict";var s=f.CesiumMath.EPSILON10;e.arrayRemoveDuplicates=function(e,t,f){if(l.defined(e)){f=h.defaultValue(f,!1);var r,a,i,n=e.length;if(n<2)return e;for(r=1;r<n&&!t(a=e[r-1],i=e[r],s);++r);if(r===n)return f&&t(e[0],e[e.length-1],s)?e.slice(1):e;for(var u=e.slice(0,r);r<n;++r)t(a,i=e[r],s)||(u.push(i),a=i);return f&&1<u.length&&t(u[0],u[u.length-1],s)&&u.shift(),u}}});
