package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBookManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActBookManageDAO")
public class ActBookManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActBookDetail(ActBookManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActBookManage.selectActBookDetail", vo);
	}
	/*목록*/
	public List<?> selectActBookList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActBookManage.selectActBookListExcel", searchVO);
		}else{
			if("type".equals(searchVO.getActListMode())){
				return selectList("ActBookManage.selectActBookType", searchVO);
			}else{
				return selectList("ActBookManage.selectActBookList", searchVO);
			}
		}
	}
	/*총 갯수*/
	public int selectActBookListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActBookManage.selectActBookListTotCnt", searchVO);
	}
	public String selectActBookMaxIdx(ActBookManageVO vo) {
		return (String) selectOne("ActBookManage.selectActBookMaxIdx", vo);
	}
	/*등록*/
	public void insertActBook(ActBookManageVO vo) throws Exception {
		insert("ActBookManage.insertActBook", vo);
	}
	/*수정*/
	public void updateActBook(ActBookManageVO vo) throws Exception {
		update("ActBookManage.updateActBook", vo);
	}
	/*삭제*/
	public void deleteActBook(ActBookManageVO vo) throws Exception {
		delete("ActBookManage.deleteActBook", vo);
	}
	/*카테고리등록*/
	public void insertActBookCategory(ActBookManageVO vo) throws Exception {
		insert("ActBookManage.insertActBookCategory", vo);
	}
	public void deleteActBookCategory(ActBookManageVO vo) throws Exception {
		delete("ActBookManage.deleteActBookCategory", vo);
	}
	public List<?> selectActBookCategory(ActBookManageVO vo) throws Exception {
		return selectList("ActBookManage.selectActBookCategory", vo);
	}

}
