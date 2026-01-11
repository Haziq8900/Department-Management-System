<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Department Management System</title>
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
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden">
            <!-- Header -->
            <div class="bg-gradient-to-r from-purple-600 to-pink-600 p-8 text-center">
                <h2 class="text-3xl font-bold text-white mb-2">Create Account</h2>
                <p class="text-purple-100">Join us today</p>
            </div>

            <!-- Error Message -->
            <%
                String error = request.getParameter("error");
                if (error != null) {
            %>
            <div class="mx-8 mt-6 p-4 bg-red-50 border-l-4 border-red-500 rounded">
                <p class="text-red-700 text-sm">
                    <% if ("username_taken".equals(error)) { %>
                    Username already exists. Please choose another.
                    <% } else { %>
                    Registration failed. Please try again.
                    <% } %>
                </p>
            </div>
            <% } %>

            <!-- Registration Form -->
            <form action="<%= request.getContextPath() %>/users" method="post" class="p-8 space-y-4" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="register">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Username</label>
                    <input
                            type="text"
                            name="username"
                            id="username"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none"
                            placeholder="Choose a username"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Email</label>
                    <input
                            type="email"
                            name="email"
                            id="email"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none"
                            placeholder="your.email@example.com"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Password</label>
                    <input
                            type="password"
                            name="password"
                            id="password"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none"
                            placeholder="Create a strong password"
                            required
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-2">Confirm Password</label>
                    <input
                            type="password"
                            id="confirmPassword"
                            class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none"
                            placeholder="Re-enter your password"
                            required
                    >
                </div>

                <button
                        type="submit"
                        class="w-full bg-gradient-to-r from-purple-600 to-pink-600 text-white py-3 rounded-lg font-semibold hover:shadow-lg transform hover:-translate-y-0.5 transition-all"
                >
                    Register
                </button>

                <p class="text-center text-sm text-slate-600">
                    Already have an account?
                    <a href="<%= request.getContextPath() %>/login.jsp" class="text-purple-600 font-semibold hover:underline">
                        Login here
                    </a>
                </p>
            </form>
        </div>
    </div>
</div>

<script>
    function validateForm() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            return false;
        }

        if (password.length < 6) {
            alert('Password must be at least 6 characters long!');
            return false;
        }

        return true;
    }
</script>
</body>
</html>