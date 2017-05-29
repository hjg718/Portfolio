package team.user.model;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class UserVo {
	
	@Size(min=3,max=16, message="1~10자로 입력해주세요")
	private String userid;
	@NotEmpty(message="필수입력 항목입니다")
	private String upwd;
	private String uname;
	private String phone;
	private String uemail;
	private String gender;
	private String authority;
	private int maxBook;
	private int currBook;
	


	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public int getMaxBook() {
		return maxBook;
	}
	public void setMaxBook(int maxBook) {
		this.maxBook = maxBook;
	}
	public int getCurrBook() {
		return currBook;
	}
	public void setCurrBook(int currBook) {
		this.currBook = currBook;
	}
	
	

}
