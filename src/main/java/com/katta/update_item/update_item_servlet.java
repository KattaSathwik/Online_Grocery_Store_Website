package com.katta.update_item;

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
 * Servlet implementation class update_item_servlet
 */
@WebServlet("/update_item_servlet")
public class update_item_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String i_id = request.getParameter("item_id").toString();
		String i_name = request.getParameter("item_name");
		String i_price = request.getParameter("item_price");
		String i_stock = request.getParameter("item_stock");
		String i_description = request.getParameter("item_desc");
		String i_image = request.getParameter("item_img");
		
		RequestDispatcher req_Dispatcher = null;
		//int row_count = 0;
		
		if ( i_id.equals("") || i_id == null ) { 
			request.setAttribute("update_item_status", "invalid_id");
			req_Dispatcher = request.getRequestDispatcher("update_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		/*if ( i_name.equals("") || i_name == null ) { 
			request.setAttribute("update_item_status", "invalid_name");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_price.equals("") || i_price == null ) {
			request.setAttribute("update_item_status", "invalid_price");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_stock.equals("") || i_stock == null ) {
			request.setAttribute("update_item_status", "invalid_stock");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_description.equals("") || i_description == null ) {
			request.setAttribute("add_item_status", "invalid_description");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( i_image.equals("") || i_image == null ) {
			request.setAttribute("update_item_status", "invalid_image");
			req_Dispatcher = request.getRequestDispatcher("add_item.jsp");
			req_Dispatcher.forward(request, response);
		}*/

		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		String update_query_for_table = "UPDATE products_table SET ";
		String select_query_for_table = "SELECT * FROM products_table WHERE item_id = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			//PreparedStatement prepst_emp_table = con.prepareStatement(insert_query_for_table);

			// now we need the set the values of the parameters
			
			PreparedStatement select_prepst_emp_table = con.prepareStatement(select_query_for_table);
			
			select_prepst_emp_table.setInt(1, Integer.parseInt(i_id));
			
			ResultSet res_set = select_prepst_emp_table.executeQuery();
			
			if (!res_set.next()) {
				request.setAttribute("update_item_status", "id_not_exist");
				req_Dispatcher = request.getRequestDispatcher("update_item.jsp");
				req_Dispatcher.forward(request, response);
			} else {
				//row_count = prepst_emp_table.executeUpdate();
				
				if(i_name != "" || i_name == null ) {
					update_query_for_table = update_query_for_table + " item_name = '" + i_name + "',";
				}
				if(i_price != "" || i_price == null) {
					update_query_for_table = update_query_for_table + " item_price = '" + i_price + "',";
				}
				if(i_image != "" || i_image == null) {
					update_query_for_table = update_query_for_table + " item_img = '" + i_image + "',";
				}
				if(i_stock != "" || i_stock == null) {
					update_query_for_table = update_query_for_table + " item_qua = '" + i_stock + "',";
				}
				if(i_description != "" || i_description == null) {
					update_query_for_table = update_query_for_table + " item_desc = '" + i_description + "'";
				}
				
				if(update_query_for_table.charAt(update_query_for_table.length() - 1 ) == ',') {
					update_query_for_table = update_query_for_table.substring(0, update_query_for_table.length() - 1);
				}
				
				update_query_for_table = update_query_for_table + " WHERE item_id = " + Integer.parseInt(i_id);
				Statement select_st_pro_table = con.createStatement();
				select_st_pro_table.executeUpdate( update_query_for_table );
				
				request.setAttribute("update_item_status", "success");
				req_Dispatcher = request.getRequestDispatcher("update_item.jsp");
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
