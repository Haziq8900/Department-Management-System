package com.departmentmanagementsystem.servlet;

import com.departmentmanagementsystem.User;
import com.departmentmanagementsystem.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private final UserDao dao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login.jsp?message=logged_out");
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("login".equals(action)) {
                String username = req.getParameter("username");
                String password = req.getParameter("password");

                // CORRECTED: Capture the User object returned by the DAO
                User user = dao.login(username, password);

                // CORRECTED: Check if the user object is not null
                if (user != null) {
                    HttpSession session = req.getSession();
                    // SUCCESS: Store the user object (which now includes ID, Email, and ROLE)
                    session.setAttribute("user", user);

                    resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp?error=invalid_credentials");
                }

            } else if ("changePassword".equals(action)) {
                String username = req.getParameter("username");
                String oldPassword = req.getParameter("oldPassword");
                String newPassword = req.getParameter("newPassword");

                if (dao.changePassword(username, oldPassword, newPassword)) {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp?message=password_changed");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/changePassword.jsp?error=invalid_old_password");
                }

            } else if ("register".equals(action)) {
                String username = req.getParameter("username");
                String password = req.getParameter("password");

                if (dao.registerUser(username, password)) {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp?message=registration_successful");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/register.jsp?error=username_taken");
                }

            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}