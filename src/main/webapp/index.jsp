<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>员工列表</title>
<%@include file="/WEB-INF/views/common/css.jsp" %>
<style type="text/css">
	.empTable {
	    table-layout: automatic;
	}
	.bootstrap-table td button {
		margin: 0 4px;
	}
	 
	.table2 {
	    table-layout: fixed;
	}
	.table3 {
	    table-layout: automatic;
	}
	.table3 tbody tr td {
		overflow: hidden; 
		text-overflow: ellipsis; 
		white-space: nowrap; 
       }
	.table4 {
	    table-layout: automatic;
	    word-break:break-all; 
	    word-wrap:break-all;
	}
</style>
</head>
<body>
<div class="container">
	<div class="panel-body container">		
		<h1>SSM-CRUD</h1>
		<div id="toolbar" class="btn-group">
		    <button id="btn_add" type="button" class="btn btn-default">
		        <span class="glyphicon glyphicon-plus"></span>新增
		    </button>
		    <button id="btn_delete" type="button" class="btn btn-danger">
		        <span class="glyphicon glyphicon-remove"></span>删除
		    </button>
		</div>
		<table id="empTable" class="table"></table>
	</div>	
</div>
<!-- 新增模态框 -->
<div class="modal fade" id="newEmpModal" tabindex="-1" role="dialog" aria-labelledby="newEmpModalLabel" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" align="left">新增</h4>
			</div>
			<div class="modal-body">
				<form id="newEmpModalForm" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">姓名：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="text" name="empName" class="form-control"
								data-rule="required;remote(${ctx}/checkUser)"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">性别：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="radio" name="gender" value="M"/>
							<label for="gender">男</label>
							<input type="radio" name="gender" value="W"/>
							<label for="gender">女</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">邮箱：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="text" name="email" class="form-control"
								data-rule="required;email;"
								data-rule-email="[/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,'请填入正确的邮箱']"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">部门：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<select class="selectpicker show-tick form-control" name="dId"
								title="请选择" data-rule="required;"></select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer" style="text-align: center;">
				<button type="button" class="btn btn-info btn-save">保存</button>
				<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- 修改模态框 -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" align="left">修改</h4>
			</div>
			<div class="modal-body">
				<form id="editModalForm" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">ID：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="text" name="empId" class="form-control" readonly/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">姓名：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="text" name="empName" class="form-control" readonly/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">性别：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="radio" name="gender" value="M"/>
							<label for="gender">男</label>
							<input type="radio" name="gender" value="W"/>
							<label for="gender">女</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">邮箱：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<input type="text" name="email" class="form-control"
								data-rule="required;email;"
								data-rule-email="[/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,'请填入正确的邮箱']"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 col-md-4 col-lg-4 control-label">部门：</label>
						<div class="col-sm-5 col-md-5 col-lg-5">
							<select class="selectpicker show-tick form-control" name="dId"
								title="请选择" data-rule="required;"></select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer" style="text-align: center;">
				<button type="button" class="btn btn-info btn-save">保存</button>
				<button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
<%@include file="/WEB-INF/views/common/js.jsp" %>
<script  type="text/javascript">
var loadIndex = '';				//加载loading
$(function(){
	initTable();
	initModalSelect();
});

/**
 * 初始化empTable表格
 */
function initTable(){
	$('#empTable').bootstrapTable({
		url: "${ctx}/emp",
		columns: columns,
		method: 'get',
		search: true, //是否显示表格搜索
		classes: 'table-no-bordered',
		toolbar: "#toolbar",
		sortable: true, // 是否启用排序
		sortOrder: "desc", // 排序方式
		pagination: true, // 是否显示分页（*）
		pageNumber: 1, // 初始化加载第一页，默认第一页
		pageSize: 5, // 每页的记录行数（*）
		pageList: [5, 10, 20], // 可供选择的每页的行数（*）  */
		showRefresh: true, // 是否显示刷新按钮 */
		clickToSelect: true,
		sidePagination: 'server',
		queryParamsType: "",
		queryParams: function (params) {
			//自定义参数，这里的参数是传给后台的，我这是是分页用的
			return {//这里的params是table提供的
				pageNum: params.pageNumber,//从数据库第几条记录开始
				pageSize: params.pageSize,//找多少条
				searchText:params.searchText, //查询内容searchText
				sortOrder:params.sortOrder, //排序方式
				sortName:params.sortName, //排序名称
			};
		},			 
		responseHandler:function (result) {
			return{
				total: result.data.total,
				rows: result.data.list
			};
		}
	});
}

/**
 * 初始化editModal和newEmpModal模态框的Select
 */
function initModalSelect(){
	$.ajax({
		url: "${ctx}/getDeptList",
		type: 'get',
		success: function (data) {
			var depts = data.data;
			$("#newEmpModal select[name=dId]").empty();//清空option
			$("#editModal select[name=dId]").empty();//清空option
			$.each(depts,function(i,item){
				$("#newEmpModal select[name=dId]")
					.append("<option value="+item.deptId+">"+item.deptName+"</option>");
				$("#editModal select[name=dId]")
					.append("<option value="+item.deptId+">"+item.deptName+"</option>");
			});
			$("#newEmpModal select[name=dId]").selectpicker('refresh');
			$("#editModal select[name=dId]").selectpicker('refresh');
		}
	});
}

