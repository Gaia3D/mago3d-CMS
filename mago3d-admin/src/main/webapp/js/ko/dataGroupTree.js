/**
 * http://dev.axisj.com
 * Require Files for AXISJ UI Component...
 * Based		: jQuery
 * Javascript 	: AXJ.js, AXTree.js, AXInput.js, AXSelect.js, AXModal.js
 * CSS			: AXJ.css, AXTree.css, AXInput.css, AXSelect.css
*/

var pageID = "DataGroupTreeControl";
var dataGroupTree = new AXTree();
	
var fnObj = {
	pageStart: function() {
		fnObj.tree1();			
	},
	tree1: function(){
		dataGroupTree.setConfig({
			targetID : "AXTreeTarget",
			theme: "AXTree_none",
			//height:"auto",
			xscroll:true,
            emptyListMSG:"<i class='fa fa-spinner'></i> List of Empty",
            iconWidth:18,
            indentRatio:0.75,

			relation:{
				parentKey:"parent",
				childKey:"data_group_id",
				parentName:"parent_name",
				childName:"data_group_name"
			},
			colGroup: [
				{ key:"data_group_name", label:"제목", width:"*", align:"left", indent:true,
					getIconClass: function(){
                        if(this.item.__subTreeLength > 0){
                            return {
                                addClass:"userHtml",
                                html:"<i class='fa fa-folder-open'></i>"
                            };
                        }else{
                            return {
                                addClass:"userHtml",
                                html:"<i class='fa fa-file'></i>"
                            };
                        }
					},
					formatter:function(){
						return (this.item.data_group_name||"").dec();
					}
				}
			],
			body: {
				onclick:function(idx, item) {					
					
					var obj = dataGroupTree.getSelectedList();
					document.dataGroupForm.reset();
					document.dataGroupForm.writeMode.value = "modify";
					
					$("#data_group_id").val(item.data_group_id);
					$("#depth").val(item.depth);
					document.dataGroupForm.data_group_name.value = item.data_group_name;
					$("[name=use_yn]").removeAttr("checked");
					$("[name=use_yn]").filter("[value='" + item.use_yn + "']").prop("checked",true);
					$("#use_yn > option[value='"+item.use_yn+"']").attr("selected", "true");
					$("#data_group_key").val(item.data_group_key);
					$("#latitude").val(item.latitude);
					$("#longitude").val(item.longitude);
					$("#height").val(item.height);
					$("#duration").val(item.duration);
					$("#description").val(item.description);
					$("#ancestor").val(item.ancestor);
					$("#parent").val(item.parent);
					$("#view_order").val(item.view_order);
					$("#update_type").val(item.update_type);
					
					if (item.depth > 0) {
						ajaxListDataGroupData(1);
					} else {
						drawParent("data");
					}
					
					$("#data_manager").dialog("option", "title", item.data_group_name + " 그룹 데이터 관리");
				},
				addClass: function(){
					return "myClass";	
				}
			},
			contextMenu: {
				// TODO 이 부분을 어떻게 바꿔야 할지 모르겠음. library 랑 관련이 있음
				theme:"AXContextMenu", // 선택항목
				width:"150", // 선택항목
				menu:[
					{ userType:0, label:"위로", className:"up", onclick:function(id) {
						dataGroupTree.moveUpTree();
					}},
					{ userType:0, label:"아래로", className:"down", onclick:function(id) {
						dataGroupTree.moveDownTree();
					}},
					{userType:1, label:"추가", className:"plus", onclick:fnObj.addTree},
					{userType:1, label:"자식추가", className:"plus", onclick:fnObj.addChildTree},
					{userType:1, label:"삭제하기", className:"", onclick:fnObj.delTree},
					{userType:1, label:"수정하기", className:"", onclick:fnObj.updateTree}
				],
				filter:function(id){
					// this.menu : 메뉴
					// this.sendObj : 선택된 tree item
					if(this.sendObj){ // 선택된 트리 아이템이 있으면
						if(this.sendObj.nodeType == "company") { // 선택된 트리 아이템 의 nodeType 이 company 이면
							return (this.menu.userType == 0);
						}else{
							return (this.menu.userType == 1);
						}
					}else{
						return false;
					}
				}
			}
		});
		dataGroupTree.setTree(DATA_GROUP_TREE_DATA);
	},
	appendTree: function(){
		var frm = document.dataGroupForm;
		var writeMode = document.dataGroupForm.writeMode.value;
		if(writeMode == "child") {
			// 자식 객체 추가
//			var obj = myTree.getSelectedList();
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:obj.item.menuId}]);
			ajaxInsertDataGroup();
		} else if(writeMode == "append") {
			// 형제 객체 추가
			var obj = dataGroupTree.getSelectedListParent(); // 선택 아이템의 부모 아이템 가져오기
			var pno = 0;
			if(obj.item){
				pno = obj.item.data_group_id;
			}			
			//document.treeWriteForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:pno}]);
			ajaxInsertDataGroup();
		}else if(writeMode == "modify") {
			var obj = dataGroupTree.getSelectedList();
			if(obj.error){
				alert("그룹을 선택해 주세요");
				return;
			}
			if(obj.item.data_group_id == "0") {
				alert("수정할 수 없는 그룹 입니다.");
				return;
			}
			//console.log($("#depth").val() + ", " + $(":radio[name='use_yn']:checked").val());
			if($("#depth").val() == "1" && $(':radio[name="use_yn"]:checked').val() == "N") {
				if(confirm("미사용으로 선택하실 경우 하위 그룹을 전부 사용할수 없습니다. \n 계속 진행하시겠습니까?")) {							
					ajaxUpdateDataGroup();
				}
			} else {
				ajaxUpdateDataGroup();
			}
		}
		
		return false;
	},
	addTree: function() {
		var obj = dataGroupTree.getSelectedList();
		if(obj.item == null || obj.item == "" || obj.item == undefined || obj.item == "undefined" || obj.item.data_group_id == "0") {
			alert("하위 그룹을 추가하여 주십시오.");
			return;
		}
		
		document.dataGroupForm.reset();
		document.dataGroupForm.writeMode.value = "append";
		document.dataGroupForm.ancestor.value = obj.item.ancestor;
		document.dataGroupForm.parent.value = obj.item.parent;
		document.dataGroupForm.depth.value = obj.item.depth;
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		
		document.dataGroupForm.data_group_name.focus();
	},
	addChildTree: function(){
		var obj = dataGroupTree.getSelectedList();
		if(obj.error){
			alert("상위 그룹을 선택해 주세요");
			return;
		}
		if(obj.item.use_yn == "N") {
			alert("상위 그룹이 미사용이므로 하위 그룹을 생성할 수 없습니다.");
			return;
		}
		
		document.dataGroupForm.reset();
		document.dataGroupForm.writeMode.value = "child";
		console.log("obj.item.ancestor = " + obj.item.ancestor);
		document.dataGroupForm.ancestor.value = obj.item.ancestor;
		document.dataGroupForm.parent.value = obj.item.data_group_id;		
		document.dataGroupForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		document.dataGroupForm.data_group_name.focus();
	},
	delTree: function(){
		var obj = dataGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.data_group_id == "0" || obj.item.default_yn == "Y") {
			alert("삭제할 수 없는 그룹 입니다.");
			return;
		}
		
		$("#data_group_id").val(obj.item.data_group_id);		
		ajaxDeleteDataGroup();
		//myTree.removeTree(obj.index, obj.item);
		document.dataGroupForm.reset();
	},
	updateTree: function(){
		var obj = dataGroupTree.getSelectedList();
		//console.log("group : " + obj.item.data_group_id);
		$("#data_group_id").val(obj.item.data_group_id);
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.data_group_id == "0") {
			alert("수정할 수 없는 그룹 입니다.");
			return;
		}
		document.dataGroupForm.reset();
		document.dataGroupForm.writeMode.value = "modify";
		$("#data_group_id").val(obj.item.data_group_id);
		$("#data_group_key").val(obj.item.data_group_key);
		$("#depth").val(obj.item.depth);
		document.dataGroupForm.data_group_name.value = obj.item.data_group_name;
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='" + obj.item.use_yn + "']").prop("checked",true);
		//$("#url").val(obj.item.url);
		$("#description").val(obj.item.description);
		document.dataGroupForm.data_group_name.focus();
	},
	updateMoveUpTree: function() {
		var obj = dataGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.data_group_id == "0") {
			alert("이동할 수 없는 그룹입니다.");
			return;
		}
		if(obj.item.view_order == "1") {
			alert("제일 처음 입니다.");
			return;
		}
		$("#data_group_id").val(obj.item.data_group_id);
		$("#data_group_key").val(obj.item.data_group_key);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("up");
		ajaxUpdateMoveDataGroup();
	},
	updateMoveDownTree: function() {
		var obj = dataGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.data_group_id == "0") {
			alert("이동할 수 없는 그룹입니다.");
			return;
		}
		$("#data_group_id").val(obj.item.data_group_id);
		$("#data_group_key").val(obj.item.data_group_key);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("down");
		ajaxUpdateMoveDataGroup();
	},
	moveTree: function(){
		dataGroupTree.moveTree({
			startMove: function(){
				dataGroupTree.addClassItem({
					className:"disable", 
					addClass:function(){
						return (this.data_group_id == "N");
					}
				});
			},
			validate:function(){
				if(this.targetObj.data_group_id == "N"){
					alert("이동할 수 없는 대상을 선택하셨습니다.");
					return false;
				}else{
					return true;	
				}
			},
			endMove: function(){
				dataGroupTree.removeClassItem({
					className:"disable", 
					removeClass:function(){
						return (this.data_group_id == "N");
					}
				});
			}
		});
	}		
	
};

