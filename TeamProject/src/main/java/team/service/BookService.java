package team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import team.book.model.Book;
import team.book.model.BookDao;
import team.book.model.BookVo;

@Service
public class BookService {

	@Autowired
	private SqlSessionTemplate sqlST;
	
	@Autowired
    protected JavaMailSender  mailSender;

	
	public Book search(String keyword,String category){
		BookDao dao = sqlST.getMapper(BookDao.class);
		Book book= dao.search(keyword,category,1);
		return book;
	}

	public boolean add(BookVo vo) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		MultipartFile file = vo.getCover();
		String[] name= file.getOriginalFilename().split("\\.");
		vo.setCoverName(name[1]);
		int row = dao.add(vo);
		if(row>0){
			for(int i=0;i<vo.getCate().size();i++){
				dao.addcate(vo.getBnum(),vo.getCate().get(i));
			}
			InputStream ins = null;
			OutputStream ous = null;
			try {
				ins = file.getInputStream();
				String coverName= vo.getBnum()+"."+name[1];
				File f = new File("D:/upload/"+coverName);
				byte[] buf = new byte[1024];
				int read = 0;
				ous = new FileOutputStream(f);
				while((read=ins.read(buf))!=-1){
					ous.write(buf, 0, read);
					ous.flush();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					ins.close();
					ous.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return true;
		}
		return false;
	}

	

	public String searchPage(String keyword, String category, int page) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		Book book= dao.search(keyword,category,page);
		List<BookVo> list= book.getList();
		JSONArray jarr = new JSONArray();
		for(int i=0;i<list.size();i++){
			JSONObject jobj = new JSONObject();
			jobj.put("bnum", list.get(i).getBnum());
			jobj.put("bname", list.get(i).getBname());
			jobj.put("coverName", list.get(i).getCoverName());
			jobj.put("publisher", list.get(i).getPublisher());
			jobj.put("author", list.get(i).getAuthor());
			jarr.add(jobj);
		}
		return jarr.toJSONString();
	}

