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

        .layui-form {
            width: 37%;
            margin: 0px auto;
        }

        .layui-input, .layui-textarea {
            display: block;
            width: 69%;
            padding-left: 10px;
        }

        #motify_m {
            height: 0px !important;
            overflow-y: hidden;
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
<input type="text" name="username" lay-verify="required" autocomplete="off"
       class="layui-input name_m">
<div id="motify_m">
    <div class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">卡号</label>
            <div class="layui-input-block">
                <textarea type="text" name="title" lay-verify="title" autocomplete="off"
                          class="layui-input card_nub"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="username" lay-verify="required" autocomplete="off"
                       class="layui-input name_m">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block">
                <input type="tel" name="phone" lay-verify="phone" autocomplete="off" class="layui-input phone_m">
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
                    <input type="text" name="price_min" placeholder="￥" autocomplete="off" class="layui-input price_m">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-block">
                <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off"
                       class="layui-input date_m">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" name="text" class="layui-textarea remarks_m"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
</div>
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
    });
    //-------------------------------------------------------------
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
            done: function () {
                $(".laytable-cell-1-birthdate").each(function (index, item) {
                    if (index > 0) {
                        $(this).text(formatDate_ssm($(this).text(), "年", "月", "日"))
                    }
                })
                $(".laytable-cell-1-registdate").each(function (index) {
                    if (index > 0) {
                        $(this).text(formatDate_ssm($(this).text(), "年", "月", "日", '时'))
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
                window.location.href = "/admin/transaction?id=" + data.id
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                var d = eval("(" + JSON.stringify(data) + ')')
                var mid = d.id;
                console.log(addVal(d))
                layer.open({
                    type: 1,
                    title: ['修改'],
                    closeBtn: 1,
                    anim: 1,
                    skin: 'layui-layer-demo', //样式类名
                    anim: 2,
                    shadeClose: true, //开启遮罩关闭
                    offset: 'auto',
                    area: ['60%', '100%'],
                    content: addVal(d)
                });
                $('.submit_motify').on('click', function () {
                    var open_pay = $(".open_pay").text();
                    var open_remark = $(".open_remark").text();
                    var open_data_transcation = $(".open_data_transcation").text();
                    currentRecordId;
                    $.ajax({
                        type: 'post',
                        url: '/admin/motifyRcord',
                        data: ({
                            open_pay: open_pay,
                            open_remark: open_remark,
                            open_data_transcation: open_data_transcation,
                            currentRecordId: currentRecordId
                        }),
                        datatType: '',
                        success: (function (d) {
                            layer.msg(d)
                            setTimeout('window.location.reload()', 2000)
                        })
                    })

                });


            }
        });

        table.on('sort(user)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            $(".laytable-cell-1-birthdate").each(function (index, item) {
                if (index > 0) {
                    $(this).text(formatDate_ssm($(this).text(), "年", "月", "日"))
                }
            })
            $(".laytable-cell-1-registdate").each(function (index) {
                if (index > 0) {
                    $(this).text(formatDate_ssm($(this).text(), "年", "月", "日", '时'))
                }
            })
        });
    });

    function addVal(d) {
        var cloneBody = $("#motify_m").clone();
        var html_ = "";
        $(".name_m").val(123)
        cloneBody.find(".card_nub").text(123456)
        cloneBody.find(".name_m").text(d.membername)
        cloneBody.find(".phone_m").val(d.phonenumber)
        cloneBody.find(".name_m").val()
        cloneBody.find(".price_m").val(d.balance)
        cloneBody.find(".date_m").val(d.birthdate)
        cloneBody.find(".remarks_m").val(d.remarks)
        html_ = cloneBody.html();
        return html_;
    }
</script>
</body>
</html>
