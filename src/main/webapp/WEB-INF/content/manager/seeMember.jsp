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
        <button class="layui-btn" id="submit_search" lay-submit="" lay-filter="demo1">查找</button>
    </div>
</div>
<div style="margin-bottom: 5px;">
    <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px"
         data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>
</div>
<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
</div>
<table class="layui-table" lay-data="{width: 892, height:332, url:'/demo/table/user/', page:true, id:'idTest'}"
       lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{checkbox:true, fixed: true}"></th>
        <th lay-data="{field:'id', width:80, sort: true, fixed: true}">ID</th>
        <th lay-data="{field:'username', width:80}">用户名</th>
        <th lay-data="{field:'sex', width:80, sort: true}">性别</th>
        <th lay-data="{field:'city', width:80}">城市</th>
        <th lay-data="{field:'sign', width:177}">签名</th>
        <th lay-data="{field:'experience', width:80, sort: true}">积分</th>
        <th lay-data="{field:'classify', width:80}">职业</th>
        <th lay-data="{field:'wealth', width:135, sort: true}">财富</th>
        <th lay-data="{field:'score', width:80, sort: true, fixed: 'right'}">评分</th>
        <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
    </thead>
</table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>
<script>
    $(function () {
        $("#submit_search").click(function () {
            var num = $("#num").val();
            var phone = $("#phone").val();
            var mName = $("#mName").val();
            console.log(num + phone + mName)
            $.ajax({
                type: "post",
                data: ({num: num, phone: phone, mName: mName}),
                url: ("sumbitSearch"),
                dataType: "text",
                success: function (d) {
                    layer.msg(d)
                }
            })
        })
        layui.use('table', function () {
            var table = layui.table;
            table.on('checkbox(demo)', function (obj) {
                console.log(obj)
            });
            table.on('tool(demo)', function (obj) {
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
            var $ = layui.$, active = {
                getCheckData: function () {
                    var checkStatus = table.checkStatus('idTest')
                        , data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                }
                , getCheckLength: function () {
                    var checkStatus = table.checkStatus('idTest')
                        , data = checkStatus.data;
                    layer.msg('选中了：' + data.length + ' 个');
                }
                , isAll: function () {
                    var checkStatus = table.checkStatus('idTest');
                    layer.msg(checkStatus.isAll ? '全选' : '未全选')
                }
            };
            $('.demoTable .layui-btn').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        })
    })
</script>
</body>
</html>
