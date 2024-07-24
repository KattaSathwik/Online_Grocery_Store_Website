package com.katta.add_to_cart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
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
 * Servlet implementation class add_cart_item
 */
@WebServlet("/add_cart_item")
public class add_cart_item extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		String i_id = request.getParameter("item_id").toString();
		String i_name = request.getParameter("item_name");
		String cust_name = request.getParameter("cust_name");
		String i_cart_qua = request.getParameter("no_of_items");
		
		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;
		int cust_id = 0;
		int item_qua = -1;
		int item_price = -1;
		int item_total_price = -1;
		int cart_item_qua = -1;
		String item_image = "";
		LocalDate user_sql_cur_date = LocalDate.now();
		int cart_item_quantity = -1;
		
		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";
		
		String insert_query_for_cart_table = "INSERT INTO cart_table ( item_id, item_name, item_price, cart_item_qua, item_image, item_total_price, customer_id, cart_added_date ) values(?, ?, ?, ?, ?, ? ,? ,?)";
		String select_query_for_cart_table = "SELECT * FROM cart_table WHERE customer_id = ? AND item_id = ?";
		String select_query_for_cust_table = "SELECT * FROM loged_persons_table WHERE p_name = ?";
		String select_query_for_prod_table = "SELECT * FROM products_table WHERE item_id = ?";
		String update_query_for_cart_table = "UPDATE cart_table SET cart_item_qua = cart_item_qua + ?, item_total_price = item_total_price + ? WHERE cart_id = ?";
		String update_query_for_prod_table = "UPDATE products_table SET item_qua = item_qua - ? WHERE item_id = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			//PreparedStatement prepst_emp_table = con.prepareStatement(insert_query_for_table);

			// now we need the set the values of the parameters
			
			if ( i_cart_qua.equals("") || i_cart_qua == null || i_cart_qua == "" ) { 
				request.setAttribute("cart_item_status", "invalid_qua");
				req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
				req_Dispatcher.forward(request, response);
			}
			
			PreparedStatement select_prepst_cust_table = con.prepareStatement(select_query_for_cust_table);
			
			select_prepst_cust_table.setString(1, cust_name);
			
			ResultSet res_set = select_prepst_cust_table.executeQuery();
			
			if ( res_set.next() ) {
				cust_id = res_set.getInt(1);
			} else {
				request.setAttribute("cart_item_status", "user_not_exist");
				req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
				req_Dispatcher.forward(request, response);
			}
			
			PreparedStatement select_prepst_cart_table = con.prepareStatement(select_query_for_cart_table);
			
			select_prepst_cart_table.setInt(1, cust_id);
			select_prepst_cart_table.setInt(2, Integer.parseInt(i_id));
			
			ResultSet res_set_2 = select_prepst_cart_table.executeQuery();
			
			if (res_set_2.next() ) {
				PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);
				
				select_prepst_prod_table.setInt(1, Integer.parseInt(i_id));
				
				ResultSet res_set_prod = select_prepst_prod_table.executeQuery();
				
				if ( res_set_prod.next() ) {
					item_qua = res_set_prod.getInt(4);
					item_price = res_set_prod.getInt(3);
				}
				
				cart_item_quantity = Integer.parseInt( res_set_2.getString(5) ) + Integer.parseInt(i_cart_qua);
				
				if ( item_qua >= cart_item_quantity ) {
					PreparedStatement update_prepst_cart_table = con.prepareStatement(update_query_for_cart_table);
					
					update_prepst_cart_table.setInt(1, Integer.parseInt(i_cart_qua));
					update_prepst_cart_table.setInt(2, Integer.parseInt(i_cart_qua) * item_price );
					update_prepst_cart_table.setInt(3, (res_set_2.getInt(1)));
					
					int res_set_up_cart = update_prepst_cart_table.executeUpdate();
					
					/*PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
					
					update_prepst_prod_table.setInt(1, Integer.parseInt(i_cart_qua));
					update_prepst_prod_table.setInt(2, Integer.parseInt(i_id) );
					
					int res_set_up_prod = update_prepst_prod_table.executeUpdate();*/
					
					if (res_set_up_cart > 0 ) {
						request.setAttribute("cart_item_status", "i_cart_qua");
						req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
						req_Dispatcher.forward(request, response);
					} 
				} else {
					request.setAttribute("cart_item_status", "item_out_stock");
					req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
					req_Dispatcher.forward(request, response);
				}
				
			} else {
				PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);
				
				select_prepst_prod_table.setInt(1, Integer.parseInt(i_id));
				
				ResultSet res_set_prod = select_prepst_prod_table.executeQuery();
				
				if ( res_set_prod.next() ) {
					cart_item_qua = Integer.parseInt(i_cart_qua);
					item_qua = Integer.parseInt(res_set_prod.getString(4));
					item_price = Integer.parseInt(res_set_prod.getString(3));
					item_total_price = item_price * cart_item_qua;
					item_image = res_set_prod.getString(6);
				}
				
				if ( item_qua >= Integer.parseInt(i_cart_qua)) {
					PreparedStatement insert_prepst_cart_table = con.prepareStatement(insert_query_for_cart_table);
					
					insert_prepst_cart_table.setInt(1, Integer.parseInt(i_id)); 
					insert_prepst_cart_table.setString(2, i_name);
					insert_prepst_cart_table.setString(3, item_price + "");
					insert_prepst_cart_table.setString(4, i_cart_qua);
					insert_prepst_cart_table.setString(5, item_image);
					insert_prepst_cart_table.setString(6, item_total_price + "");
					insert_prepst_cart_table.setInt(7, cust_id);
					insert_prepst_cart_table.setString(8, user_sql_cur_date.toString());
					
					int res_set_ins_cart = insert_prepst_cart_table.executeUpdate();
					
					/*PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
					
					update_prepst_prod_table.setInt(1, Integer.parseInt(i_cart_qua));
					update_prepst_prod_table.setInt(2, Integer.parseInt(i_id) );
					
					int res_set_up_prod = update_prepst_prod_table.executeUpdate();*/
					
					if (res_set_ins_cart > 0 ) {
						request.setAttribute("cart_item_status", "added_sucessfully");
						req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
						req_Dispatcher.forward(request, response);
					}
				} else {
					request.setAttribute("cart_item_status", "item_out_stock");
					req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
					req_Dispatcher.forward(request, response);
				}
			}

			con.close();

		} catch (Exception ex) {
			request.setAttribute("cart_item_status", "failed");
			req_Dispatcher = request.getRequestDispatcher("customer_items.jsp");
			req_Dispatcher.forward(request, response);

			Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
			lgr.log(Level.SEVERE, ex.getMessage(), ex);
		}
	}
}
