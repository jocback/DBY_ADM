package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActMovingManageDAO")
public class ActMovingManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActMovingDetail(ActMovingManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActMovingManage.selectActMovingDetail", vo);
	}
	/*목록*/
	public List<?> selectActMovingList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActMovingManage.selectActMovingListExcel", searchVO);
		}else if("type".equals(searchVO.getActListMode())){
			return selectList("ActMovingManage.selectActMovingType", searchVO);
		}else{
			return selectList("ActMovingManage.selectActMovingList", searchVO);
		}
	}
	/*총 갯수*/
	public int selectActMovingListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActMovingManage.selectActMovingListTotCnt", searchVO);
	}
	public String selectActMovingMaxIdx(ActMovingManageVO vo) {
		return (String) selectOne("ActMovingManage.selectActMovingMaxIdx", vo);
	}
	/*등록*/
	public void insertActMoving(ActMovingManageVO vo) throws Exception {
		insert("ActMovingManage.insertActMoving", vo);
	}
	/*수정*/
	public void updateActMoving(ActMovingManageVO vo) throws Exception {
		update("ActMovingManage.updateActMoving", vo);
	}
	/*삭제*/
	public void deleteActMoving(ActMovingManageVO vo) throws Exception {
		delete("ActMovingManage.deleteActMoving", vo);
	}
	/*교재등록*/
	public void insertActLectureBook(ActMovingManageVO vo) throws Exception {
		insert("ActMovingManage.insertActLectureBook", vo);
	}
	public void deleteActLectureBook(ActMovingManageVO vo) throws Exception {
		delete("ActMovingManage.deleteActLectureBook", vo);
	}
	public List<?> selectActLectureBook(ActMovingManageVO vo) throws Exception {
		return selectList("ActMovingManage.selectActLectureBook", vo);
	}
	/*동영상등록*/
	public void insertActLectureClip(ActMovingManageVO vo) throws Exception {
		insert("ActMovingManage.insertActLectureClip", vo);
	}
	public void updateActLectureClip(ActMovingManageVO vo) throws Exception {
		update("ActMovingManage.updateActLectureClip", vo);
	}
	public void deleteActLectureClip(ActMovingManageVO vo) throws Exception {
		delete("ActMovingManage.deleteActLectureClip", vo);
	}
	public List<?> selectActLectureClip(ActMovingManageVO vo) throws Exception {
		return selectList("ActMovingManage.selectActLectureClip", vo);
	}

}
