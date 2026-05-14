<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body { font-family: Arial; margin: 20px; }
        .report-box { border: 1px solid #ddd; padding: 20px; margin: 15px 0; border-radius: 5px; background: #f9f9f9; }
        h3 { color: #4CAF50; margin-top: 0; }
        input, select { padding: 8px; margin: 5px; width: 250px; }
        input[type="submit"] { width: auto; background: #4CAF50; color: white; border: none; cursor: pointer; padding: 10px 20px; }
        input[type="submit"]:hover { background: #45a049; }
        .nav { margin-bottom: 20px; }
        .nav a { margin-right: 15px; text-decoration: none; color: #4CAF50; font-weight: bold; }
    </style>
    <script>
        function toggleReport(type) {
            document.getElementById('dateForm').style.display = 'none';
            document.getElementById('ailmentForm').style.display = 'none';
            document.getElementById('doctorForm').style.display = 'none';
            document.getElementById(type + 'Form').style.display = 'block';
        }
    </script>
</head>
<body onload="toggleReport('date')">
    <h2>Generate Patient Reports</h2>
    
    <div class="nav">
        <a href="index.jsp">Home</a>
        <a href="addPatient">Add Patient</a>
        <a href="displayPatients">View All Patients</a>
        <a href="updatePatient">Update Patient</a>
        <a href="deletePatient">Delete Patient</a>
    </div>
    
    <% String error = request.getParameter("error"); 
       if(error != null) { %>
        <p style="color:red; font-weight:bold;">Error: <%= error %></p>
    <% } %>
    
    <h3>Select Report Type:</h3>
    <input type="radio" name="report" value="date" onclick="toggleReport('date')" checked> By Date Range
    <input type="radio" name="report" value="ailment" onclick="toggleReport('ailment')"> By Ailment
    <input type="radio" name="report" value="doctor" onclick="toggleReport('doctor')"> By Doctor
    
    <!-- Report 1: By Date Range -->
    <div id="dateForm" class="report-box">
        <h3>Report 1: Patients Admitted in Date Range</h3>
        <form action="generateReport" method="post">
            <input type="hidden" name="reportType" value="date">
            <b>Start Date:</b> <input type="date" name="startDate" required><br><br>
            <b>End Date:</b> <input type="date" name="endDate" required><br><br>
            <input type="submit" value="Generate Report">
        </form>
    </div>
    
    <!-- Report 2: By Ailment -->
    <div id="ailmentForm" class="report-box" style="display:none;">
        <h3>Report 2: Patients with Specific Ailment</h3>
        <form action="generateReport" method="post">
            <input type="hidden" name="reportType" value="ailment">
            <b>Select Ailment:</b> 
            <select name="ailment" required>
                <option value="">--Select Ailment--</option>
                <% 
                List<String> ailmentList = (List<String>) request.getAttribute("ailmentList");
                if(ailmentList != null) {
                    for(String a : ailmentList) { 
                %>
                        <option value="<%= a %>"><%= a %></option>
                <% 
                    }
                } 
                %>
            </select><br><br>
            <input type="submit" value="Generate Report">
        </form>
    </div>
    
    <!-- Report 3: By Doctor -->
    <div id="doctorForm" class="report-box" style="display:none;">
        <h3>Report 3: Patients Assigned to Specific Doctor</h3>
        <form action="generateReport" method="post">
            <input type="hidden" name="reportType" value="doctor">
            <b>Select Doctor:</b> 
            <select name="doctor" required>
                <option value="">--Select Doctor--</option>
                <% 
                List<String> doctorList = (List<String>) request.getAttribute("doctorList");
                if(doctorList != null) {
                    for(String d : doctorList) { 
                %>
                        <option value="<%= d %>"><%= d %></option>
                <% 
                    }
                } 
                %>
            </select><br><br>
            <input type="submit" value="Generate Report">
        </form>
    </div>
    
</body>
</html>