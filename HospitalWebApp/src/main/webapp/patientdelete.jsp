<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Patient</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body { font-family: Arial; margin: 20px; }
        select { padding: 8px; margin: 10px; width: 400px; }
        input[type="submit"] { padding: 10px 20px; background: #f44336; color: white; border: none; cursor: pointer; }
        input[type="submit"]:hover { background: #d32f2f; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Delete Patient</h2>
    <a href="index.jsp">Home</a> | <a href="viewAllPatients">View All Patients</a><br><br>
    
    <% 
    String error = request.getParameter("error"); 
    if(error != null) { 
    %>
        <p style="color:red; font-weight:bold;">Error: <%= error %></p>
    <% } %>
    
    <h3>Select Patient to Delete</h3>
    <form action="deletePatient" method="post" onsubmit="return confirm('Are you sure you want to delete this patient? This action cannot be undone.');">
        <select name="patientId" required>
            <option value="">--Select Patient--</option>
            <% 
            List<Patient> list = (List<Patient>) request.getAttribute("patientList");
            if(list != null && !list.isEmpty()) {
                for(Patient p : list) { 
            %>
                    <option value="<%= p.getPatientID() %>">
                        ID: <%= p.getPatientID() %> | Name: <%= p.getPatientName() %> | Age: <%= p.getAge() %> | Ailment: <%= p.getAilment() %>
                    </option>
            <% 
                }
            } else { 
            %>
                <option value="" disabled>No patients found in database</option>
            <% } %>
        </select>
        <br><br>
        <input type="submit" value="Delete Patient">
    </form>
    
    <% if(list != null && !list.isEmpty()) { %>
    <h3>All Patients</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Ailment</th>
            <th>Doctor</th>
            <th>Admission Date</th>
        </tr>
        <% for(Patient p : list) { %>
        <tr>
            <td><%= p.getPatientID() %></td>
            <td><%= p.getPatientName() %></td>
            <td><%= p.getAge() %></td>
            <td><%= p.getGender() %></td>
            <td><%= p.getAilment() %></td>
            <td><%= p.getAssignedDoctor() %></td>
            <td><%= p.getAdmissionDate() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
    
</body>
</html>