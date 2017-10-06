<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/content/config/head.jsp" %>

<html>
<head>
    <style>
        .addFont {
            font-family: cursive;
            font-size: 24px;
            color: #009688;
            font-weight: bold;
        }

        .layui-input, .layui-textarea {
            display: block;
            width: 60%;
            padding-left: 10px;
        }

        .layui-form-item layui-form-text {
            width: 80%;
        }

        .layui-form-item {
            text-align: left;
        }

        input[name="phone"] {
            width: 100%;
        }

        input[name="price_min"] {
            width: 100%;
        }
    </style>
</head>
<body>
<blockquote class="layui-elem-quote layui-text">
    <span class="addFont">添加会员</span>
</blockquote>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">卡号</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入卡号"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" placeholder="请输入姓名" autocomplete="off"
                   class="layui-input">
        </div>

    </div>
    <div class="layui-inline">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="tel" name="phone" lay-verify="phone" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="sex" value="男" title="男" checked="">
            <input type="radio" name="sex" value="女" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">首充</label>
            <div class="layui-input-block" style="width: 100px;">
                <input type="text" name="price_min" placeholder="￥" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生日</label>
        <div class="layui-input-block">
            <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" name="text" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });
        var editIndex = layedit.build('LAY_demo_editor');
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });
        form.on('submit(demo1)', function (data) {
            var data = eval("(" + JSON.stringify(data.field) + ")");
            var memberNum = data.title;
            var userName = data.username;
            var phoneNum = data.phone;
            var sex = data.sex;
            var balance = data.price_min;
            var birthday = data.date;
            var remarks = data.text;
            $.ajax({
                type:"post"
               ,url:"submitMember"
               ,data:({
                    memberNum:memberNum,
                    userName:userName,
                    phoneNum:phoneNum,
                    sex:sex,
                    balance:balance,
                    birthday:birthday,
                    remarks:remarks,
                })
               , dataType : "text",
                success:function(d){
                    layer.msg(d)
                }
            })
            return false;
        });
    });
</script>

</body>
</html>
