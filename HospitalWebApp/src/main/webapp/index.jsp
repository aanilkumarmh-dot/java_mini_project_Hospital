<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Management System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="header">
        <h1>🏥 Hospital Management System</h1>
        <p>Manage Patients Efficiently & Smartly</p>
    </div>

    <div class="container">
        <% String msg = request.getParameter("msg"); String error = request.getParameter("error"); %>
        <% if (msg != null) { %><p style="color:green; text-align:center; margin-bottom:20px;"><%= msg %></p><% } %>
        <% if (error != null) { %><p style="color:red; text-align:center; margin-bottom:20px;"><%= error %></p><% } %>

        <div class="card-grid">
            <a href="patientadd" class="card">
                <span class="icon icon-blue">➕</span>
                <h3>Add Patient</h3>
                <p>Register new patient details</p>
            </a>

            <a href="patientdisplay" class="card">
                <span class="icon icon-green">📋</span>
                <h3>View Patients</h3>
                <p>View all registered patients</p>
            </a>

            <a href="patientdisplay" class="card">
                <span class="icon icon-orange">✏️</span>
                <h3>Update Patient</h3>
                <p>Edit patient information</p>
            </a>

            <a href="patientdisplay" class="card">
                <span class="icon icon-gray">🗑️</span>
                <h3>Delete Patient</h3>
                <p>Remove patient records</p>
            </a>

            <a href="reports" class="card">
                <span class="icon icon-purple">📊</span>
                <h3>Reports</h3>
                <p>Generate patient reports</p>
            </a>
        </div>
    </div>
</body>
</html>