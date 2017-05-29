package team.user.model;

import java.util.List;


public class User {
	
	private UserVo vo;
	private List<RentalVo> rvoList;
	private List<BookingVo> bvoList;
	
	public UserVo getVo() {
		return vo;
	}
	public void setVo(UserVo vo) {
		this.vo = vo;
	}
	public List<RentalVo> getRvoList() {
		return rvoList;
	}
	public void setRvoList(List<RentalVo> rvoList) {
		this.rvoList = rvoList;
	}
	public List<BookingVo> getBvoList() {
		return bvoList;
	}
	public void setBvoList(List<BookingVo> bvoList) {
		this.bvoList = bvoList;
	}
	

}
