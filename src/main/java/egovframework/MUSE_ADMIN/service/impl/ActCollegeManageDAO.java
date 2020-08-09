package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActCollegeManageDAO")
public class ActCollegeManageDAO extends EgovComAbstractDAO {

	public List<?> selectActCollegeLectList(ActCollegeManageVO vo) throws Exception {
		return selectList("ActCollegeManage.selectActCollegeLectList", vo);
	}

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActCollegeDetail(ActCollegeManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActCollegeManage.selectActCollegeDetail", vo);
	}
	/*목록*/
	public List<?> selectActCollegeList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActCollegeManage.selectActCollegeListExcel", searchVO);
		}else{
			if("type".equals(searchVO.getActListMode())){
				return selectList("ActCollegeManage.selectActCollegeType", searchVO);
			}else{
				return selectList("ActCollegeManage.selectActCollegeList", searchVO);
			}
		}
	}
	/*총 갯수*/
	public int selectActCollegeListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActCollegeManage.selectActCollegeListTotCnt", searchVO);
	}
	public String selectActCollegeMaxIdx(ActCollegeManageVO vo) {
		return (String) selectOne("ActCollegeManage.selectActCollegeMaxIdx", vo);
	}
	/*등록*/
	public void insertActCollege(ActCollegeManageVO vo) throws Exception {
		insert("ActCollegeManage.insertActCollege", vo);
	}
	/*수정*/
	public void updateActCollege(ActCollegeManageVO vo) throws Exception {
		update("ActCollegeManage.updateActCollege", vo);
	}
	/*삭제*/
	public void deleteActCollege(ActCollegeManageVO vo) throws Exception {
		delete("ActCollegeManage.deleteActCollege", vo);
	}
	/*순서 수정*/
    public void updateSeqSwitch(ActCollegeManageVO vo) throws Exception {
		update("ActCollegeManage.updateSeqSwitch", vo);
    }
	/*금액등록*/
	public void insertActCollegePrice(ActCollegeManageVO vo) throws Exception {
		insert("ActCollegeManage.insertActCollegePrice", vo);
	}
	public void deleteActCollegePrice(ActCollegeManageVO vo) throws Exception {
		delete("ActCollegeManage.deleteActCollegePrice", vo);
	}
	public List<?> selectActCollegePrice(ActCollegeManageVO vo) throws Exception {
		return selectList("ActCollegeManage.selectActCollegePrice", vo);
	}
	/*동영상등록*/
	public void insertActCollegeLect(ActCollegeManageVO vo) throws Exception {
		insert("ActCollegeManage.insertActCollegeLect", vo);
	}
	public void deleteActCollegeLect(ActCollegeManageVO vo) throws Exception {
		delete("ActCollegeManage.deleteActCollegeLect", vo);
	}
	public List<?> selectActCollegeLect(ActCollegeManageVO vo) throws Exception {
		return selectList("ActCollegeManage.selectActCollegeLect", vo);
	}
	/*동영상택일설정*/
	public void insertActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		insert("ActCollegeManage.insertActCollegeOpt", vo);
	}
	public void deleteActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		delete("ActCollegeManage.deleteActCollegeOpt", vo);
	}
	public List<?> selectActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		return selectList("ActCollegeManage.selectActCollegeOpt", vo);
	}

}
