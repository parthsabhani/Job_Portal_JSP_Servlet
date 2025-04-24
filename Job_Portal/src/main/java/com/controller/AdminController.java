package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.http.HttpRequest;
import java.util.List;

import com.dao.AdminDao;
import com.model.CompanyModel;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    public AdminController() {
        super();

    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("action");
		AdminDao admin = new AdminDao();
		
		// Admin Login
		if(action.equalsIgnoreCase("login"))
		{
			String username = request.getParameter("username");
			String password = request.getParameter("password");
	
			boolean isValid = admin.adminLogin(username, password);
			
			if(isValid)
			{
				HttpSession session = request.getSession(true);
				session.setAttribute("role", "admin");
				
				List<CompanyModel> companyList = admin.getAllCompanies();
				request.setAttribute("companyList", companyList);
				request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
			}
			else
			{
				response.sendRedirect("adminLogin.jsp?error=Invalid username and password");
			}
		}
		else if(action.equalsIgnoreCase("approve")) // Company Approval
		{
			int x = admin.updateStatusCompany(Integer.parseInt(request.getParameter("companyId")),true);
			if(x > 0)
			{				
				List<CompanyModel> companyList = admin.getAllCompanies();
				request.setAttribute("companyList", companyList);
				request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
			}
			else
			{
				response.sendRedirect("error.jsp");
			}
		}
		else if(action.equalsIgnoreCase("reject")) // Company Rejection
		{
			int x = admin.updateStatusCompany(Integer.parseInt(request.getParameter("companyId")),false);
			if(x > 0)
			{				
				List<CompanyModel> companyList = admin.getAllCompanies();
				request.setAttribute("companyList", companyList);
				request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
			}
			else
			{
				response.sendRedirect("error.jsp");
			}
		}
	}

}
