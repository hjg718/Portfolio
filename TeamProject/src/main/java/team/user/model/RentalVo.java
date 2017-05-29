package team.user.model;

import java.util.Date;

public class RentalVo {

	private int num;
	private Date rentaldate;
	private String returndate;
	private String rendate;
	private int booknum;
	private String day;
	private String bookname;
	private String rentalUser;
	private int status;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public Date getRentaldate() {
		return rentaldate;
	}
	public void setRentaldate(Date rentaldate) {
		this.rentaldate = rentaldate;
	}
	public String getReturndate() {
		return returndate;
	}
	public void setReturndate(String returndate) {
		this.returndate = returndate;
	}
	public int getBooknum() {
		return booknum;
	}
	public void setBooknum(int booknum) {
		this.booknum = booknum;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getRendate() {
		return rendate;
	}
	public void setRendate(String rendate) {
		this.rendate = rendate;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getRentalUser() {
		return rentalUser;
	}
	public void setRentalUser(String rentalUser) {
		this.rentalUser = rentalUser;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
