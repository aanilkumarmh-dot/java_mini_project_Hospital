package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HospitalDAO dao = new HospitalDAO();
            req.setAttribute("ailmentList", dao.getAllAilments());
            req.setAttribute("doctorList", dao.getAllDoctors());
            req.getRequestDispatcher("reports.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("index.jsp?error=" + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String reportType = req.getParameter("reportType");
            HospitalDAO dao = new HospitalDAO();
            List<Patient> results = null;
            
            if ("dateRange".equals(reportType)) {
                Date start = Date.valueOf(req.getParameter("startDate"));
                Date end = Date.valueOf(req.getParameter("endDate"));
                results = dao.getPatientsByDateRange(start, end);
                req.setAttribute("reportTitle", "Patients admitted from " + start + " to " + end);
            } else if ("ailment".equals(reportType)) {
                String ailment = req.getParameter("ailment");
                results = dao.getPatientsByAilment(ailment);
                req.setAttribute("reportTitle", "Patients with Ailment: " + ailment);
            } else if ("doctor".equals(reportType)) {
                String doctor = req.getParameter("doctor");
                results = dao.getPatientsByDoctor(doctor);
                req.setAttribute("reportTitle", "Patients assigned to: " + doctor);
            }
            
            req.setAttribute("patientList", results);
            req.getRequestDispatcher("report_result.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("reports?error=" + e.getMessage());
        }
    }
}