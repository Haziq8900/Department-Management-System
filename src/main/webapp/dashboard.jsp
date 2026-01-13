<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.User" %>
<%@ page import="com.departmentmanagementsystem.dao.StudentDao" %>
<%@ page import="com.departmentmanagementsystem.dao.TeacherDao" %>
<%@ page import="com.departmentmanagementsystem.dao.CourseDao" %>
<%@ page import="com.departmentmanagementsystem.dao.ResultDao" %>
<%@ page import="java.sql.SQLException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required");
        return;
    }

    // Fetch counts from database
    int totalStudents = 0;
    int totalTeachers = 0;
    int totalCourses = 0;
    int totalResults = 0;

    try {
        StudentDao studentDao = new StudentDao();
        TeacherDao teacherDao = new TeacherDao();
        CourseDao courseDao = new CourseDao();
        ResultDao resultDao = new ResultDao();

        totalStudents = studentDao.findAll().size();
        totalTeachers = teacherDao.findAll().size();
        totalCourses = courseDao.findAll().size();
        totalResults = resultDao.getAllResults().size();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        .slide-in { animation: slideIn 0.4s ease-out; }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="space-y-6 slide-in">
            <!-- Welcome Section -->
            <div class="bg-gradient-to-r from-blue-600 to-purple-600 rounded-xl shadow-lg p-8 text-white">
                <h1 class="text-4xl font-bold mb-2">Welcome, <%= user.getUsername() %>!</h1>
                <p class="text-blue-100 text-lg">Here's what's happening in your department today</p>
            </div>

            <!-- Success/Error Messages -->
            <%
                String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) {
            %>
            <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded">
                <p class="text-green-700">
                    <%= message.replace("_", " ").toUpperCase() %> successfully!
                </p>
            </div>
            <% } %>
            <% if (error != null) { %>
            <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded">
                <p class="text-red-700">
                    Error: <%= error.replace("_", " ") %>
                </p>
            </div>
            <% } %>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <!-- Students Card -->
                <div class="bg-white rounded-xl shadow-lg p-6 transform hover:scale-105 transition-all duration-200 hover:shadow-xl">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Total Students</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= totalStudents %></h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Teachers Card -->
                <div class="bg-white rounded-xl shadow-lg p-6 transform hover:scale-105 transition-all duration-200 hover:shadow-xl">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Total Teachers</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= totalTeachers %></h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Courses Card -->
                <div class="bg-white rounded-xl shadow-lg p-6 transform hover:scale-105 transition-all duration-200 hover:shadow-xl">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Total Courses</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= totalCourses %></h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Results Card -->
                <div class="bg-white rounded-xl shadow-lg p-6 transform hover:scale-105 transition-all duration-200 hover:shadow-xl">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Results Published</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= totalResults %></h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-orange-500 to-orange-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activities & Quick Actions -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Recent Activities -->
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-xl font-bold text-slate-800 mb-4">Recent Activities</h3>
                    <div class="space-y-3">
                        <div class="flex items-center gap-3 p-3 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors">
                            <div class="w-2 h-2 bg-blue-500 rounded-full"></div>
                            <div class="flex-1">
                                <p class="text-sm font-medium text-slate-700">System active</p>
                                <p class="text-xs text-slate-500">Connected to database</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-3 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors">
                            <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                            <div class="flex-1">
                                <p class="text-sm font-medium text-slate-700">Dashboard loaded</p>
                                <p class="text-xs text-slate-500">All modules operational</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 p-3 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors">
                            <div class="w-2 h-2 bg-purple-500 rounded-full"></div>
                            <div class="flex-1">
                                <p class="text-sm font-medium text-slate-700">User session active</p>
                                <p class="text-xs text-slate-500">Logged in as <%= user.getRole() %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <h3 class="text-xl font-bold text-slate-800 mb-4">Quick Actions</h3>
                    <div class="grid grid-cols-2 gap-3">
                        <% if ("Admin".equals(user.getRole()) || "Teacher".equals(user.getRole())) { %>
                        <a href="<%= request.getContextPath() %>/students?action=new" class="p-4 bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-1 transition-all duration-200 text-center">
                            <svg class="w-6 h-6 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                            </svg>
                            <span class="text-sm font-medium">Add Student</span>
                        </a>
                        <% } %>

                        <% if ("Admin".equals(user.getRole())) { %>
                        <a href="<%= request.getContextPath() %>/teachers?action=new" class="p-4 bg-gradient-to-br from-purple-500 to-purple-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-1 transition-all duration-200 text-center">
                            <svg class="w-6 h-6 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                            </svg>
                            <span class="text-sm font-medium">Add Teacher</span>
                        </a>
                        <% } %>

                        <% if ("Admin".equals(user.getRole()) || "Teacher".equals(user.getRole())) { %>
                        <a href="<%= request.getContextPath() %>/courses?action=new" class="p-4 bg-gradient-to-br from-green-500 to-green-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-1 transition-all duration-200 text-center">
                            <svg class="w-6 h-6 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                            </svg>
                            <span class="text-sm font-medium">Add Course</span>
                        </a>
                        <% } %>

                        <a href="<%= request.getContextPath() %>/students" class="p-4 bg-gradient-to-br from-orange-500 to-orange-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-1 transition-all duration-200 text-center">
                            <svg class="w-6 h-6 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                            <span class="text-sm font-medium">View All</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>