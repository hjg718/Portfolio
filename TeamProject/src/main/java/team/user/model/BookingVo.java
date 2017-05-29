package team.user.model;

import java.util.Date;
import java.util.List;

import team.book.model.BookVo;

public class BookingVo {
	
	private int num;
	private String bookname;
	private int booknum;
	private boolean ok;
	private String rendate;
	private String returndate;
	private String day;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}

	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	
	public int getBooknum() {
		return booknum;
	}
	public void setBooknum(int booknum) {
		this.booknum = booknum;
	}
	
	public boolean isOk() {
		return ok;
	}
	public void setOk(boolean ok) {
		this.ok = ok;
	}
	public String getRendate() {
		return rendate;
	}
	public void setRendate(String rendate) {
		this.rendate = rendate;
	}
	public String getReturndate() {
		return returndate;
	}
	public void setReturndate(String returndate) {
		this.returndate = returndate;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	
	
}
