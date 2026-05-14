<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Patient - Hospital Management System</title>
    <style>
        body { font-family: Arial; background: #f5f5f5; margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        h2 { text-align: center; color: #dc2626; margin-bottom: 25px; }
        .form-section { max-width: 500px; margin: 0 auto 30px auto; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; }
        input[type="number"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 16px; box-sizing: border-box; }
        .btn-delete { width: 100%; padding: 12px; background: #dc2626; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; }
        .btn-delete:hover { background: #b91c1c; }
        .back-link { color: #1e90ff; text-decoration: none; font-weight: 600; display: inline-block; margin-bottom: 20px; }
        .back-link:hover { text-decoration: underline; }
        .msg { padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
        .msg-error { background: #fee; color: #c00; }
        .msg-success { background: #efe; color: #060; }
        .patient-table { width: 100%; border-collapse: collapse; font-size: 13px; margin-top: 20px; }
        .patient-table th { background: #1e90ff; color: white; padding: 10px 6px; text-align: left; font-weight: 600; }
        .patient-table td { padding: 8px 6px; border-bottom: 1px solid #eee; }
        .patient-table tr:hover { background: #f8f9ff; }
        h3 { margin-top: 30px; color: #333; }
    </style>
</head>
<body>
    <div class="container">
        <a href="patientdisplay" class="back-link">← Back to Patient List</a>
        <h2>🗑️ Delete Patient</h2>
        
        <% String error = request.getParameter("error"); %>
        <% if(error != null) { %>
            <div class="msg msg-error">Error: <%= error %></div>
        <% } %>
        
        <div class="form-section">
            <form action="deletepatientaction" method="post" onsubmit="return confirm('Delete Patient ID ' + document.getElementById('pid').value + '? This cannot be undone.');">
                <div class="form-group">
                    <label>Enter Patient ID to Delete:</label>
                    <input type="number" name="patientId" id="pid" required placeholder="Enter Patient ID">
                </div>
                <button type="submit" class="btn-delete">Delete Patient</button>
            </form>
        </div>

        <h3>Available Patients</h3>
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
                </tr>
            </thead>
            <tbody>
                <% List<Patient> list = (List<Patient>) request.getAttribute("patientList");
                   if(list != null && !list.isEmpty()) {
                       for(Patient p : list) { %>
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
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="9" style="text-align:center; padding:20px;">No patients found</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>