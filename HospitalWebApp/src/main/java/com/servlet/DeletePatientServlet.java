package com.servlet;

import com.dao.HospitalDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/patientdelete")
public class DeletePatientServlet extends HttpServlet {
    
    // GET: For delete links from table like ?id=4
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            deletePatient(id, req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("patientdisplay?error=" + e.getMessage());
        }
    }

    // POST: For delete form with dropdown
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("patientId"));
            deletePatient(id, req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("deletepatient?error=" + e.getMessage());
        }
    }
    
    private void deletePatient(int id, HttpServletRequest req, HttpServletResponse res) throws Exception {
        HospitalDAO dao = new HospitalDAO();
        if (dao.deletePatient(id) > 0) {
            res.sendRedirect("patientdisplay?msg=Patient ID " + id + " Deleted Successfully");
        } else {
            res.sendRedirect("patientdisplay?error=Failed to delete Patient ID " + id);
        }
    }
}