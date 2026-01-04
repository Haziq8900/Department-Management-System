package com.departmentmanagementsystem.servlet;

import com.departmentmanagementsystem.Teacher;
import com.departmentmanagementsystem.dao.TeacherDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/teachers")
public class TeacherServlet extends HttpServlet {
    private final TeacherDao dao = new TeacherDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        // Handles teacher requests: list, new, edit, delete
        if (action == null || action.equals("list")) {
            list(req, resp);
        } else if (action.equals("new")) {
            req.setAttribute("teacher", new Teacher());
            req.getRequestDispatcher("/teachers/form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = parseInt(req.getParameter("id"));
            // Finds teacher by ID; forwards to form or redirects
            try {
                Teacher t = dao.findById(id);
                if (t == null) {
                    resp.sendRedirect(req.getContextPath() + "/teachers");
                    return;
                }
                req.setAttribute("teacher", t);
                req.getRequestDispatcher("/teachers/form.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else if (action.equals("delete")) {
            int id = parseInt(req.getParameter("id"));
            try {
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/teachers");
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else {
            list(req, resp);
        }
    }

    /**
     * Handles teacher submissions: create or update
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        Teacher t = new Teacher();
        t.setName(req.getParameter("name"));
        t.setEmail(req.getParameter("email"));
        t.setDepartment(req.getParameter("department"));
        t.setPhone(req.getParameter("phone"));

        try {
            // Creates or updates teacher based on ID existence
            if (idStr == null || idStr.isEmpty()) {
                dao.create(t);
            } else {
                t.setId(parseInt(idStr));
                dao.update(t);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        resp.sendRedirect(req.getContextPath() + "/teachers");
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setAttribute("items", dao.findAll());
            req.getRequestDispatcher("/teachers/list.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private int parseInt(String s) { try { return Integer.parseInt(s); } catch (Exception e) { return 0; } }
}
