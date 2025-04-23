package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.CompanyModel;
import com.util.ConnectionClass;

public class AdminDao 
{
	Connection c = null;
	
	public boolean adminLogin(String username, String password)
	{
		boolean isValid = false;
		
		c = ConnectionClass.getConnection();
		String q = "select * from admin where username = ? and password = ?";
		
		try 
		{
			PreparedStatement ps = c.prepareStatement(q);
			ps.setString(1, username);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				isValid = true;
			}
			
			c.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return isValid;
	}
	
	public List<CompanyModel> getAllCompanies()
	{
		List<CompanyModel> companies = new ArrayList<>();;
		
		c = ConnectionClass.getConnection();
		String q = "select * from company";
		
		try 
		{
			PreparedStatement ps = c.prepareStatement(q);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				CompanyModel model = new CompanyModel();
			    model.setCompanyid(rs.getInt("companyid"));
			    model.setName(rs.getString("name"));
			    model.setEmail(rs.getString("email"));
			    model.setAddress(rs.getString("address"));
			    model.setPhone(rs.getString("phone"));
			    model.setWebsite(rs.getString("website"));
			    model.setPassword(rs.getString("password"));
			    model.setApproved(rs.getBoolean("isApproved"));
			    model.setActive(rs.getBoolean("isActive"));
			    
			    companies.add(model);
			}
			
			c.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return companies;
	}
	
	public int updateStatusCompany(int id, boolean isApproved)
	{
		int x =0;
		
		c = ConnectionClass.getConnection();
		String q = "update company set isApproved = ? where companyid = ?";
		
		try 
		{
			PreparedStatement ps = c.prepareStatement(q);
			ps.setBoolean(1, isApproved);
			ps.setInt(2, id);
			
			x = ps.executeUpdate();
			
			c.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return x;
	}
}
