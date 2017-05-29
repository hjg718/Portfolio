package team.board.model;

import java.util.List;

public class Board {
	
	
	private List<BoardVO> list;
	private int totalpage; // 총 페이지
	private int currpage; // 현재 페이지
	
	//------------------------------------------------
	
	public List<BoardVO> getList() {return list;}
	public void setList(List<BoardVO> list) {this.list = list;}
	
	public int getTotalpage() {return totalpage;}
	public void setTotalpage(int totalpage) {this.totalpage = totalpage;}
	
	public int getCurrpage() {return currpage;}
	public void setCurrpage(int currpage) {this.currpage = currpage;}
	
	
	
	
	
}
