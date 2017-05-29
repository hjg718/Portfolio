package team.board.model;

import java.sql.Date;

public class BoardVO {

	private int num; // 글 번호 (pk_)
	private String title; // 글 제목
	private String contents; //글 내용
	private String author; //작성자
	private Date regdate; // 작성 날짜
	private int ref;
	private int readCnt; // 조회수
	private int goodcnt; // 추천수
	private String goodname; //추천인(추천 눌렀을때 추천한 아이디 저장)
	private int goodnum;//추천한 글번호
	private int currpage;
	private int totalpage;
	
	//------------------------------
	public int getNum() {return num;}
	public void setNum(int num) {this.num = num;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
	
	public String getContents() {return contents;}
	public void setContents(String contents) {this.contents = contents;}
	
	public String getAuthor() {return author;}
	public void setAuthor(String author) {this.author = author;}
	
	public Date getRegdate() {return regdate;}
	public void setRegdate(Date regdate) {this.regdate = regdate;}
	
	public int getRef() {return ref;}
	public void setRef(int ref) {this.ref = ref;} 
	
	public int getReadCnt() {return readCnt;}
	public void setReadCnt(int readCnt) {this.readCnt = readCnt;}
	
	public int getGoodcnt() {return goodcnt;}
	public void setGoodcnt(int goodcnt) {this.goodcnt = goodcnt;}
	
	public String getGoodname() {return goodname;}
	public void setGoodname(String goodname) {this.goodname = goodname;}
	
	public int getGoodnum() {return goodnum;}
	public void setGoodnum(int goodnum) {this.goodnum = goodnum;}
	
	public int getCurrpage() {return currpage;}
	public void setCurrpage(int currpage) {this.currpage = currpage;}
	
	public int getTotalpage() {return totalpage;}
	public void setTotalpage(int totalpage) {this.totalpage = totalpage;}
	
	
}
