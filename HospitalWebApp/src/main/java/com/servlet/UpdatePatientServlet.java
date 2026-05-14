package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/patientupdate")
public class UpdatePatientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            HospitalDAO dao = new HospitalDAO();
            req.setAttribute("patient", dao.getPatientById(id));
            req.setAttribute("ailmentList", dao.getAllAilments());
            req.setAttribute("doctorList", dao.getAllDoctors());
            req.getRequestDispatcher("patientupdate.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("patientdisplay?error=" + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Patient p = new Patient();
            p.setPatientID(Integer.parseInt(req.getParameter("patientID")));
            p.setPatientName(req.getParameter("patientName"));
            p.setAge(Integer.parseInt(req.getParameter("age")));
            p.setGender(req.getParameter("gender"));
            p.setDob(Date.valueOf(req.getParameter("dob")));
            p.setWeight(Double.parseDouble(req.getParameter("weight")));
            p.setAdmissionDate(Date.valueOf(req.getParameter("admissionDate")));
            p.setAilment(req.getParameter("ailment"));
            p.setAssignedDoctor(req.getParameter("assignedDoctor"));

            HospitalDAO dao = new HospitalDAO();
            if (dao.updatePatient(p) > 0) {
                res.sendRedirect("patientdisplay?msg=Patient Updated Successfully");
            } else {
                res.sendRedirect("patientdisplay?error=Failed to update");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("patientdisplay?error=" + e.getMessage());
        }
    }
}