package com.model;

public class EducationModel 
{
	private int passoutYear;
	private String instituteName, degreeName, degreeDescription;
	
	public int getPassoutYear() {
		return passoutYear;
	}
	public void setPassoutYear(int passoutYear) {
		this.passoutYear = passoutYear;
	}
	public String getInstituteName() {
		return instituteName;
	}
	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}
	public String getDegreeName() {
		return degreeName;
	}
	public void setDegreeName(String degreeName) {
		this.degreeName = degreeName;
	}
	public String getDegreeDescription() {
		return degreeDescription;
	}
	public void setDegreeDescription(String degreeDescription) {
		this.degreeDescription = degreeDescription;
	}
	
	 @Override
	    public String toString() {
	        return "EducationModel{" +
	               "passoutYear=" + passoutYear +
	               ", instituteName='" + instituteName  +
	               ", degreeName='" + degreeName +
	               ", degreeDescription='" + degreeDescription +
	               '}';
	    }
}
