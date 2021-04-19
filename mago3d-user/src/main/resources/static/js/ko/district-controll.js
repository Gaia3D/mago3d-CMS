var district;

function DistrictControll(magoInstance) {
    var viewer = magoInstance.getViewer();
    district = new District(magoInstance, viewer);
    loadDistrict();
}

function District(magoInstance, viewer) {

    this.drawDistrict = function (name, sdoCode, sggCode, emdCode, bjcdLen) {

        this.deleteDistrict();
        var now = new Date();
        var rand = (now - now % 5000) / 5000;
        var policy = MAGO.policy;

        var sdoCodeStr = sdoCode.toString();
        var sggCodeStr = sggCode.toString();
        var emdCodeStr = emdCode.toString();

        // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
        var queryString;
        if (bjcdLen == 10) {
            queryString = "bjcd = " + sdoCodeStr.padStart(2, '0')
                                    + sggCodeStr.padStart(3, '0')
                                    + emdCodeStr.padStart(3, '0') + '00';
        } else {
            queryString = "bjcd = " + sdoCodeStr + sggCodeStr + emdCodeStr;
        }

        // TODO 개발 서버 포팅후 geoserver url 변경하기 
        var provider = new Cesium.WebMapServiceImageryProvider({
            url: policy.geoserverDataUrl + "/wms",
            layers: 'mago3d:district',
            minimumLevel: 2,
            maximumLevel: 20,
            parameters: {
                service: 'WMS'
                , version: '1.1.1'
                , request: 'GetMap'
                , transparent: 'true'
                , format: 'image/png'
                , time: 'P2Y/PRESENT'
                , rand: rand
                , maxZoom: 25
                , maxNativeZoom: 23
                , CQL_FILTER: queryString
                //bjcd LIKE '47820253%' AND name='청도읍'
            },
            enablePickFeatures: false
        });

        var layer = viewer.imageryLayers.addImageryProvider(provider);
        layer.id = "district";
    },

    this.deleteDistrict = function () {
        var districtProvider = MAGO.map.getImageryLayerById('district');
        if (districtProvider) {
            viewer.imageryLayers.remove(districtProvider);
        }
    },

    this.gotoFly = function(longitude, latitude, altitude, duration) {
        event.stopPropagation();
        gotoFlyAPI(MAGO3D_INSTANCE, longitude, latitude, altitude, duration);
    }
}

var sdoName = "";
var sggName = "";
var emdName = "";
var sdoCode = "";
var sggCode = "";
var emdCode = "";
var bjcdLen;
var districtMapType = 1;

/**
 * 시도 목록을 로딩
 */
