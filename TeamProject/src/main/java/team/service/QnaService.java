package team.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.scripts.JS;
import team.QnA.model.Qna;
import team.QnA.model.QnaDao;
import team.QnA.model.QnaVo;

@Service
public class QnaService {
	
	@Autowired
	private SqlSessionTemplate sqlST;

	public boolean save(QnaVo vo){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONObject job = new JSONObject();
		int input = dao.save(vo);
		boolean ok ;
		if(input == 0){
			ok = false;
		}else {
			ok = true;
		}
		return ok;
	}
	
	public ArrayList<QnaVo> list(){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		return dao.list();
	}
	
	
	public String page(int num){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONArray jarr = new JSONArray();
		Qna list = dao.getPage(num);
		for(int i=0; i<list.getList().size(); i++){
			JSONObject job = new JSONObject();
			job.put("title",list.getList().get(i).getTitle());
			job.put("num",list.getList().get(i).getNum());
			job.put("author",list.getList().get(i).getAuthor());
			jarr.add(job);
		}
		return jarr.toJSONString();
	}
	

	public QnaVo read(int num){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		return dao.read(num);
	}
	
	public String find(String keyword,String category,int pgnum){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		JSONArray jarr = new JSONArray();
		ArrayList<QnaVo> list = dao.find(keyword,category,pgnum);
		for(int i=0; i<list.size(); i++){
			JSONObject job = new JSONObject();
			job.put("num",list.get(i).getNum());
			job.put("title",list.get(i).getTitle());
			job.put("author",list.get(i).getAuthor());
			job.put("total",list.get(i).getTotalpages());
			job.put("curr",list.get(i).getPage());
			jarr.add(job);
		}
		return jarr.toJSONString();
	}
	
	
	public boolean modify(QnaVo vo){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		int row = dao.modify(vo);
		boolean ok ;
		if(row>0){
			ok=true;
		}
		else{
			ok=false;
		}
		return ok;
	}
	
	public String delete(int num,int pwd){
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		QnaVo vo = dao.read(num);
		JSONObject job = new JSONObject();
		
		if(vo.getPwd()==pwd){
			int row = dao.delete(num);
			if(row>0){
				job.put("pass",true);
				return job.toJSONString();
			}
		}else if(vo.getPwd()!=pwd){
			job.put("pass",false);
		}
		return job.toJSONString();
	}

	public QnaVo recent(String id) {
		QnaDao dao = sqlST.getMapper(QnaDao.class);
		QnaVo vo = dao.recent(id);
		return vo;
	}
	
}
