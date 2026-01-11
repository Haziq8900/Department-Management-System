<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-50 via-purple-50 to-pink-50">
<div class="min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-md">
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden">
            <div class="bg-gradient-to-r from-orange-600 to-red-600 p-8 text-center">
                <h2 class="text-3xl font-bold text-white mb-2">Change Password</h2>
                <p class="text-orange-100">Update your password</p>
            </div>

            <%
                String error = request.getParameter("error");
                if (error != null) {
            %>
            <div class="mx-8 mt-6 p-4 bg-red-50 border-l-4 border-red-500 rounded">
                <p class="text-red-700 text-sm">
                    <% if ("invalid_old_password".equals(error)) { %>
                    Old password is incorrect!
                    <% } else { %>
                    Failed to change password. Please try again.
                    <% } %>
                </p>
            </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/users" method="post" class="p-8 space-y-4" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="changePassword">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Username</label>
                    <input
                            type="text"
                            name="username"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Old Password</label>
                    <input
                            type="password"
                            name="oldPassword"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">New Password</label>
                    <input
                            type="password"
                            name="newPassword"
                            id="newPassword"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Confirm New Password</label>
                    <input
                            type="password"
                            id="confirmPassword"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none"
                            required
                    >
                </div>

                <button
                        type="submit"
                        class="w-full bg-gradient-to-r from-orange-600 to-red-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transition-all"
                >
                    Change Password
                </button>

                <p class="text-center text-sm text-slate-600">
                    <a href="<%= request.getContextPath() %>/login.jsp" class="text-orange-600 hover:underline">
                        Back to Login
                    </a>
                </p>
            </form>
        </div>
    </div>
</div>

<script>
    function validateForm() {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            alert('New passwords do not match!');
            return false;
        }

        if (newPassword.length < 6) {
            alert('Password must be at least 6 characters long!');
            return false;
        }

        return true;
    }
</script>
</body>
</html>