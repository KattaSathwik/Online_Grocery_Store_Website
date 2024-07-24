package com.katta.loginpage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.ChannelSender;
import org.apache.jasper.tagplugins.jstl.core.If;

import com.katta.registrationpage.JdbcMySQLVersion;
import com.mysql.cj.xdevapi.Statement;

/**
 * Servlet implementation class login_servlet_page
 */
@WebServlet("/login_servlet_page")
public class login_servlet_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		String p_name = request.getParameter("username");
		String p_password = request.getParameter("password");
		String p_position = request.getParameter("select_pos");
		HttpSession session = request.getSession();
		RequestDispatcher req_Dispatcher = null;
		
		if ( p_name.equals("") || p_name == null ) {
			request.setAttribute("log_status", "invalid_username");
			req_Dispatcher = request.getRequestDispatcher("login.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_password.equals("") || p_password == null ) {
			request.setAttribute("log_status", "invalid_password");
			req_Dispatcher = request.getRequestDispatcher("login.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_position.equals("select the position") || p_position == null ) {
			request.setAttribute("log_status", "invalid_position");
			req_Dispatcher = request.getRequestDispatcher("login.jsp");
			req_Dispatcher.forward(request, response);
		}

		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";
		
		String log_select_query_for_table = "SELECT * FROM loged_persons_table WHERE p_name = ?";
		String select_query_for_table = "SELECT * FROM registered_persons_table WHERE p_name = ? AND p_pass = ? AND p_position = ?";
		String insert_query_for_table = "INSERT INTO loged_persons_table(p_name, p_password, p_position_name) VALUES(?, ?, ?)";

		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement prepst_emp_table = con.prepareStatement(insert_query_for_table);

			// now we need the set the values of the parameters

			prepst_emp_table.setString(1, p_name);
			
			prepst_emp_table.setString(2, p_password);
			
			prepst_emp_table.setString(3, p_position);
			
			PreparedStatement loged_prepst_emp_table = con.prepareStatement(log_select_query_for_table);
			
			loged_prepst_emp_table.setString(1, p_name);
			
			ResultSet lod_res_set = loged_prepst_emp_table.executeQuery();
			
			PreparedStatement select_prepst_emp_table = con.prepareStatement(select_query_for_table);
			
			select_prepst_emp_table.setString(1, p_name);
			select_prepst_emp_table.setString(2, p_password);
			select_prepst_emp_table.setString(3, p_position);
			
			ResultSet res_set = select_prepst_emp_table.executeQuery();
			
			if (res_set.next()) {
				System.out.print(res_set.getString("p_name"));
				session.setAttribute("name", res_set.getString("p_name"));
				session.setAttribute("p_pos", res_set.getString("p_position"));
				if (!lod_res_set.next()) {
					int row_count = prepst_emp_table.executeUpdate();
				}
				//request.setAttribute("p_pos", res_set.getString("p_position"));
				if ( p_position.equals("shopkeeper")) {
					req_Dispatcher = request.getRequestDispatcher("shopkeeper_home.jsp");
				} else if (p_position.equals("customer") ) {
					req_Dispatcher = request.getRequestDispatcher("person_profile.jsp");
				}
				//RequestDispatcher req_Dispatcher = request.getRequestDispatcher("index.jsp");
			} else {
				request.setAttribute("log_status", "failed");
				req_Dispatcher = request.getRequestDispatcher("login.jsp");
			}
			
			//RequestDispatcher req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			
			req_Dispatcher.forward(request, response);

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
