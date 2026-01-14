<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.User" %>
<%
    User sidebarUser = (User) session.getAttribute("user");
    String currentPath = request.getServletPath();
    String role = sidebarUser != null && sidebarUser.getRole() != null ? sidebarUser.getRole() : "Student";
%>
<aside class="w-64 bg-gradient-to-b from-slate-900 to-slate-800 text-white shadow-2xl fixed left-0 top-0 h-full z-20">
    <div class="p-6 border-b border-slate-700">
        <h2 class="text-xl font-bold">DMS Portal</h2>
        <p class="text-sm text-slate-400 mt-1"><%= role %> Panel</p>
    </div>

    <nav class="p-4 space-y-2">
        <!-- Dashboard (All users) -->
        <a href="<%= request.getContextPath() %>/dashboard.jsp"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("dashboard") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
            </svg>
            <span class="font-medium">Dashboard</span>
        </a>

        <!-- Students (Admin & Teacher can CRUD, Students can view) -->
        <% if ("Admin".equals(role) || "Teacher".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/students"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("students") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
            </svg>
            <span class="font-medium">Students</span>
        </a>
        <% } else if ("Student".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/students"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("students") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
            </svg>
            <span class="font-medium">View Students</span>
        </a>
        <% } %>

        <!-- Teachers (Admin can CRUD, Everyone can view) -->
        <a href="<%= request.getContextPath() %>/teachers"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("teachers") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
            </svg>
            <span class="font-medium"><%= "Admin".equals(role) ? "Teachers" : "View Teachers" %></span>
        </a>

        <!-- Courses (Admin & Teacher can CRUD, Students can view) -->
        <a href="<%= request.getContextPath() %>/courses"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("courses") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
            </svg>
            <span class="font-medium"><%= "Student".equals(role) ? "View Courses" : "Courses" %></span>
        </a>

        <!-- Results -->
        <% if ("Student".equals(role)) { %>
        <!-- Students can only view their own results -->
        <a href="<%= request.getContextPath() %>/result?action=viewStudentResults"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("result") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
            </svg>
            <span class="font-medium">My Results</span>
        </a>
        <% } else if ("Teacher".equals(role)) { %>
        <!-- Teachers can manage results -->
        <a href="<%= request.getContextPath() %>/result?action=viewAll"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("result") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
            </svg>
            <span class="font-medium">Manage Results</span>
        </a>
        <% } else if ("Admin".equals(role)) { %>
        <!-- Admin can only view results -->
        <a href="<%= request.getContextPath() %>/result?action=viewAll"
           class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 <%= currentPath.contains("result") ? "bg-blue-600 shadow-lg" : "hover:bg-slate-700" %>">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
            </svg>
            <span class="font-medium">View Results</span>
        </a>
        <% } %>
    </nav>

    <!-- Logout Button -->
    <div class="absolute bottom-0 w-64 p-4 border-t border-slate-700">
        <a href="<%= request.getContextPath() %>/users?action=logout"
           class="flex items-center gap-3 px-4 py-3 rounded-lg bg-red-600 hover:bg-red-700 transition-all duration-200">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            <span class="font-medium">Logout</span>
        </a>
    </div>
</aside>