package team.controller;

import java.util.*;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import team.board.model.Board;
import team.board.model.BoardVO;
import team.service.BoardService;


@Controller
@RequestMapping("board/")
public class BoardController {

	@Autowired
	private BoardService svc;
	
	//게시판 첫 화면 
	@RequestMapping(value="list")
	public String boardListStart(Model model){
		Board b = svc.boardFirstPage(1);
		List<BoardVO> list = b.getList();
		model.addAttribute("total",b.getTotalpage());
		model.addAttribute("curr", b.getCurrpage());
		model.addAttribute("boardlist",list);
		
		List<BoardVO> goodList =svc.goodList();//추천수가 많은 리스트
		model.addAttribute("goodlist",goodList);
		return "board/boardList";
	}
	//페이지 번호
	@RequestMapping("listPage")
	@ResponseBody
	public List<BoardVO> listPage(Model model, @RequestParam("page") int page){
		Board b = svc.boardPage(page);
		List<BoardVO> list = b.getList();
		model.addAttribute("list",list);
		return list;
	}
	//게시판 글 쓰기1
	@RequestMapping("inputPage")
	public String inputPage(Model model, BoardVO board){
		return "board/boardInput";
	}
	//게시판 글 쓰기2
	@RequestMapping(value="input")
	public String input(Model model, BoardVO board){
		boolean ok = svc.input(board);
		if(ok){
			BoardVO vo = svc.info(board.getNum());
			model.addAttribute("board", vo);
		}
		return "board/boardRecent";
	}
	
	//댓글
	@RequestMapping("boardRepl")
	@ResponseBody
	public String boardRepl(Model model,BoardVO board){
		boolean ok = svc.input(board);
		JSONObject job = new JSONObject();
		job.put("ok", ok);
		return job.toJSONString();
	}
	
	//제목 클릭시 내용 읽어오기  , 조회수
	@RequestMapping("info")
	public String info(@RequestParam("num") int num,BoardVO boardvo,Model model){
		svc.readCnt(boardvo); // 조회수  void 이게 먼저 실행
		//svc.readCnt(boardVO) 실행후 밑에가 실행 된다.
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardInfo";
	}
	
	//수정1
	@RequestMapping("edit")
	public String edit(Model model, @RequestParam("num") int num){
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardEdit";
	}
	//수정2
	@RequestMapping("update")
	@ResponseBody
	public String update(Model model,BoardVO board){
		boolean ok = svc.update(board);
		JSONObject job = new JSONObject();
		job.put("ok",ok);
		return job.toJSONString();
	}
	//삭제
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model , @RequestParam("num") int num){
		boolean ok = svc.delete(num);
		JSONObject job= new JSONObject();
			job.put("ok", ok);
		return job.toJSONString();
	}
	//검색
	@RequestMapping("search")
	@ResponseBody
	public String search(Model model,@RequestParam("category") String cat,
									 @RequestParam("keyword") String key,
									 @RequestParam("page") int page){
			String list = svc.search(cat, key, page);
			return list;
	}
	//추천
	@RequestMapping("good")
	@ResponseBody
	public String goodCnt(BoardVO board){
			boolean ok = svc.goodCnt(board);
			JSONObject job = new JSONObject();
			job.put("ok",ok);
		return job.toJSONString();
	}
	
	@RequestMapping("recent")
	public String recent(@RequestParam("id")String id, Model model){
		BoardVO vo = svc.recent(id);
		model.addAttribute("board",vo);
		return "board/boardRecent";
	}
}
