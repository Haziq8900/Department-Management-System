<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Result" %>
<%@ page import="com.departmentmanagementsystem.User" %>
<%@ page import="java.util.List" %>
<%
    List<Result> results = (List<Result>) request.getAttribute("results");
    User currentUser = (User) session.getAttribute("user");
    String role = currentUser != null && currentUser.getRole() != null ? currentUser.getRole() : "Student";
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
                    <h2 class="text-3xl font-bold text-slate-800">
                        <% if ("Teacher".equals(role)) { %>
                        Manage Results
                        <% } else { %>
                        All Results
                        <% } %>
                    </h2>
                    <p class="text-slate-600 mt-1">
                        <% if ("Teacher".equals(role)) { %>
                        Add, update, or view student results
                        <% } else { %>
                        View all student results
                        <% } %>
                    </p>
                </div>
                <div class="flex gap-3">
                    <% if ("Teacher".equals(role)) { %>
                    <a href="<%= request.getContextPath() %>/result?action=new"
                       class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-0.5 transition-all">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Add Result
                    </a>
                    <% } %>
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

            <!-- Results Table -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 border-b border-slate-200">
                    <div class="flex gap-4">
                        <div class="flex-1 relative">
                            <input
                                    type="text"
                                    id="searchInput"
                                    placeholder="Search by student enrollment, course code, or teacher..."
                                    class="w-full pl-10 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                                    onkeyup="searchTable()"
                            >
                            <svg class="w-5 h-5 absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                            </svg>
                        </div>
                        <% if ("Teacher".equals(role)) { %>
                        <form action="<%= request.getContextPath() %>/result" method="get" class="flex gap-2">
                            <input type="hidden" name="action" value="searchByEnrollment">
                            <input
                                    type="text"
                                    name="enrollmentNo"
                                    placeholder="Search by enrollment..."
                                    class="px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                            >
                            <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-all">
                                Search
                            </button>
                        </form>
                        <% } %>
                    </div>
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
                            <% if ("Teacher".equals(role)) { %>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Actions</th>
                            <% } %>
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
                            <% if ("Teacher".equals(role)) { %>
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
                            <% } %>
                        </tr>
                        <% }
                        } else { %>
                        <tr>
                            <td colspan="<%= "Teacher".equals(role) ? "10" : "9" %>" class="py-12 text-center">
                                <div class="text-slate-400">
                                    <svg class="w-16 h-16 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    <p class="text-lg font-medium">No results found</p>
                                    <% if ("Teacher".equals(role)) { %>
                                    <p class="text-sm mt-1">Add results to see them here</p>
                                    <% } %>
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