<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <h2>Generate Reports</h2>
    
    <h4>Date Range Report</h4>
    <form action="ReportServlet" method="get">
        <input type="hidden" name="reportType" value="dateRange">
        Start Date: <input type="date" name="startDate" required>
        End Date: <input type="date" name="endDate" required>
        <input type="submit" value="Generate" class="btn btn-primary">
    </form>
    <hr>
    
    <h4>Ailment Report</h4>
    <form action="ReportServlet" method="get">
        <input type="hidden" name="reportType" value="ailment">
        Ailment: <input type="text" name="ailment" required>
        <input type="submit" value="Generate" class="btn btn-primary">
    </form>
    <hr>
    
    <h4>Doctor Report</h4>
    <form action="ReportServlet" method="get">
        <input type="hidden" name="reportType" value="doctor">
        Doctor: <input type="text" name="doctor" required>
        <input type="submit" value="Generate" class="btn btn-primary">
    </form>
</body>
</html>