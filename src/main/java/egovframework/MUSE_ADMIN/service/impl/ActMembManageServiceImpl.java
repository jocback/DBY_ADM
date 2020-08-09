package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActMembManageService")
public class ActMembManageServiceImpl extends EgovAbstractServiceImpl implements ActMembManageService {

	@Resource(name = "ActMembManageDAO")
	private ActMembManageDAO actMembManageDAO;
	
	@Override
	public Map<String, Object> selectActMembDetail(ActMembManageVO vo) throws Exception {
		return actMembManageDAO.selectActMembDetail(vo);
	}

	@Override
	public List<?> selectActMembList(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMembList(searchVO);
	}
	
	@Override
	public List<?> selectActMembExcelList(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMembExcelList(searchVO);
	}
	
	@Override
	public int selectActMembListTotCnt(ActManageDefaultVO searchVO) {
		return actMembManageDAO.selectActMembListTotCnt(searchVO);
	}
	
	@Override
	public int selectActMembExcelListTotCnt(ActManageDefaultVO searchVO) {
		return actMembManageDAO.selectActMembExcelListTotCnt(searchVO);
	}
	@Override
	public void insertActMemb(ActMembManageVO vo) throws Exception {
		//패스워드 암호화
		String pass = EgovFileScrty.encryptPassword2(vo.getmPass());
		//String pass = EgovFileScrty.encryptPassword(vo.getPassword(), vo.getEmpId());
		vo.setmPass(pass);

		actMembManageDAO.insertActMemb(vo);	
	}

	@Override
	public void updateActMemb(ActMembManageVO vo) throws Exception {
		if(vo.getmPass() != null && (vo.getmPass()).length() != 0){
			String pass = EgovFileScrty.encryptPassword2(vo.getmPass());
			vo.setmPass(pass);
		}
		actMembManageDAO.updateActMemb(vo);
	}

	@Override
	public void deleteActMemb(ActMembManageVO vo) throws Exception {
		actMembManageDAO.deleteActMemb(vo);
	}

	@Override
	public void updateProfSeq(ActMembManageVO vo) throws Exception {
		actMembManageDAO.updateProfSeq(vo);
	}

	@Override
	public List<?> selectActEquipList(ActMembManageVO vo) throws Exception {
		return actMembManageDAO.selectActEquipList(vo);
	}
	
	@Override
	public void deleteActEquip(ActManageDefaultVO searchVO) throws Exception {
		actMembManageDAO.deleteActEquip(searchVO);
	}

	@Override
	public List<?> selectActMembDelList(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMembDelList(searchVO);
	}
	@Override
	public int selectActMembDelListTotCnt(ActManageDefaultVO searchVO) {
		return actMembManageDAO.selectActMembDelListTotCnt(searchVO);
	}
	
	@Override
	public void cancelDelActMemb(ActMembManageVO vo) throws Exception {
		actMembManageDAO.cancelDelActMemb(vo);
	}

	@Override
	public void withdrawActMembInfo(ActMembManageVO vo) throws Exception {
		actMembManageDAO.withdrawActMembInfo(vo);
	}

	@Override
	public void delMemoActMembInfo(ActMembManageVO vo) throws Exception {
		actMembManageDAO.delMemoActMembInfo(vo);
	}

	@Override
	public Map<String, Object> selectActMemTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMemTotCnt(searchVO);
	}
	@Override
	public Map<String, Object> selectActMemLoginTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMemLoginTotCnt(searchVO);
	}
	@Override
	public Map<String, Object> selectActMemCondTotCnt(ActManageDefaultVO searchVO) throws Exception {
		return actMembManageDAO.selectActMemCondTotCnt(searchVO);
	}

}
