<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Patients - Hospital Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
       .table-container {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
       .table-container h2 {
            text-align: center;
            color: #1e90ff;
            margin-bottom: 25px;
        }
       .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
       .btn-add {
            padding: 10px 20px;
            background: linear-gradient(90deg, #1e90ff, #0077e6);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
        }
       .btn-add:hover { opacity: 0.9; }
       .back-link {
            color: #1e90ff;
            text-decoration: none;
            font-weight: 600;
        }
       .back-link:hover { text-decoration: underline; }
       .patient-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
       .patient-table th {
            background: #1e90ff;
            color: white;
            padding: 12px 8px;
            text-align: left;
            font-weight: 600;
        }
       .patient-table td {
            padding: 10px 8px;
            border-bottom: 1px solid #eee;
        }
       .patient-table tr:hover {
            background: #f8f9ff;
        }
       .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            margin-right: 5px;
        }
       .btn-edit {
            background: #ea580c;
            color: white;
        }
       .btn-edit:hover { background: #c2410c; }
       .btn-delete {
            background: #dc2626;
            color: white;
        }
       .btn-delete:hover { background: #b91c1c; }
       .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
       .msg { text-align: center; padding: 12px; border-radius: 8px; margin-bottom: 20px; }
       .msg-error { background: #fee; color: #c00; }
       .msg-success { background: #efe; color: #060; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏥 Hospital Management System</h1>
        <p>Manage Patients Efficiently & Smartly</p>
    </div>

    <div class="container">
        <div class="table-container">
            <div class="table-header">
                <a href="index.jsp" class="back-link">← Back to Home</a>
                <h2>📋 All Registered Patients</h2>
                <a href="patientadd" class="btn-add">➕ Add New Patient</a>
            </div>

            <% String msg = request.getParameter("msg"); String error = request.getParameter("error"); %>
            <% if (msg!= null) { %><div class="msg msg-success"><%= msg %></div><% } %>
            <% if (error!= null) { %><div class="msg msg-error"><%= error %></div><% } %>

            <table class="patient-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>DOB</th>
                        <th>Weight</th>
                        <th>Admission</th>
                        <th>Ailment</th>
                        <th>Doctor</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<Patient> patientList = (List<Patient>) request.getAttribute("patientList");
                    if(patientList!= null &&!patientList.isEmpty()) {
                        for(Patient p : patientList) { 
                    %>
                    <tr>
                        <td><%= p.getPatientID() %></td>
                        <td><%= p.getPatientName() %></td>
                        <td><%= p.getAge() %></td>
                        <td><%= p.getGender() %></td>
                        <td><%= p.getDob() %></td>
                        <td><%= p.getWeight() %> kg</td>
                        <td><%= p.getAdmissionDate() %></td>
                        <td><%= p.getAilment() %></td>
                        <td><%= p.getAssignedDoctor() %></td>
                        <td>
                            <a href="patientupdate?id=<%= p.getPatientID() %>" class="action-btn btn-edit">✏️ Edit</a>
                            <a href="deletepatient" class="action-btn btn-delete">🗑️ Delete Patient</a>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="10" class="no-data">No patients found. <a href="patientadd">Add the first patient</a></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>