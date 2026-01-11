<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Course" %>
<%@ page import="java.util.List" %>
<%
    List<Course> items = (List<Course>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="space-y-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-800">Courses</h2>
                    <p class="text-slate-600 mt-1">Manage course catalog</p>
                </div>
                <a href="<%= request.getContextPath() %>/courses?action=new"
                   class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-0.5 transition-all">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Course
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 border-b border-slate-200">
                    <input
                            type="text"
                            id="searchInput"
                            placeholder="Search courses by code or title..."
                            class="w-full pl-10 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent outline-none"
                            onkeyup="searchTable()"
                    >
                    <svg class="w-5 h-5 absolute left-9 top-9 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full" id="coursesTable">
                        <thead class="bg-slate-50">
                        <tr>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">ID</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Course Code</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Title</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Credits</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Teacher</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% if (items != null && !items.isEmpty()) {
                            for (Course course : items) { %>
                        <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors">
                            <td class="py-4 px-6 text-slate-700"><%= course.getId() %></td>
                            <td class="py-4 px-6">
                                        <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm font-mono font-semibold">
                                            <%= course.getCode() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6">
                                <span class="font-medium text-slate-800"><%= course.getTitle() %></span>
                            </td>
                            <td class="py-4 px-6">
                                <div class="flex items-center gap-2">
                                    <svg class="w-5 h-5 text-yellow-500" fill="currentColor" viewBox="0 0 24 24">
                                        <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                                    </svg>
                                    <span class="font-semibold"><%= course.getCredits() != null ? course.getCredits() : "N/A" %></span>
                                </div>
                            </td>
                            <td class="py-4 px-6 text-slate-600">
                                <%= course.getTeacherId() != null ? "Teacher ID: " + course.getTeacherId() : "Not Assigned" %>
                            </td>
                            <td class="py-4 px-6">
                                <div class="flex items-center justify-center gap-2">
                                    <a href="<%= request.getContextPath() %>/courses?action=edit&id=<%= course.getId() %>"
                                       class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Edit">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/courses?action=delete&id=<%= course.getId() %>"
                                       class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                       onclick="return confirm('Are you sure you want to delete this course?')" title="Delete">
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
                            <td colspan="6" class="py-12 text-center">
                                <div class="text-slate-400">
                                    <svg class="w-16 h-16 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                    </svg>
                                    <p class="text-lg font-medium">No courses found</p>
                                    <p class="text-sm mt-1">Add your first course to get started</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <% if (items != null && !items.isEmpty()) { %>
                <div class="p-6 border-t border-slate-200 bg-slate-50">
                    <p class="text-sm text-slate-600">
                        Showing <span class="font-semibold"><%= items.size() %></span> courses
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
        const table = document.getElementById('coursesTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const tdCode = tr[i].getElementsByTagName('td')[1];
            const tdTitle = tr[i].getElementsByTagName('td')[2];
            if (tdCode || tdTitle) {
                const codeValue = tdCode.textContent || tdCode.innerText;
                const titleValue = tdTitle.textContent || tdTitle.innerText;
                if (codeValue.toUpperCase().indexOf(filter) > -1 || titleValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    }
</script>
</body>
</html>