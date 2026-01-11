<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Result" %>
<%
    Result result = (Result) request.getAttribute("result");
    boolean isEdit = (result != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Update" : "Add" %> Result - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
<%@ include file="/includes/header.jsp" %>

<div class="flex">
    <%@ include file="/includes/sidebar.jsp" %>

    <main class="flex-1 p-6 ml-64">
        <div class="max-w-4xl mx-auto">
            <div class="mb-6">
                <a href="<%= request.getContextPath() %>/result?action=viewAll"
                   class="inline-flex items-center gap-2 text-slate-600 hover:text-slate-800 transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Back to Results
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-orange-600 to-red-600 p-6 text-white">
                    <h2 class="text-2xl font-bold"><%= isEdit ? "Update Result" : "Add New Result" %></h2>
                    <p class="text-orange-100 mt-1">
                        <%= isEdit ? "Update student's result information" : "Enter marks and result details" %>
                    </p>
                </div>

                <form action="<%= request.getContextPath() %>/result" method="post" class="p-8" onsubmit="return validateMarks()">
                    <input type="hidden" name="action" value="<%= isEdit ? "updateResult" : "addResult" %>">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Student Enrollment Number -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Student Enrollment Number <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="studentEnrollmentNo"
                                    value="<%= result != null && result.getStudentEnrollmentNo() != null ? result.getStudentEnrollmentNo() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all font-mono"
                                    placeholder="e.g., STD001"
                                <%= isEdit ? "readonly" : "" %>
                                    required
                            >
                        </div>

                        <!-- Course Code -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Course Code <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="courseCode"
                                    value="<%= result != null && result.getCourseCode() != null ? result.getCourseCode() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all font-mono"
                                    placeholder="e.g., CS-101"
                                <%= isEdit ? "readonly" : "" %>
                                    required
                            >
                        </div>

                        <!-- Course Title -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Course Title <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="courseTitle"
                                    value="<%= result != null && result.getCourseTitle() != null ? result.getCourseTitle() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="e.g., Introduction to Computer Science"
                                    required
                            >
                        </div>

                        <!-- Teacher Name -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Teacher Name <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    name="teacherName"
                                    value="<%= result != null && result.getTeacherName() != null ? result.getTeacherName() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="e.g., Dr. John Smith"
                                    required
                            >
                        </div>

                        <!-- Marks Section -->
                        <div class="md:col-span-2 border-t border-slate-200 pt-6 mt-4">
                            <h3 class="text-lg font-semibold text-slate-800 mb-4">Marks Distribution</h3>
                        </div>

                        <!-- Sessional Marks -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Sessional Marks (Max: 20) <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="number"
                                    name="sessionalMarks"
                                    id="sessionalMarks"
                                    value="<%= result != null ? result.getSessionalMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-20"
                                    min="0"
                                    max="20"
                                    onchange="calculateTotal()"
                                    required
                            >
                        </div>

                        <!-- Mid Marks -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Mid Term Marks (Max: 30) <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="number"
                                    name="midMarks"
                                    id="midMarks"
                                    value="<%= result != null ? result.getMidMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-30"
                                    min="0"
                                    max="30"
                                    onchange="calculateTotal()"
                                    required
                            >
                        </div>

                        <!-- Final Marks -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Final Exam Marks (Max: 50) <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="number"
                                    name="finalMarks"
                                    id="finalMarks"
                                    value="<%= result != null ? result.getFinalMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-50"
                                    min="0"
                                    max="50"
                                    onchange="calculateTotal()"
                                    required
                            >
                        </div>

                        <!-- Total and Grade Display -->
                        <div class="bg-slate-50 p-6 rounded-lg">
                            <div class="space-y-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm font-medium text-slate-700">Total Marks:</span>
                                    <span id="totalMarks" class="text-2xl font-bold text-slate-800">0 / 100</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <span class="text-sm font-medium text-slate-700">Grade:</span>
                                    <span id="grade" class="px-4 py-2 bg-gray-100 text-gray-700 rounded-full text-xl font-bold">-</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4 mt-8 pt-6 border-t border-slate-200">
                        <button
                                type="submit"
                                class="flex-1 bg-gradient-to-r from-orange-600 to-red-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200"
                        >
                            <%= isEdit ? "Update Result" : "Save Result" %>
                        </button>
                        <a
                                href="<%= request.getContextPath() %>/result?action=viewAll"
                                class="flex-1 bg-slate-200 text-slate-700 py-3 rounded-lg font-semibold hover:bg-slate-300 transition-all text-center"
                        >
                            Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Grading Scale -->
            <div class="mt-6 bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
                <div class="flex items-start">
                    <svg class="w-5 h-5 text-blue-500 mt-0.5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <div class="flex-1">
                        <p class="text-sm text-blue-800 font-medium mb-2">Grading Scale:</p>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-2 text-xs text-blue-700">
                            <div>A+: 90-100</div>
                            <div>A: 81-89</div>
                            <div>B+: 73-80</div>
                            <div>B: 65-72</div>
                            <div>C+: 60-64</div>
                            <div>C: 55-59</div>
                            <div>C-: 50-54</div>
                            <div>F: Below 50</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    function calculateTotal() {
        const sessional = parseInt(document.getElementById('sessionalMarks').value) || 0;
        const mid = parseInt(document.getElementById('midMarks').value) || 0;
        const final = parseInt(document.getElementById('finalMarks').value) || 0;
        const total = sessional + mid + final;

        document.getElementById('totalMarks').textContent = total + ' / 100';

        let grade = 'F';
        let gradeColor = 'red';

        if (total >= 90) { grade = 'A+'; gradeColor = 'green'; }
        else if (total >= 81) { grade = 'A'; gradeColor = 'green'; }
        else if (total >= 73) { grade = 'B+'; gradeColor = 'blue'; }
        else if (total >= 65) { grade = 'B'; gradeColor = 'blue'; }
        else if (total >= 60) { grade = 'C+'; gradeColor = 'yellow'; }
        else if (total >= 55) { grade = 'C'; gradeColor = 'yellow'; }
        else if (total >= 50) { grade = 'C-'; gradeColor = 'orange'; }

        const gradeElement = document.getElementById('grade');
        gradeElement.textContent = grade;
        gradeElement.className = `px-4 py-2 bg-${gradeColor}-100 text-${gradeColor}-700 rounded-full text-xl font-bold`;
    }

    function validateMarks() {
        const sessional = parseInt(document.getElementById('sessionalMarks').value) || 0;
        const mid = parseInt(document.getElementById('midMarks').value) || 0;
        const final = parseInt(document.getElementById('finalMarks').value) || 0;

        if (sessional < 0 || sessional > 20) {
            alert('Sessional marks must be between 0 and 20');
            return false;
        }
        if (mid < 0 || mid > 30) {
            alert('Mid term marks must be between 0 and 30');
            return false;
        }
        if (final < 0 || final > 50) {
            alert('Final exam marks must be between 0 and 50');
            return false;
        }

        return true;
    }

    window.onload = function() {
        calculateTotal();
    };
</script>
</body>
</html>