package com.katta.delete_item;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
 * Servlet implementation class delete_item_servlet
 */
@WebServlet("/delete_item_servlet")
public class delete_item_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String i_id = request.getParameter("item_id").toString();
		
		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;
		
		if ( i_id.equals("") || i_id == null ) { 
			request.setAttribute("delete_item_status", "invalid_id");
			req_Dispatcher = request.getRequestDispatcher("item_delete.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		String select_query_for_table = "SELECT * FROM products_table WHERE item_id = ?";
		String delete_query_for_table = "DELETE FROM products_table WHERE item_id = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			// now we need the set the values of the parameters
			
			PreparedStatement select_prepst_emp_table = con.prepareStatement(select_query_for_table);
			
			select_prepst_emp_table.setInt(1, Integer.parseInt(i_id));
			
			ResultSet res_set = select_prepst_emp_table.executeQuery();
			
			if (!res_set.next()) {
				request.setAttribute("delete_item_status", "id_not_exist");
				req_Dispatcher = request.getRequestDispatcher("item_delete.jsp");
				req_Dispatcher.forward(request, response);
			} else {
				//row_count = prepst_emp_table.executeUpdate();
				
				PreparedStatement delete_prepst_emp_table = con.prepareStatement(delete_query_for_table);
				
				delete_prepst_emp_table.setInt(1, Integer.parseInt(i_id));
				
				row_count = delete_prepst_emp_table.executeUpdate();
				
				if (row_count > 0 ) {
					request.setAttribute("delete_item_status", "success");
					req_Dispatcher = request.getRequestDispatcher("item_delete.jsp");
					req_Dispatcher.forward(request, response);
				}
			}

			con.close();

		} catch (Exception ex) {
			// outpt.println("Welcome to the it_ass_8_database database where you can get
			// the selcted information based on the conditions \n Now, here are your
			// conditions : " + ex);
			
			request.setAttribute("delete_item_status", "failed");
			req_Dispatcher = request.getRequestDispatcher("item_delete.jsp");
			req_Dispatcher.forward(request, response);

			Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
			lgr.log(Level.SEVERE, ex.getMessage(), ex);
		}
		
	}

}
