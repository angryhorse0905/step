<%@ page import="com.google.inject.Injector" %>
<%@ page import="java.util.Locale" %>
<%@ page import="javax.servlet.jsp.jstl.core.Config" %>
<%@ page import="com.tyndalehouse.step.core.service.AppManagerService" %>
<%@ page import="com.tyndalehouse.step.core.models.ClientSession" %>
<%@ page import="com.tyndalehouse.step.rest.controllers.SearchPageController" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Injector injector = (Injector) pageContext.getServletContext().getAttribute(Injector.class.getName());
    Locale locale = injector.getInstance(ClientSession.class).getLocale();
    Config.set(session, Config.FMT_LOCALE, locale.getLanguage());
    AppManagerService appManager = injector.getInstance(AppManagerService.class);
    request.setAttribute("analyticsToken", Boolean.TRUE.equals(Boolean.getBoolean("step.development")) ? SearchPageController.DEV_TOKEN : SearchPageController.LIVE_TOKEN);
%>
<fmt:setBundle basename="HtmlBundle"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <TITLE>E4.org</TITLE>
    <%@include file="jsps/offlinePage.jsp" %>
    <link href="css/bootstrap.css" rel="stylesheet" media="screen"/>
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" media="screen"/>
    <link rel="stylesheet" type="text/css" href="static/static.css"/>
    <link rel="shortcut icon" href="images/step-favicon.ico"/>
    <script src="international/interactive.js" type="text/javascript"></script>
    <script src="libs/sprintf-0.7-beta1.js" type="text/javascript"></script>
    <script src="js/step_constants.js" type="text/javascript"></script>
    <script src="js/step.util.js" type="text/javascript"></script>

    <style type="text/css">
        .pageContent {
            margin: 20px;
        }

        .navTree {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;
        }

        .navTreeSub {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;
        }

        body {
            margin: 0px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        p {
            margin: 12px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        td {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        .copyright {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
            text-decoration: none;
        }

        .bottomnav {
            color: #999999;
            text-decoration: none;
        }

        a {
            color: #5A75A5;
        }

        .g1 {
            color: #5A75A5;
            text-decoration: none;
        }

        .g2 {
            color: #F7AA10;
            text-decoration: none;
        }

        .g3 {
            color: #ADA608;
            text-decoration: none;
        }

        .contactform {
            font-size: 10px;

        }

        .contactheader {
            font-size: 12px;
            color: #FFFFFF;
            font-weight: bold;
        }

        .quote {
            font-family: "Times New Roman", Times, serif;
            font-size: 12px;
            font-style: italic;
            font-weight: bold;
        }

        .quotetitle {
            font-family: "Times New Roman", Times, serif;
            font-size: 18px;
            font-style: italic;
            font-weight: bold;
        }

        .prod {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #CCCCCC;

        }

        .proddescr {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            text-align: justify;
            color: #444444;

        }

        .prodprice {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #5A75A5;

        }

        .prodtitle {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;

        }

        ul {
            margin-top: 0;
            margin-bottom: 0;
            list-style-position: outside;
        }
        .header {
            border:0px;
        }
    </style>

</HEAD>
<body>
<div>
    <a href="/">
        <div class="header">
            <h1></h1>
        </div>
    </a>
    <div class="pageContent">
        <iframe
                style="border:0; position:fixed; top:50px; left:0; right:0; bottom:0; width:100%; height:100%"
                src="http://www.freebiblesoftware.com/products/comingsoon.asp?newLibraries=2222&IDNode=1">

        </iframe>
    </div>
</div>


</body>
</HTML>
