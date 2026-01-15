<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Result" %>
<%@ page import="java.util.List" %>
<%
    List<Result> results = (List<Result>) request.getAttribute("results");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Results - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="space-y-6">
            <!-- Header -->
            <div>
                <h2 class="text-3xl font-bold text-slate-800">My Results</h2>
                <p class="text-slate-600 mt-1">View your academic performance</p>
            </div>

            <% if (results != null && !results.isEmpty()) {
                // Calculate overall statistics
                int totalMarks = 0;
                int totalCourses = results.size();
                for (Result r : results) {
                    totalMarks += r.getTotalMarks();
                }
                double averageMarks = totalCourses > 0 ? (double) totalMarks / totalCourses : 0;
            %>

            <!-- Statistics Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white rounded-xl shadow-lg p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Total Courses</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= totalCourses %></h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Average Score</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2"><%= String.format("%.1f", averageMarks) %>%</h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-600 text-sm font-medium">Overall GPA</p>
                            <h3 class="text-3xl font-bold text-slate-800 mt-2">
                                <%= averageMarks >= 90 ? "4.0" : averageMarks >= 80 ? "3.5" : averageMarks >= 70 ? "3.0" : averageMarks >= 60 ? "2.5" : "2.0" %>
                            </h3>
                        </div>
                        <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Results Table -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 border-b border-slate-200">
                    <h3 class="text-xl font-bold text-slate-800">Course Results</h3>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-slate-50">
                        <tr>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Course Code</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Course Title</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Teacher</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Sessional</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Mid</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Final</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Total</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Grade</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Result result : results) {
                            String gradeColor = "gray";
                            String grade = result.getGrade();
                            if (grade.startsWith("A")) gradeColor = "green";
                            else if (grade.startsWith("B")) gradeColor = "blue";
                            else if (grade.startsWith("C")) gradeColor = "yellow";
                            else gradeColor = "red";
                        %>
                        <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors">
                            <td class="py-4 px-6">
                                        <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-mono font-semibold">
                                            <%= result.getCourseCode() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6 font-medium text-slate-800"><%= result.getCourseTitle() %></td>
                            <td class="py-4 px-6 text-slate-600"><%= result.getTeacherName() %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getSessionalMarks() != null ? result.getSessionalMarks() : "-" %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getMidMarks() != null ? result.getMidMarks() : "-" %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getFinalMarks() != null ? result.getFinalMarks() : "-" %></td>
                            <td class="py-4 px-6 text-center">
                                        <span class="px-3 py-1 bg-slate-100 text-slate-800 rounded-full text-sm font-bold">
                                            <%= result.getTotalMarks() %> / <%= result.getMaxMarks() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6 text-center">
                                        <span class="px-3 py-1 bg-<%= gradeColor %>-100 text-<%= gradeColor %>-700 rounded-full text-sm font-bold">
                                            <%= grade %>
                                        </span>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <% } else { %>
            <!-- No Results Found -->
            <div class="bg-white rounded-xl shadow-lg p-12 text-center">
                <svg class="w-24 h-24 mx-auto text-slate-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                <h3 class="text-2xl font-bold text-slate-800 mb-2">No Results Available</h3>
                <p class="text-slate-600">Your results will appear here once they are published by your teachers.</p>
            </div>
            <% } %>
        </div>
    </main>
</div>
</body>
</html>