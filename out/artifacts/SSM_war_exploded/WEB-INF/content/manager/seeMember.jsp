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

        .layui-table-body {
            height: auto !important;
        }

        .layui-table-view {
            position: relative;
            margin: 10px 37px;
            overflow: hidden;
        }
        .layui-table-page {
            height: 26px;
            width: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="seeMember_div">
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
</div>
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
            , loading: true
            , limit: 10 //默认采用60
            , url: '/admin/sumbitSearch'
            , cols: [[
                {field: 'id', title: 'ID', width: 50, sort: true, fixed: true}
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

        //监听工具条
        table.on('tool(user)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('ID：' + data.id + ' 的查看操作');
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.alert('编辑行：<br>' + JSON.stringify(data))
            }
        });
    });
</script>
</body>
</html>
