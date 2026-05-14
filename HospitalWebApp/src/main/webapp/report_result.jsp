<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results - Hospital Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
       .result-container {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
       .result-header {
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid #7c3aed;
        }
       .result-header h2 {
            color: #7c3aed;
            margin-bottom: 8px;
        }
       .result-header p {
            color: #666;
            font-size: 15px;
        }
       .result-count {
            background: #f3e8ff;
            color: #7c3aed;
            padding: 10px 20px;
            border-radius: 8px;
            display: inline-block;
            font-weight: 600;
            margin-bottom: 20px;
        }
       .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
       .btn-back {
            padding: 10px 20px;
            background: #7c3aed;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
        }
       .btn-back:hover { opacity: 0.9; }
       .btn-print {
            padding: 10px 20px;
            background: #059669;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }
       .btn-print:hover { opacity: 0.9; }
       .result-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
       .result-table th {
            background: #7c3aed;
            color: white;
            padding: 12px 8px;
            text-align: left;
            font-weight: 600;
        }
       .result-table td {
            padding: 10px 8px;
            border-bottom: 1px solid #eee;
        }
       .result-table tr:hover {
            background: #f8f9ff;
        }
       .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
       @media print {
           .header, .action-bar, .btn-back, .btn-print { display: none; }
           .result-container { box-shadow: none; margin: 0; }
       }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏥 Hospital Management System</h1>
        <p>Manage Patients Efficiently & Smartly</p>
    </div>

    <div class="container">
        <div class="result-container">
            <div class="result-header">
                <h2>📊 Report Results</h2>
                <p><%= request.getAttribute("reportTitle") %></p>
            </div>

            <div class="action-bar">
                <a href="reports" class="btn-back">← Back to Reports</a>
                <button onclick="window.print()" class="btn-print">🖨️ Print Report</button>
            </div>

            <% 
            List<Patient> patientList = (List<Patient>) request.getAttribute("patientList");
            int count = (patientList!= null) ? patientList.size() : 0;
            %>
            
            <div class="result-count">
                Total Records Found: <%= count %>
            </div>

            <table class="result-table">
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
                    <% 
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
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="9" class="no-data">
                            No records found matching your criteria.<br>
                            <a href="reports">Try a different filter</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>