/**
 * http://dev.axisj.com
 * Require Files for AXISJ UI Component...
 * Based		: jQuery
 * Javascript 	: AXJ.js, AXTree.js, AXInput.js, AXSelect.js, AXModal.js
 * CSS			: AXJ.css, AXTree.css, AXInput.css, AXSelect.css
*/

var pageID = "MenuTreeControl";
var menuTree = new AXTree();
//var myModal = new AXModal();
	
var fnObj = {
	pageStart: function() {
		fnObj.tree1();			
	},
	tree1: function(){
		menuTree.setConfig({
			targetID : "AXTreeTarget",
			theme: "AXTree_none",
			//height:"auto",
			xscroll:true,
            emptyListMSG:"<i class='fa fa-spinner'></i> List of Empty",
            iconWidth:18,
            indentRatio:0.75,

			relation:{
				parentKey:"parent",
				childKey:"menu_id",
				parentName:"parent_name",
				childName:"name"
			},
			colGroup: [
				{ key:"name", label:"제목", width:"*", align:"left", indent:true,
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
						return (this.item.name||"").dec();
					}
				}
			],
			body: {
				onclick:function(idx, item) {
					//toast.push(Object.toJSON(item));
					//trace(item);
					
					var obj = menuTree.getSelectedList();
					document.treeWriteForm.reset();
					document.treeWriteForm.writeMode.value = "modify";
					$("#menu_id").val(obj.item.menu_id);
					$("#depth").val(obj.item.depth);
					$("#name").val(obj.item.name);
					$("#name_en").val(obj.item.name_en);
					$("[name=use_yn]").removeAttr("checked");
					$("[name=use_yn]").filter("[value='" + obj.item.use_yn + "']").prop("checked",true);
					$("#url").val(obj.item.url);
					$("#image").val(obj.item.image);
					$("#image_alt").val(obj.item.image_alt);
					$("#css_class").val(obj.item.css_class);
					$("#description").val(obj.item.description);
					document.treeWriteForm.name.focus();
					
				},
				addClass: function(){
					return "myClass";	
				}
			},
			contextMenu: {
				theme:"AXContextMenu", // 선택항목
				width:"150", // 선택항목
				menu:[
					{ userType:0, label:"위로", className:"up", onclick:function(id) {
						menuTree.moveUpTree();
					}},
					{ userType:0, label:"아래로", className:"down", onclick:function(id) {
						menuTree.moveDownTree();
					}},
					{userType:1, label:"추가", className:"plus", onclick:fnObj.addTree},
					{userType:1, label:"하위메뉴추가", className:"plus", onclick:fnObj.addChildTree},
					{userType:1, label:"선택삭제", className:"", onclick:fnObj.delTree}
					/*{userType:1, label:"수정", className:"", onclick:fnObj.updateTree}*/
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
		menuTree.setTree(MENU_TREE_DATA);
	},
	appendTree: function(){
		var frm = document.treeWriteForm;
		var writeMode = document.treeWriteForm.writeMode.value;
		if(writeMode === null || writeMode === "") {
			alert("메뉴를 선택해 주세요.");
			return;
		}
		//myModal.close('addTreeModal');
		if(writeMode == "child") {
			// 자식 객체 추가
//			var obj = menuTree.getSelectedList();
//			menuTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:obj.item.menuId}]);
			ajaxInsertMenu();
		}else if(writeMode == "append") {
			// 형제 객체 추가
			var obj = menuTree.getSelectedListParent(); // 선택 아이템의 부모 아이템 가져오기
			var pno = 0;
			if(obj.item){
				pno = obj.item.menu_id;
			}
			
			//document.treeWriteForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
//			menuTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:pno}]);
			ajaxInsertMenu();
		}else if(writeMode == "modify") {
			var obj = menuTree.getSelectedList();
			if(obj.error){
				alert("메뉴를 선택해 주세요");
				return;
			}
			if(obj.item.menu_id == "0") {
				alert("수정할 수 없는 메뉴 입니다.")
				return;
			}
			
			console.log($("#depth").val() + ", " + $(":radio[name='use_yn']:checked").val());
			if($("#depth").val() == "1" && $(":radio[name='use_yn']:checked").val() == "N") {
				if(confirm("미사용으로 선택하실 경우 하위 메뉴를 전부 사용할수 없습니다. \n 계속 진행하시겠습니까?")) {
					ajaxUpdateMenu();
				}
			} else {
				ajaxUpdateMenu();
			}
		}
		
		return false;
	},
	addTree: function() {
		var obj = menuTree.getSelectedList();
		if(obj.item == null || obj.item == "" || obj.item == undefined || obj.item == "undefined" || obj.item.menu_id == "0") {
			alert("하위 메뉴를 추가하여 주십시오.");
			return;
		}
		
		document.treeWriteForm.reset();
		document.treeWriteForm.writeMode.value = "append";
		document.treeWriteForm.parent.value = obj.item.parent;
		document.treeWriteForm.depth.value = obj.item.depth;
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		
		/*myModal.openDiv({
			modalID:"addTreeModal",
			targetID:"modalContent",
			width:450,
			top:150
		});*/
		document.treeWriteForm.name.focus();
	},
	addChildTree: function(){
		var obj = menuTree.getSelectedList();
		if(obj.error){
			alert("상위메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.use_yn == "N") {
			alert("상위 메뉴가 미사용이므로 하위 메뉴를 생성할 수 없습니다.");
			return;
		}
		/*if(parseInt(obj.item.depth) == 2) {
			alert("성능 최적화를 위해 2Depth 이하의 하위 메뉴를 생성할 수 없습니다.");
			return;
		}*/
		document.treeWriteForm.reset();
		document.treeWriteForm.writeMode.value = "child";
		document.treeWriteForm.parent.value = obj.item.menu_id;
		document.treeWriteForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
		/*myModal.openDiv({
			modalID:"addTreeModal",
			targetID:"modalContent",
			width:450,
			top:150
		});*/
		document.treeWriteForm.name.focus();
	},
	delTree: function(){
		var obj = menuTree.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menu_id == "0" || obj.item.default_yn == "Y") {
			alert("삭제할 수 없는 메뉴 입니다.")
			return;
		}
		$("#menu_id").val(obj.item.menu_id);
		ajaxDeleteMenu();
		//menuTree.removeTree(obj.index, obj.item);
		document.treeWriteForm.reset();
	},
	updateTree: function(){
		var obj = menuTree.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menu_id == "0") {
			alert("수정할 수 없는 메뉴 입니다.")
			return;
		}
		document.treeWriteForm.reset();
		document.treeWriteForm.writeMode.value = "modify";
		/*myModal.openDiv({
			modalID:"addTreeModal",
			targetID:"modalContent",
			width:450,
			top:150
		});*/
		$("#menu_id").val(obj.item.menu_id);
		$("#depth").val(obj.item.depth);
		$("#name").val(obj.item.name);
		$("#name_en").val(obj.item.name_en);
		$("[name=use_yn]").removeAttr("checked");
		$("[name=use_yn]").filter("[value='" + obj.item.use_yn + "']").prop("checked",true);
		$("#url").val(obj.item.url);
		$("#image").val(obj.item.image);
		$("#image_alt").val(obj.item.image_alt);
		$("#css_class").val(obj.item.css_class);
		$("#description").val(obj.item.description);
		document.treeWriteForm.name.focus();
	},
	updateMoveUpTree: function() {
		var obj = menuTree.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menu_id == "0") {
			alert("이동할 수 없는 메뉴입니다.")
			return;
		}
		if(obj.item.view_order == "1") {
			alert("제일 처음 입니다.")
			return;
		}
		$("#menu_id").val(obj.item.menu_id);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("up");
		ajaxUpdateMoveMenu();
	},
	updateMoveDownTree: function() {
		var obj = menuTree.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menu_id == "0") {
			alert("이동할 수 없는 메뉴입니다.")
			return;
		}
		$("#menu_id").val(obj.item.menu_id);
		$("#view_order").val(obj.item.view_order);
		$("#parent").val(obj.item.parent);
		$("#update_type").val("down");
		ajaxUpdateMoveMenu();
	},
	moveTree: function(){
		menuTree.moveTree({
			startMove: function(){
				menuTree.addClassItem({
					className:"disable", 
					addClass:function(){
						return (this.menu_id == "N");
					}
				});
			},
			validate:function(){
				//this.moveObj
				//this.targetObj
				/*if(this.targetObj.menuId == "0"){
					alert("이동할 수 없는 대상을 선택하셨습니다.");
					return false;
				}*/
				if(this.targetObj.menu_id == "N"){
					alert("이동할 수 없는 대상을 선택하셨습니다.");
					return false;
				}else{
					return true;	
				}
			},
			endMove: function(){
				menuTree.removeClassItem({
					className:"disable", 
					removeClass:function(){
						return (this.menu_id == "N");
					}
				});
			}
		});
	}		
};

