<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/content/config/head.jsp" %>
<html>
<head>
    <title>查找会员</title>
    <style>
        .seeMember_div {
            width: 90%;
            margin: 20px auto;
        }

        .layui-border-box {
            width: auto !important;
            height: auto !important;
        }

        .layui-table {
            width: 100%;
        }

        .layui-table-body{
            height: auto !important;
        }
    </style>
</head>
<body>
<blockquote class="layui-elem-quote layui-text">
    <span class="addFont">查找会员</span>
</blockquote>
<div class="seeMember_div"></div>
<div class="layui-inline">
    <label class="layui-form-label">卡号</label>
    <div class="layui-input-block">
        <input type="tel" id="num" lay-verify="phone" autocomplete="off" class="layui-input">
    </div>
</div>
<div class="layui-inline">
    <label class="layui-form-label">手机号</label>
    <div class="layui-input-block">
        <input type="tel" id="phone" lay-verify="phone" autocomplete="off" class="layui-input">
    </div>
</div>
<div class="layui-inline">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-block">
        <input type="tel" id="mName" lay-verify="phone" autocomplete="off" class="layui-input">
    </div>
</div>
<div class="layui-inline">
    <div class="layui-input-block">
        <button class="layui-btn" id="submit_search" data-type="reload" lay-submit="" lay-filter="demo1">查找</button>
    </div>
</div>
<%--<div class="layui-btn-group demoTable">--%>
    <%--<button class="layui-btn" data-type="getCheckData">获取选中行数据</button>--%>
    <%--<button class="layui-btn" data-type="getCheckLength">获取选中数目</button>--%>
    <%--<button class="layui-btn" data-type="isAll">验证是否全选</button>--%>
<%--</div>--%>
<table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
<script>
    layui.use('table', function () {
        var table = layui.table
        var tableIns = table.render({
            elem: '#LAY_table_user'
            ,loading: true
            ,limit: 10 //默认采用60
            , url: '/admin/sumbitSearch'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 50, sort: true, fixed: true}
                , {field: 'membernumber', title: '会员编号', width: 150}
                , {field: 'sex', title: '性别', width: 80, sort: true}
                , {field: 'membername', title: '会员姓名', width: 100}
                , {field: 'phonenumber', title: '手机号', width: 120}
                , {field: 'registdate', title: '注册日期', sort: true, width: 140}
                , {field: 'birthdate', title: '出生日期', sort: true, width: 140}
                , {field: 'consumptionsum', title: '累计消费', width: 100}
                , {field: 'balance', title: '余额', width: 80}
                , {field: 'remarks', title: '备注', width: 80}
                , {field: 'right', title: '操作', width: 177, toolbar: "#barDemo"}
            ]]
            , id: 'testReload'
            , page: true
            , height: 315
        });


        $('#submit_search').on('click', function () {
            var num = $("#num").val();
            var phone = $("#phone").val();
            var mName = $("#mName").val();
            tableIns.reload({
                where: {
                    num: num
                    , phone: phone
                    , mName: mName
                }
            });
        });
    });
</script>
</body>
</html>
