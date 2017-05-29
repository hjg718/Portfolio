package team.user.model;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import team.book.model.BookVo;



@Repository
public interface UserDao {
	public String check(String id);
	public int join(UserVo vo);
	public UserVo getvo(String id);
	public int edit(HashMap<String, Object> map);
	public int secession(String userid);
	public List<BookingVo> booking(String id);
	public List<RentalVo> rental(String userid);
	public Date rentalCheck(int booknum);
	public int removeBooking(String userid);
	public List<RentalVo> returnRequest();

}
