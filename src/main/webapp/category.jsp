<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理系统</title>
    <link rel="stylesheet" type="text/css" href="themes1.3.5/icon.css"/>
    <link rel="stylesheet" type="text/css" href="themes1.3.5/default/easyui.css"/>
    <script src="js/jquery.min1.3.5.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min1.3.5.js" type="text/javascript"></script>
    <script src="js/easyui-lang-zh_CN1.3.5.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#categoryDataGrid").datagrid({
                title: "类别表",
                url: "${pageContext.request.contextPath}/category/queryAll",
                pagination: true,
                width: 485,
                height: 445,
                //fit:true,
                toolbar: "#categoryToolbar",
                rownumbers: true,
                checkOnSelect: false,
                //scrollbarSize :0,
                onClickRow: function (rowIndex, rowData) {
                    $(this).datagrid('unselectRow', rowIndex);
                },
                onLoadSuccess: function (data) {
                    if (data.total == 0) {
                        var body = $(this).data().datagrid.dc.body2;
                        body.find("table tbody").append("<tr><td width='" + body.width() + "' style='height: 35px; text-align: center;'><h1>抱歉,暂无数据</h1></td></tr>");
                    } /*else {
                        var body = $(this).data().datagrid.dc.body2;
                        //var rows = $(this).datagrid("getRows");
                        body.find("table tbody tr:eq(0)").append("<td width='" + body.width() + "' style='height: 250px;font-size: 15px;color: green;vertical-align: text-top' rowspan='10'>" +
                            "提示:<br>&nbsp;&nbsp;父类别:<br>&nbsp;&nbsp;&nbsp;&nbsp;1.不允许修改它的父类别<br>&nbsp;&nbsp;&nbsp;&nbsp;2.如果有新的需求请添加<br>&nbsp;&nbsp;子类别:<br>&nbsp;&nbsp;&nbsp;&nbsp;1.修改子类别的信息，下面的图书所属类别也会改变" +
                            "</td>");
                    }*/
                },
                columns: [[
                    {field: "categoryName", title: "类别名称", width: 100},
                    {
                        field: "parentCategoryName", title: "父类别", width: 100, formatter: function (value, row, index) {
                            var parentCategoryName = row.parentCategory.categoryName;
                            return parentCategoryName;
                        }
                    },
                    {field: "bookCount", title: "该类别下的图书数量", width: 150},
                    {
                        field: "operate", title: "操作", width: 100, formatter: function (value, row, index) {
                            return "<a href='javascript:void(0)' onclick='update(" + row.categoryId + ")'>修改</a>&nbsp;&nbsp;&nbsp;" +
                                "<a href='javascript:void(0)' name='deleteOneCategory' x1='" + row.categoryId + "' x2='" + index + "'>删除</a>"
                        }
                    },
                ]]
            });
            $("#categoryTreePanel").panel({
                title: "类别展示",
                width: 338,
                height: 445,
                //scrollbarSize :0,
                //fit:true,
            });
            $("#categoryTree").tree({
                url: "${pageContext.request.contextPath}/category/queryAllTreeNode",
            });
            $("#addCategoryDialog").dialog({
                title: "添加类别",
                width: 300,
                height: 200,
                buttons: "#addCategoryButton",
                closed: true,
                modal: true
            });
            $("#categoryName").validatebox({
                required: true,
                missingMessage: "类别名称不能为空"
            });
            $("#addCategory").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/categoryCombobox/queryAllParentCategories",
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.flag == 1) {
                            var options = $("#parentCategoryId").combobox("options");
                            options.textField = "text";
                            options.valueField = "id";
                            $("#parentCategoryId").combobox("loadData", data.categoryComboboxList);
                            $("#parentCategoryId").combobox('setValue', data.categoryComboboxList[0].id);
                            $("#categoryName").val("");
                            $("#addCategoryDialog").dialog();
                            $("#addCategoryDialog").dialog("open");
                        }
                    }
                });
            });
            $("#addCategoryOk").click(function () {
                $("#addCategoryForm").form("submit", {
                    url: "${pageContext.request.contextPath}/category/addCategory",
                    onSubmit: function () {
                        return $("#addCategoryForm").form("validate")
                    },
                    success: function (data) {
                        data = JSON.parse(data);
                        if (data.flag == 1) {
                            $("#addCategoryDialog").dialog("close");
                            $.messager.alert("提示框", "添加成功！", "info", function () {
                                $("#categoryDataGrid").datagrid("reload");
                                $("#categoryTree").tree("reload");
                            });
                        } else {
                            $.messager.alert("提示框", "添加失败！", "error");
                        }
                    }
                })
            });
            /*$("#categoryDataGrid").on("click","[name=deleteOneCategory]",function () {
                var categoryId = $(this).attr("x1");
                var index = $(this).attr("x2");
                $("#categoryDataGrid").datagrid("deleteRow",index);
                $.ajax({
                    url:"/category/deleteOneCategory",
                    type:"post",
                    data:"categoryId="+categoryId,
                    dataType:"json",
                    success:function (data) {

                    }
                });
            });*/
            $("#updateCategoryDialog").dialog({
                title: "修改类别",
                width: 300,
                height: 200,
                buttons: "#updateCategoryButton",
                closed: true,
                modal: true
            });
            $("#categoryNameUpdate").validatebox({
                required: true,
                missingMessage: "类别名称不能为空",
                novalidate: true
            });
            update = function (categoryId) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/category/queryOne",
                    type: "post",
                    data: "categoryId=" + categoryId,
                    dataType: "json",
                    success: function (data) {
                        if (data.flag == 1) {
                            var options = $("#parentCategoryIdUpdate").combobox("options");
                            options.textField = "text";
                            options.valueField = "id";
                            $("#parentCategoryIdUpdate").combobox("loadData", data.categoryComboboxList);
                            $("#parentCategoryIdUpdate").combobox('setValue', data.category.parentCategory.categoryId);
                            if (data.category.parentCategory.categoryId == 0) {
                                $("#parentCategoryIdUpdate").combobox("readonly", true);
                            } else {
                                $("#parentCategoryIdUpdate").combobox("readonly", false);
                            }
                            $("#categoryIdUpdate").val(data.category.categoryId);
                            $("#categoryNameUpdate").val(data.category.categoryName);
                            $("#categoryNameUpdate").validatebox("enableValidation");
                            $("#updateCategoryDialog").dialog("open");
                        }
                    }
                });
            };
            $("#updateCategoryOk").click(function () {
                $.messager.confirm("提示框", "您确认想要修改记录吗？", function (r) {
                    if (r) {
                        $("#updateCategoryForm").form("submit", {
                            url: "${pageContext.request.contextPath}/category/updateCategory",
                            onSubmit: function () {
                                return $("#updateCategoryForm").form("validate");
                            },
                            success: function (data) {
                                data = JSON.parse(data);
                                if (data.flag == 1) {
                                    $("#updateCategoryDialog").dialog("close");
                                    $.messager.alert("提示框", "修改成功！", "info", function () {
                                        $("#categoryDataGrid").datagrid("reload");
                                    });
                                } else {
                                    $.messager.alert("提示框", "修改失败", "error");
                                }
                            }
                        });
                    }
                });
            });
            $("#searchCategory").click(function () {
                var queryCategoryName = $("#queryCategoryName").val();
                var categoryType = $("[name=categoryType]:checked").val();
                $("#categoryDataGrid").datagrid("load", {
                    queryCategoryName: queryCategoryName,
                    categoryType: categoryType,
                });
            });
            $("#reset").click(function () {
                $("#queryCategoryName").val("");
                $("[name=categoryType]:checked").prop("checked", false);
            });
        })
    </script>
