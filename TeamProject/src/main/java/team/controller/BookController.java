package team.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sun.xml.internal.ws.developer.MemberSubmissionAddressing;

import team.book.model.Book;
import team.book.model.BookVo;
import team.service.BookService;

@Controller
@RequestMapping("book/")
public class BookController {

	@Autowired
	BookService svc;
	
	@RequestMapping("search")
	public String search(@RequestParam("keyword")String keyword, 
			@RequestParam("category")String category,HttpSession session,Model model){
		Book book= svc.search(keyword, category);
		session.setAttribute("keyword", keyword);
		session.setAttribute("category", category);
		model.addAttribute("book", book);
		return "book/searchresult";
	}
	
	@RequestMapping("searchPage")
	@ResponseBody
	public String searchPage(@RequestParam("keyword")String keyword, 
			@RequestParam("category")String category,@RequestParam("page") int page){
		String res = svc.searchPage(keyword, category,page);
		return res;
	}
	
	@RequestMapping("add")
	public String add(){
		return "book/add";
	}
	@RequestMapping("addbook")
	public String add(BookVo vo,Model model){
		boolean pass = svc.add(vo);
		if(pass){
			Book book = svc.read(vo.getBnum());
			model.addAttribute("book", book);
		}
		return "book/recent";
	}
	@RequestMapping("img")
	@ResponseBody
	 public byte[] getImage(HttpServletResponse response, @RequestParam("coverName") String coverName) throws IOException
	 {
	    File file = new File("D:/upload/"+coverName);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");
	    return bytes;
	 }
	
	@RequestMapping("read")
	public ModelAndView read(@RequestParam("bnum")int bnum){
		Book book = svc.read(bnum);
		return new ModelAndView("book/read","book",book);
	}
	
	@RequestMapping("rental")
	@ResponseBody
	public String rental(@RequestParam("booknum")int booknum, @RequestParam("userid") String userid ){
		String pass = svc.rental(booknum,userid);
		return pass;
	}
	
	@RequestMapping("returnBook")
	@ResponseBody
	public String returnBook(@RequestParam("num")int num,@RequestParam("booknum") int bnum,Authentication auth){
		String pass= svc.returnBook(num, bnum,auth.getName());
		return pass;
	}
	
	@RequestMapping("booking")
	@ResponseBody
	public String booking(@RequestParam("booknum")int booknum, @RequestParam("userid") String userid ){
		String pass = svc.booking(booknum,userid);
		return pass;
	}
	@RequestMapping("cancel")
	@ResponseBody
	public String cancel(@RequestParam("num")int num){
		String pass = svc.cancel(num);
		return pass;
	}
	@RequestMapping("bookingrental")
	@ResponseBody
	public String bookingrental(@RequestParam("booknum")int booknum,
			@RequestParam("bookingnum")int bookingnum,@RequestParam("userid") String userid){
		String pass = svc.bookingrental(booknum,bookingnum,userid);
		return pass;
	}
	
	@RequestMapping(value="edit", method=RequestMethod.GET)
	public ModelAndView edit(@RequestParam("bnum")int bnum){
		Book book = svc.read(bnum);
		return new ModelAndView("book/bookEdit","book",book);
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String edit(Book book,Model model){
		boolean pass = svc.edit(book.getVo());
		if(pass){
			Book newBook = svc.read(book.getVo().getBnum());
			model.addAttribute("book", newBook);
		}
		else{
			Book newBook = svc.read(book.getVo().getBnum());
			model.addAttribute("error", true);
			model.addAttribute("book", newBook);
			return "book/bookEdit";
		}
		return "book/recent";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam("booknum") int booknum){
		String pass= svc.delete(booknum);
		return pass;
	}
	
	@RequestMapping("returnConfirm")
	@ResponseBody
	public String returnConfirm(@RequestParam("num")int num,@RequestParam("userid") String userid){
		String pass= svc.returnConfirm(num,userid);
		return pass;
	}
}
