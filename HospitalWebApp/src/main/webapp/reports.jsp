<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports - Hospital Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
       .reports-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
       .reports-container h2 {
            text-align: center;
            color: #7c3aed;
            margin-bottom: 30px;
        }
       .report-section {
            background: #f8f9ff;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid #7c3aed;
        }
       .report-section h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
       .form-row {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
        }
       .form-group {
            flex: 1;
            min-width: 200px;
        }
       .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
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
            border-color: #7c3aed;
            box-shadow: 0 0 0 3px rgba(124,58,237,0.1);
        }
       .btn-generate {
            padding: 10px 25px;
            background: linear-gradient(90deg, #7c3aed, #6d28d9);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            height: 42px;
        }
       .btn-generate:hover { opacity: 0.9; }
       .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #7c3aed;
            text-decoration: none;
            font-weight: 600;
        }
       .back-link:hover { text-decoration: underline; }
       .msg { text-align: center; padding: 10px; border-radius: 8px; margin-bottom: 20px; }
       .msg-error { background: #fee; color: #c00; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏥 Hospital Management System</h1>
        <p>Manage Patients Efficiently & Smartly</p>
    </div>

    <div class="container">
        <div class="reports-container">
            <a href="index.jsp" class="back-link">← Back to Home</a>
            <h2>📊 Patient Reports</h2>

            <% String error = request.getParameter("error"); %>
            <% if (error!= null) { %><div class="msg msg-error"><%= error %></div><% } %>

            <% 
            List<String> ailmentList = (List<String>) request.getAttribute("ailmentList");
            List<String> doctorList = (List<String>) request.getAttribute("doctorList");
            %>

            <!-- Report 1: Date Range -->
            <div class="report-section">
                <h3>1️⃣ Patients Admitted in Date Range</h3>
                <form action="reports" method="post">
                    <input type="hidden" name="reportType" value="dateRange">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Start Date *</label>
                            <input type="date" name="startDate" required>
                        </div>
                        <div class="form-group">
                            <label>End Date *</label>
                            <input type="date" name="endDate" required>
                        </div>
                        <button type="submit" class="btn-generate">Generate Report</button>
                    </div>
                </form>
            </div>

            <!-- Report 2: Specific Ailment -->
            <div class="report-section">
                <h3>2️⃣ Patients with Specific Ailment</h3>
                <form action="reports" method="post">
                    <input type="hidden" name="reportType" value="ailment">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Select Ailment *</label>
                            <select name="ailment" required>
                                <option value="">-- Select Ailment --</option>
                                <% if (ailmentList!= null) { 
                                       for (String a : ailmentList) { %>
                                <option value="<%= a %>"><%= a %></option>
                                <% } } %>
                            </select>
                        </div>
                        <button type="submit" class="btn-generate">Generate Report</button>
                    </div>
                </form>
            </div>

            <!-- Report 3: Specific Doctor -->
            <div class="report-section">
                <h3>3️⃣ Patients Assigned to Specific Doctor</h3>
                <form action="reports" method="post">
                    <input type="hidden" name="reportType" value="doctor">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Select Doctor *</label>
                            <select name="doctor" required>
                                <option value="">-- Select Doctor --</option>
                                <% if (doctorList!= null) { 
                                       for (String d : doctorList) { %>
                                <option value="<%= d %>"><%= d %></option>
                                <% } } %>
                            </select>
                        </div>
                        <button type="submit" class="btn-generate">Generate Report</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>