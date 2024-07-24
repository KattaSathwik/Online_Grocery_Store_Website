package com.katta.add_item;

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
 * Servlet implementation class add_item_servlet
 */
@WebServlet("/add_item_servlet")
public class add_item_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String i_name = request.getParameter("item_name");
		String i_price = request.getParameter("item_price");
		String i_stock = request.getParameter("item_stock");
		String i_description = request.getParameter("item_desc");
		String i_image = request.getParameter("item_img");
		
		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;
		if ( i_name.equals("") || i_name == null ) { 
			request.setAttribute("add_item_status", "invalid_name");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_price.equals("") || i_price == null ) {
			request.setAttribute("add_item_status", "invalid_price");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_stock.equals("") || i_stock == null ) {
			request.setAttribute("add_item_status", "invalid_stock");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_description.equals("") || i_description == null ) {
			request.setAttribute("add_item_status", "invalid_description");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_image.equals("") || i_image == null ) {
			request.setAttribute("add_item_status", "invalid_image");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}

		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		String insert_query_for_table = "INSERT INTO products_table( item_name, item_price, item_qua, item_desc, item_img) VALUES(?, ?, ?, ?, ?)";
		String select_query_for_table = "SELECT * FROM products_table WHERE item_name = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement prepst_emp_table = con.prepareStatement(insert_query_for_table);

			// now we need the set the values of the parameters

			prepst_emp_table.setString(1, i_name);
			
			prepst_emp_table.setString(2, i_price);
			
			prepst_emp_table.setString(3, i_stock);
			
			prepst_emp_table.setString(4, i_description);
			
			prepst_emp_table.setString(5, i_image);
			
			PreparedStatement select_prepst_emp_table = con.prepareStatement(select_query_for_table);
			
			select_prepst_emp_table.setString(1, i_name);
			
			ResultSet res_set = select_prepst_emp_table.executeQuery();
			
			if (res_set.next()) {
				request.setAttribute("add_item_status", "already_exixts");
				req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
				req_Dispatcher.forward(request, response);
			} else {
				row_count = prepst_emp_table.executeUpdate();
			}

			if ( row_count > 0 ) {
				request.setAttribute("add_item_status", "success");
				req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
				req_Dispatcher.forward(request, response);
			} else {
				request.setAttribute("add_item_status", "failed");
				req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
				req_Dispatcher.forward(request, response);
			}

			con.close();

		} catch (Exception ex) {
			// outpt.println("Welcome to the it_ass_8_database database where you can get
			// the selcted information based on the conditions \n Now, here are your
			// conditions : " + ex);

			Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
			lgr.log(Level.SEVERE, ex.getMessage(), ex);
		}
		
	}

}
