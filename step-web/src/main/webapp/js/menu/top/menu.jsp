<%@page import="com.tyndalehouse.step.core.models.Language" trimDirectiveWhitespaces="true" %>
<%@page import="java.util.List" %>
<%@page import="com.tyndalehouse.step.core.service.LanguageService" %>
<%@page import="com.google.inject.Injector" %>
<%@page import="com.tyndalehouse.step.core.models.ClientSession" %>
<%@page import="java.util.Locale" %>
<%@page import="javax.servlet.jsp.jstl.core.Config" %>
<%@ page import="com.tyndalehouse.step.core.service.AppManagerService" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    Injector injector = (Injector) pageContext.getServletContext().getAttribute(Injector.class.getName());
    AppManagerService appManager = injector.getInstance(AppManagerService.class);
    Locale locale = injector.getInstance(ClientSession.class).getLocale();
    Config.set(session, Config.FMT_LOCALE, locale.getLanguage());
%>
<fmt:setBundle basename="HtmlBundle"/>
<div class="headerButtons pull-right">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <%--<button  class="btn btn-default btn-sm showBooks" type="button" title="<fmt:message key="see_books" />">--%>
        <%--<span class="glyphicon glyphicon-book"></span></button>--%>
    <button  class="btn btn-default btn-sm showStats" type="button" title="<fmt:message key="passage_open_sidebar" />">
        <span class="glyphicon glyphicon-save"></span></button>
</div>