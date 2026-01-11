<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Teacher" %>
<%
    Teacher teacher = (Teacher) request.getAttribute("teacher");
    boolean isEdit = (teacher != null && teacher.getId() != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Teacher - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="max-w-4xl mx-auto">
            <div class="mb-6">
                <a href="<%= request.getContextPath() %>/teachers"
                   class="inline-flex items-center gap-2 text-slate-600 hover:text-slate-800 transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Back to Teachers
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-purple-600 to-pink-600 p-6 text-white">
                    <h2 class="text-2xl font-bold"><%= isEdit ? "Edit Teacher" : "Add New Teacher" %></h2>
                    <p class="text-purple-100 mt-1">
                        <%= isEdit ? "Update teacher information" : "Fill in the details to add a new teacher" %>
                    </p>
                </div>

                <form action="<%= request.getContextPath() %>/teachers" method="post" class="p-8">
                    <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= teacher.getId() %>">
                    <% } %>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Full Name <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="name"
                                    value="<%= teacher != null && teacher.getName() != null ? teacher.getName() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                                    placeholder="Enter teacher's full name"
                                    required
                            >
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Email Address <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="email"
                                    name="email"
                                    value="<%= teacher != null && teacher.getEmail() != null ? teacher.getEmail() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                                    placeholder="teacher@example.com"
                                    required
                            >
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Phone Number
                            </label>
                            <input
                                    type="tel"
                                    name="phone"
                                    value="<%= teacher != null && teacher.getPhone() != null ? teacher.getPhone() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                                    placeholder="+92 300 1234567"
                            >
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Department <span class="text-red-500">*</span>
                            </label>
                            <select
                                    name="department"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                                    required
                            >
                                <option value="">Select Department</option>
                                <option value="Computer Science" <%= teacher != null && "Computer Science".equals(teacher.getDepartment()) ? "selected" : "" %>>Computer Science</option>
                                <option value="Mathematics" <%= teacher != null && "Mathematics".equals(teacher.getDepartment()) ? "selected" : "" %>>Mathematics</option>
                                <option value="Physics" <%= teacher != null && "Physics".equals(teacher.getDepartment()) ? "selected" : "" %>>Physics</option>
                                <option value="Chemistry" <%= teacher != null && "Chemistry".equals(teacher.getDepartment()) ? "selected" : "" %>>Chemistry</option>
                                <option value="Biology" <%= teacher != null && "Biology".equals(teacher.getDepartment()) ? "selected" : "" %>>Biology</option>
                                <option value="English" <%= teacher != null && "English".equals(teacher.getDepartment()) ? "selected" : "" %>>English</option>
                                <option value="History" <%= teacher != null && "History".equals(teacher.getDepartment()) ? "selected" : "" %>>History</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex gap-4 mt-8 pt-6 border-t border-slate-200">
                        <button
                                type="submit"
                                class="flex-1 bg-gradient-to-r from-purple-600 to-pink-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200"
                        >
                            <%= isEdit ? "Update Teacher" : "Save Teacher" %>
                        </button>
                        <a
                                href="<%= request.getContextPath() %>/teachers"
                                class="flex-1 bg-slate-200 text-slate-700 py-3 rounded-lg font-semibold hover:bg-slate-300 transition-all text-center"
                        >
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>