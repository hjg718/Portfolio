
package team.QnA.model;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface QnaDao {

	public int save(QnaVo vo);
	
	
	public ArrayList<QnaVo> list();
	
	public Qna getPage(int page);
	
	public QnaVo read(int num);
	
	public ArrayList<QnaVo> find(@Param("keyword")String keyword , @Param("category")String category,@Param("pgnum")int pgnum);
	
	public int modify(QnaVo vo);
	
	public int delete(int num);

	public QnaVo recent(String id);
	
}
