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
        String role = user.getRole() != null ? user.getRole() : "Student";

        try {
            switch (action != null ? action : "") {
                case "viewStudentResults":
                    // Students can only view their own results
                    if ("Student".equals(role)) {
                        String enrollmentNo = user.getUsername(); // Assuming username = enrollment number
                        List<Result> results = resultDao.getResultsByStudent(enrollmentNo);
                        req.setAttribute("results", results);
                        req.getRequestDispatcher("/results/studentResults.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "viewAll":
                    // Admin and Teacher can view all results
                    if ("Admin".equals(role) || "Teacher".equals(role)) {
                        List<Result> allResults = resultDao.getAllResults();
                        req.setAttribute("results", allResults);
                        req.getRequestDispatcher("/results/allResults.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "new":
                    // Only Teachers can add results
                    if ("Teacher".equals(role)) {
                        req.setAttribute("result", null);
                        req.getRequestDispatcher("/results/form.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "delete":
                    // Only Teachers can delete results
                    if ("Teacher".equals(role)) {
                        String delEnrollmentNo = req.getParameter("studentEnrollmentNo");
                        String delCourseCode = req.getParameter("courseCode");
                        if (resultDao.deleteResult(delEnrollmentNo, delCourseCode)) {
                            resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&message=result_deleted");
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&error=delete_failed");
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "searchByEnrollment":
                    // Teachers can search by enrollment number
                    if ("Teacher".equals(role)) {
                        String searchEnrollment = req.getParameter("enrollmentNo");
                        if (searchEnrollment != null && !searchEnrollment.isEmpty()) {
                            List<Result> searchResults = resultDao.getResultsByStudent(searchEnrollment);
                            req.setAttribute("results", searchResults);
                            req.setAttribute("searchQuery", searchEnrollment);
                            req.getRequestDispatcher("/results/allResults.jsp").forward(req, resp);
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&error=invalid_search");
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                case "edit":
                    // Only Teachers can edit results
                    if ("Teacher".equals(role)) {
                        String editEnrollmentNo = req.getParameter("studentEnrollmentNo");
                        String editCourseCode = req.getParameter("courseCode");
                        try {
                            // Get the result to edit
                            List<Result> results = resultDao.getResultsByStudent(editEnrollmentNo);
                            Result editResult = null;
                            for (Result r : results) {
                                if (r.getCourseCode().equals(editCourseCode)) {
                                    editResult = r;
                                    break;
                                }
                            }
                            if (editResult != null) {
                                req.setAttribute("result", editResult);
                                req.getRequestDispatcher("/results/form.jsp").forward(req, resp);
                            } else {
                                resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&error=result_not_found");
                            }
                        } catch (SQLException e) {
                            throw new ServletException(e);
                        }
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
                    }
                    break;

                default:
                    // Redirect based on role
                    if ("Student".equals(role)) {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewStudentResults");
                    } else if ("Teacher".equals(role)) {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewAll");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewAll");
                    }
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
        String role = user.getRole() != null ? user.getRole() : "Student";

        // Only Teachers can add or update results
        if (!"Teacher".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?error=unauthorized");
            return;
        }

        try {
            switch (action != null ? action : "") {
                case "addResult":
                    Result newResult = new Result(
                            req.getParameter("teacherName"),
                            req.getParameter("courseTitle"),
                            req.getParameter("courseCode"),
                            req.getParameter("studentEnrollmentNo"),
                            parseIntegerRequired(req.getParameter("sessionalMarks")), // Mandatory
                            parseIntegerOptional(req.getParameter("midMarks")), // Optional
                            parseIntegerOptional(req.getParameter("finalMarks")) // Optional
                    );

                    // Check if result already exists
                    if (resultDao.resultExists(newResult.getStudentEnrollmentNo(), newResult.getCourseCode())) {
                        resp.sendRedirect(req.getContextPath() + "/result?action=new&error=result_already_exists");
                    } else if (resultDao.addResult(newResult)) {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&message=result_added");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/result?action=new&error=add_failed");
                    }
                    break;

                case "updateResult":
                    Result updatedResult = new Result(
                            req.getParameter("teacherName"),
                            req.getParameter("courseTitle"),
                            req.getParameter("courseCode"),
                            req.getParameter("studentEnrollmentNo"),
                            parseIntegerRequired(req.getParameter("sessionalMarks")), // Mandatory
                            parseIntegerOptional(req.getParameter("midMarks")), // Optional
                            parseIntegerOptional(req.getParameter("finalMarks")) // Optional
                    );

                    if (resultDao.updateResult(updatedResult)) {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&message=result_updated");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/result?action=viewAll&error=update_failed");
                    }
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/result?action=viewAll");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/result?action=new&error=invalid_marks");
        }
    }

    /**
     * Parse integer that is required (throws exception if null/empty)
     */
    private Integer parseIntegerRequired(String value) throws NumberFormatException {
        if (value == null || value.trim().isEmpty()) {
            throw new NumberFormatException("Required field is empty");
        }
        return Integer.parseInt(value.trim());
    }

    /**
     * Parse integer that is optional (returns null if empty)
     */
    private Integer parseIntegerOptional(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}