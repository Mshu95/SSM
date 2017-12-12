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
                , {field: 'registdate', title: '注册日期', sort: true, width: 170}
                , {field: 'balance', title: '余额', width: 80}
                , {field: 'remarks', title: '备注', width: 80}
                , {field: 'right', title: '操作', width: 177, toolbar: "#barDemo"}
            ]]
            , id: 'testReload'
            , page: true
            , height: 315
            ,
            done: function(){

                $(".laytable-cell-1-birthdate").each(function(index,item){
                    if(index>0){
                        $(this).text(formatDate_ssm($(this).text(),"年","月","日"))
                    }
                })
                $(".laytable-cell-1-registdate").each(function(index){
                    if(index>0){
                        $(this).text(formatDate_ssm($(this).text(),"年","月","日",'时'))
                    }
                })
            }
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
                window.location.href="/admin/transaction?id="+data.id
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                layer.alert('编辑行：<br>' + JSON.stringify(data))
            }
        });

        table.on('sort(user)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            $(".laytable-cell-1-birthdate").each(function(index,item){
                if(index>0){
                    $(this).text(formatDate_ssm($(this).text(),"年","月","日"))
                }
            })
            $(".laytable-cell-1-registdate").each(function(index){
                if(index>0){
                    $(this).text(formatDate_ssm($(this).text(),"年","月","日",'时'))
                }
            })

            //尽管我们的 table 自带排序功能，但并没有请求服务端。
            //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
//            table.reload('idTest', {
//                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。 layui 2.1.1 新增参数
//                ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
//                    field: obj.field //排序字段
//                    ,order: obj.type //排序方式
//                }
//            });
        });
    });

    $(function(){
        ;
//        setTimeout(console.log($(".laytable-cell-1-birthdate").text()),5000)

    })
</script>
</body>
</html>
