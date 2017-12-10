<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/content/config/head.jsp" %>
<html>
<head>
    <title>交易</title>
    <style>
        #from_ {
            padding: 3% 20%;
        }

        .layui-form-switch {
            width: 56px;
        }

        .layui-form-onswitch i {
            left: 36px;
        }

        .layui-form-switch i {
            top: 2px;
        }

    </style>
</head>
<body>
<div class="layui-form layui-form-pane" id="from_">
    <div class="layui-form-item">
        <label class="layui-form-label">交易类型</label>
        <div class="layui-input-block">
            <input type="checkbox" type="" id="tran_type" checked="" name="open" lay-skin="switch"
                   lay-filter="switchTest" lay-text="消费|充值">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">交易金额</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input type="text" id="price_id" name="price" lay-verify="price" placeholder="￥" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" name="remarks" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" id="sub" >立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</>
<script>

    //--------------------------------------------------------------
    layui.use(['form', 'layedit', 'laydate'], function () {
        var state;

        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            price: [/^[0-9]{1,999999}$/, '请输入正确的余额']
        });

        //监听指定开关
        form.on('switch(switchTest)', function (data) {
            state = this.checked ? '消费' : '充值';
            layer.tips('当前交易模式：' + state, data.othis, {tips: [2, '#78BA32']})
        });
        $("#sub").click(function () {
            var open = check_switch();
            var price = $("input[name='price']").val();
            var remarks = $("textarea[name='remarks']").val();
            var mId = '${mId}';
            if(!$("#price_id").hasClass("layui-form-danger")){
                $.ajax({
                    type: "post"
                    , url: "/admin/submitRecord"
                    , data: ({open: open, price: price, remarks: remarks,mId:mId})
                    , dataType: "text",
                    success: function (d) {
                        layer.msg(d)
                        setTimeout('close_()',2000);
                    }
                })
            }
        })
    });

    function check_switch() {
        if ($(".layui-unselect").hasClass("layui-form-onswitch")) {
            return 'consume';
        } else {
            return 'recharge';
        }
    }
    function close_(){
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
        parent.location.reload();
    }
</script>
</body>
</html>
