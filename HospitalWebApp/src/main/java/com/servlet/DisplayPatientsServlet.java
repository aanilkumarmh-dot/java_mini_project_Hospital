package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/patientdisplay")
public class DisplayPatientsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HospitalDAO dao = new HospitalDAO();
            List<Patient> patientList = dao.getAllPatients();
            req.setAttribute("patientList", patientList);
            req.getRequestDispatcher("patientdisplay.jsp").forward(req, res);
        } catch(Exception e) {
            e.printStackTrace();
            res.sendRedirect("index.jsp?error=" + e.getMessage());
        }
    }
}