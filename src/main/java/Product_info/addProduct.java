package Product_info;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/addProduct")
public class addProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productname = request.getParameter("productname");
        String description = request.getParameter("description");
        String price = request.getParameter("price");

        Connection conn = null;
        PreparedStatement pstmt = null;
        String Url = "jdbc:mysql://localhost:3306/demo";
        String u_name = "root";
        String pass = "Priyanka";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(Url, u_name, pass);
            System.out.println("Connected to the database!");

           String sql = "INSERT INTO products (name, description, price) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productname);
            pstmt.setString(2, description);
            pstmt.setString(3, price);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Product added successfully!");
                response.sendRedirect("index.jsp"); // Redirect to a success page
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Unable to add product. Please try again later.</h3>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
