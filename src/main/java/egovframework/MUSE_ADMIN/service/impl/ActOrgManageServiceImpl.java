package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrgManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrgManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrgManageService")
public class ActOrgManageServiceImpl extends EgovAbstractServiceImpl implements ActOrgManageService {

	@Resource(name = "ActOrgManageDAO")
	private ActOrgManageDAO actOrgManageDAO;

	/** ID Generation */
	@Resource(name = "egovActOrgIdGnrService")
	private EgovIdGnrService idgenService;

	@Override
	public Map<String, Object> selectActOrgDetail(ActOrgManageVO vo) throws Exception {
		return actOrgManageDAO.selectActOrgDetail(vo);
	}

	@Override
	public List<?> selectActOrgList(ActManageDefaultVO searchVO) throws Exception {
		return actOrgManageDAO.selectActOrgList(searchVO);
	}

	@Override
	public int selectActOrgListTotCnt(ActManageDefaultVO searchVO) {
		return actOrgManageDAO.selectActOrgListTotCnt(searchVO);
	}

	@Override
	public String selectActOrgInfoOne(String actField, String empId) {
		ActOrgManageVO vo = new ActOrgManageVO();
		vo.setEmpField(actField);
		vo.setEmpNo(empId);
		return actOrgManageDAO.selectActOrgInfoOne(vo);
	}

	@Override
	public void insertActOrg(ActOrgManageVO vo) throws Exception {
		String newId = idgenService.getNextStringId();
		vo.setEmpNo(newId);
		actOrgManageDAO.insertActOrg(vo);
	}

	@Override
	public void updateActOrg(ActOrgManageVO vo) throws Exception {
		actOrgManageDAO.updateActOrg(vo);
	}

	@Override
	public void updateActOrgSeq(ActOrgManageVO vo) throws Exception {
		actOrgManageDAO.updateActOrgSeq(vo);
	}

	@Override
	public void deleteActOrg(ActOrgManageVO vo) throws Exception {
		actOrgManageDAO.deleteActOrg(vo);
	}

}
