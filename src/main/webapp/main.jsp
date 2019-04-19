<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理系统</title>
    <link rel="stylesheet" type="text/css" href="themes1.3.5/icon.css"/>
    <link rel="stylesheet" type="text/css" href="themes1.3.5/default/easyui.css"/>
    <script src="js/jquery.min1.3.5.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min1.3.5.js" type="text/javascript"></script>
    <script src="js/easyui-lang-zh_CN1.3.5.js" type="text/javascript"></script>
    <style type="text/css">
        #tabs .tabs-panels > .panel > .panel-body {
            overflow: hidden;
            fit: true
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $(".easyui-linkbutton").click(function () {
                var buttonContent = $(this).html();
                var id = $(this).prop("id");
                var isExist = $("#tabs").tabs("exists", buttonContent);
                if (isExist) {
                    $("#tabs").tabs("select", buttonContent);
                } else {
                    $("#tabs").tabs("add", {
                        title: buttonContent,
                        content: "<iframe src='${pageContext.request.contextPath}/" + id + ".jsp' width='100%' height='100%'></iframe>",
                        selected: true,
                        closable: true,
                    });
                }
            });
        })
    </script>
</head>
<body>
<div id="mainLayout" class="easyui-layout" style="width: 80%;height: 100%;margin: 0 auto">
    <div data-options="region:'north'"
         style="height: 100%;font-size: 50px;text-align: left;font-family: 幼圆;font-weight: bolder;overflow: hidden">
        <div style="background-color: #99cdff;padding: 2.5%">
            图书管理系统
        </div>
    </div>
    <div data-options="region:'west',title:'导航菜单'" style="width: 150%">
        <div class="easyui-accordion" data-options="fit:true">
            <div data-options="title:'图书管理'">
                <span><a id="borrow" href="javascript:void(0)" class="easyui-linkbutton"
                         data-options="plain:true">借阅管理</a></span><br>
                <span><a id="category" href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true">类别管理</a></span><br>
                <span><a id="book" href="javascript:void(0)" class="easyui-linkbutton"
                         data-options="plain:true">书籍管理</a></span>
            </div>
            <div data-options="title:'统计管理'">
                <span><a id="count" href="javascript:void(0)" class="easyui-linkbutton"
                         data-options="plain:true">图书种类</a></span>
            </div>
            <div data-options="title:'系统管理'">
                <span><a id="system" href="javascript:void(0)" class="easyui-linkbutton"
                         data-options="plain:true">系统日志</a></span>
            </div>
        </div>
    </div>
    <div data-options="region:'center'">
        <div id="tabs" class="easyui-tabs" data-options="fit:true">
            <div data-options="title:'首页'">
                <img src="images/main.jpg" width="100%" height="100%">
            </div>
        </div>
    </div>
</div>
</body>
</html>