/**
 * 删除员工
 * @ids 员工的id，逗号拼接
 */
function deleteEmps(ids){
	$.ajax({
        url: "${ctx}/emp/" + ids,
        type: 'delete',
        async: true,
        beforeSend: function(){
        	loadIndex = loading();
        },
        complete: function(){
        	layer.close(loadIndex);
        },
        success: function (data) {
        	$('#empTable').bootstrapTable("refresh");
        	if (data.status === 200) {
        		layer.msg(data.msg, {icon: 1});
            } else {
                layer.msg(data.msg, {icon: 2});
            }
        }
    });
}

/**
 * 保存新增员工
 * newEmpModal模态框保存按钮点击事件
 */
$("#newEmpModal button.btn-save").on("click",function(){
	$("#newEmpModalForm").isValid(function(){
		$.ajax({
            url: "${ctx}/emp",
            type: 'post',
            async: true,
            data: $("#newEmpModalForm").serialize(),
               beforeSend: function(){
               	loadIndex = loading();
               },
               complete: function(){
               	layer.close(loadIndex);
               },
            success: function (data) {
            	$('#empTable').bootstrapTable("refresh");
				$("#newEmpModal").modal('hide');
            	if (data.status === 200) {
            		layer.msg(data.msg, {icon: 1});
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            }
        });
	});
});
/**
 * 保存修改员工
 * newEmpModal模态框保存按钮点击事件
 */
$("#editModal button.btn-save").on("click",function(){
	console.log(JSON.stringify($("#editModalForm").serialize()));
	$("#editModalForm").isValid(function(){
		$.ajax({
            url: "${ctx}/emp",
            type: 'put',
            async: true,
            data: $("#editModalForm").serialize(),
            beforeSend: function(){
            	loadIndex = loading();
            },
            complete: function(){
            	layer.close(loadIndex);
            },
            success: function (data) {
				$('#empTable').bootstrapTable("refresh");
				$("#editModal").modal('hide');
            	if (data.status === 200) {
            		layer.msg(data.msg, {icon: 1});
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            }
        });
	});
});

/**
 * 每次关闭newEmpModal模态框重置表单
 * 避免校验插件bug
 */
$("#newEmpModal").on('hidden.bs.modal',function(){
   	document.getElementById("newEmpModalForm").reset();
});

/**
 * 工具栏新增按钮点击事件
 */
$("#btn_add").on("click",function(){
   	$("#newEmpModal input[name=empName]").val("");
   	$("#newEmpModal input[name=email]").val("");
   	$("#newEmpModal select[name=dId]").selectpicker('deselectAll');
   	$("#newEmpModal").modal('show');
});
/**
 * 工具栏删除按钮点击事件
 */
$("#btn_delete").on("click",function(){
	var allSelectedLineData = $("#empTable").bootstrapTable('getSelections');
	var len = allSelectedLineData.length;
	var ids = "";
	if(len == 0) {
        layer.msg('请先选择要删除的员工!', {icon: 2});
        return;
    }
	
	$.each(allSelectedLineData, function (i, item) {
		ids += item.empId;
		if(i<len-1) ids += ",";
    });
	
	layer.confirm("确定要刪除这" + len +  "条记录？", {
		title: ['操作提示'],
		btn: ['确定', '取消'],
		icon: 3
	},function(){
		deleteEmps(ids);
	},function(){return;});
});

/**
 * 加载动画
 * @return loadIndex
 */
function loading(){
	return layer.load(1, {
		shade: [0.1, '#fff'],
		time: 10*1000
	});
}

var columns  =	[{ 
		field : 'a',
		checkbox: true
	}, {
		field : 'empId',
		title :'ID',
		sortable: true,
		align : 'center'
  },{
		field : 'empName',
		title :'姓名',
		sortable: false,
		align : 'center'
	},{
		field : 'gender',
		title :'性别',
		sortable: true,
		align : 'center',
		formatter: function (data,row,index) {
			switch(data){
				case "M": return "男"; break;
				case "W": return "女"; break;
				default: return "-";
			}
		}
	},{
		field : 'email',
		title :'邮箱',
		sortable: true,
		align : 'center'
	},{
		field : 'department.deptName',
		title :'部门',
		sortable: false,
		align : 'center'
	},{
		title :'操作',
		align : 'center',
		formatter : function(){
			return [
				'<button type="button" class="btn btn-default btn_edit">',
				'<span class="glyphicon glyphicon-pencil"></span>修改',
				'</button>',
				'<button type="button" class="btn btn-danger btn_delete">',
				'<span class="glyphicon glyphicon-remove"></span>删除',
				'</button>'
			].join("");
		},
		events: {
			'click .btn_edit': function (e, val, row) {
				$("#editModal input[name=empId]").val(row.empId);
				$("#editModal input[name=empName]").val(row.empName);
				$("#editModal input[name=gender][value="+row.gender+"]").prop("checked",true);
				$("#editModal input[name=email]").val(row.email);
				$("#editModal select[name=dId]").selectpicker('val',row.dId);
				$("#editModal").modal('show');
			},
			'click .btn_delete': function (e, val, row) {
				layer.confirm("确定要刪除？", {
					title: ['操作提示'],
					btn: ['确定', '取消'],
					icon: 3
				},function(){
					deleteEmps(row.empId);
				},function(){return;});
			}
		}
	}];
</script>
</html>