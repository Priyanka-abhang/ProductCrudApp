<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String idToDelete = request.getParameter("id");

    if (idToDelete != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            String dbUrl = "jdbc:mysql://localhost:3306/demo";
            String dbUsername = "root";
            String dbPassword = "Priyanka";

            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String deleteQuery = "DELETE FROM products WHERE id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setString(1, idToDelete);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("index.jsp"); // Redirect back to the main product list
            } else {
                out.println("<p style='color: red;'>Failed to delete product.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