// 동일 레벨의 그룹 추가
function addTree() {
	fnObj.addTree();
}
// 하위 레벨의 그룹 추가
function addChildTree() {
	fnObj.addChildTree();
}
// 그룹 삭제
function delTree() {
	fnObj.delTree();
}
// 그룹 수정
function updateTree() {
	fnObj.updateTree();
}

// 그룹 위로 이동
var upFlag = true;
function moveUpTree() {
	if(upFlag) {
		upFlag = false;
		var validationCode = null;
		validationCode = dataGroupTree.moveUpTree();
		if(validationCode == "1") {
			fnObj.updateMoveUpTree();
			upFlag = true;
		}
		upFlag = true;
	} else {
		alert("진행 중입니다.");
		return;
	}
}

// 그룹 아래로 이동
var downFlag = true;
function moveDownTree() {
	if(downFlag) {
		downFlag = false;
		var validationCode = null;
		validationCode = dataGroupTree.moveDownTree();
		if(validationCode == "1") {
			fnObj.updateMoveDownTree();
			downFlag = true;
		}
		downFlag = true;
	} else {
		alert("진행 중입니다.");
		return;
	}
}
// 그룹 정보 저장
function appendTree() {
	fnObj.appendTree();
}
// 취소
/*function modalClose(modalId) {
	myModal.close(modalId);
}*/

