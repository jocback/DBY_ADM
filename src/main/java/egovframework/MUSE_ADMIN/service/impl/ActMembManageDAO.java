package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActMembManageDAO")
public class ActMembManageDAO extends EgovComAbstractDAO {
	public boolean isNull(String str) {
		return (str == null || str.trim().length() < 1);
	}
	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object>  selectActMembDetail(ActMembManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActMembManage.selectActMembDetail", vo);
	}
	/*목록*/
	public List<?> selectActMembList(ActManageDefaultVO searchVO) throws Exception {
			return selectList("ActMembManage.selectActMembList", searchVO);
	}
	public List<?> selectActMembExcelList(ActManageDefaultVO searchVO) throws Exception {
			return selectList("ActMembManage.selectActMembExcelList", searchVO);
	}
	/*총 갯수*/
	public int selectActMembListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActMembManage.selectActMembListTotCnt", searchVO);
	}
	public int selectActMembExcelListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActMembManage.selectActMembExcelListTotCnt", searchVO);
	}

	/*등록*/
	public void insertActMemb(ActMembManageVO vo) throws Exception {
		insert("ActMembManage.insertActMemb", vo);
	}
	/*수정*/
	public void updateActMemb(ActMembManageVO vo) throws Exception {
		update("ActMembManage.updateActMemb", vo);
		if((vo.getmGubun()).equals("21") && ("PROF").equals(vo.getActListMode())){
			insert("ActMembManage.insertActProfSub", vo);
		}
	}
	/*삭제*/
	public void deleteActMemb(ActMembManageVO vo) throws Exception {
		delete("ActMembManage.deleteActMemb", vo);
	}

	public void updateProfSeq(ActMembManageVO vo) throws Exception {
		delete("ActMembManage.updateProfSeq", vo);
	}

	public List<?> selectActEquipList(ActMembManageVO vo) throws Exception {
			return selectList("ActMembManage.selectActEquipList", vo);
	}

	public void deleteActEquip(ActManageDefaultVO searchVO) throws Exception {
		if("1".equals(searchVO.getSearchCnd())){
			delete("ActMembManage.deleteActEquip1", searchVO);
		}else{
			delete("ActMembManage.deleteActEquip2", searchVO);
		}
	}

	public List<?> selectActMembDelList(ActManageDefaultVO searchVO) throws Exception {
			return selectList("ActMembManage.selectActMembDelList", searchVO);
	}
	public int selectActMembDelListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActMembManage.selectActMembDelListTotCnt", searchVO);
	}

	public void cancelDelActMemb(ActMembManageVO vo) throws Exception {
		delete("ActMembManage.cancelDelActMemb", vo);
	}

	public void withdrawActMembInfo(ActMembManageVO vo) throws Exception {
		delete("ActMembManage.withdrawActMembInfo", vo);
	}

	public void delMemoActMembInfo(ActMembManageVO vo) throws Exception {
		update("ActMembManage.delMemoActMembInfo", vo);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object>  selectActMemTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return (Map<String, Object>) selectOne("ActMembManage.selectActMemTotCnt", searchVO);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object>  selectActMemLoginTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return (Map<String, Object>) selectOne("ActMembManage.selectActMemLoginTotCnt", searchVO);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object>  selectActMemCondTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return (Map<String, Object>) selectOne("ActMembManage.selectActMemCondTotCnt", searchVO);
	}
}