</head>
<body>
<div id="categoryToolbar">
    <div style="text-align: center;padding-top: 0.5%">
        类别名:<input id="queryCategoryName" type="text" style="border-radius: 9px;outline: none;">父类别:<input type="radio"
                                                                                                           name="categoryType"
                                                                                                           value="0">子类别:<input
            type="radio" name="categoryType" value="1"><br>
        <a id="searchCategory" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        <a id="reset" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
    </div>
    <a id="addCategory" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add',plain:true">添加</a>
    <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">批量删除</a>--%>
</div>
<div>
    <div style="float: left">
        <table id="categoryDataGrid">
        </table>
    </div>
    <div style="float: right">
        <div id="categoryTreePanel" style="padding: 20px;">
            <ul id="categoryTree">
            </ul>
        </div>
    </div>
</div>
<div id="addCategoryDialog" style="padding: 10%">
    <form id="addCategoryForm" method="post">
        类别名称:<input type="text" id="categoryName" name="categoryName"><br><br>
        父级类别:
        <select id="parentCategoryId" name="parentCategoryId" class="easyui-combobox"
                data-options="editable:false,panelHeight:'auto'" style="width: 100px">
        </select>
    </form>
    <div id="addCategoryButton">
        <a id="addCategoryOk" href="javascript:void(0)" class="easyui-linkbutton"
           data-options="iconCls:'icon-ok'">确认</a>
    </div>
</div>
<div id="updateCategoryDialog" style="padding: 10%">
    <form id="updateCategoryForm" method="post">
        <input type="hidden" id="categoryIdUpdate" name="categoryId">
        类别名称:<input type="text" id="categoryNameUpdate" name="categoryName"><br><br>
        父级类别:
        <select id="parentCategoryIdUpdate" name="parentCategory.categoryId" class="easyui-combobox"
                data-options="editable:false,panelHeight:'auto'" style="width: 100px">
        </select>
    </form>
    <div id="updateCategoryButton">
        <a id="updateCategoryOk" href="javascript:void(0)" class="easyui-linkbutton"
           data-options="iconCls:'icon-ok'">确认</a>
    </div>
</div>
</body>
</html>