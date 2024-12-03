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

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");  // Get the product id from the URL
        
        if (productId != null) {
            // JDBC to delete the product from the database
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // Setup the database connection (same as in the previous JSP code)
                String dbURL = "jdbc:mysql://localhost:3306/your_database";  // Change this to your DB URL
                String dbUsername = "your_username";
                String dbPassword = "your_password";

                // Load MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                // SQL delete query
                String deleteQuery = "DELETE FROM products WHERE id = ?";
                stmt = conn.prepareStatement(deleteQuery);
                stmt.setString(1, productId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Successfully deleted, redirect to index.jsp to refresh the product list
                    response.sendRedirect("index.jsp");
                } else {
                    // Handle case if no rows were deleted
                    response.sendRedirect("error.jsp");
                }
            } catch (SQLException | ClassNotFoundException e) {
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
}
