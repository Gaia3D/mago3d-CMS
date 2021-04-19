
$(document).ready(function (){
	
	// 초기 레이어 트리 그리기  
	getLayerList();
	
	// 레이어 그룹 on/off
	$("#layerContent").on("click", ".layerGroup", function(e){
		if(!initLayerCheck()) return;
		e.stopPropagation();
		
		var target = $(this).parent("p").parent("li");
		var layerGroupId = $(target).attr("data-depth");
		if($(this).text() === "OFF") {
			$(this).text("ON");
			$(".nodepth").each(function(e){
				if(layerGroupId === $(this).attr("data-ancestor")) {
					$(this).addClass("on");
				}
			});
			MAGO.map.addGroupLayer(Number(layerGroupId));
		} else {
			$(this).text("OFF");
			$(".nodepth").each(function(e){
				if(layerGroupId === $(this).attr("data-ancestor")) {
					$(this).removeClass("on");
				}
			});
			MAGO.map.removeGroupLayer(Number(layerGroupId));
		}
	});
	
	// 하위 영역 on/off
    $("#layerContent").on("click", ".mapLayer p", function(e) {
    	if(!initLayerCheck()) return;
    	e.stopPropagation();
    	var target = $(this).parent("li");
    	target.toggleClass("on");
    });
    
    // layer on/off
    $("#layerContent").on("click", ".nodepth p", function(e) {
    	layerOnOff($(this).parent("li"));
    	layerGroupOnOff();
    });
    
});

// 선택한 레이어 on/off
function layerOnOff(obj) {
	var layerKey = $(obj).attr("data-layer-key");
    var flag = $(obj).hasClass("on");
	if(flag) {
		MAGO.map.addLayer(layerKey);
	} else {
		MAGO.map.removeLayer(layerKey);
	}
}

// 레이어 그룹 on/off
function layerGroupOnOff() {
	$(".layerGroup").each(function(e){
    	var that = this;
    	$(that).text("OFF");
    	var target = $(that).parent("p").parent("li");
		var layerGroupId = $(target).attr("data-depth");
    	$(".nodepth").each(function(e){
			if(layerGroupId === $(this).attr("data-ancestor") && $(this).hasClass("on")) {
				$(that).text("ON");
			}
		});
	});
}
//레이어 메뉴 목록 조회
function getLayerList() {
    $.ajax({
        url: "/layers",
        type: "GET",
        headers: {"X-Requested-With": "XMLHttpRequest"},
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(res){
        	if(res.statusCode <= 200) {
            	// html 생성
                createLayerHtml(res.layerGroupList);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
        	alert(JS_MESSAGE["ajax.error.message"]);
        }
    });
}

// 레이어 트리 html 랜더링 
function createLayerHtml(res) {
	if (!$("#layerListSource").html()) return;
	var template = Handlebars.compile($("#layerListSource").html());

    for(var i=0, len=res.length; i<len; i++) {
        var h = "";
        var selector = "";

        h += template(res[i]);

        if(res[i].depth === 1) {
            selector = $("#layerForm > ul");
            selector.append(h);
        } else {
        	selector = $("[data-depth=" + res[i].parent + "] > ul");
            selector.append(h);
        }
    }
    
    layerGroupOnOff();
}

// 사용자 레이어 설정 저장 
function saveUserLayers() {
	var layerList = [];
	$(".nodepth").each(function(e){
		if($(this).hasClass("on")) {
			layerList.push($(this).attr("data-layer-key"));
		}
	});
	$("#baseLayers").val(layerList.join(","));
	
	$.ajax({
        url: "/user-policy/update-layers",
        type: "POST",
        headers: {"X-Requested-With": "XMLHttpRequest"},
        dataType: "json",
        data : $("#layerForm").serialize(),
        success: function(res){
        	if(res.statusCode <= 200) {
        		alert(JS_MESSAGE["update"]);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
        	alert(JS_MESSAGE["ajax.error.message"]);
        }
    });
}
// 레이어 전체 켜기 
function turnOnAllLayer() {
	if(!initLayerCheck()) return;
	$(".nodepth").addClass("on");
	$(".layerGroup").text("ON");
	MAGO.map.removeAllLayers();
	MAGO.map.initLayer(true);
}
//레이어 전체 끄기
function turnOffAllLayer() {
	if(!initLayerCheck()) return;
	$(".nodepth").removeClass("on");
	$(".layerGroup").text("OFF");
	MAGO.map.removeAllLayers();
}

// 레이어 트리 전체 펼치기 
function openAllLayerTree() {
	if(!initLayerCheck()) return;
	$(".mapLayer").addClass("on");
}

// 레이어 트리 전체 접기
function closeAllLayerTree() {
	if(!initLayerCheck()) return;
	$(".mapLayer").removeClass("on");
}

function initLayerCheck() {
	if(!MAGO.map) {
		alert(JS_MESSAGE["loading"]);
		return false;
	} else {
		return true;
	}
}