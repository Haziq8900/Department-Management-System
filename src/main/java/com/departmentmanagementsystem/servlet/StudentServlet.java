package com.departmentmanagementsystem.servlet;

import com.departmentmanagementsystem.Student;
import com.departmentmanagementsystem.User;
import com.departmentmanagementsystem.dao.StudentDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private final StudentDao dao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        // For doGet - allow only list action
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && "Student".equals(user.getRole())) {
                String action2 = req.getParameter("action");
                if (action != null && !"list".equals(action) && !action.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    return;
                }
            }
        }
        // Handles student actions: list, new, edit, delete
        if (action == null || action.equals("list")) {
            list(req, resp);
        } else if (action.equals("new")) {
            req.setAttribute("student", new Student());
            req.getRequestDispatcher("/students/form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = parseInt(req.getParameter("id"));
            // Finds student by ID; forwards to form for editing
            try {
                Student s = dao.findById(id);
                if (s == null) { resp.sendRedirect(req.getContextPath() + "/students"); return; }
                req.setAttribute("student", s);
                req.getRequestDispatcher("/students/form.jsp").forward(req, resp);
            } catch (SQLException e) { throw new ServletException(e); }
        } else if (action.equals("delete")) {
            int id = parseInt(req.getParameter("id"));
            try { dao.delete(id); resp.sendRedirect(req.getContextPath() + "/students"); }
            catch (SQLException e) { throw new ServletException(e); }
        } else {
            list(req, resp);
        }
    }

    /**
     * Handles student creation/update; redirects to list
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // For doPost - block all POST requests
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && "Student".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                return;
            }
        }
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        Student s = new Student();
        s.setName(req.getParameter("name"));
        s.setEmail(req.getParameter("email"));
        s.setEnrollmentNumber(req.getParameter("enrollmentNumber"));
        s.setDepartment(req.getParameter("department"));
        s.setSemester(parseNullableInt(req.getParameter("semester")));
        try {
            // Creates or updates student based on ID presence
            if (idStr == null || idStr.isEmpty()) { dao.create(s); }
            else { s.setId(parseInt(idStr)); dao.update(s); }
        } catch (SQLException e) { throw new ServletException(e); }
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try { req.setAttribute("items", dao.findAll()); req.getRequestDispatcher("/students/list.jsp").forward(req, resp); }
        catch (SQLException e) { throw new ServletException(e); }
    }

    private int parseInt(String s) { try { return Integer.parseInt(s); } catch (Exception e) { return 0; } }
    private Integer parseNullableInt(String s) { try { return (s==null||s.isEmpty())?null:Integer.parseInt(s); } catch (Exception e) { return null; } }
}
