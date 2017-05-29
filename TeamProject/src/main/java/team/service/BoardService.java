package team.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.board.model.Board;
import team.board.model.BoardDAO;
import team.board.model.BoardVO;



@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlST;

	//게시판 첫 페이지
	public Board boardFirstPage(int num){
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		Board b = dao.boardPage(num);
		return b;
	}
	//게시판 추천수
	public List<BoardVO> goodList(){
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.goodList();
		return list;
	}
	//페이지 번호 클릭
	public Board boardPage(int page) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		Board b = dao.boardPage(page);
		return b;
	}
	//제목 클릭시 상세내용 보여주기
	public BoardVO info(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		BoardVO board = dao.info(num);
		return board;
	}
	//수정
	public boolean update(BoardVO board) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int n = dao.update(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//삭제
	public boolean delete(int num) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int n =dao.delete(num);
		boolean ok =false;
		if(n>0){
			ok=true;
		}
		else if(n<0){
			ok=false;
		}
		return ok;

	}
	//글쓰기
	public boolean input(BoardVO board) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int n = dao.input(board);
		boolean ok =false;
		if(n>0){
			ok = true;
		}
		return ok;
	}
	//검색
	public String search(String cat, String key, int page) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.search(cat,key, page);
		JSONArray jar = new JSONArray();
		for(int i = 0 ; i<list.size(); i++){
			JSONObject job = new JSONObject();
			job.put("num", list.get(i).getNum());
			job.put("title",list.get(i).getTitle());
			job.put("author",list.get(i).getAuthor());
			job.put("currpage",list.get(i).getCurrpage());
			job.put("totalpage",list.get(i).getTotalpage());
			job.put("readCnt",list.get(i).getReadCnt());
			job.put("goodcnt",list.get(i).getGoodcnt());
			jar.add(job);
		}		
		return jar.toJSONString();
	}
	//조회수
	public void readCnt(BoardVO boardvo) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		int cnt = boardvo.getReadCnt();//조회수 +1
		boardvo.setReadCnt(cnt);
		dao.readCnt(boardvo);
	}
	//추천수, 추천 중복 불가
	public boolean goodCnt(BoardVO board) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		boolean ok = false;
		boolean good = true;

		String goodId= board.getGoodname();
		int goodNum = board.getGoodnum();

		List<BoardVO> list = dao.goodUserList(board);

		//처음에 글에서 추천누르면 유저의 아이디가 DB테이블에 없으므로 if문 시작
		if(list.size() == 0){
			good=true;
		}
		else{
			for(int i = 0 ; i<list.size();i++){
				//글번호와 리스트에서 가져온 글번호가 같으면
				if(goodNum == list.get(i).getGoodnum()){
					good=false;
				}
			}
		}
		if(good){
			int n = dao.goodCnt(board); //추천수 +1 하기
			if(n>0){
				ok = true;
				dao.goodCntUser(board); // 로그인된 아이디와, 글번호를 저장
				return ok;
			}
		}
		if(good == false){
			return ok=false;
		}
		return false;
	}
	public BoardVO recent(String id) {
		BoardDAO dao = sqlST.getMapper(BoardDAO.class);
		BoardVO vo = dao.recent(id);
		return vo;
	}



}
