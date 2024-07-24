package com.katta.registrationpage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * Servlet implementation class registration_servlet_page
 */
@WebServlet("/registration_servlet_page")
public class registration_servlet_page extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String p_name = request.getParameter("name");
		String p_email_id = request.getParameter("email");
		String p_password = request.getParameter("pass");
		String re_p_password = request.getParameter("re_pass");
		String p_contact = request.getParameter("contact");
		String p_position = request.getParameter("select_pos");
		RequestDispatcher req_Dispatcher = null;
		int row_count = 0;
		System.out.println(p_contact);
		if ( p_contact.equals("") || p_contact == null ) { 
			request.setAttribute("reg_status", "invalid_contact");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		} else if (p_contact.length() > 10 ) {
			request.setAttribute("reg_status", "invalid_contact_match");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_name.equals("") || p_name == null ) {
			request.setAttribute("reg_status", "invalid_username");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_email_id.equals("") || p_email_id == null ) {
			request.setAttribute("reg_status", "invalid_email");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_password.equals("") || p_password == null ) {
			request.setAttribute("reg_status", "invalid_password");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		} else if (!p_password.equals(re_p_password)) {
			request.setAttribute("reg_status", "invalid_password_match");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		}
		
		if ( p_position.equals("select the position") || p_position == null ) {
			request.setAttribute("reg_status", "invalid_position");
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
			req_Dispatcher.forward(request, response);
		}

		String url = "jdbc:mysql://localhost:3306/grocery_project?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "root";
		String password = "katta@123";

		String insert_query_for_table = "INSERT INTO registered_persons_table(p_name, p_email, p_pass, p_contact, p_position) VALUES(?, ?, ?, ?, ?)";
		String select_query_for_table = "SELECT * FROM registered_persons_table WHERE p_name = ? AND p_pass = ? AND p_position = ?";
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement prepst_emp_table = con.prepareStatement(insert_query_for_table);

			// now we need the set the values of the parameters

			prepst_emp_table.setString(1, p_name);
			
			prepst_emp_table.setString(2, p_email_id);
			
			prepst_emp_table.setString(3, p_password);
			
			prepst_emp_table.setString(4, p_contact);
			
			prepst_emp_table.setString(5, p_position);
			
			PreparedStatement select_prepst_emp_table = con.prepareStatement(select_query_for_table);
			
			select_prepst_emp_table.setString(1, p_name);
			select_prepst_emp_table.setString(2, p_password);
			select_prepst_emp_table.setString(3, p_position);
			
			ResultSet res_set = select_prepst_emp_table.executeQuery();
			
			if (res_set.next()) {
				request.setAttribute("reg_status", "already_exixts");
				req_Dispatcher = request.getRequestDispatcher("registration.jsp");
				req_Dispatcher.forward(request, response);
			} else {
				row_count = prepst_emp_table.executeUpdate();
			}

			if ( row_count > 0 ) {
				request.setAttribute("reg_status", "success");
			} else {
				request.setAttribute("reg_status", "failed");
			}
			
			req_Dispatcher = request.getRequestDispatcher("registration.jsp");
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
