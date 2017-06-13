/**
 * http://dev.axisj.com
 * Require Files for AXISJ UI Component...
 * Based		: jQuery
 * Javascript 	: AXJ.js, AXTree.js, AXInput.js, AXSelect.js, AXModal.js
 * CSS			: AXJ.css, AXTree.css, AXInput.css, AXSelect.css
*/

var pageID = "ObjectGroupTreeControl";
var objectGroupTree = new AXTree();
	
var fnObj = {
	pageStart: function() {
		fnObj.tree1();			
	},
	tree1: function(){
		objectGroupTree.setConfig({
			targetID : "AXTreeTarget",
			theme: "AXTree_none",
			//height:"auto",
			xscroll:true,
            emptyListMSG:"<i class='fa fa-spinner'></i> List of Empty",
            iconWidth:18,
            indentRatio:0.75,

			relation:{
				parentKey:"parent",
				childKey:"object_group_id",
				parentName:"parent_name",
				childName:"object_group_name"
			},
			colGroup: [
				{ key:"object_group_name", label:"제목", width:"*", align:"left", indent:true,
					getIconClass: function(){
                        if(this.item.__subTreeLength > 0){
                            return {
                                addClass:"objectHtml",
                                html:"<i class='fa fa-folder-open'></i>"
                            };
                        }else{
                            return {
                                addClass:"objectHtml",
                                html:"<i class='fa fa-file'></i>"
                            };
                        }
					},
					formatter:function(){
						return (this.item.object_group_name||"").dec();
					}
				}
			],
			body: {
				onclick:function(idx, item) {					
					
					var obj = objectGroupTree.getSelectedList();
					document.objectGroupForm.reset();
					document.objectGroupForm.writeMode.value = "modify";
					
					$("#object_group_id").val(item.object_group_id);
					$("#depth").val(item.depth);
					document.objectGroupForm.object_group_name.value = item.object_group_name;
					$("[name=use_yn]").removeAttr("checked");
					$("[name=use_yn]").filter("[value='" + item.use_yn + "']").prop("checked",true);
					$("#use_yn > option[value='"+item.use_yn+"']").attr("selected", "true");
					$("#object_group_key").val(item.object_group_key);
					$("#description").val(item.description);
					$("#ancestor").val(item.ancestor);
					$("#parent").val(item.parent);
					$("#view_order").val(item.view_order);
					$("#update_type").val(item.update_type);
					
					if (item.depth > 0) {
						ajaxListObjectGroupObject(1);
					} else {
						drawParent("object");
					}
					
					$("#object_manager").dialog("option", "title", item.group_name + " 그룹 Object 관리");
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
					{ objectType:0, label:"위로", className:"up", onclick:function(id) {
						objectGroupTree.moveUpTree();
					}},
					{ objectType:0, label:"아래로", className:"down", onclick:function(id) {
						objectGroupTree.moveDownTree();
					}},
					{objectType:1, label:"추가", className:"plus", onclick:fnObj.addTree},
					{objectType:1, label:"자식추가", className:"plus", onclick:fnObj.addChildTree},
					{objectType:1, label:"삭제하기", className:"", onclick:fnObj.delTree},
					{objectType:1, label:"수정하기", className:"", onclick:fnObj.updateTree}
				],
				filter:function(id){
					// this.menu : 메뉴
					// this.sendObj : 선택된 tree item
					if(this.sendObj){ // 선택된 트리 아이템이 있으면
						if(this.sendObj.nodeType == "company") { // 선택된 트리 아이템 의 nodeType 이 company 이면
							return (this.menu.objectType == 0);
						}else{
							return (this.menu.objectType == 1);
						}
					}else{
						return false;
					}
				}
			}
		});
		objectGroupTree.setTree(OBJECT_GROUP_TREE_DATA);
	},
	appendTree: function(){
		var frm = document.objectGroupForm;
		var writeMode = document.objectGroupForm.writeMode.value;
		if(writeMode == "child") {
			// 자식 객체 추가
//			var obj = myTree.getSelectedList();
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:obj.item.menuId}]);
			ajaxInsertObjectGroup();
		} else if(writeMode == "append") {
			// 형제 객체 추가
			var obj = objectGroupTree.getSelectedListParent(); // 선택 아이템의 부모 아이템 가져오기
			var pno = 0;
			if(obj.item){
				pno = obj.item.object_group_id;
			}			
			//document.treeWriteForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:pno}]);
			ajaxInsertObjectGroup();
		}else if(writeMode == "modify") {
			var obj = objectGroupTree.getSelectedList();
			if(obj.error){
				alert("그룹을 선택해 주세요");
				return;
			}
			if(obj.item.object_group_id == "0") {
				alert("수정할 수 없는 그룹 입니다.")
				return;
			}
			//console.log($("#depth").val() + ", " + $(":radio[name='use_yn']:checked").val());
			if($("#depth").val() == "1" && $(':radio[name="use_yn"]:checked').val() == "N") {
				if(confirm("미사용으로 선택하실 경우 하위 그룹을 전부 사용할수 없습니다. \n 계속 진행하시겠습니까?")) {							
					ajaxUpdateObjectGroup();
				}
			} else {
				ajaxUpdateObjectGroup();
			}
		}
		
		return false;
	},
	addTree: function() {
		var obj = objectGroupTree.getSelectedList();
		if(obj.item == null || obj.item == "" || obj.item == undefined || obj.item == "undefined" || obj.item.object_group_id == "0") {
			alert("하위 그룹을 추가하여 주십시오.");
			return;
		}
		
		document.objectGroupForm.reset();
		document.objectGroupForm.writeMode.value = "append";
		document.objectGroupForm.parent.value = obj.item.parent;
		document.objectGroupForm.depth.value = obj.item.depth;
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		
		document.objectGroupForm.object_group_name.focus();
	},
	addChildTree: function(){
		var obj = objectGroupTree.getSelectedList();
		if(obj.error){
			alert("상위 그룹을 선택해 주세요");
			return;
		}
		if(obj.item.use_yn == "N") {
			alert("상위 그룹이 미사용이므로 하위 그룹을 생성할 수 없습니다.");
			return;
		}
		
		document.objectGroupForm.reset();
		document.objectGroupForm.writeMode.value = "child";
		document.objectGroupForm.parent.value = obj.item.object_group_id;		
		document.objectGroupForm.depth.value = parseInt(obj.item.depth) + parseInt(1);		
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		document.objectGroupForm.object_group_name.focus();
	},
	delTree: function(){
		var obj = objectGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.object_group_id == "0" || obj.item.default_yn == "Y") {
			alert("삭제할 수 없는 그룹 입니다.")
			return;
		}
		
		$("#object_group_id").val(obj.item.object_group_id);		
		ajaxDeleteObjectGroup();
		//myTree.removeTree(obj.index, obj.item);
		document.objectGroupForm.reset();
	},
	updateTree: function(){
		var obj = objectGroupTree.getSelectedList();
		//console.log("group : " + obj.item.object_group_id);
		$("#object_group_id").val(obj.item.object_group_id);
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.object_group_id == "0") {
			alert("수정할 수 없는 그룹 입니다.")
			return;
		}
		document.objectGroupForm.reset();
		document.objectGroupForm.writeMode.value = "modify";
		$("#object_group_id").val(obj.item.object_group_id);
		$("#object_group_key").val(obj.item.object_group_key);
		$("#depth").val(obj.item.depth);
		document.objectGroupForm.object_group_name.value = obj.item.object_group_name;
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='" + obj.item.use_yn + "']").prop("checked",true);
		//$("#url").val(obj.item.url);
		$("#description").val(obj.item.description);
		document.objectGroupForm.object_group_name.focus();
	},
	updateMoveUpTree: function() {
		var obj = objectGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.object_group_id == "0") {
			alert("이동할 수 없는 그룹입니다.")
			return;
		}
		if(obj.item.view_order == "1") {
			alert("제일 처음 입니다.")
			return;
		}
		$("#object_group_id").val(obj.item.object_group_id);
		$("#object_group_key").val(obj.item.object_group_key);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("up");
		ajaxUpdateMoveObjectGroup();
	},
	updateMoveDownTree: function() {
		var obj = objectGroupTree.getSelectedList();
		if(obj.error){
			alert("그룹을 선택해 주세요");
			return;
		}
		if(obj.item.object_group_id == "0") {
			alert("이동할 수 없는 그룹입니다.")
			return;
		}
		$("#object_group_id").val(obj.item.object_group_id);
		$("#object_group_key").val(obj.item.object_group_key);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("down");
		ajaxUpdateMoveObjectGroup();
	},
	moveTree: function(){
		objectGroupTree.moveTree({
			startMove: function(){
				objectGroupTree.addClassItem({
					className:"disable", 
					addClass:function(){
						return (this.object_group_id == "N");
					}
				});
			},
			validate:function(){
				if(this.targetObj.object_group_id == "N"){
					alert("이동할 수 없는 대상을 선택하셨습니다.");
					return false;
				}else{
					return true;	
				}
			},
			endMove: function(){
				objectGroupTree.removeClassItem({
					className:"disable", 
					removeClass:function(){
						return (this.object_group_id == "N");
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
		validationCode = objectGroupTree.moveUpTree();
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
		validationCode = objectGroupTree.moveDownTree();
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

// 그룹 트리 초기화 값
function initObjectGroup(objectGroupTree) {
	OBJECT_GROUP_TREE_DATA = objectGroupTree;
} 

// Object 그룹 목록
function getAjaxObjectGroupList() {
	var info = "";
	$.ajax({
		url: "/object/ajax-list-object-group.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				initObjectGroup(msg.objectGroupTree);
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
function ajaxInsertObjectGroup() {
	var object_group_name = $("#object_group_name").val();
	var object_group_key = $("#object_group_key").val();
	var description = $("#description").val();
	
	if (object_group_name == '') {
		alert("그룹명을 입력해 주세요.");
		return;
	}
	if (object_group_key == '') {
		alert("그룹명(영문)을 입력해 주세요");
		return;
	}
	var regExp = /^[0-9A-Za-z;\-_#$]*$/;
	if (!regExp.test(object_group_key)) {
		alert("그룹명(영문)은 영문 대, 소문자만 입력할 수 있습니다.");
		return;
	}
	
	var info = $("#objectGroupForm").serialize();
	$.ajax({
		url: "/object/ajax-insert-object-group.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				objectGroupTree.setTree(msg.objectGroupTree);
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

// Object 그룹 수정
function ajaxUpdateObjectGroup() {
	var info = $("#objectGroupForm").serialize();
	info.object_group_id = $("#object_group_id").val();
	$.ajax({
		url: "/object/ajax-update-object-group.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				objectGroupTree.setTree(msg.objectGroupTree);
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
function ajaxDeleteObjectGroup() {
	if(confirm("삭제하시겠습니까?")) {
		var info = $("#objectGroupForm").serialize();
		info.object_group_id = $("#object_group_id").val();
		$.ajax({
			url: "/object/ajax-delete-object-group.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					alert("삭제되었습니다.");
					objectGroupTree.setTree(msg.objectGroupTree);
				} else if (msg.result == "objectgroupserver.exists") {
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
function ajaxUpdateMoveObjectGroup() {
	if(confirm("이동하시겠습니까?")) {
		var info = $("#objectGroupForm").serialize();
		$.ajax({
			url: "/object/ajax-update-move-object-group.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "object.session.empty"){
					alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if(msg.result == "object.group.invalid") {
					alert("필수 입력값이 유효하지 않습니다.");
				} else if(msg.result == "db.exception") {
					alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if(msg.result == "success") {
					objectGroupTree.setTree(msg.objectGroupTree);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
}