// 동일 레벨의 메뉴 추가
function addTree() {
	fnObj.addTree();
}
// 하위 레벨의 메뉴 추가
function addChildTree() {
	fnObj.addChildTree();
}
// 메뉴 삭제
function delTree() {
	fnObj.delTree();
}
// 메뉴 수정
function updateTree() {
	fnObj.updateTree();
}

// 메뉴 위로 이동
var upFlag = true;
function moveUpTree() {
	if(upFlag) {
		upFlag = false;
		var validationCode = null;
		validationCode = menuTree.moveUpTree();
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

// 메뉴 아래로 이동
var downFlag = true;
function moveDownTree() {
	if(downFlag) {
		downFlag = false;
		var validationCode = null;
		validationCode = menuTree.moveDownTree();
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
// 메뉴 정보 저장
function appendTree() {
	fnObj.appendTree();
}
// 취소
/*function modalClose(modalId) {
	myModal.close(modalId);
}*/
function resetForm() {
	document.treeWriteForm.reset();
}

// 트리 초기화 값
function initMenu(menuTree) {
	MENU_TREE_DATA = menuTree;
} 

// 메뉴 목록
function getAjaxMenuList() {
	// var info = $("#treeWriteForm").serialize();
	var info = "";
	$.ajax({
		url: "/config/ajax-list-menu.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				console.log(msg.menuTree);
				initMenu(msg.menuTree);
			} else {
				alert(JS_MESSAGE[msg.result]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

// 메뉴 등록
function ajaxInsertMenu() {
	var info = $("#treeWriteForm").serialize();
	$.ajax({
		url: "/config/ajax-insert-menu.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				menuTree.setTree(msg.menuTree);
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

// 메뉴 수정
function ajaxUpdateMenu() {
	var info = $("#treeWriteForm").serialize();
	$.ajax({
		url: "/config/ajax-update-menu.do",
		type: "POST",
		data: info,
		cache: false,
		async:false,
		dataType: "json",
		success: function(msg){
			if(msg.result == "success") {
				menuTree.setTree(msg.menuTree);
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

// 메뉴 삭제
function ajaxDeleteMenu() {
	if(confirm(JS_MESSAGE["delete.confirm"])) {
		var info = $("#treeWriteForm").serialize();
		$.ajax({
			url: "/config/ajax-delete-menu.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					menuTree.setTree(msg.menuTree);
					alert(JS_MESSAGE["delete"]);
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

// 메뉴 위로/아래로 수정
function ajaxUpdateMoveMenu() {
	if(confirm(JS_MESSAGE["move.confirm"])) {
		var info = $("#treeWriteForm").serialize();
		$.ajax({
			url: "/config/ajax-update-move-menu.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					menuTree.setTree(msg.menuTree);
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