<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <link rel="stylesheet" href="update.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Custom Theme files -->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!-- web font -->
    <link href="//fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,700,700i" rel="stylesheet">
</head>
<body>
    <%
        String id = request.getParameter("id"); // Get the product ID from the query parameter
        String productName = "";
        String description = "";
        String price = "";

        if (id != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                // Database connection details
                String dbUrl = "jdbc:mysql://localhost:3306/demo"; // Replace with your DB URL
                String dbUsername = "root"; // Replace with your DB username
                String dbPassword = "Priyanka"; // Replace with your DB password
                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                String selectQuery = "SELECT * FROM products WHERE id = ?";
                stmt = conn.prepareStatement(selectQuery);
                stmt.setString(1, id);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    productName = rs.getString("name");
                    description = rs.getString("description");
                    price = rs.getString("price");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <!-- Main form structure -->
    <div class="main-w3layouts wrapper">
        <h1>Update Product</h1>
        <div class="main-agileinfo">
            <div class="agileits-top">
                <!-- Form to submit updated product details -->
                <form action="update.jsp" method="post">
                    <!-- Hidden field to store product ID -->
                    <input type="hidden" name="id" value="<%= id %>">
                    
                    <!-- Pre-fill the fields with existing values -->
                    <input class="text" type="text" name="productname" placeholder="Product name" 
                           value="<%= productName %>" required="">
                    <input class="text" type="text" name="disc" placeholder="Description" 
                           value="<%= description %>" required="">
                    <input class="text" type="text" name="price" placeholder="Price" 
                           value="<%= price %>" required="">
                    
                    <div class="wthree-text">
                        <div class="clear"> </div>
                    </div>
                    <input type="submit" value="Update">
                </form>
            </div>
        </div>
    </div>

    <%
        // Handle form submission for updating the product
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String productId = request.getParameter("id");
            String updatedName = request.getParameter("productname");
            String updatedDescription = request.getParameter("disc");
            String updatedPrice = request.getParameter("price");

            if (productId != null && updatedName != null && updatedDescription != null && updatedPrice != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                try {
                    String dbUrl = "jdbc:mysql://localhost:3306/demo"; // Replace with your DB URL
                    String dbUsername = "root"; // Replace with your DB username
                    String dbPassword = "Priyanka"; // Replace with your DB password
                    conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                    String updateQuery = "UPDATE products SET name = ?, description = ?, price = ? WHERE id = ?";
                    stmt = conn.prepareStatement(updateQuery);
                    stmt.setString(1, updatedName);
                    stmt.setString(2, updatedDescription);
                    stmt.setString(3, updatedPrice);
                    stmt.setString(4, productId);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        response.sendRedirect("index.jsp"); // Redirect to index.jsp to view updated list
                    } else {
                        out.println("<p style='color: red;'>Failed to update product.</p>");
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
        }
    %>
</body>
</html>
