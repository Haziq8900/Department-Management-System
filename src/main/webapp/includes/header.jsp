<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.User" %>
<%
    User headerUser = (User) session.getAttribute("user");
    if (headerUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<header class="bg-white shadow-sm border-b border-slate-200 fixed top-0 left-64 right-0 z-10">
    <div class="px-6 py-4 flex items-center justify-between">
        <div class="flex items-center gap-4">
            <h1 class="text-2xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
                Department Management System
            </h1>
        </div>
        <div class="flex items-center gap-3">
            <div class="text-right">
                <p class="text-sm font-medium text-slate-700"><%= headerUser.getUsername() %></p>
                <p class="text-xs text-slate-500"><%= headerUser.getRole() != null ? headerUser.getRole() : "User" %></p>
            </div>
            <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-semibold">
                <%= headerUser.getUsername().substring(0, 1).toUpperCase() %>
            </div>
        </div>
    </div>
</header>
<div class="h-16"></div>