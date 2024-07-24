package com.katta.delete_cart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlet_java.JdbcMySQLVersion;

/**
 * Servlet implementation class delete_cart_item
 */
@WebServlet("/delete_cart_item")
public class delete_cart_item extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cart_id = request.getParameter("cart_id").toString();
		
		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;
		
		if ( cart_id.equals("") || cart_id == null ) { 
			request.setAttribute("delete_cart_item_status", "invalid_cart_id");
			req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		//String select_query_for_table = "SELECT * FROM products_table WHERE item_id = ?";
		String delete_query_for_cart_table = "DELETE FROM cart_table WHERE cart_id = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			
				//row_count = prepst_emp_table.executeUpdate();
				
				PreparedStatement delete_prepst_cart_table = con.prepareStatement(delete_query_for_cart_table);
				
				delete_prepst_cart_table.setInt(1, Integer.parseInt(cart_id));
				
				row_count = delete_prepst_cart_table.executeUpdate();
				
				if (row_count > 0 ) {
					request.setAttribute("delete_cart_item_status", "success");
					req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
					req_Dispatcher.forward(request, response);
				}
			

			con.close();

		} catch (Exception ex) {
			// outpt.println("Welcome to the it_ass_8_database database where you can get
			// the selcted information based on the conditions \n Now, here are your
			// conditions : " + ex);
			
			request.setAttribute("delete_cart_item_status", "failed");
			req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
			req_Dispatcher.forward(request, response);

			Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
			lgr.log(Level.SEVERE, ex.getMessage(), ex);
		}
	}

}
