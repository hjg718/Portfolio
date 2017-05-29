package team.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.QnA.model.Qna;
import team.QnA.model.QnaVo;
import team.service.QnaService;

@Controller
@RequestMapping("qna/")
public class QnAController {
	
	@Autowired
	QnaService svc;
	
	
	@RequestMapping(value="save",method=RequestMethod.GET)
	public String savef(){
		return "qna/input";
	}
	
	@RequestMapping(value="save",method=RequestMethod.POST)
	public String save(QnaVo vo,Model model){
		boolean ok = svc.save(vo);
		if(ok==true){
			model.addAttribute("recent",svc.read(vo.getNum()));
		}
		return "qna/recent";
	}
	
	@RequestMapping(value="list")
	public String list(QnaVo vo,Model model){
		ArrayList<QnaVo> list = svc.list();
		model.addAttribute("list",list);
		return "qna/list"; 
	}
	
	@RequestMapping(value="page", method=RequestMethod.POST)
	@ResponseBody
	public String getPage(@RequestParam("pgnum") int num){
		String list = svc.page(num);
		return list;
	}
	

	@RequestMapping(value="read")
	public String Read(@RequestParam("num")int num,Model model,QnaVo vo,HttpSession session){
		session.setAttribute("read",svc.read(num));
		return "qna/read";
	}
	
	@RequestMapping(value="find")
	@ResponseBody
	public String find(@RequestParam("keyword")String keyword, @RequestParam("category")String category,@RequestParam("pgnum")int pgnum
			,HttpSession session){
		String list = svc.find(keyword, category, pgnum);
		return list;
	}
	
	@RequestMapping(value="recent")
	public String recent(@RequestParam("id")String id,Model model){
		model.addAttribute("recent",svc.recent(id));
		return "qna/recent";
	}
	
	@RequestMapping(value="modifyPage")
	public String ModifyF(@RequestParam("num")int num,@RequestParam("pwd")int pwd,Model model){
		QnaVo vo = svc.read(num);
		model.addAttribute("read", vo);
		if(vo.getPwd()==pwd){
			return "qna/modify";
		}
		model.addAttribute("error", true);
		return "qna/read";
	}
	
	@RequestMapping(value="modify",method=RequestMethod.POST)
	public String setUpdateModify(QnaVo vo,Model model){
		boolean ok = svc.modify(vo);
		if(ok==true){
			model.addAttribute("read", svc.read(vo.getNum()));
			return "qna/read";
		}
		model.addAttribute("read", svc.read(vo.getNum()));
		model.addAttribute("error", true);
		return "qna/modify";
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public String Delete(@RequestParam("num")int num,@RequestParam("pwd")int pwd){
		String del = svc.delete(num,pwd);
		return del;
	}
	
	@RequestMapping(value="reple")
	@ResponseBody
	public Map<String, Boolean> Reple(QnaVo vo){
		Boolean ok = svc.save(vo);
		Map<String, Boolean> map = new HashMap<String, Boolean>();		
		if(ok==true){
			map.put("ok", ok);
		}
		return map;
	}
	
	
}

