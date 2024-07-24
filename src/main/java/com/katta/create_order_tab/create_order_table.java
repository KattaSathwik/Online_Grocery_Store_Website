package com.katta.create_order_tab;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

import java.util.logging.Level;
import java.util.logging.Logger;
import com.katta.registrationpage.JdbcMySQLVersion;
import com.mysql.cj.Session;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.ChannelSender;

/**
 * Servlet implementation class create_order_table
 */
@WebServlet("/create_order_table")
public class create_order_table extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;

		int cart_id;
		int i_id;
		String i_name = "";
		String i_price = "";
		String i_qua = "";
		int item_total_price;
		int item_total_price_cnt = 0;
		int cust_id = -1;
		String cart_add_date = "";
		String i_image = "";
		HttpSession session = request.getSession();

		LocalDate user_sql_cur_date = LocalDate.now();
		//int new_res_set_ins_order = -1;
		int res_set_ins_order = -1;
		
		int res_set_up_order = -1;
		//int new_res_set_up_order = -1;

		int prod_item_qua = -1;
		int prod_item_price = -1;
		
		int int_up_prod = -1;

		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		String insert_query_for_order_table = "INSERT INTO orders_table ( item_id, item_name, item_price, order_item_qua, item_image, item_total_price, customer_id, ordered_date ) values(?, ?, ?, ?, ?, ? ,? ,?)";
		String select_query_for_cust_table = "SELECT * FROM loged_persons_table WHERE p_name = ?";
		String select_query_for_table = "SELECT * FROM cart_table WHERE customer_id = ?";
		String select_query_for_cart_table = "SELECT * FROM cart_table WHERE customer_id = ? AND item_id = ?";
		String select_query_for_order_table = "SELECT * FROM orders_table WHERE customer_id = ? AND item_id = ?";
		String select_query_for_prod_table = "SELECT * FROM products_table WHERE item_id = ?";
		String update_query_for_order_table = "UPDATE orders_table SET order_item_qua = order_item_qua + ?, item_total_price = item_total_price + ? WHERE order_id = ?";
		String update_query_for_prod_table = "UPDATE products_table SET item_qua = item_qua - ? WHERE item_id = ?";
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			// now we need the set the values of the parameters

			PreparedStatement select_prepst_cust_table = con.prepareStatement(select_query_for_cust_table);

			select_prepst_cust_table.setString(1, session.getAttribute("name").toString());

			ResultSet res_set_cust = select_prepst_cust_table.executeQuery();

			if (res_set_cust.next()) {
				cust_id = res_set_cust.getInt(1);
			} else {
				request.setAttribute("order_item_status", "user_not_exist");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
				req_Dispatcher.forward(request, response);
			}

			PreparedStatement select_prepst_cart_table = con.prepareStatement(select_query_for_table);

			select_prepst_cart_table.setInt(1, cust_id);

			ResultSet res_set = select_prepst_cart_table.executeQuery();

			if (!res_set.next()) {
				request.setAttribute("order_item_status", "no_item_exists");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
				req_Dispatcher.forward(request, response);
			} else {

				PreparedStatement select_prepst_order_table = con.prepareStatement(select_query_for_order_table);

				select_prepst_order_table.setInt(1, cust_id);
				select_prepst_order_table.setInt(2, res_set.getInt(2));

				ResultSet res_set_order = select_prepst_order_table.executeQuery();

				if (res_set_order.next()) {
					PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);

					select_prepst_prod_table.setInt(1, res_set.getInt(2));

					ResultSet res_set_prod = select_prepst_prod_table.executeQuery();

					if (res_set_prod.next()) {
						prod_item_qua = res_set_prod.getInt(4);
						prod_item_price = res_set_prod.getInt(3);
					}

					int order_item_quantity = Integer.parseInt(res_set_order.getString(5)) + Integer.parseInt(res_set.getString(5));

					if (prod_item_qua >= order_item_quantity) {
						PreparedStatement update_prepst_order_table = con.prepareStatement(update_query_for_order_table);

						update_prepst_order_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_order_table.setInt(2, Integer.parseInt(res_set.getString(5)) * prod_item_price);
						update_prepst_order_table.setInt(3, (res_set_order.getInt(1)));

						res_set_up_order = update_prepst_order_table.executeUpdate();

						PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
						
						update_prepst_prod_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_prod_table.setInt(2, res_set.getInt(2) );
						
						int_up_prod = update_prepst_prod_table.executeUpdate();

						/*if (res_set_up_order > 0) {
							/*request.setAttribute("order_item_status", "order_updated");*/
							/*req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
							req_Dispatcher.forward(request, response);*/
						/*}*/
					} else {
						request.setAttribute("order_item_status", "item_out_stock");
						req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
						req_Dispatcher.forward(request, response);
					}

				} else {

					PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);

					select_prepst_prod_table.setInt(1, res_set.getInt(2));

					ResultSet res_set_prod = select_prepst_prod_table.executeQuery();

					if (res_set_prod.next()) {
						prod_item_qua = res_set_prod.getInt(4);
						prod_item_price = res_set_prod.getInt(3);
					}

					if (prod_item_qua >= Integer.parseInt(res_set.getString(5))) {
						
						cart_id = res_set.getInt(1);
						i_id = res_set.getInt(2);
						i_name = res_set.getString(3);
						i_price = res_set.getString(4);
						i_qua = res_set.getString(5);
						item_total_price = Integer.parseInt(res_set.getString(7));
						item_total_price_cnt += item_total_price;
						cust_id = res_set.getInt(8);
						cart_add_date = res_set.getString(9);
						i_image = res_set.getString(6);

						PreparedStatement insert_prepst_order_table = con.prepareStatement(insert_query_for_order_table);

						insert_prepst_order_table.setInt(1, i_id);
						insert_prepst_order_table.setString(2, i_name);
						insert_prepst_order_table.setString(3, i_price + "");
						insert_prepst_order_table.setString(4, i_qua);
						insert_prepst_order_table.setString(5, i_image);
						insert_prepst_order_table.setString(6, item_total_price + "");
						insert_prepst_order_table.setInt(7, cust_id);
						insert_prepst_order_table.setString(8, user_sql_cur_date.toString());

						res_set_ins_order = insert_prepst_order_table.executeUpdate();
						
						PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
						
						update_prepst_prod_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_prod_table.setInt(2, res_set.getInt(2) );
						
						int_up_prod = update_prepst_prod_table.executeUpdate();
					}

				}
			}

			while (res_set.next()) {
				PreparedStatement select_prepst_order_table = con.prepareStatement(select_query_for_order_table);

				select_prepst_order_table.setInt(1, cust_id);
				select_prepst_order_table.setInt(2, res_set.getInt(2));

				ResultSet res_set_order = select_prepst_order_table.executeQuery();

				if (res_set_order.next()) {
					PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);

					select_prepst_prod_table.setInt(1, res_set.getInt(2));

					ResultSet res_set_prod = select_prepst_prod_table.executeQuery();

					if (res_set_prod.next()) {
						prod_item_qua = res_set_prod.getInt(4);
						prod_item_price = res_set_prod.getInt(3);
					}

					/*
					 * PreparedStatement select_prepst_cart_item_table =
					 * con.prepareStatement(select_query_for_cart_table);
					 * 
					 * select_prepst_cart_item_table.setInt(1, res_set.getInt(2) );
					 * 
					 * ResultSet res_set_cart = select_prepst_cart_item_table.executeQuery();
					 */

					int order_item_quantity = Integer.parseInt(res_set_order.getString(5)) + Integer.parseInt(res_set.getString(5));

					if (prod_item_qua >= order_item_quantity) {
						PreparedStatement update_prepst_order_table = con.prepareStatement(update_query_for_order_table);

						update_prepst_order_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_order_table.setInt(2, Integer.parseInt(res_set.getString(5)) * prod_item_price);
						update_prepst_order_table.setInt(3, (res_set_order.getInt(1)));

						 res_set_up_order = update_prepst_order_table.executeUpdate();

						 PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
							
						update_prepst_prod_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_prod_table.setInt(2, res_set.getInt(2) );
							
						int_up_prod = update_prepst_prod_table.executeUpdate();
					} else {
						request.setAttribute("order_item_status", "item_out_stock");
						req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
						req_Dispatcher.forward(request, response);
					}

				} else {

					PreparedStatement select_prepst_prod_table = con.prepareStatement(select_query_for_prod_table);

					select_prepst_prod_table.setInt(1, res_set.getInt(2));

					ResultSet res_set_prod = select_prepst_prod_table.executeQuery();

					if (res_set_prod.next()) {
						prod_item_qua = res_set_prod.getInt(4);
						prod_item_price = res_set_prod.getInt(3);
					}

					if (prod_item_qua >= Integer.parseInt(res_set.getString(5))) {
						
						cart_id = res_set.getInt(1);
						i_id = res_set.getInt(2);
						i_name = res_set.getString(3);
						i_price = res_set.getString(4);
						i_qua = res_set.getString(5);
						item_total_price = Integer.parseInt(res_set.getString(7));
						item_total_price_cnt += item_total_price;
						cust_id = res_set.getInt(8);
						cart_add_date = res_set.getString(9);
						i_image = res_set.getString(6);

						PreparedStatement insert_prepst_order_table = con.prepareStatement(insert_query_for_order_table);

						insert_prepst_order_table.setInt(1, i_id);
						insert_prepst_order_table.setString(2, i_name);
						insert_prepst_order_table.setString(3, i_price + "");
						insert_prepst_order_table.setString(4, i_qua);
						insert_prepst_order_table.setString(5, i_image);
						insert_prepst_order_table.setString(6, item_total_price + "");
						insert_prepst_order_table.setInt(7, cust_id);
						insert_prepst_order_table.setString(8, user_sql_cur_date.toString());

						res_set_ins_order = insert_prepst_order_table.executeUpdate();
						
						PreparedStatement update_prepst_prod_table = con.prepareStatement(update_query_for_prod_table);
						
						update_prepst_prod_table.setInt(1, Integer.parseInt(res_set.getString(5)));
						update_prepst_prod_table.setInt(2, res_set.getInt(2) );
						
						int_up_prod = update_prepst_prod_table.executeUpdate();
					}

				}

			}
			
			if (res_set_ins_order > 0 && res_set_up_order > 0 ) {
				session.setAttribute("customer_ordered", "ordered");
				request.setAttribute("order_item_status", "updated_inserted_successfully");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
				req_Dispatcher.forward(request, response);
			} 
			
			if (int_up_prod > 0 ) {
				session.setAttribute("customer_ordered", "ordered");
				request.setAttribute("order_item_status", "prob_updated_successfully");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
				req_Dispatcher.forward(request, response);
			}

			if (res_set_ins_order > 0 ) {
				session.setAttribute("customer_ordered", "ordered");
				request.setAttribute("order_item_status", "inserted_successfully");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
				req_Dispatcher.forward(request, response);
			}
			
			if (res_set_up_order > 0 ) {
				session.setAttribute("customer_ordered", "ordered");
				request.setAttribute("order_item_status", "updated_successfully");
				req_Dispatcher = request.getRequestDispatcher("show_cart_items.jsp");
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
