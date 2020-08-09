package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActStudentManageService;
import egovframework.MUSE_ADMIN.service.ActStudentManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActStudentManageService")
public class ActStudentManageServiceImpl extends EgovAbstractServiceImpl implements ActStudentManageService {

	@Resource(name = "ActStudentManageDAO")
	private ActStudentManageDAO actStudentManageDAO;

	@Override
	public Map<String, Object> selectActStudentDetail(ActStudentManageVO vo) throws Exception {
		return actStudentManageDAO.selectActStudentDetail(vo);
	}

	@Override
	public List<?> selectActStudentList(ActStudentManageVO freeVO) throws Exception {
		return actStudentManageDAO.selectActStudentList(freeVO);
	}

	@Override
	public Map<String, Object> selectActStudentListCnt(ActStudentManageVO vo) throws Exception {
		return actStudentManageDAO.selectActStudentListCnt(vo);
	}

	@Override
	public String selectActStudentMaxIdx(ActStudentManageVO vo) {
		return actStudentManageDAO.selectActStudentMaxIdx(vo);
	}

	@Override
	public void insertActStudent(ActStudentManageVO vo) throws Exception {
		actStudentManageDAO.insertActStudent(vo);
	}

	@Override
	public void updateActStudent(ActStudentManageVO vo) throws Exception {
		actStudentManageDAO.updateActStudent(vo);
	}

	@Override
	public void deleteActStudent(ActStudentManageVO vo) throws Exception {
		actStudentManageDAO.deleteActStudent(vo);
	}

}
