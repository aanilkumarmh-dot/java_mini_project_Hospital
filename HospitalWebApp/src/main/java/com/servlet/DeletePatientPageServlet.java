package com.servlet;

import com.dao.HospitalDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deletepatient")
public class DeletePatientPageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HospitalDAO dao = new HospitalDAO();
            req.setAttribute("patientList", dao.getAllPatients());
            req.getRequestDispatcher("deletepatient.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("index.jsp?error=" + e.getMessage());
        }
    }
}