package team.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.glass.ui.delegate.MenuBarDelegate;

import team.service.UserService;
import team.user.model.User;
import team.user.model.UserVo;

@Controller
@RequestMapping("user/")
public class UserController {
	
	@Autowired
	UserService svc;

	@RequestMapping(value="join",method=RequestMethod.GET)
	public String joinForm(UserVo vo){
		return "user/join";
	}
	@RequestMapping(value="join",method=RequestMethod.POST)
	public String join(@Valid UserVo vo, BindingResult result,Model model){
		if(result.hasErrors()){
			return "user/join";
		}
		boolean pass = svc.join(vo);
		if(!pass){
			model.addAttribute("overlap",true);
			return "user/join";
		}
		else{
			model.addAttribute("join", true);
		}
		return "user/login";
	}
	@RequestMapping("check")
	@ResponseBody
	public String check(@RequestParam("id") String id){
		String ok = svc.check(id);
		return ok;
	}
	
	@RequestMapping("login")
	public String loginform(){
		return "user/login";
	}
	
	@RequestMapping("info")
	public String info(@RequestParam("id") String id,Model model){
		User info = svc.getinfo(id);
		model.addAttribute("info", info);
		return "user/info";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(@RequestParam("id") String id,Model model){
		UserVo vo = svc.getvo(id);
		model.addAttribute("userVo", vo);
		return "user/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(UserVo vo,@RequestParam("newpwd")String newpwd,Model model){
		boolean pass= svc.edit(vo,newpwd);
		if(pass){
			model.addAttribute("info", svc.getinfo(vo.getUserid()));
			return "user/info";
		}
		UserVo userVo = svc.getvo(vo.getUserid());
		model.addAttribute("userVo", userVo);
		model.addAttribute("error", true);
		return "user/edit";
	}
	
	@RequestMapping("secession")
	@ResponseBody
	public String secession(@RequestParam("upwd") String upwd,
			@RequestParam("userid") String userid){
		String pass = svc.secession(upwd,userid);
		return pass;
		
	}
}
