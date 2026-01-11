<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Course" %>
<%
    Course course = (Course) request.getAttribute("course");
    boolean isEdit = (course != null && course.getId() != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Course - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="max-w-4xl mx-auto">
            <div class="mb-6">
                <a href="<%= request.getContextPath() %>/courses"
                   class="inline-flex items-center gap-2 text-slate-600 hover:text-slate-800 transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Back to Courses
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-green-600 to-emerald-600 p-6 text-white">
                    <h2 class="text-2xl font-bold"><%= isEdit ? "Edit Course" : "Add New Course" %></h2>
                    <p class="text-green-100 mt-1">
                        <%= isEdit ? "Update course information" : "Fill in the details to add a new course" %>
                    </p>
                </div>

                <form action="<%= request.getContextPath() %>/courses" method="post" class="p-8">
                    <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= course.getId() %>">
                    <% } %>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Course Code -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Course Code <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="code"
                                    value="<%= course != null && course.getCode() != null ? course.getCode() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent outline-none transition-all font-mono"
                                    placeholder="e.g., CS-101"
                                    required
                            >
                            <p class="text-xs text-slate-500 mt-1">Unique identifier for the course</p>
                        </div>

                        <!-- Credits -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Credits <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="number"
                                    name="credits"
                                    value="<%= course != null && course.getCredits() != null ? course.getCredits() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent outline-none transition-all"
                                    placeholder="3"
                                    min="1"
                                    max="6"
                                    required
                            >
                            <p class="text-xs text-slate-500 mt-1">Number of credit hours (1-6)</p>
                        </div>

                        <!-- Course Title -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Course Title <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="title"
                                    value="<%= course != null && course.getTitle() != null ? course.getTitle() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent outline-none transition-all"
                                    placeholder="e.g., Introduction to Computer Science"
                                    required
                            >
                        </div>

                        <!-- Teacher Assignment -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Assigned Teacher (Optional)
                            </label>
                            <input
                                    type="number"
                                    name="teacherId"
                                    value="<%= course != null && course.getTeacherId() != null ? course.getTeacherId() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent outline-none transition-all"
                                    placeholder="Enter Teacher ID (leave empty if not assigned)"
                                    min="1"
                            >
                            <p class="text-xs text-slate-500 mt-1">Teacher ID from the teachers table</p>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4 mt-8 pt-6 border-t border-slate-200">
                        <button
                                type="submit"
                                class="flex-1 bg-gradient-to-r from-green-600 to-emerald-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200"
                        >
                            <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <%= isEdit ? "Update Course" : "Save Course" %>
                        </button>
                        <a
                                href="<%= request.getContextPath() %>/courses"
                                class="flex-1 bg-slate-200 text-slate-700 py-3 rounded-lg font-semibold hover:bg-slate-300 transition-all text-center"
                        >
                            Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Help Card -->
            <div class="mt-6 bg-green-50 border-l-4 border-green-500 p-4 rounded">
                <div class="flex items-start">
                    <svg class="w-5 h-5 text-green-500 mt-0.5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <div>
                        <p class="text-sm text-green-800 font-medium">Course Guidelines:</p>
                        <ul class="text-sm text-green-700 mt-1 list-disc list-inside">
                            <li>Course code should be unique and follow department standards</li>
                            <li>Credit hours typically range from 1 to 6</li>
                            <li>Teacher assignment can be updated later if not available now</li>
                            <li>Course title should be descriptive and professional</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>