package team.book.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BookDao {

	public Book search(@Param("keyword")String keyword,
			@Param("category")String category,@Param("page") int num);

	public int add(BookVo vo);

	public void addcate(@Param("num") int num,@Param("cate") String string);

	public Book readRental(int bnum);

	public int rental(@Param("booknum")int booknum,@Param("userid") String userid);

	public int addCurrbook(@Param("userid")String userid);
	
	public int decCurrbook(@Param("userid")String userid);
	
	public int check(@Param("userid")String userid);

	public int returnBook(int num);

	public int checkBook(int booknum);

	public int booking(@Param("booknum")int booknum,@Param("userid") String userid);

	public List<String> subscriber(int bnum);
	
	public BookVo read(int bnum);

	public int cancel(int num);

	public int edit(BookVo vo);

	public List<String> getcate(int bnum);

	public void removeCate(@Param("bnum")int bnum, @Param("cate")String cate);

	public int delete(int booknum);
	
}