function loadDistrict() {
    var url = "../searchmap/sdos";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {

                bjcdLen = msg.sdoList[0].bjcd.length;

                // 핸들바 템플릿 컴파일
                updateSelectSdo(msg);

            } else {
                alert(JS_MESSAGE[msg.errorCode]);
                console.log("---- " + msg.message);
            }
        },
        error: function (request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

/**
 * 시도가 변경되면 하위 시군구, 읍면동이 변경됨
 * @param _this
 * @param _sdoCode
 * @returns {boolean}
 */
function changeSdo(_this, _sdoCode) {
    sdoCode = _sdoCode;
    sggCode = "";
    emdCode = "";
    districtMapType = 1;

    if (!sdoCode) {
        sdoCode = "";

        var msg = {
            sdoCode : sdoCode,
            sggCode : sggCode,
            emdCode : emdCode,
            isSelectedSdo : true,
            sdoName : '',
            sggName : '',
            emdName : ''
        };

        // 핸들바 템플릿 컴파일
        updateSelectSgg(msg);
        updateSelectEmd(msg);
        updateSelectNav(msg);
        updateSelectedElement("#districtSelectSdoDHTML li", _this);

        return false;
    }

    var url = "../searchmap/sdos/" + sdoCode + "/sggs";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {
                sdoName = $(_this).text();
                sggName = "";
                emdName = "";

                msg.sdoCode = sdoCode;
                msg.sggCode = sggCode;
                msg.emdCode = emdCode;
                msg.isSelectedSdo = true;
                msg.sdoName = sdoName;
                msg.sggName = sggName;
                msg.emdName = emdName;

                // 핸들바 템플릿 컴파일
                updateSelectSgg(msg);
                updateSelectEmd(msg);
                updateSelectNav(msg);
                updateSelectedElement("#districtSelectSdoDHTML li", _this);

            } else {
                alert(JS_MESSAGE[msg.errorCode]);
                console.log("---- " + msg.message);
            }
        },
        error: function (request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

/**
 * 시군구가 변경되면 하위 읍면동이 변경됨
 * @param _this
 * @param _sdoCode
 * @param _sggCode
 * @returns {boolean}
 */
function changeSgg(_this, _sdoCode, _sggCode) {
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = "";
    districtMapType = 2;

    if (!sggCode) {
        sggCode = "";
        districtMapType = 1;

        var msg = {
            sdoCode : sdoCode,
            sggCode : sggCode,
            emdCode : emdCode,
            isSelectedSdo : true,
            sdoName : sdoName,
            sggName : "",
            emdName : ""
        };

        // 핸들바 템플릿 컴파일
        updateSelectEmd(msg);
        updateSelectNav(msg);
        updateSelectedElement("#districtSelectSggDHTML li", _this);

        return false;
    }

    var url = "../searchmap/sdos/" + sdoCode + "/sggs/" + sggCode + "/emds";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {
                sggName = $(_this).text();
                emdName = "";

                msg.sdoCode = sdoCode;
                msg.sggCode = sggCode;
                msg.emdCode = emdCode;
                msg.isSelectedSgg = true;
                msg.sdoName = sdoName;
                msg.sggName = sggName;
                msg.emdName = emdName;

                // 핸들바 템플릿 컴파일
                updateSelectEmd(msg);
                updateSelectNav(msg);
                updateSelectedElement("#districtSelectSggDHTML li", _this);

            } else {
                alert(JS_MESSAGE[msg.errorCode]);
                console.log("---- " + msg.message);
            }
        },
        error: function (request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

/**
 * 읍면동을 선택
 * @param _this
 * @param _sdoCode
 * @param _sggCode
 * @param _emdCode
 * @returns {boolean}
 */
function changeEmd(_this, _sdoCode, _sggCode, _emdCode) {
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = _emdCode;
    districtMapType = 3;

    if (!emdCode) {
        emdCode = "";
        districtMapType = 2;
        var msg = {
            sdoCode : sdoCode,
            sggCode : sggCode,
            emdCode : emdCode,
            isSelectedSgg : true,
            sdoName : sdoName,
            sggName : sggName,
            emdName : ""
        };
        updateSelectNav(msg);
        updateSelectedElement("#districtSelectEmdDHTML li", _this);
        return false;
    }

    emdName = $(_this).text();
    var msg = {
        sdoCode : sdoCode,
        sggCode : sggCode,
        emdCode : emdCode,
        isSelectedEmd : true,
        sdoName : sdoName,
        sggName : sggName,
        emdName : emdName
    };
    updateSelectNav(msg);
    updateSelectedElement("#districtSelectEmdDHTML li", _this);
}

function updateSelectSdo(msg) {
    var templateSdo = Handlebars.compile($("#districtSelectSdoSource").html());
    $("#districtSelectSdoDHTML").html("").append(templateSdo(msg));
}

function updateSelectSgg(msg) {
    var templateSgg = Handlebars.compile($("#districtSelectSggSource").html());
    $("#districtSelectSggDHTML").html("").append(templateSgg(msg));
}

function updateSelectEmd(msg) {
    var templateEmd = Handlebars.compile($("#districtSelectEmdSource").html());
    $("#districtSelectEmdDHTML").html("").append(templateEmd(msg));
}

function updateSelectNav(msg) {
    var templateNav = Handlebars.compile($("#districtSelectNavSource").html());
    $("#districtSelectNavDHTML").html("").append(templateNav(msg));
}

function updateSelectedElement(_parent, _this) {
    $(_parent).removeClass("on");
    $(_this).addClass('on');
}

// 지역선택
$('#districtSelect').click(function() {
    $(this).toggleClass('on');
    $('#districtSelectContent').toggle();
    if ($("#districtSearchResultContent").is(':visible')) {
        $("#districtSearchResultContent").hide();
}
});

// 지역이동
$("#districtFlyButton").click(function () {
    var name = [sdoName, sggName, emdName].join(" ").trim();
    district.drawDistrict(name, sdoCode, sggCode, emdCode, bjcdLen);
    getEnvelope(name, sdoCode, sggCode, emdCode, bjcdLen);
    //getCentroid(name, sdoCode, sggCode, emdCode);
});
// 영역 지우기
$("#districtCancelButton").click(function () {
    district.deleteDistrict();
});
// 닫기
$("#districtCloseButton").click(function () {
    if ($("#districtSelectContent").is(':visible')) {
        $('#districtSelectContent').hide();
    }
});

function getEnvelope(name, sdoCode, sggCode, emdCode, bjcdLen) {
    var layerType = districtMapType;

    var sdoCodeStr = sdoCode.toString();
    var sggCodeStr = sggCode.toString();
    var emdCodeStr = emdCode.toString();

    // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
    var bjcd;
    if (bjcdLen == 10) {
        bjcd = sdoCodeStr.padStart(2, '0')
            + sggCodeStr.padStart(3, '0')
            + emdCodeStr.padStart(3, '0') + '00';
    } else {
        bjcd = sdoCodeStr + sggCodeStr + emdCodeStr;
    }

    var info = "layerType=" + layerType + "&name=" + name + "&bjcd=" + bjcd;
    $.ajax({
        url: "../searchmap/envelope",
        type: "GET",
        data: info,
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {

                var pointArray = [];
                var minX = msg.minPoint[0];
                var minY = msg.minPoint[1];
                var maxX = msg.maxPoint[0];
                var maxY = msg.maxPoint[1];

                pointArray[0] = Mago3D.ManagerUtils.geographicCoordToWorldPoint(minX, minY, 0);
                pointArray[1] = Mago3D.ManagerUtils.geographicCoordToWorldPoint(maxX, maxY, 0);

                MAGO3D_INSTANCE.getMagoManager().flyToBox(pointArray);

            } else {
                alert(JS_MESSAGE[msg.errorCode]);
                console.log("---- " + msg.message);
            }
        },
        error: function (request, status, error) {
            //alert(JS_MESSAGE["ajax.error.message"]);
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

function getCentroid(name, sdoCode, sggCode, emdCode, bjcdLen) {
    var layerType = districtMapType;

    var sdoCodeStr = sdoCode.toString();
    var sggCodeStr = sggCode.toString();
    var emdCodeStr = emdCode.toString();

    // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
    var bjcd;
    if (bjcdLen == 10) {
        bjcd = sdoCodeStr.padStart(2, '0')
            + sggCodeStr.padStart(3, '0')
            + emdCodeStr.padStart(3, '0') + '00';
    } else {
        bjcd = sdoCodeStr + sggCodeStr + emdCodeStr;
    }
    var time = 3;

    var info = "layerType=" + layerType + "&name=" + name + "&bjcd=" + bjcd;
    $.ajax({
        url: "../searchmap/centroids",
        type: "GET",
        data: info,
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {
                var altitude = 50000;
                if(layerType === 2) {
                    altitude = 15000;
                } else if(layerType === 3) {
                    altitude = 1500;
                }
                gotoFly(msg.longitude, msg.latitude, altitude, time);
            } else {
                alert(JS_MESSAGE[msg.errorCode]);
                console.log("---- " + msg.message);
            }
        },
        error: function (request, status, error) {
            //alert(JS_MESSAGE["ajax.error.message"]);
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

function updateViewDistrictName() {
    // 시군구가 blank
    if (sggName.trim() === "" || sdoName === sggName) {
        // 읍면동이 blan 이거나 시도랑 같은 경우
        if (emdName.trim() === "" || sdoName === emdName) {
            $("#viewDistrictName").html([sdoName]);
        } else {
            $("#viewDistrictName").html([sdoName, emdName].join(" "));
        }
    } else {
        // 시도랑 시군구랑 다를때
        // 시도랑 읍면동이 같을때
        if (sdoName === emdName) {
            $("#viewDistrictName").html([sdoName, sggName].join(" "));
        } else {
            if (sggName === emdName) {
                $("#viewDistrictName").html([sdoName, sggName].join(" "));
            } else {
                $("#viewDistrictName").html([sdoName, sggName, emdName].join(" "));
            }
        }

        if (sggName === emdName) {
            $("#viewDistrictName").html([sdoName, sggName].join(" "));
        } else {
            $("#viewDistrictName").html([sdoName, sggName, emdName].join(" "));
        }
    }
}