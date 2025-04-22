package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.CompanyDao;
import com.dao.UserDao;
import com.model.CompanyModel;
import com.model.UserModel;

@WebServlet("/CompanyController")
public class CompanyController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	public CompanyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String value = request.getParameter("value");
		if(value.equalsIgnoreCase("register"))
		{
			CompanyModel rmodel = new CompanyModel();
			rmodel.setName(request.getParameter("name"));	
			
			String email = request.getParameter("email");
			if(new CompanyDao().isEmailExist(email)) 
			{				
				request.setAttribute("error", "email already exists");
				request.getRequestDispatcher("companyRegistration.jsp").forward(request, response);
			}
			else
			{		
//				System.out.println("email added");
				rmodel.setEmail(email);
			}

			rmodel.setAddress(request.getParameter("address"));
			rmodel.setPhone(request.getParameter("phone"));
			rmodel.setWebsite(request.getParameter("website"));
			rmodel.setPassword(request.getParameter("password"));
			
			System.out.println(rmodel);
			
			int x = new CompanyDao().companyRegistration(rmodel);
			
			if(x > 0)
			{
				response.sendRedirect("userLogin.jsp");
			}
			else
			{
				response.sendRedirect("companyRegistration.jsp");
			}
		}
		else if(value.equalsIgnoreCase("login"))
		{
			CompanyModel lmodel = new CompanyModel();
			lmodel.setEmail(request.getParameter("email"));
			lmodel.setPassword(request.getParameter("password"));
			
			CompanyModel model = new CompanyDao().companyLogin(lmodel.getEmail(), lmodel.getPassword());
			
			if(model != null)
			{
				HttpSession session = request.getSession();
				session.setAttribute("company", model);
				response.sendRedirect("jobSeekerDashboard.jsp");
			}else
			{
				response.sendRedirect("userLogin.jsp?error=invalid email and password");
			}
		}
	}
}

