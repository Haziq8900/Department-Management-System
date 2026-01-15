<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.departmentmanagementsystem.Result" %>
<%@ page import="com.departmentmanagementsystem.Course" %>
<%@ page import="com.departmentmanagementsystem.dao.CourseDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%
    Result result = (Result) request.getAttribute("result");
    boolean isEdit = (result != null);

    // Fetch all courses for dropdown
    CourseDao courseDao = new CourseDao();
    List<Course> courses = null;
    try {
        courses = courseDao.findAll();
    } catch (SQLException e) {
        courses = new java.util.ArrayList<>();
    }
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
                    <input type="hidden" id="courseCredits" value="<%= result != null && result.getCredits() != null ? result.getCredits() : "3" %>">

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

                        <!-- Course Dropdown -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Select Course <span class="text-red-500">*</span>
                            </label>
                            <select
                                    id="courseSelect"
                                    name="courseCode"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    onchange="updateCourseDetails()"
                                    <%= isEdit ? "disabled" : "" %>
                                    required
                            >
                                <option value="">-- Select Course --</option>
                                <% if (courses != null) {
                                    for (Course course : courses) { %>
                                <option value="<%= course.getCode() %>"
                                        data-title="<%= course.getTitle() %>"
                                        data-credits="<%= course.getCredits() != null ? course.getCredits() : 3 %>"
                                        <%= result != null && course.getCode().equals(result.getCourseCode()) ? "selected" : "" %>>
                                    <%= course.getCode() %> - <%= course.getTitle() %> (<%= course.getCredits() %> Credits)
                                </option>
                                <% } } %>
                            </select>
                            <% if (isEdit) { %>
                            <input type="hidden" name="courseCode" value="<%= result.getCourseCode() %>">
                            <% } %>
                        </div>

                        <!-- Course Title (Auto-filled) -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Course Title <span class="text-red-500">*</span>
                            </label>
                            <input
                                    type="text"
                                    id="courseTitle"
                                    name="courseTitle"
                                    value="<%= result != null && result.getCourseTitle() != null ? result.getCourseTitle() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg bg-slate-50 outline-none"
                                    readonly
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

                        <!-- Credits (Hidden field) -->
                        <input type="hidden" id="creditsField" name="credits" value="<%= result != null && result.getCredits() != null ? result.getCredits() : "3" %>">

                        <!-- Marks Distribution Info -->
                        <div class="md:col-span-2 bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
                            <p class="text-sm text-blue-800 font-medium" id="marksInfo">
                                Marks Distribution (3 Credits): Sessional(20) + Mid(30) + Final(50) = 100 Total
                            </p>
                        </div>

                        <!-- Marks Section -->
                        <div class="md:col-span-2 border-t border-slate-200 pt-6 mt-4">
                            <h3 class="text-lg font-semibold text-slate-800 mb-4">Marks Entry</h3>
                        </div>

                        <!-- Sessional Marks -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Sessional Marks <span class="text-red-500">*</span> <span id="sessionalMax" class="text-xs text-slate-500">(Max: 20)</span>
                            </label>
                            <input
                                    type="number"
                                    name="sessionalMarks"
                                    id="sessionalMarks"
                                    value="<%= result != null && result.getSessionalMarks() != null ? result.getSessionalMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-20"
                                    min="0"
                                    max="20"
                                    onchange="calculateTotal()"
                                    required
                            >
                            <p class="text-xs text-green-600 mt-1">✓ Required field</p>
                        </div>

                        <!-- Mid Marks -->
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Mid Term Marks <span id="midMax" class="text-xs text-slate-500">(Max: 20)</span> <span class="text-slate-400 text-xs">(Optional)</span>
                            </label>
                            <input
                                    type="number"
                                    name="midMarks"
                                    id="midMarks"
                                    value="<%= result != null && result.getMidMarks() != null ? result.getMidMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-20 (leave empty if not yet conducted)"
                                    min="0"
                                    max="20"
                                    onchange="calculateTotal()"
                            >
                            <p class="text-xs text-slate-500 mt-1">Leave empty if mid exam not yet conducted</p>
                        </div>

                        <!-- Final Marks -->
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-slate-700 mb-2">
                                Final Exam Marks <span id="finalMax" class="text-xs text-slate-500">(Max: 60)</span> <span class="text-slate-400 text-xs">(Optional)</span>
                            </label>
                            <input
                                    type="number"
                                    name="finalMarks"
                                    id="finalMarks"
                                    value="<%= result != null && result.getFinalMarks() != null ? result.getFinalMarks() : "" %>"
                                    class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all"
                                    placeholder="0-60 (leave empty if finals not yet conducted)"
                                    min="0"
                                    max="60"
                                    onchange="calculateTotal()"
                            >
                            <p class="text-xs text-slate-500 mt-1">Leave empty if final exam not yet conducted</p>
                        </div>

                        <!-- Total and Grade Display -->
                        <div class="md:col-span-2 bg-slate-50 p-6 rounded-lg">
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <span class="text-sm font-medium text-slate-700">Total Marks:</span>
                                    <span id="totalMarks" class="block text-3xl font-bold text-slate-800 mt-2">0 / 100</span>
                                </div>
                                <div>
                                    <span class="text-sm font-medium text-slate-700">Grade:</span>
                                    <span id="grade" class="block mt-2 px-4 py-2 bg-gray-100 text-gray-700 rounded-full text-2xl font-bold inline-block">-</span>
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
                        <p class="text-sm text-blue-800 font-medium mb-2">Grading Scale (Based on Percentage):</p>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-2 text-xs text-blue-700">
                            <div>A+: 90-100%</div>
                            <div>A: 81-89%</div>
                            <div>B+: 73-80%</div>
                            <div>B: 65-72%</div>
                            <div>C+: 60-64%</div>
                            <div>C: 55-59%</div>
                            <div>C-: 50-54%</div>
                            <div>F: Below 50%</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // Store max marks for each component
    let maxMarks = {
        total: 100,
        sessional: 20,
        mid: 20,
        final: 60
    };

    function updateCourseDetails() {
        const select = document.getElementById('courseSelect');
        const selectedOption = select.options[select.selectedIndex];

        if (selectedOption.value) {
            const title = selectedOption.getAttribute('data-title');
            const credits = parseInt(selectedOption.getAttribute('data-credits'));

            document.getElementById('courseTitle').value = title;
            document.getElementById('creditsField').value = credits;
            document.getElementById('courseCredits').value = credits;

            // Update max marks based on credits
            updateMaxMarks(credits);
            calculateTotal();
        }
    }

    function updateMaxMarks(credits) {
        if (credits >= 3) {
            // 3 credit course = 100 marks total
            maxMarks = { total: 100, sessional: 20, mid: 20, final: 60 };
            document.getElementById('marksInfo').textContent = `Marks Distribution (${credits} Credits): Sessional(20) + Mid(20) + Final(60) = 100 Total`;
        } else {
            // Less than 3 credits = 50 marks total
            maxMarks = { total: 50, sessional: 10, mid: 10, final: 30 };
            document.getElementById('marksInfo').textContent = `Marks Distribution (${credits} Credits): Sessional(10) + Mid(10) + Final(30) = 50 Total`;
        }

        // Update input fields max attributes and labels
        document.getElementById('sessionalMarks').setAttribute('max', maxMarks.sessional);
        document.getElementById('midMarks').setAttribute('max', maxMarks.mid);
        document.getElementById('finalMarks').setAttribute('max', maxMarks.final);

        document.getElementById('sessionalMax').textContent = `(Max: ${maxMarks.sessional})`;
        document.getElementById('midMax').textContent = `(Max: ${maxMarks.mid})`;
        document.getElementById('finalMax').textContent = `(Max: ${maxMarks.final})`;

        // Update placeholders
        document.getElementById('sessionalMarks').setAttribute('placeholder', `0-${maxMarks.sessional}`);
        document.getElementById('midMarks').setAttribute('placeholder', `0-${maxMarks.mid} (optional)`);
        document.getElementById('finalMarks').setAttribute('placeholder', `0-${maxMarks.final} (optional)`);
    }

    function calculateTotal() {
        const sessional = parseInt(document.getElementById('sessionalMarks').value) || 0;
        const mid = parseInt(document.getElementById('midMarks').value) || 0;
        const final = parseInt(document.getElementById('finalMarks').value) || 0;
        const total = sessional + mid + final;

        document.getElementById('totalMarks').textContent = total + ' / ' + maxMarks.total;

        let grade = 'Pending';
        let gradeColor = 'gray';

        // Only calculate grade if final marks are entered
        const finalInput = document.getElementById('finalMarks').value;
        if (finalInput !== null && finalInput !== '') {
            const percentage = (total / maxMarks.total) * 100;

            if (percentage >= 90) { grade = 'A+'; gradeColor = 'green'; }
            else if (percentage >= 81) { grade = 'A'; gradeColor = 'green'; }
            else if (percentage >= 73) { grade = 'B+'; gradeColor = 'blue'; }
            else if (percentage >= 65) { grade = 'B'; gradeColor = 'blue'; }
            else if (percentage >= 60) { grade = 'C+'; gradeColor = 'yellow'; }
            else if (percentage >= 55) { grade = 'C'; gradeColor = 'yellow'; }
            else if (percentage >= 50) { grade = 'C-'; gradeColor = 'orange'; }
            else { grade = 'F'; gradeColor = 'red'; }
        }

        const gradeElement = document.getElementById('grade');
        gradeElement.textContent = grade;
        gradeElement.className = `block mt-2 px-4 py-2 bg-${gradeColor}-100 text-${gradeColor}-700 rounded-full text-2xl font-bold inline-block`;
    }

    function validateMarks() {
        const sessional = document.getElementById('sessionalMarks').value;
        const mid = document.getElementById('midMarks').value;
        const final = document.getElementById('finalMarks').value;

        // Sessional is mandatory
        if (!sessional || sessional === '') {
            alert('Sessional marks are required!');
            return false;
        }

        const sessionalNum = parseInt(sessional);
        if (sessionalNum < 0 || sessionalNum > maxMarks.sessional) {
            alert(`Sessional marks must be between 0 and ${maxMarks.sessional}`);
            return false;
        }

        // Mid marks are optional, but if provided, must be valid
        if (mid !== '' && mid !== null) {
            const midNum = parseInt(mid);
            if (midNum < 0 || midNum > maxMarks.mid) {
                alert(`Mid term marks must be between 0 and ${maxMarks.mid}`);
                return false;
            }
        }

        // Final marks are optional, but if provided, must be valid
        if (final !== '' && final !== null) {
            const finalNum = parseInt(final);
            if (finalNum < 0 || finalNum > maxMarks.final) {
                alert(`Final exam marks must be between 0 and ${maxMarks.final}`);
                return false;
            }
        }

        return true;
    }

    window.onload = function() {
        // Initialize max marks based on existing credits
        const credits = parseInt(document.getElementById('courseCredits').value) || 3;
        updateMaxMarks(credits);
        calculateTotal();
    };
</script>
</body>
</html>