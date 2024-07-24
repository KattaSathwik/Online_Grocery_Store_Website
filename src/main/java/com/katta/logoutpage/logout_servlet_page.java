package com.katta.logoutpage;

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
import javax.servlet.http.HttpSession;

import com.katta.loginpage.login_servlet_page;

import servlet_java.JdbcMySQLVersion;

/**
 * Servlet implementation class logout_servlet_page
 */
@WebServlet("/logout_servlet_page")
public class logout_servlet_page extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name") != null) {
			session.removeAttribute("name");
		}

		RequestDispatcher req_Dispatcher = null;

		if (session.getAttribute("p_pos").equals("customer")) {
			if (session.getAttribute("customer_ordered") != null) {
				String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				String user = "root";
				String password = "katta@123";

				// String select_query_for_table = "SELECT * FROM products_table WHERE item_id =
				// ?";
				String delete_query_for_cart_table = "DELETE FROM cart_table";

				try {

					Class.forName("com.mysql.jdbc.Driver");
					Connection con = DriverManager.getConnection(url, user, password);

					// row_count = prepst_emp_table.executeUpdate();

					// Statement delete_st_cart_table = con.createStatement();
					// ResultSet res_set =
					// delete_st_cart_table.executeQuery(delete_query_for_cart_table);

					PreparedStatement delete_prepst_cart_table = con.prepareStatement(delete_query_for_cart_table);

					int row_count = delete_prepst_cart_table.executeUpdate();
					
					session.removeAttribute("customer_ordered");
					session.removeAttribute("p_pos");
					if (row_count > 0) {
						request.setAttribute("delete_all_cart_item_status", "success");
						req_Dispatcher = request.getRequestDispatcher("login.jsp");
						req_Dispatcher.forward(request, response);
					}

					con.close();

				} catch (Exception ex) {
					// outpt.println("Welcome to the it_ass_8_database database where you can get
					// the selcted information based on the conditions \n Now, here are your
					// conditions : " + ex);

					request.setAttribute("delete_all_cart_item_status", "failed");
					req_Dispatcher = request.getRequestDispatcher("login.jsp");
					req_Dispatcher.forward(request, response);

					Logger lgr = Logger.getLogger(JdbcMySQLVersion.class.getName());
					lgr.log(Level.SEVERE, ex.getMessage(), ex);
				}
			} else {
				request.setAttribute("delete_all_cart_item_status", "new_success");
				req_Dispatcher = request.getRequestDispatcher("login.jsp");
				req_Dispatcher.forward(request, response);
			}

		} else {
			session.removeAttribute("p_pos");
			request.setAttribute("delete_all_cart_item_status", "shopk_success");
			req_Dispatcher = request.getRequestDispatcher("login.jsp");
			req_Dispatcher.forward(request, response);
		}

		// response.sendRedirect("login.jsp");
	}

}
