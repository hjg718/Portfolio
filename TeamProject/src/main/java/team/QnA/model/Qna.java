package team.QnA.model;

import java.util.List;


public class Qna {

	private List<QnaVo> list;
	
	private QnaVo vo;
	
	private int page;
	
	private int totalpages;
	
	public List<QnaVo> getList() {
		return list;
	}
	public void setList(List<QnaVo> list) {
		this.list = list;
	}
	public QnaVo getVo() {
		return vo;
	}
	public void setVo(QnaVo vo) {
		this.vo = vo;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTotalpages() {
		return totalpages;
	}
	public void setTotalpages(int totalpages) {
		this.totalpages = totalpages;
	}
	
	
}
