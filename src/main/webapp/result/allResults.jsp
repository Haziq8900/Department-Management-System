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
    <title>All Results - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="space-y-6">
            <!-- Header -->
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-800">All Results</h2>
                    <p class="text-slate-600 mt-1">Manage all student results</p>
                </div>
                <div class="flex gap-3">
                    <button
                            onclick="window.print()"
                            class="flex items-center gap-2 px-6 py-3 bg-slate-600 text-white rounded-lg hover:bg-slate-700 transition-all">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                        </svg>
                        Print
                    </button>
                </div>
            </div>

            <!-- Results Table -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 border-b border-slate-200">
                    <input
                            type="text"
                            id="searchInput"
                            placeholder="Search by student enrollment, course code, or teacher..."
                            class="w-full pl-10 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                            onkeyup="searchTable()"
                    >
                    <svg class="w-5 h-5 absolute left-9 top-9 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full" id="resultsTable">
                        <thead class="bg-slate-50">
                        <tr>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Student ID</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Course Code</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Course Title</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Teacher</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Sessional</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Mid</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Final</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Total</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Grade</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% if (results != null && !results.isEmpty()) {
                            for (Result result : results) {
                                String gradeColor = "gray";
                                String grade = result.getGrade();
                                if (grade.startsWith("A")) gradeColor = "green";
                                else if (grade.startsWith("B")) gradeColor = "blue";
                                else if (grade.startsWith("C")) gradeColor = "yellow";
                                else gradeColor = "red";
                        %>
                        <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors">
                            <td class="py-4 px-6">
                                        <span class="px-3 py-1 bg-purple-100 text-purple-700 rounded-full text-sm font-semibold">
                                            <%= result.getStudentEnrollmentNo() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6">
                                        <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-mono font-semibold">
                                            <%= result.getCourseCode() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6 font-medium text-slate-800"><%= result.getCourseTitle() %></td>
                            <td class="py-4 px-6 text-slate-600"><%= result.getTeacherName() %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getSessionalMarks() %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getMidMarks() %></td>
                            <td class="py-4 px-6 text-center font-semibold"><%= result.getFinalMarks() %></td>
                            <td class="py-4 px-6 text-center">
                                        <span class="px-3 py-1 bg-slate-100 text-slate-800 rounded-full text-sm font-bold">
                                            <%= result.getTotalMarks() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6 text-center">
                                        <span class="px-3 py-1 bg-<%= gradeColor %>-100 text-<%= gradeColor %>-700 rounded-full text-sm font-bold">
                                            <%= grade %>
                                        </span>
                            </td>
                            <td class="py-4 px-6">
                                <div class="flex items-center justify-center gap-2">
                                    <a href="<%= request.getContextPath() %>/result?action=delete&studentEnrollmentNo=<%= result.getStudentEnrollmentNo() %>&courseCode=<%= result.getCourseCode() %>"
                                       class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                       onclick="return confirm('Are you sure you want to delete this result?')"
                                       title="Delete">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                        </svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% }
                        } else { %>
                        <tr>
                            <td colspan="10" class="py-12 text-center">
                                <div class="text-slate-400">
                                    <svg class="w-16 h-16 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    <p class="text-lg font-medium">No results found</p>
                                    <p class="text-sm mt-1">Add results to see them here</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <% if (results != null && !results.isEmpty()) { %>
                <div class="p-6 border-t border-slate-200 bg-slate-50">
                    <p class="text-sm text-slate-600">
                        Showing <span class="font-semibold"><%= results.size() %></span> results
                    </p>
                </div>
                <% } %>
            </div>
        </div>
    </main>
</div>

<script>
    function searchTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toUpperCase();
        const table = document.getElementById('resultsTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const tds = tr[i].getElementsByTagName('td');
            let found = false;

            for (let j = 0; j < 4; j++) {
                if (tds[j]) {
                    const txtValue = tds[j].textContent || tds[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }

            tr[i].style.display = found ? '' : 'none';
        }
    }
</script>
</body>
</html>