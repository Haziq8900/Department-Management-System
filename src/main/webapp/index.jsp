<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to login page if no session exists
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }
%>