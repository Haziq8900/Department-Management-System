package com.departmentmanagementsystem.servlet;

import com.departmentmanagementsystem.Result;
import com.departmentmanagementsystem.User;
import com.departmentmanagementsystem.dao.ResultDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    private final ResultDao resultDao = new ResultDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=login_required");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = req.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "viewStudentResults": // student views their own results
                    String enrollmentNo = user.getUsername(); // assuming username = enrollment number for students
                    List<Result> results = resultDao.getResultsByStudent(enrollmentNo);
                    req.setAttribute("results", results);
                    req.getRequestDispatcher("/studentResults.jsp").forward(req, resp);
                    break;

                case "viewCourseResults": // teacher/admin views results by course
                    String courseCode = req.getParameter("courseCode");
                    if (courseCode != null && !courseCode.isEmpty()) {
                        List<Result> courseResults = resultDao.getResultsByCourse(courseCode);
                        req.setAttribute("results", courseResults);
                        req.getRequestDispatcher("/courseResults.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=invalid_course");
                    }
                    break;

                case "viewAll": // admin views all results
                    if ("Admin".equalsIgnoreCase(user.getRole())) {
                        List<Result> allResults = resultDao.getAllResults();
                        req.setAttribute("results", allResults);
                        req.getRequestDispatcher("/allResults.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "delete": // delete a result
                    if ("Admin".equalsIgnoreCase(user.getRole()) || "Teacher".equalsIgnoreCase(user.getRole())) {
                        String delEnrollmentNo = req.getParameter("studentEnrollmentNo");
                        String delCourseCode = req.getParameter("courseCode");
                        if (resultDao.deleteResult(delEnrollmentNo, delCourseCode)) {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?message=result_deleted");
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=delete_failed");
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=login_required");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = req.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "addResult":
                    if ("Admin".equalsIgnoreCase(user.getRole()) || "Teacher".equalsIgnoreCase(user.getRole())) {
                        Result newResult = new Result(
                                req.getParameter("teacherName"),
                                req.getParameter("courseTitle"),
                                req.getParameter("courseCode"),
                                req.getParameter("studentEnrollmentNo"),
                                Integer.parseInt(req.getParameter("sessionalMarks")),
                                Integer.parseInt(req.getParameter("midMarks")),
                                Integer.parseInt(req.getParameter("finalMarks"))
                        );

                        if (resultDao.addResult(newResult)) {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?message=result_added");
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=add_failed");
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "updateResult":
                    if ("Admin".equalsIgnoreCase(user.getRole()) || "Teacher".equalsIgnoreCase(user.getRole())) {
                        Result updatedResult = new Result(
                                req.getParameter("teacherName"),
                                req.getParameter("courseTitle"),
                                req.getParameter("courseCode"),
                                req.getParameter("studentEnrollmentNo"),
                                Integer.parseInt(req.getParameter("sessionalMarks")),
                                Integer.parseInt(req.getParameter("midMarks")),
                                Integer.parseInt(req.getParameter("finalMarks"))
                        );

                        if (resultDao.updateResult(updatedResult)) {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?message=result_updated");
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=update_failed");
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
