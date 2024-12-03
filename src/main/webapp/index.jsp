<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Product List</h2>

        <!-- Add Product Form -->
        <form action="addProduct" method="post" class="mb-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <input type="text" class="form-control" name="productname" placeholder="Product Name" required>
                </div>
                <div class="col-md-4">
                    <input type="text" class="form-control" name="description" placeholder="Description" required>
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" name="price" placeholder="Price" step="0.01" required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </div>
            </div>
        </form>

        <!-- Product Table -->
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Sr.No</th>
                        <th scope="col">Product Name</th>
                        <th scope="col">Description</th>
                        <th scope="col">Price</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                
                
                    <!-- Fetch data from database and show it in the table -->
<%
    // JDBC Connection variables
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Direct JDBC connection (change these values based on your setup)
        String dbURL = "jdbc:mysql://localhost:3306/demo";  // Change the database URL
        String dbUsername = "root";  // Change your DB username
        String dbPassword = "Priyanka";  // Change your DB password
        
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");  // Make sure the MySQL driver is in the classpath
        
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        
        // SQL query to fetch product data
        String selectQuery = "SELECT * FROM products";  // Assuming your table is 'products'
        
        // Execute the query
        stmt = conn.createStatement();
        rs = stmt.executeQuery(selectQuery);

        int srNo = 1;
        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
            String price = rs.getString("price");
%>
        <tr>
            <td><%= srNo++ %></td>
            <td><%= name %></td>
            <td><%= description %></td>
            <td><%= price %></td>
            <td>
    <!-- Edit Button -->
    <a href="update.jsp?id=<%= id %>" class="btn btn-warning btn-sm">
        <i class="bi bi-pencil"></i> Edit
    </a>
    <!-- Delete Button -->
                <a href="deleteProduct.jsp?id=<%= id %>&action=delete" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?');">
                    <i class="bi bi-trash"></i> Delete
                </a>
        </tr>
<%
        }
    } catch (SQLException | ClassNotFoundException e) {
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
%>
                </tbody>
            </table>
        </div>
    </div>



    


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
