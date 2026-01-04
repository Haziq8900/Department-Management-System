package com.departmentmanagementsystem.servlet;

import com.departmentmanagementsystem.Course;
import com.departmentmanagementsystem.dao.CourseDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    private final CourseDao dao = new CourseDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        // Handles course listing, creation, editing, and deletion
        if (action == null || action.equals("list")) {
            list(req, resp);
        } else if (action.equals("new")) {
            req.setAttribute("course", new Course());
            req.getRequestDispatcher("/courses/form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = parseInt(req.getParameter("id"));
            try {
                Course c = dao.findById(id);
                if (c == null) { resp.sendRedirect(req.getContextPath() + "/courses"); return; }
                req.setAttribute("course", c);
                req.getRequestDispatcher("/courses/form.jsp").forward(req, resp);
            } catch (SQLException e) { throw new ServletException(e); }
        } else if (action.equals("delete")) {
            int id = parseInt(req.getParameter("id"));
            try { dao.delete(id); resp.sendRedirect(req.getContextPath() + "/courses"); }
            catch (SQLException e) { throw new ServletException(e); }
        } else {
            list(req, resp);
        }
    }

    /**
     * Handles course creation/updates; redirects to course list
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        Course c = new Course();
        c.setCode(req.getParameter("code"));
        c.setTitle(req.getParameter("title"));
        c.setCredits(parseNullableInt(req.getParameter("credits")));
        c.setTeacherId(parseNullableInt(req.getParameter("teacherId")));
        try {
            // Creates or updates course based on ID existence
            if (idStr == null || idStr.isEmpty()) { dao.create(c); }
            else { c.setId(parseInt(idStr)); dao.update(c); }
        } catch (SQLException e) { throw new ServletException(e); }
        resp.sendRedirect(req.getContextPath() + "/courses");
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try { req.setAttribute("items", dao.findAll()); req.getRequestDispatcher("/courses/list.jsp").forward(req, resp); }
        catch (SQLException e) { throw new ServletException(e); }
    }

    private int parseInt(String s) { try { return Integer.parseInt(s); } catch (Exception e) { return 0; } }
    private Integer parseNullableInt(String s) { try { return (s==null||s.isEmpty())?null:Integer.parseInt(s); } catch (Exception e) { return null; } }
}
