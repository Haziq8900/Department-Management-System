<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Department Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in { animation: fadeIn 0.6s ease-out; }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-50 via-purple-50 to-pink-50">
<div class="min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-md fade-in">
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden transform hover:scale-105 transition-transform duration-300">
            <!-- Header -->
            <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-8 text-center">
                <div class="w-20 h-20 bg-white rounded-full mx-auto mb-4 flex items-center justify-center">
                    <svg class="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/>
                    </svg>
                </div>
                <h2 class="text-3xl font-bold text-white mb-2">Welcome Back</h2>
                <p class="text-blue-100">Login to your account</p>
            </div>

            <!-- Error/Success Messages -->
            <%
                String error = request.getParameter("error");
                String message = request.getParameter("message");
                if (error != null) {
            %>
            <div class="mx-8 mt-6 p-4 bg-red-50 border-l-4 border-red-500 rounded">
                <p class="text-red-700 text-sm">
                    <% if ("invalid_credentials".equals(error)) { %>
                    Invalid username or password!
                    <% } else if ("login_required".equals(error)) { %>
                    Please login to continue.
                    <% } else { %>
                    An error occurred. Please try again.
                    <% } %>
                </p>
            </div>
            <% } %>

            <% if (message != null) { %>
            <div class="mx-8 mt-6 p-4 bg-green-50 border-l-4 border-green-500 rounded">
                <p class="text-green-700 text-sm">
                    <% if ("logged_out".equals(message)) { %>
                    You have been logged out successfully.
                    <% } else if ("registration_successful".equals(message)) { %>
                    Registration successful! Please login.
                    <% } else if ("password_changed".equals(message)) { %>
                    Password changed successfully! Please login.
                    <% } else { %>
                    <%= message %>
                    <% } %>
                </p>
            </div>
            <% } %>

            <!-- Login Form -->
            <form action="<%= request.getContextPath() %>/users" method="post" class="p-8 space-y-6">
                <input type="hidden" name="action" value="login">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Username</label>
                    <input
                            type="text"
                            name="username"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                            placeholder="Enter your username"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Password</label>
                    <input
                            type="password"
                            name="password"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all"
                            placeholder="Enter your password"
                            required
                    >
                </div>

                <button
                        type="submit"
                        class="w-full bg-gradient-to-r from-blue-600 to-purple-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200"
                >
                    Login
                </button>

                <div class="text-center space-y-2">
                    <p class="text-sm text-slate-600">
                        Don't have an account?
                        <a href="<%= request.getContextPath() %>/register.jsp" class="text-blue-600 font-semibold hover:underline">
                            Register here
                        </a>
                    </p>
                    <p class="text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/changePassword.jsp" class="text-blue-600 hover:underline">
                            Change Password
                        </a>
                    </p>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>