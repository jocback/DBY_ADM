package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActEmpManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActEmpManageVO;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActEmpManageService")
public class ActEmpManageServiceImpl extends EgovAbstractServiceImpl implements ActEmpManageService {

	@Resource(name = "ActEmpManageDAO")
	private ActEmpManageDAO actEmpManageDAO;

	@Override
	public Map<String, Object> selectActEmpDetail(ActEmpManageVO vo) throws Exception {
		return actEmpManageDAO.selectActEmpDetail(vo);
	}

	@Override
	public List<?> selectActEmpList(ActManageDefaultVO searchVO) throws Exception {
		return actEmpManageDAO.selectActEmpList(searchVO);
	}

	@Override
	public int selectActEmpListTotCnt(ActManageDefaultVO searchVO) {
		return actEmpManageDAO.selectActEmpListTotCnt(searchVO);
	}

	@Override
	public String selectActEmpInfoOne(String actField, String empId) {
		ActEmpManageVO vo = new ActEmpManageVO();
		vo.setEmpField(actField);
		vo.setEmpId(empId);
		return actEmpManageDAO.selectActEmpInfoOne(vo);
	}

	@Override
	public void insertActEmp(ActEmpManageVO vo) throws Exception {
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword2(vo.getPassword());
		//String pass = EgovFileScrty.encryptPassword(vo.getPassword(), vo.getEmpId());
		vo.setPassword(pass);
		actEmpManageDAO.insertActEmp(vo);
	}

	@Override
	public void updateActEmp(ActEmpManageVO vo) throws Exception {
		if(vo.getPassword() != null && (vo.getPassword()).length() != 0){
			String pass = EgovFileScrty.encryptPassword2(vo.getPassword());
			vo.setPassword(pass);
		}
		egovLogger.debug(vo.toString());
		actEmpManageDAO.updateActEmp(vo);
	}

	@Override
	public void deleteActEmp(ActEmpManageVO vo) throws Exception {
		egovLogger.debug(vo.toString());
		actEmpManageDAO.deleteActEmp(vo);
	}

	@Override
	public List<?> selectActGroupList(ActEmpManageVO vo) throws Exception {
		return actEmpManageDAO.selectActGroupList(vo);
	}

	@Override
	public List<?> searchInfoEmp(ActManageDefaultVO searchVO) {
		List<?> result = actEmpManageDAO.searchInfoEmp(searchVO);
		return result;
	}

}
