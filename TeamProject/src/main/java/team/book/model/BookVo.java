package team.book.model;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BookVo {

	private int bnum;
	private String bname;
	private String bindex;
	private String author;
	private String publisher;
	private String bcontents;
	private String pdate;
	private List<String> cate;
	private MultipartFile cover;
	private String coverName;
	
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	
	public String getBcontents() {
		return bcontents;
	}
	public void setBcontents(String bcontents) {
		this.bcontents = bcontents;
	}
	public String getBindex() {
		return bindex;
	}
	public void setBindex(String bindex) {
		this.bindex = bindex;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public List<String> getCate() {
		return cate;
	}
	public void setCate(List<String> cate) {
		this.cate = cate;
	}
	public MultipartFile getCover() {
		return cover;
	}
	public void setCover(MultipartFile cover) {
		this.cover = cover;
	}
	public String getCoverName() {
		return coverName;
	}
	public void setCoverName(String coverName) {
		this.coverName = coverName;
	}

	
	
}
