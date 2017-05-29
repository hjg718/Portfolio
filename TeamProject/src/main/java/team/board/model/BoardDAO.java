package team.board.model;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardDAO {
	public Board boardPage(int pageNum); //리스트,페이지 번호
	public int input(BoardVO board); // 새 글쓰기
	public BoardVO info(int num);//제목 클릭시 내용 보여주기
	public int update(BoardVO board); //수정
	public int delete(int num); //삭제
	public void readCnt(BoardVO board); //조회수
	public List<BoardVO> goodList();//추천수 리스트
	
	public int goodCnt(BoardVO board);//추천수
	public void goodCntUser(BoardVO board);//추천인 저장
	public List<BoardVO> goodUserList(BoardVO board);//추천한 아이디와 추천글 리스트 
	
	public List<BoardVO> search(
	@Param("category") String cat,@Param("keyword") String key, @Param("page") int page ); //검색
	public BoardVO recent(String id);
	
	


	
}
