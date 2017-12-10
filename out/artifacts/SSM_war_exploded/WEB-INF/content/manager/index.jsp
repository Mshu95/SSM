<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/content/config/head.jsp" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <style>
        #iframe_div{
            width: 100%;
            height: 100% !important;
        }
        .layui-body {
            position: static !important;
             left: 0px;
            width: 100%;
            height: auto;
        }

        .layui-layout-admin .layui-body {
            top: 60px;
            bottom: 0px;
        }

        body{
            text-align: center;
        }
        .layui-nav-item  div{
            width: 100px;
            cursor: pointer;
            font-weight: bold;
            color: #777;
            font-family: cursive;
            font-size: 17px;
        }
        iframe{
            width: 100%;
            height: 550px;
        }
        /*#seeMember_li:after {*/
            /*position: absolute;*/
            /*left: 0;*/
            /*top: 0;*/
            /*width: 0;*/
            /*height: 5px;*/
            /*background-color: #5FB878;*/
            /*transition: all .2s;*/
            /*-webkit-transition: all .2s;*/
        /*}*/
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item" id="seeMember_li"><div  id="seeMember">查看会员</div></li>
            <li class="layui-nav-item"><div id="regist">会员注册</div></li>
            <li class="layui-nav-item"><div id="transaction">交易</div></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe  id="iframe_div1" class="lay_iframe"  src="/admin/addMember">
        </iframe>
        <iframe  id="iframe_div2" class="lay_iframe" src="/admin/seeMember">
        </iframe>
        <iframe  id="iframe_div3" class="lay_iframe" src="/admin/toTransaction">
        </iframe>
    </div>
</div>

</div>
<script>
    $(function(){
        $(".lay_iframe").hide();
        $("#iframe_div2").show()

        $("#regist").click(function(){
            $(".lay_iframe").hide();
            $("#iframe_div1").show()
        })
        $("#seeMember").click(function(){
            $(".lay_iframe").hide();
            $("#iframe_div2").show()
        })
        $("#transaction").click(function(){
            $(".lay_iframe").hide();
            $("#iframe_div3").show()
        })
    })
    layui.use('element', function(){
        var element = layui.element;

    });


</script>
</body>
</html>