	public Book read(int bnum) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		BookVo vo = dao.read(bnum);
		Book book = dao.readRental(bnum);
		if(book!=null){
			Calendar cal = new GregorianCalendar(Locale.KOREA);
			cal.setTime(book.getRentaldate());
			cal.add(Calendar.DAY_OF_YEAR, 10);
			SimpleDateFormat sd = new SimpleDateFormat("MM-dd");
			String returndate = sd.format(cal.getTime());
			book.setReturndate(returndate);
		}
		else if(book==null){
			book = new Book();
		}
		int num = dao.checkBook(bnum);
		List<String> subscriber = dao.subscriber(bnum);
		book.setBookingnum(num);
		book.setSubscriber(subscriber);
		book.setVo(vo);
		return book;
	}

	public String rental(int booknum, String userid) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int pass = dao.check(userid);
			if(pass>0){
				int row = dao.rental(booknum,userid);
				if(row>0){
					dao.addCurrbook(userid);
					jobj.put("pass", true);
				}
			}
			else jobj.put("pass", false);
		return jobj.toJSONString();
	}

	public String returnBook(int num,int bnum,String id)  {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int row = dao.returnBook(num);
		BookVo vo = dao.read(bnum);
		if(row>0){
			jobj.put("pass", true);
			MimeMessage msg = mailSender.createMimeMessage();
			try {
				InternetAddress addr = new InternetAddress("hjg718@naver.com");
				msg.setFrom(addr);
				msg.setSubject(id+"���� ������ �ݳ��ϼ̽��ϴ�.");
				
				Multipart multipart = new MimeMultipart();
				BodyPart messageBodyPart = new MimeBodyPart();
				String htmlText = "<div><img src=\"cid:my-image\" style=\"width: 150px; height: 150px; vertical-align: middle;\" >"
						+"&thinsp;&thinsp;&thinsp;&thinsp; <span  style=\" font-size:15pt;\" >"+id+"���� ["+vo.getBname()+"] �� �ݳ� �ϼ̽��ϴ�. </span>"
						+ "<a href=\"http://192.168.0.111:8081/TeamProject/user/info\" style=\" font-size: 15pt;\" >�ݳ����� �Ϸ�����</a></div>";
				messageBodyPart.setContent(htmlText, "text/html;charset=utf-8");
				multipart.addBodyPart(messageBodyPart);
				
				messageBodyPart = new MimeBodyPart();
				File file = new File("D:/upload/"+vo.getCoverName());
				FileDataSource fds = new FileDataSource(file);
				messageBodyPart.setDataHandler(new DataHandler(fds));
				messageBodyPart .setHeader("Content-ID","<my-image>");
				multipart.addBodyPart(messageBodyPart);
				
				msg.setContent(multipart, "text/plain;charset=utf-8");
			
				
				msg.setRecipient(RecipientType.TO , new InternetAddress("hjg718@naver.com"));
			    mailSender.send(msg);
			} catch (Exception e) {
				System.err.println("���� ����");
				e.printStackTrace();
			}
		}
		return jobj.toJSONString();
	}

	public String booking(int booknum, String userid) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int pass = dao.checkBook(booknum);
			if(pass<5){
				int row = dao.booking(booknum,userid);
				if(row>0){
					jobj.put("pass", true);
				}
			}
			else jobj.put("pass", false);
		return jobj.toJSONString();
	}

	public String cancel(int num) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int row = dao.cancel(num);
		if(row>0){
			jobj.put("pass", true);
		}
		else jobj.put("pass", false);
		return jobj.toJSONString();
	}

	public String bookingrental(int booknum, int bookingnum, String userid) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int pass = dao.check(userid);
		if(pass>0){
			int row = dao.rental(booknum,userid);
			if(row>0){
				dao.addCurrbook(userid);
				dao.cancel(bookingnum);
				jobj.put("pass", true);
			}
		}
		else jobj.put("pass", false);
		return jobj.toJSONString();
	}

	public boolean edit(BookVo vo) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		MultipartFile file = vo.getCover();
		if(file.getSize()==0){
			int row = dao.edit(vo);
			if(row>0){
				List<String> newCate = vo.getCate();
				List<String> saveCate = dao.getcate(vo.getBnum());
				for(int i=0;i<saveCate.size();i++){
					boolean ok = false;
					for(int j = newCate.size()-1; j>=0;j--){
						if(saveCate.get(i).equals(newCate.get(j))){
							newCate.remove(j);
							ok=true;
						}
					}
					if(!ok){
						dao.removeCate(vo.getBnum(),saveCate.get(i));
					}
				}
				for(int i=0;i<newCate.size();i++){
					dao.addcate(vo.getBnum(),newCate.get(i));
				}
				return true;
			}
		}
		if(file.getSize() != 0){
			InputStream ins = null;
			OutputStream ous = null;
			try {
				String[] name= file.getOriginalFilename().split("\\.");
				String coverName= vo.getBnum()+"."+name[1];
				vo.setCoverName(coverName);
				ins = file.getInputStream();
				File f = new File("D:/upload/"+coverName);
				byte[] buf = new byte[1024];
				int read = 0;
				ous = new FileOutputStream(f);
				while((read=ins.read(buf))!=-1){
					ous.write(buf, 0, read);
					ous.flush();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				try {
					ins.close();
					ous.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			int row = dao.edit(vo);
			if(row>0){
				List<String> newCate = vo.getCate();
				List<String> saveCate = dao.getcate(vo.getBnum());
				for(int i=0;i<saveCate.size();i++){
					boolean ok = false;
					for(int j = newCate.size()-1; j>=0;j--){
						if(saveCate.get(i).equals(newCate.get(j))){
							newCate.remove(j);
							ok=true;
						}
					}
					if(!ok){
						dao.removeCate(vo.getBnum(),saveCate.get(i));
					}
				}
				for(int i=0;i<newCate.size();i++){
					dao.addcate(vo.getBnum(),newCate.get(i));
				}
				return true;
			}
		}
		return false;
	}

	public String delete(int booknum) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		int row = dao.delete(booknum);
		JSONObject jobj = new JSONObject();
		if(row>0){
			jobj.put("pass", true);
		}
		else jobj.put("pass", false); 
		return jobj.toJSONString();
	}

	public String returnConfirm(int num, String userid) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		JSONObject jobj = new JSONObject();
		int row = dao.returnConfirm(num);
		if(row>0){
			dao.decCurrbook(userid);
			jobj.put("pass", true);
		}
		return jobj.toJSONString();
	}
}
