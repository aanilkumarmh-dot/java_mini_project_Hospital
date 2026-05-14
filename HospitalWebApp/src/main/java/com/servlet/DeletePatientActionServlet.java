package com.servlet;

import com.dao.HospitalDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deletepatientaction")
public class DeletePatientActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("patientId"));
            HospitalDAO dao = new HospitalDAO();
            
            if (dao.deletePatient(id) > 0) {
                res.sendRedirect("patientdisplay?msg=Patient ID " + id + " Deleted Successfully");
            } else {
                res.sendRedirect("deletepatient?error=Patient ID " + id + " Not Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("deletepatient?error=" + e.getMessage());
        }
    }
}