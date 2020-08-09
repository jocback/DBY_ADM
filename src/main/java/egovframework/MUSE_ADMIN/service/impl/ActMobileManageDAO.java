package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActMobileManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActMobileManageDAO")
public class ActMobileManageDAO extends EgovComAbstractDAO {

	/*목록*/
	public List<?> selectActMobileList(ActMobileManageVO freeVO) throws Exception {
		if("conf".equals(freeVO.getTableNm())){
			return selectList("ActMobileManage.selectActMobileList", freeVO);
		}else{
			return selectList("ActMobileManage.selectActMobileList", freeVO);
		}
	}
	public Map<String,Object> selectActMobileListCnt(ActMobileManageVO freeVO) throws Exception {
		freeVO.setActListMode("COUNT");
		return selectOne("ActMobileManage.selectActMobileList", freeVO);
	}

	public Map<String,Object> selectActMobileTotCnt(ActMobileManageVO freeVO) throws Exception {
		return selectOne("ActMobileManage.selectActMobileTotCnt", freeVO);
	}
	/*등록*/
	public void insertActMobileConf(ActMobileManageVO vo) throws Exception {
		insert("ActMobileManage.insertActMobileConf", vo);
	}
	/*삭제*/
	public void deleteMobileConf(ActMobileManageVO vo) throws Exception {
		delete("ActMobileManage.deleteMobileConf", vo);
	}

	public void deleteMobileDevice(ActMobileManageVO vo) throws Exception {
		delete("ActMobileManage.deleteMobileDevice", vo);
	}

}
