<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Teacher" %>
<%@ page import="java.util.List" %>
<%
    List<Teacher> items = (List<Teacher>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teachers - Department Management System</title>
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
                    <h2 class="text-3xl font-bold text-slate-800">Teachers</h2>
                    <p class="text-slate-600 mt-1">Manage teacher records</p>
                </div>
                <a href="<%= request.getContextPath() %>/teachers?action=new"
                   class="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg hover:shadow-lg transform hover:-translate-y-0.5 transition-all">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Teacher
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="p-6 border-b border-slate-200">
                    <input
                            type="text"
                            id="searchInput"
                            placeholder="Search teachers by name or email..."
                            class="w-full pl-10 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none"
                            onkeyup="searchTable()"
                    >
                    <svg class="w-5 h-5 absolute left-9 top-9 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full" id="teachersTable">
                        <thead class="bg-slate-50">
                        <tr>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">ID</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Name</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Email</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Department</th>
                            <th class="text-left py-4 px-6 font-semibold text-slate-700">Phone</th>
                            <th class="text-center py-4 px-6 font-semibold text-slate-700">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% if (items != null && !items.isEmpty()) {
                            for (Teacher teacher : items) { %>
                        <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors">
                            <td class="py-4 px-6 text-slate-700"><%= teacher.getId() %></td>
                            <td class="py-4 px-6">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center text-white font-semibold">
                                        <%= teacher.getName().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <span class="font-medium text-slate-800"><%= teacher.getName() %></span>
                                </div>
                            </td>
                            <td class="py-4 px-6 text-slate-600"><%= teacher.getEmail() %></td>
                            <td class="py-4 px-6">
                                        <span class="px-3 py-1 bg-purple-100 text-purple-700 rounded-full text-sm font-medium">
                                            <%= teacher.getDepartment() %>
                                        </span>
                            </td>
                            <td class="py-4 px-6 text-slate-700"><%= teacher.getPhone() != null ? teacher.getPhone() : "N/A" %></td>
                            <td class="py-4 px-6">
                                <div class="flex items-center justify-center gap-2">
                                    <a href="<%= request.getContextPath() %>/teachers?action=edit&id=<%= teacher.getId() %>"
                                       class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Edit">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/teachers?action=delete&id=<%= teacher.getId() %>"
                                       class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                       onclick="return confirm('Are you sure you want to delete this teacher?')" title="Delete">
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
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                    </svg>
                                    <p class="text-lg font-medium">No teachers found</p>
                                    <p class="text-sm mt-1">Add your first teacher to get started</p>
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
                        Showing <span class="font-semibold"><%= items.size() %></span> teachers
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
        const table = document.getElementById('teachersTable');
        const tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) {
            const tdName = tr[i].getElementsByTagName('td')[1];
            const tdEmail = tr[i].getElementsByTagName('td')[2];
            if (tdName || tdEmail) {
                const nameValue = tdName.textContent || tdName.innerText;
                const emailValue = tdEmail.textContent || tdEmail.innerText;
                if (nameValue.toUpperCase().indexOf(filter) > -1 || emailValue.toUpperCase().indexOf(filter) > -1) {
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