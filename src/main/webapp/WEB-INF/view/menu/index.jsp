<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>cms - 菜单管理</title>
    <link rel="icon" href="favicon.ico" type="image/ico">
    <meta name="keywords" content="cms,后台模板,后台管理系统,HTML模板">
    <meta name="description" content="cms是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
    <meta name="author" content="yinqi">
    <link href="${pageContext.request.contextPath}/asset/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/asset/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/asset/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/asset/css/style.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/asset/js/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid p-t-15">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <div id="toolbar2" class="toolbar-btn-action">
                        <button type="button" class="btn btn-sm btn-info m-r-5" onclick="to_add()">新增</button>
                        <button type="button" class="btn btn-sm btn-success m-r-5" onclick="to_update()">修改</button>
                        <button type="button" class="btn btn-sm btn-cyan m-r-5" onclick="change_tree()">展开折叠</button>
                    </div>
                    <table class="tree-table"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/bootstrap-table/bootstrap-table.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
<!--行内编辑插件-->
<link href="${pageContext.request.contextPath}/asset/js/x-editable/1.5.1/bootstrap3-editable/css/bootstrap-editable.min.css"
      rel="stylesheet">
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/x-editable/1.5.1/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/bootstrap-table/extensions/editable/bootstrap-table-editable.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/asset/js/main.min.js"></script>
<!--以下是tree-grid的使用示例-->
<link href="${pageContext.request.contextPath}/asset/js/jquery-treegrid/jquery.treegrid.min.css" rel="stylesheet">
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/jquery-treegrid/jquery.treegrid.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/asset/js/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.min.js"></script>
<script type="text/javascript">
    var data;
    $.ajax({
        async: false,
        type: "POST",
        url: "/system/menu/list",
        dataType: "json",
        success: function (result) {
            data = result
        },
        error: function () {
        }
    });
    var $treeTable = $('.tree-table');
    $treeTable.bootstrapTable({
        data: data,
        idField: 'menuId',
        uniqueId: 'menuId',
        dataType: 'jsonp',
        toolbar: '#toolbar2',
        columns: [
            {
                field: 'check',
                checkbox: true
            },
            {
                field: 'menuName',
                title: '名称'
            },
            {
                field: 'orderNum',
                title: '排序'
            },
            {
                field: 'path',
                title: '请求地址'
            },
            {
                field: 'menuType',
                title: '类型',
                formatter: menuTypeFormatter
            },
            {
                field: 'visible',
                title: '可见',
                formatter: visibleFormatter
            },
            {
                field: 'perms',
                title: '权限值'
            },
            {
                field: 'operate',
                title: '操作',
                align: 'center',
                events: {
                    'click .role-add': function (e, value, row, index) {
                        add(row.id);
                    },
                    'click .role-delete': function (e, value, row, index) {
                        del(row.id);
                    },
                    'click .role-edit': function (e, value, row, index) {
                        update(row.id);
                    }
                },
                formatter: operateFormatter
            }
        ],
        treeShowField: 'menuName',
        parentIdField: 'parentId'
    });

    $treeTable.treegrid({
        initialState: 'collapseAll', // 所有节点都折叠
        treeColumn: 1
    });

    function to_add() {

    }

    function to_update() {

    }

    var flag = true;

    function change_tree() {
        if (flag) {
            $treeTable.treegrid('expandAll');
            flag = !flag;
        } else {
            $treeTable.treegrid('collapseAll');
            flag = !flag;
        }
    }

    function menuTypeFormatter(value, row, index) {
        switch (value) {
            case 'M':
                return "目录";
            case 'C':
                return "菜单";
            case 'F':
                return "按钮";
            default:
                return ""
        }
    }

    function visibleFormatter(value, row, index) {
        switch (value) {
            case '0':
                return "显示";
            case '1':
                return "隐藏";
            default:
                return ""
        }
    }

    function operateFormatter(value, row, index) {
        return [
            '<a type="button" class="role-edit btn btn-xs btn-success m-r-5" title="编辑" data-toggle="tooltip"><i class="mdi mdi-pencil">编辑</i></a>',
            '<a type="button" class="role-add btn btn-xs btn-info m-r-5" title="新增" data-toggle="tooltip"><i class="mdi mdi-plus">新增</i></a>',
            '<a type="button" class="role-delete btn btn-xs btn-danger" title="删除" data-toggle="tooltip"><i class="mdi mdi-delete">删除</i></a>'
        ].join('');
    }

    function selectChilds(datas, row, id, pid, checked) {
        for (var i in datas) {
            if (datas[i][pid] == row[id]) {
                datas[i].check = checked;
                selectChilds(datas, datas[i], id, pid, checked);
            }
        }
    }

    function selectParentChecked(datas, row, id, pid) {
        for (var i in datas) {
            if (datas[i][id] == row[pid]) {
                datas[i].check = true;
                selectParentChecked(datas, datas[i], id, pid);
            }
        }
    }

    function add(id) {
        alert("add 方法 , id = " + id);
    }

    function del(id) {
        alert("del 方法 , id = " + id);
    }

    function update(id) {
        alert("update 方法 , id = " + id);
    }

</script>
</body>
</html>