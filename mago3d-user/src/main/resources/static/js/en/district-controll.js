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
        // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
        var queryString;
        if (bjcdLen==10){
        	queryString = "bjcd = " + sdoCode.toString().padStart(2, '0') + sggCode.toString().padStart(3, '0') + emdCode.toString().padStart(3, '0') + '00';
        }else{
        	queryString = "bjcd = " + sdoCode.toString() + sggCode.toString() + emdCode.toString();
        }
        console.log(sdoCode.toString().length);
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
    }

    this.deleteDistrict = function () {
        var districtProvider = MAGO.map.getImageryLayerById('district');
        if (districtProvider) {
            viewer.imageryLayers.remove(districtProvider);
        }
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

var defaultDistrictObject = '<li class="on">전체</li>';

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
                var sdoList = msg.sdoList;
                var content = "";
                bjcdLen = sdoList[0].bjcd.length;

                content += defaultDistrictObject;
                for (var i = 0, len = sdoList.length; i < len; i++) {
                    var sdo = sdoList[i];
                    content += '<li onclick="changeSdo(this, ' + sdo.sdoCode + ')">' + sdo.name + '</li>';
                }
                $('#sdoList').html(content);
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

// 시도가 변경되면 하위 시군구, 읍면동이 변경됨
function changeSdo(_this, _sdoCode) {
    sdoCode = _sdoCode;
    sggCode = "";
    emdCode = "";
    districtMapType = 1;

    var url = "../searchmap/sdos/" + sdoCode + "/sggs";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {
                var sggList = msg.sggList;
                var content = "";

                content += defaultDistrictObject;
                for (var i = 0, len = sggList.length; i < len; i++) {
                    var sgg = sggList[i];
                    content += '<li onclick="changeSgg(this, ' + sdoCode + ', ' + sgg.sggCode + ')">' + sgg.name + '</li>';
                }
                sdoName = $(_this).text();
                sggName = "";
                emdName = "";

                $('#sggList').html(content);
                $('#emdList').html(defaultDistrictObject);

                $("#sdoList li").removeClass("on");
                $(_this).addClass('on');

                updateViewDistrictName();
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

// 시군구가 변경되면 하위 읍면동이 변경됨
function changeSgg(_this, _sdoCode, _sggCode) {
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = "";
    districtMapType = 2;

    var url = "../searchmap/sdos/" + sdoCode + "/sggs/" + sggCode + "/emds";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (msg) {
            if (msg.statusCode <= 200) {
                var emdList = msg.emdList;
                var content = "";

                content += defaultDistrictObject;
                for (var i = 0, len = emdList.length; i < len; i++) {
                    var emd = emdList[i];
                    content += '<li onclick="changeEmd(this, ' + sdoCode + ', ' + sggCode + ', ' + emd.emdCode + ')">' + emd.name + '</li>';
                }
                sggName = $(_this).text();
                emdName = "";

                $('#emdList').html(content);

                $("#sggList li").removeClass("on");
                $(_this).addClass('on');

                updateViewDistrictName();
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

// 읍면동을 선택
function changeEmd(_this, _sdoCode, _sggCode, _emdCode) {
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = _emdCode;
    districtMapType = 3;

    emdName = $(_this).text();

    $("#emdList li").removeClass("on");
    $(_this).addClass('on');

    updateViewDistrictName();
}

$("#districtFlyButton").click(function () {
    var name = [sdoName, sggName, emdName].join(" ").trim();
    district.drawDistrict(name, sdoCode, sggCode, emdCode, bjcdLen);
    //getCentroid(name, sdoCode, sggCode, emdCode);
    getEnvelope(name, sdoCode, sggCode, emdCode, bjcdLen);
});

$("#districtCancelButton").click(function () {
    district.deleteDistrict();
});


function getCentroid(name, sdoCode, sggCode, emdCode, bjcdLen) {
    var layerType = districtMapType;
    if(bjcdLen==10){
    var bjcd = sdoCode.toString().padStart(2, '0') + sggCode.toString().padStart(3, '0') + emdCode.toString().padStart(3, '0') + '00';
    }else{
    	bjcd = sdoCode.toString() + sggCode.toString() + emdCode.toString();
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
                if (layerType === 2) {
                    altitude = 15000;
                } else if (layerType === 3) {
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

function getEnvelope(name, sdoCode, sggCode, emdCode, bjcdLen) {
    var layerType = districtMapType;
    var bjcd;
    if(bjcdLen==10){
    var bjcd = sdoCode.toString().padStart(2, '0') + sggCode.toString().padStart(3, '0') + emdCode.toString().padStart(3, '0') + '00';
    }else{
    	bjcd = sdoCode.toString() + sggCode.toString() + emdCode.toString();
    }
    
    var time = 3;

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

                /*
                var altitude = 50000;
                if(layerType === 2) {
                    altitude = 15000;
                } else if(layerType === 3) {
                    altitude = 1500;
                }
                gotoFly(msg.longitude, msg.latitude, altitude, time);
                */
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

function gotoFly(longitude, latitude, altitude, duration) {
    gotoFlyAPI(MAGO3D_INSTANCE, longitude, latitude, altitude, duration);
}