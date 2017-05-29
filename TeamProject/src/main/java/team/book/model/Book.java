package team.book.model;

import java.util.Date;
import java.util.List;

public class Book {
	
	private int page;
	private int tpg;
	private List<BookVo> list;
	private String rentaluser;
	private Date rentaldate;
	private String returndate;
	private BookVo vo;
	private int bookingnum;
	private List<String> subscriber;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTpg() {
		return tpg;
	}
	public void setTpg(int tpg) {
		this.tpg = tpg;
	}
	public List<BookVo> getList() {
		return list;
	}
	public void setList(List<BookVo> list) {
		this.list = list;
	}
	public String getRentaluser() {
		return rentaluser;
	}
	public void setRentaluser(String rentaluser) {
		this.rentaluser = rentaluser;
	}
	public Date getRentaldate() {
		return rentaldate;
	}
	public void setRentaldate(Date rentaldate) {
		this.rentaldate = rentaldate;
	}
	public BookVo getVo() {
		return vo;
	}
	public void setVo(BookVo vo) {
		this.vo = vo;
	}
	public String getReturndate() {
		return returndate;
	}
	public void setReturndate(String returndate) {
		this.returndate = returndate;
	}
	public int getBookingnum() {
		return bookingnum;
	}
	public void setBookingnum(int bookingnum) {
		this.bookingnum = bookingnum;
	}
	public List<String> getSubscriber() {
		return subscriber;
	}
	public void setSubscriber(List<String> subscriber) {
		this.subscriber = subscriber;
	}
	
	
}
