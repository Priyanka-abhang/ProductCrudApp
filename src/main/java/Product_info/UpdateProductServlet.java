package Product_info;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateProduct")
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        String productName = request.getParameter("productname");
        String description = request.getParameter("description");
        String price = request.getParameter("price");

        // Database connection
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // Set up the database connection (use your own DB details)
            String dbUrl = "jdbc:mysql://localhost:3306/your_database";
            String dbUsername = "your_username";
            String dbPassword = "your_password";
            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String updateQuery = "UPDATE products SET name = ?, description = ?, price = ? WHERE id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setString(3, price);
            stmt.setString(4, id);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to the index page after successful update
                response.sendRedirect("index.jsp");
            } else {
                // Handle the case where no rows were updated (optional)
                response.getWriter().println("Error: Product not found!");
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

