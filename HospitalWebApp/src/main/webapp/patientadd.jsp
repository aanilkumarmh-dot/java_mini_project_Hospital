<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient - Hospital Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
 .form-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
 .form-container h2 {
            text-align: center;
            color: #1e90ff;
            margin-bottom: 25px;
        }
 .form-group {
            margin-bottom: 18px;
        }
 .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }
 .form-group input,.form-group select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
 .form-group input:focus,.form-group select:focus {
            outline: none;
            border-color: #1e90ff;
            box-shadow: 0 0 0 3px rgba(30,144,255,0.1);
        }
 .form-group input[readonly] {
            background: #f5f5f5;
            color: #059669;
            font-weight: 600;
        }
 .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(90deg, #1e90ff, #0077e6);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }
 .btn-submit:hover { opacity: 0.9; }
 .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #1e90ff;
            text-decoration: none;
            font-weight: 600;
        }
 .back-link:hover { text-decoration: underline; }
 .msg { text-align: center; padding: 10px; border-radius: 8px; margin-bottom: 20px; }
 .msg-error { background: #fee; color: #c00; }
 .msg-success { background: #efe; color: #060; }
    </style>
    <script>
        function calculateAge() {
            const dob = document.getElementById('dob').value;
            if (dob) {
                const birthDate = new Date(dob);
                const today = new Date();
                let age = today.getFullYear() - birthDate.getFullYear();
                const m = today.getMonth() - birthDate.getMonth();
                if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                    age--;
                }
                document.getElementById('age').value = age;
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <h1>🏥 Hospital Management System</h1>
        <p>Manage Patients Efficiently & Smartly</p>
    </div>

    <div class="container">
        <div class="form-container">
            <a href="index.jsp" class="back-link">← Back to Home</a>
            <h2>➕ Add New Patient</h2>

            <% String error = request.getParameter("error"); String msg = request.getParameter("msg"); %>
            <% if (error!= null) { %><div class="msg msg-error"><%= error %></div><% } %>
            <% if (msg!= null) { %><div class="msg msg-success"><%= msg %></div><% } %>

            <form action="patientadd" method="post">
                <div class="form-group">
                    <label>Patient ID</label>
                    <input type="number" name="patientId" value="<%= request.getAttribute("nextPatientID") %>" readonly>
                    <small style="color: #6b7280;">Auto-generated</small>
                </div>

                <div class="form-group">
                    <label>Patient Name *</label>
                    <input type="text" name="patientName" required>
                </div>

                <div class="form-group">
                    <label>Date of Birth *</label>
                    <input type="date" name="dob" id="dob" onchange="calculateAge()" required>
                </div>

                <div class="form-group">
                    <label>Age</label>
                    <input type="number" name="age" id="age" readonly required>
                </div>

                <div class="form-group">
                    <label>Gender *</label>
                    <select name="gender" required>
                        <option value="">Select Gender</option>
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Weight (kg) *</label>
                    <input type="number" step="0.1" name="weight" required>
                </div>

                <div class="form-group">
                    <label>Admission Date *</label>
                    <input type="date" name="admissionDate" value="<%= LocalDate.now() %>" required>
                </div>

                <div class="form-group">
                    <label>Ailment *</label>
                    <select name="ailment" required>
                        <option value="">Select Ailment</option>
                        <% List<String> ailmentList = (List<String>) request.getAttribute("ailmentList");
                           if (ailmentList!= null) {
                               for (String a : ailmentList) { %>
                        <option value="<%= a %>"><%= a %></option>
                        <% } } %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Assigned Doctor *</label>
                    <select name="assignedDoctor" required>
                        <option value="">Select Doctor</option>
                        <% List<String> doctorList = (List<String>) request.getAttribute("doctorList");
                           if (doctorList!= null) {
                               for (String d : doctorList) { %>
                        <option value="<%= d %>"><%= d %></option>
                        <% } } %>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Add Patient</button>
            </form>
        </div>
    </div>
</body>
</html>