// 그룹 트리 초기화 값
function initDataGroup(groupTree) {
	DATA_GROUP_TREE_DATA = groupTree;
} 

// 사용자 그룹 목록
function getAjaxDataGroupList() {
	var info = "";
	$.ajax({
		url: "/data/ajax-list-data-group.do",
		type: "POST",
		data: info,
		cache: false,
//		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				initDataGroup(msg.groupTree);
				fnObj.pageStart.delay(0.1);
			} else {
				alert(JS_MESSAGE[msg.result]);
			}
		},
//		error: function() {
//			alert(JS_MESSAGE["ajax.error.message"]);
//		}
		error:function(request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}

	});
}

// 그룹 등록
function ajaxInsertDataGroup() {
	var data_group_name = $("#data_group_name").val();
	var data_group_key = $("#data_group_key").val();
	var description = $("#description").val();
	
	if (data_group_name == '') {
		alert("그룹명을 입력해 주세요.");
		return;
	}
	if (data_group_key == '') {
		alert("그룹명(영문)을 입력해 주세요");
		return;
	}
	var regExp = /^[0-9A-Za-z;\-_#$]*$/;
	if (!regExp.test(data_group_key)) {
		alert("그룹명(영문)은 영문 대, 소문자만 입력할 수 있습니다.");
		return;
	}
	
	var info = $("#dataGroupForm").serialize();
	$.ajax({
		url: "/data/ajax-insert-data-group.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				dataGroupTree.setTree(msg.groupTree);
				alert(JS_MESSAGE["insert"]);
			} else {
				alert(JS_MESSAGE[msg.result]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 사용자 그룹 수정
function ajaxUpdateDataGroup() {
	var info = $("#dataGroupForm").serialize();
	info.data_group_id = $("#data_group_id").val();
	$.ajax({
		url: "/data/ajax-update-data-group.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				dataGroupTree.setTree(msg.groupTree);
				alert(JS_MESSAGE["update"]);
			} else {
				alert(JS_MESSAGE[msg.result]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 그룹 삭제
function ajaxDeleteDataGroup() {
	if(confirm("삭제하시겠습니까?")) {
		var info = $("#dataGroupForm").serialize();
		info.data_group_id = $("#data_group_id").val();
		$.ajax({
			url: "/data/ajax-delete-data-group.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					alert("삭제되었습니다.");
					dataGroupTree.setTree(msg.groupTree);
				} else if (msg.result == "usergroupserver.exists") {
					alert("등록된 서버가 있어 삭제할 수 없습니다.");
					return;
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
}

// 그룹 위로/아래로 수정
function ajaxUpdateMoveDataGroup() {
	if(confirm("이동하시겠습니까?")) {
		var info = $("#dataGroupForm").serialize();
		$.ajax({
			url: "/data/ajax-update-move-data-group.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "user.session.empty"){
					alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if(msg.result == "user.group.invalid") {
					alert("필수 입력값이 유효하지 않습니다.");
				} else if(msg.result == "db.exception") {
					alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if(msg.result == "success") {
					dataGroupTree.setTree(msg.groupTree);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
}
