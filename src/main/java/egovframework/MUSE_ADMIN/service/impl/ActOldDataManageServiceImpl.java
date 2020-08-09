package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.MUSE_ADMIN.service.ActOldDataManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOldDataManageService")
public class ActOldDataManageServiceImpl extends EgovAbstractServiceImpl implements ActOldDataManageService {

	@Resource(name = "ActOldDataManageDAO")
	private ActOldDataManageDAO actOldDataManageDAO;

	@Override
	public List<BoardManageVO> selectActOldDataList(BoardManageVO boardVO) throws Exception {
		return actOldDataManageDAO.selectActOldDataList(boardVO);
	}
	@Override
	public void insertActBookOld() throws Exception {
		actOldDataManageDAO.insertActBookOld();	
	}

	@Override
	public void insertActLectureOld() throws Exception {
		actOldDataManageDAO.insertActLectureOld();	
	}

	@Override
	public void insertActMembOld() throws Exception {
		actOldDataManageDAO.insertActMembOld();	
	}

	@Override
	public List<ActMembManageVO> selectActOldProfList(ActMembManageVO membVO) throws Exception {
		return actOldDataManageDAO.selectActOldProfList(membVO);
	}
	@Override
	public void insertActProfOld(ActMembManageVO vo) throws Exception {
		actOldDataManageDAO.insertActProfOld(vo);	
	}
	@Override
	public void updateActOldDataCn(BoardManageVO boardVO) throws Exception {
		actOldDataManageDAO.updateActOldDataCn(boardVO);	
	}
	@Override
	public void insertActDownCntOld() throws Exception {
		actOldDataManageDAO.insertActDownCntOld();	
	}

	@Override
	public List<ActMembManageVO> selectOldMemberPass() throws Exception {
		return actOldDataManageDAO.selectOldMemberPass();
	}
	@Override
	public void oldMemberPassTran(ActMembManageVO membVO) throws Exception {
		if(membVO.getmPass() != null && (membVO.getmPass()).length() != 0){
			String pass = EgovFileScrty.encryptPassword2(membVO.getmPass());
			membVO.setmPass(pass);
		}
		actOldDataManageDAO.oldMemberPassTran(membVO);	
	}
}
