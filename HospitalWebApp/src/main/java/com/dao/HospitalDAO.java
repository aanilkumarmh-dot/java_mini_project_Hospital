package com.dao;

import com.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/hospitaldb";
    private String jdbcUser = "root";
    private String jdbcPass = "root"; // CHANGE YOUR PASSWORD
    
    static {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); } 
        catch (ClassNotFoundException e) { e.printStackTrace(); }
    }
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);
    }
    
    // FIXED: Use MAX + 1 instead of AUTO_INCREMENT - more reliable
    public int getNextPatientID() throws SQLException {
        String sql = "SELECT COALESCE(MAX(PatientID), 0) + 1 FROM patients";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 1;
    }
    
    public int addPatient(Patient p) throws SQLException {
        String sql = "INSERT INTO patients (PatientName, Age, Gender, DOB, Weight, AdmissionDate, Ailment, AssignedDoctor) VALUES (?,?,?,?,?,?,?,?)";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getPatientName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setDate(4, p.getDob());
            ps.setDouble(5, p.getWeight());
            ps.setDate(6, p.getAdmissionDate());
            ps.setString(7, p.getAilment());
            ps.setString(8, p.getAssignedDoctor());
            return ps.executeUpdate();
        }
    }
    
    public int updatePatient(Patient p) throws SQLException {
        String sql = "UPDATE patients SET PatientName=?, Age=?, Gender=?, DOB=?, Weight=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getPatientName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setDate(4, p.getDob());
            ps.setDouble(5, p.getWeight());
            ps.setDate(6, p.getAdmissionDate());
            ps.setString(7, p.getAilment());
            ps.setString(8, p.getAssignedDoctor());
            ps.setInt(9, p.getPatientID());
            return ps.executeUpdate();
        }
    }
    
    public int deletePatient(int id) throws SQLException {
        String sql = "DELETE FROM patients WHERE PatientID=?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        }
    }
    
    public List<Patient> getAllPatients() throws SQLException {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY PatientID DESC";
        try(Connection con = getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) list.add(mapRowToPatient(rs));
        }
        return list;
    }
    
    public Patient getPatientById(int id) throws SQLException {
        String sql = "SELECT * FROM patients WHERE PatientID=?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return mapRowToPatient(rs);
        }
        return null;
    }
    
    public List<String> getAllAilments() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT AilmentName FROM ailments ORDER BY AilmentName";
        try(Connection con = getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) list.add(rs.getString("AilmentName"));
        }
        return list;
    }
    
    public List<String> getAllDoctors() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DoctorName FROM doctors ORDER BY DoctorName";
        try(Connection con = getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) list.add(rs.getString("DoctorName"));
        }
        return list;
    }
    
    public List<Patient> getPatientsByDateRange(Date start, Date end) throws SQLException {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE AdmissionDate BETWEEN ? AND ?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, start); ps.setDate(2, end);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(mapRowToPatient(rs));
        }
        return list;
    }
    
    public List<Patient> getPatientsByAilment(String ailment) throws SQLException {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE Ailment=?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, ailment);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(mapRowToPatient(rs));
        }
        return list;
    }
    
    public List<Patient> getPatientsByDoctor(String doctor) throws SQLException {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE AssignedDoctor=?";
        try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, doctor);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(mapRowToPatient(rs));
        }
        return list;
    }
    
    private Patient mapRowToPatient(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setPatientID(rs.getInt("PatientID"));
        p.setPatientName(rs.getString("PatientName"));
        p.setAge(rs.getInt("Age"));
        p.setGender(rs.getString("Gender"));
        p.setDob(rs.getDate("DOB"));
        p.setWeight(rs.getDouble("Weight"));
        p.setAdmissionDate(rs.getDate("AdmissionDate"));
        p.setAilment(rs.getString("Ailment"));
        p.setAssignedDoctor(rs.getString("AssignedDoctor"));
        return p;
    }
}