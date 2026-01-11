<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Student" %>
<%
    Student student = (Student) request.getAttribute("student");
    boolean isEdit = (student != null && student.getId() != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Student - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="max-w-4xl mx-auto">
            <!-- Back Button -->
            <div class="mb-6">
                <a href="<%= request.getContextPath() %>/students"
                   class="inline-flex items-center gap-2 text-slate-600 hover:text-slate-800 transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Back to Students
                </a>
            </div>

            <!-- Form Card -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-6 text-white">
                    <h2 class="text-2xl font-bold"><%= isEdit ? "Edit Student" : "Add New Student" %></h2>
                    <p class="text-blue-100 mt-1">
                        <%= isEdit ? "Update student information" : "Fill in the details to add a new student" %>
                    </p>
                </div>

                <form action="<%= request.getContextPath() %>/students" method="post" class="p-8">
                    <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                    <% } %>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Name -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Full Name <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="name"
                                    value="<%= student != null && student.getName() != null ? student.getName() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                                    placeholder="Enter student's full name"
                                    required
                            >
                        </div>

                        <!-- Email -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Email Address <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="email"
                                    name="email"
                                    value="<%= student != null && student.getEmail() != null ? student.getEmail() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                                    placeholder="student@example.com"
                                    required
                            >
                        </div>

                        <!-- Enrollment Number -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Enrollment Number <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="enrollmentNumber"
                                    value="<%= student != null && student.getEnrollmentNumber() != null ? student.getEnrollmentNumber() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                                    placeholder="STD001"
                                    required
                            >
                        </div>

                        <!-- Department -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Department <span class="text-red-500">*</span>
                            </label>
                            <select
                                    name="department"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                                    required
                            >
                                <option value="">Select Department</option>
                                <option value="Computer Science" <%= student != null && "Computer Science".equals(student.getDepartment()) ? "selected" : "" %>>Computer Science</option>
                                <option value="Mathematics" <%= student != null && "Mathematics".equals(student.getDepartment()) ? "selected" : "" %>>Mathematics</option>
                                <option value="Physics" <%= student != null && "Physics".equals(student.getDepartment()) ? "selected" : "" %>>Physics</option>
                                <option value="Chemistry" <%= student != null && "Chemistry".equals(student.getDepartment()) ? "selected" : "" %>>Chemistry</option>
                                <option value="Biology" <%= student != null && "Biology".equals(student.getDepartment()) ? "selected" : "" %>>Biology</option>
                                <option value="English" <%= student != null && "English".equals(student.getDepartment()) ? "selected" : "" %>>English</option>
                                <option value="History" <%= student != null && "History".equals(student.getDepartment()) ? "selected" : "" %>>History</option>
                            </select>
                        </div>

                        <!-- Semester -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Semester
                            </label>
                            <input
                                    type="number"
                                    name="semester"
                                    value="<%= student != null && student.getSemester() != null ? student.getSemester() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                                    placeholder="Enter semester (1-8)"
                                    min="1"
                                    max="8"
                            >
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4 mt-8 pt-6 border-t border-slate-200">
                        <button
                                type="submit"
                                class="flex-1 bg-gradient-to-r from-blue-600 to-purple-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200"
                        >
                            <svg class="w-5 h-5 inline-block mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            <%= isEdit ? "Update Student" : "Save Student" %>
                        </button>
                        <a
                                href="<%= request.getContextPath() %>/students"
                                class="flex-1 bg-slate-200 text-slate-700 py-3 rounded-lg font-semibold hover:bg-slate-300 transition-all text-center"
                        >
                            Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Help Card -->
            <div class="mt-6 bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
                <div class="flex items-start">
                    <svg class="w-5 h-5 text-blue-500 mt-0.5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <div>
                        <p class="text-sm text-blue-800 font-medium">Important Notes:</p>
                        <ul class="text-sm text-blue-700 mt-1 list-disc list-inside">
                            <li>Enrollment number must be unique for each student</li>
                            <li>Valid email address is required for communication</li>
                            <li>All fields marked with <span class="text-red-500">*</span> are mandatory</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>