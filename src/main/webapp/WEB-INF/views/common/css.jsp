<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("ctx", request.getContextPath());
%>
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/bootstrap-select-1.7.2.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/jquery-ui.min.css"/>

<link rel="stylesheet" type="text/css" href="${ctx}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/nice-validator-1.1.4/jquery.validator.css">

<!-- bootstrap-table -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/bootstrap-table-develop/bootstrap-table.css">

<!-- jedate -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/jedate-6.5.0/jedate.css"/>

<!-- ztree -->
<link rel="stylesheet" type="text/css" href="${ctx}/static/ztree/zTreeStyle.css">