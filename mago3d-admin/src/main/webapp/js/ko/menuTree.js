/**
 * http://dev.axisj.com
 * Require Files for AXISJ UI Component...
 * Based		: jQuery
 * Javascript 	: AXJ.js, AXTree.js, AXInput.js, AXSelect.js, AXModal.js
 * CSS			: AXJ.css, AXTree.css, AXInput.css, AXSelect.css
*/

var pageID = "MenuTreeControl";
var MENU_TREE = new AXTree();
	
var TREE_OBJECT = {
	pageStart: function() {
		TREE_OBJECT.tree();
		MENU_TREE.collapseAll();
	},
	tree: function(){
		MENU_TREE.setConfig({
			targetID : "AXTreeTarget",
			theme: "AXTree_none",
			//height:"auto",
			xscroll:true,
            emptyListMSG:"<i class='fa fa-spinner'></i> List of Empty",
            iconWidth:18,
            indentRatio:0.75,

			relation:{
				parentKey:"parent",
				childKey:"menuId"
			},
			colGroup: [
				{ key:"name", label:"메뉴명", width:"*", align:"left", indent:true,
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
					
					var obj = MENU_TREE.getSelectedList();
					document.menuForm.reset();
					document.menuForm.writeMode.value = "modify";
					
					$("#menuId").val(item.menuId);
					$("#menuType").val(item.menuType);
					$("#menuTarget").val(item.menuTarget);
					$("#name").val(item.name);
					$("#nameEn").val(item.nameEn);
					$("#ancestor").val(item.ancestor);
					$("#parent").val(item.parent);
					$("#depth").val(item.depth);
					$("#viewOrder").val(item.viewOrder);
					$("#url").val(item.url);
					$("#urlAlias").val(item.urlAlias);
					$("#aliasMenuId").val(item.aliasMenuId);
					$("#htmlId").val(item.htmlId);
					$("#htmlContentId").val(item.htmlContentId);
					$("#image").val(item.image);
					$("#imageAlt").val(item.imageAlt);
					$("#cssClass").val(item.cssClass);
					$("[name=defaultYn]").removeAttr("checked");
					$("[name=defaultYn]").filter("[value='" + item.defaultYn + "']").prop("checked",true);
					$("[name=useYn]").removeAttr("checked");
					$("[name=useYn]").filter("[value='" + item.useYn + "']").prop("checked",true);
					$("[name=displayYn]").removeAttr("checked");
					$("[name=displayYn]").filter("[value='" + item.displayYn + "']").prop("checked",true);
					$("#description").val(item.description);
					$("#updateType").val(item.updateType);
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
						MENU_TREE.moveUpTree();
					}},
					{ userType:0, label:"아래로", className:"down", onclick:function(id) {
						MENU_TREE.moveDownTree();
					}},
					{userType:1, label:"추가", className:"plus", onclick:TREE_OBJECT.addTree},
					{userType:1, label:"하위메뉴추가", className:"plus", onclick:TREE_OBJECT.addChildTree},
					{userType:1, label:"삭제하기", className:"", onclick:TREE_OBJECT.delTree},
					{userType:1, label:"수정하기", className:"", onclick:TREE_OBJECT.updateTree}
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
		MENU_TREE.setTree(MENU_TREE_DATA);
	},
	appendTree: function(){
		var frm = document.menuForm;
		var writeMode = document.menuForm.writeMode.value;
		if(writeMode === null || writeMode === "") {
			alert("메뉴를 선택해 주세요.");
			return;
		}
		if(writeMode == "child") {
			// 자식 객체 추가
//			var obj = myTree.getSelectedList();
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:obj.item.menuId}]);
			insertMenu();
		} else if(writeMode == "append") {
			// 형제 객체 추가
			var obj = MENU_TREE.getSelectedListParent(); // 선택 아이템의 부모 아이템 가져오기
			var pno = 0;
			if(obj.item){
				pno = obj.item.menuId;
			}			
			//document.treeWriteForm.depth.value = parseInt(obj.item.depth) + parseInt(1);
//			myTree.appendTree(obj.index, obj.item, [{menuId:"N", menuName:frm.menuName.value, writer:'mondo', type:"file", parentMenuId:pno}]);
			insertMenu();
		}else if(writeMode == "modify") {
			var obj = MENU_TREE.getSelectedList();
			if(obj.error){
				alert("메뉴를 선택해 주세요.");
				return;
			}
			if(obj.item.menuId == "0") {
				alert("수정할 수 없는 메뉴 입니다.")
				return;
			}
			//console.log($("#depth").val() + ", " + $(":radio[name='use_yn']:checked").val());
			if( $("#depth").val() == "1" && $(':radio[name="useYn"]:checked').val() == "N" ) {
				if(confirm("미사용으로 선택하실 경우 하위 메뉴를 전부 사용할수 없습니다. \n 계속 진행하시겠습니까?")) {
					updateMenu();
				}
			} else {
				updateMenu();
			}
		}
		
		return false;
	},
	addTree: function() {
		var obj = MENU_TREE.getSelectedList();
		if(obj.item == null || obj.item == "" || obj.item == undefined || obj.item == "undefined" || obj.item.menuId == "0") {
			alert("하위 메뉴를 추가하여 주십시오.");
			return;
		}
		
		document.menuForm.reset();
		document.menuForm.writeMode.value = "append";
		console.log("--------------- add = " + obj.item.ancestor);
		$("#menuTarget").val(obj.item.menuTarget);
		
		document.menuForm.ancestor.value = obj.item.ancestor;
		document.menuForm.parent.value = obj.item.parent;
		document.menuForm.depth.value = obj.item.depth;
//		document.menuForm.viewOrder.value = obj.item.viewOrder;
		$("[name=defaultYn]").removeAttr("checked");
		$("[name=defaultYn]").filter("[value='N']").prop("checked",true);
		$("[name=useYn]").removeAttr("checked");
		$("[name=useYn]").filter("[value='Y']").prop("checked",true);
		$("[name=displayYn]").removeAttr("checked");
		$("[name=displayYn]").filter("[value='Y']").prop("checked",true);
		
		document.menuForm.name.focus();
	},
	addChildTree: function(){
		var obj = MENU_TREE.getSelectedList();
		if(obj.error){
			alert("상위메뉴를 선택해 주세요.");
			return;
		}
		if(obj.item.useYn == "N") {
			alert("상위 메뉴가 미사용이므로 하위 메뉴를 생성할 수 없습니다.");
			return;
		}
		
		document.menuForm.reset();
		document.menuForm.writeMode.value = "child";
		console.log("--------------- add child = " + obj.item.ancestor);
		$("#menuTarget").val(obj.item.menuTarget);
		
		document.menuForm.ancestor.value = obj.item.ancestor;
		document.menuForm.parent.value = obj.item.menuId;		
		document.menuForm.depth.value = parseInt(obj.item.depth) + parseInt(1);		
		$("[name=defaultYn]").removeAttr("checked");
		$("[name=defaultYn]").filter("[value='N']").prop("checked",true);
		$("[name=useYn]").removeAttr("checked");
		$("[name=useYn]").filter("[value='Y']").prop("checked",true);
		$("[name=displayYn]").removeAttr("checked");
		$("[name=displayYn]").filter("[value='Y']").prop("checked",true);
		document.menuForm.name.focus();
	},
	delTree: function(){
		var obj = MENU_TREE.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요.");
			return;
		}
		if(obj.item.menuId == "0" || obj.item.defaultYn == "Y") {
			alert("삭제할 수 없는 메뉴 입니다.")
			return;
		}
		
		$("#menuId").val(obj.item.menuId);		
		deleteMenu();
		//myTree.removeTree(obj.index, obj.item);
		MENU_TREE.collapseAll();
		document.menuForm.reset();
	},
	updateTree: function(){
		var obj = MENU_TREE.getSelectedList();
		//console.log("group : " + obj.item.user_group_id);
		$("#menuId").val(obj.item.menuId);
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menuId == "0") {
			alert("수정할 수 없는 메뉴 입니다.")
			return;
		}
		document.menuForm.reset();
		document.menuForm.writeMode.value = "modify";
		$("#menuId").val(obj.item.menuId);
		$("#menuType").val(obj.item.menuType);
		$("#menuTarget").val(obj.item.menuTarget);
		$("#name").val(obj.item.name);
		$("#nameEn").val(obj.item.nameEn);
		$("#ancestor").val(obj.item.ancestor);
		$("#parent").val(obj.item.parent);
		$("#depth").val(obj.item.depth);
		$("#url").val(obj.item.url);
		$("#urlAlias").val(obj.item.urlAlias);
		$("#aliasMenuId").val(obj.item.aliasMenuId);
		$("#htmlId").val(obj.item.htmlId);
		$("#htmlContentId").val(obj.item.htmlContentId);
		$("#image").val(obj.item.image);
		$("#imageAlt").val(obj.item.imageAlt);
		$("#cssClass").val(obj.item.cssClass);
		$("[name=defaultYn]").removeAttr("checked");
		$("[name=defaultYn]").filter("[value='" + obj.item.defaultYn + "']").prop("checked",true);
		$("[name=useYn]").removeAttr("checked");
		$("[name=useYn]").filter("[value='" + obj.item.useYn + "']").prop("checked",true);
		$("[name=displayYn]").removeAttr("checked");
		$("[name=displayYn]").filter("[value='" + obj.item.displayYn + "']").prop("checked",true);
		document.menuForm.name.focus();
	},
	updateMoveUpTree: function() {
		var obj = MENU_TREE.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요.");
			return;
		}
		if(obj.item.menuId == "0" || obj.item.menuId == "1000") {
			alert("이동할 수 없는 메뉴입니다.")
			return;
		}
		if(obj.item.viewOrder == "1") {
			alert("제일 처음 입니다.")
			return;
		}
		$("#menuId").val(obj.item.menuId);
		$("#nameEn").val(obj.item.nameEn);
		$("#viewOrder").val(obj.item.viewOrder);
		$("#parent").val(obj.item.parent);
		$("#updateType").val("up");
		updateMoveMenu();
	},
	updateMoveDownTree: function() {
		var obj = MENU_TREE.getSelectedList();
		if(obj.error){
			alert("메뉴를 선택해 주세요");
			return;
		}
		if(obj.item.menuId == "0" || obj.item.menuId == "1000") {
			alert("이동할 수 없는 메뉴입니다.")
			return;
		}
		$("#menuId").val(obj.item.menuId);
		$("#nameEn").val(obj.item.nameEn);
		$("#viewOrder").val(obj.item.viewOrder);
		$("#parent").val(obj.item.parent);
		$("#updateType").val("down");
		updateMoveMenu();
	},
	moveTree: function(){
		MENU_TREE.moveTree({
			startMove: function(){
				MENU_TREE.addClassItem({
					className:"disable", 
					addClass:function(){
						return (this.menuId == "N");
					}
				});
			},
			validate:function(){
				if(this.targetObj.menuId == "N"){
					alert("이동할 수 없는 대상을 선택하셨습니다.");
					return false;
				}else{
					return true;	
				}
			},
			endMove: function(){
				MENU_TREE.removeClassItem({
					className:"disable", 
					removeClass:function(){
						return (this.menuId == "N");
					}
				});
			}
		});
	}		
};
