<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Patient - Hospital Management System</title>
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
            color: #ea580c;
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
            border-color: #ea580c;
            box-shadow: 0 0 0 3px rgba(234,88,12,0.1);
        }
      .form-group input[readonly] {
            background: #f5f5f5;
        }
      .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(90deg, #ea580c, #c2410c);
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
            color: #ea580c;
            text-decoration: none;
            font-weight: 600;
        }
      .back-link:hover { text-decoration: underline; }
      .msg { text-align: center; padding: 10px; border-radius: 8px; margin-bottom: 20px; }
      .msg-error { background: #fee; color: #c00; }
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
            <a href="patientdisplay" class="back-link">← Back to Patient List</a>
            <h2>✏️ Update Patient Details</h2>

            <% String error = request.getParameter("error"); %>
            <% if (error!= null) { %><div class="msg msg-error"><%= error %></div><% } %>

            <% 
            Patient p = (Patient) request.getAttribute("patient");
            List<String> ailmentList = (List<String>) request.getAttribute("ailmentList");
            List<String> doctorList = (List<String>) request.getAttribute("doctorList");
            
            if(p == null) { %>
                <div class="msg msg-error">Patient not found!</div>
            <% } else { %>
            
            <form action="patientupdate" method="post">
                <input type="hidden" name="patientID" value="<%= p.getPatientID() %>">
                
                <div class="form-group">
                    <label>Patient ID</label>
                    <input type="text" value="<%= p.getPatientID() %>" readonly>
                </div>

                <div class="form-group">
                    <label>Patient Name *</label>
                    <input type="text" name="patientName" value="<%= p.getPatientName() %>" required>
                </div>

                <div class="form-group">
                    <label>Date of Birth *</label>
                    <input type="date" name="dob" id="dob" value="<%= p.getDob() %>" onchange="calculateAge()" required>
                </div>

                <div class="form-group">
                    <label>Age</label>
                    <input type="number" name="age" id="age" value="<%= p.getAge() %>" readonly required>
                </div>

                <div class="form-group">
                    <label>Gender *</label>
                    <select name="gender" required>
                        <option value="Male" <%= "Male".equals(p.getGender())?"selected":"" %>>Male</option>
                        <option value="Female" <%= "Female".equals(p.getGender())?"selected":"" %>>Female</option>
                        <option value="Other" <%= "Other".equals(p.getGender())?"selected":"" %>>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Weight (kg) *</label>
                    <input type="number" step="0.1" name="weight" value="<%= p.getWeight() %>" required>
                </div>

                <div class="form-group">
                    <label>Admission Date *</label>
                    <input type="date" name="admissionDate" value="<%= p.getAdmissionDate() %>" required>
                </div>

                <div class="form-group">
                    <label>Ailment *</label>
                    <select name="ailment" required>
                        <% if (ailmentList!= null) { 
                               for (String a : ailmentList) { %>
                        <option value="<%= a %>" <%= a.equals(p.getAilment())?"selected":"" %>><%= a %></option>
                        <% } } %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Assigned Doctor *</label>
                    <select name="assignedDoctor" required>
                        <% if (doctorList!= null) { 
                               for (String d : doctorList) { %>
                        <option value="<%= d %>" <%= d.equals(p.getAssignedDoctor())?"selected":"" %>><%= d %></option>
                        <% } } %>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Update Patient</button>
            </form>
            <% } %>
        </div>
    </div>
</body>
</html>