package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBannerManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActBannerManageDAO")
public class ActBannerManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActBannerDetail(ActBannerManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActBannerManage.selectActBannerDetail", vo);
	}
	/*목록*/
	public List<?> selectActBannerList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActBannerManage.selectActBannerListExcel", searchVO);
		}else{
			return selectList("ActBannerManage.selectActBannerList", searchVO);
		}
	}
	/*총 갯수*/
	public int selectActBannerListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActBannerManage.selectActBannerListTotCnt", searchVO);
	}
	/*월별목록*/
	public List<?> selectActBannerMonthly(ActBannerManageVO vo) throws Exception {
		return selectList("ActBannerManage.selectActBannerMonthly", vo);
	}
	/*회원 정보 한가지 추출*/
	public String selectActBannerInfoOne(ActManageDefaultVO searchVO) {
		return (String) selectOne("ActBannerManage.selectActBannerInfoOne", searchVO);
	}
	/*등록*/
	public void insertActBanner(ActBannerManageVO vo) throws Exception {
		insert("ActBannerManage.insertActBanner", vo);
	}
	/*수정*/
	public void updateActBanner(ActBannerManageVO vo) throws Exception {
		update("ActBannerManage.updateActBanner", vo);
	}
	/*삭제*/
	public void deleteActBanner(ActBannerManageVO vo) throws Exception {
		delete("ActBannerManage.deleteActBanner", vo);
	}

	public void updateActBannerSeq(ActBannerManageVO vo) throws Exception {
		update("ActBannerManage.updateActBannerSeq", vo);
	}

}
