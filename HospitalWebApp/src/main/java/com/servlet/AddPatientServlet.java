package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/patientadd")
public class AddPatientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HospitalDAO dao = new HospitalDAO();
            req.setAttribute("ailmentList", dao.getAllAilments());
            req.setAttribute("doctorList", dao.getAllDoctors());
            req.setAttribute("nextPatientID", dao.getNextPatientID()); // <-- ADD THIS LINE
            req.getRequestDispatcher("patientadd.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("index.jsp?error=" + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Patient p = new Patient();
            p.setPatientName(req.getParameter("patientName"));
            p.setAge(Integer.parseInt(req.getParameter("age")));
            p.setGender(req.getParameter("gender"));
            p.setDob(Date.valueOf(req.getParameter("dob")));
            p.setWeight(Double.parseDouble(req.getParameter("weight")));
            p.setAdmissionDate(Date.valueOf(req.getParameter("admissionDate")));
            p.setAilment(req.getParameter("ailment"));
            p.setAssignedDoctor(req.getParameter("assignedDoctor"));

            HospitalDAO dao = new HospitalDAO();
            dao.addPatient(p); // Changed: addPatient returns void, not int
            res.sendRedirect("patientdisplay?msg=Patient Added Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("patientadd?error=" + e.getMessage());
        }
    }
}