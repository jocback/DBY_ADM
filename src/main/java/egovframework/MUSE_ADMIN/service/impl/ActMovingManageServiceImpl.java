package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActMovingManageService")
public class ActMovingManageServiceImpl extends EgovAbstractServiceImpl implements ActMovingManageService {

	@Resource(name = "ActMovingManageDAO")
	private ActMovingManageDAO actMovingManageDAO;

	@Override
	public Map<String, Object> selectActMovingDetail(ActMovingManageVO vo) throws Exception {
		return actMovingManageDAO.selectActMovingDetail(vo);
	}

	@Override
	public List<?> selectActMovingList(ActManageDefaultVO searchVO) throws Exception {
		return actMovingManageDAO.selectActMovingList(searchVO);
	}

	@Override
	public int selectActMovingListTotCnt(ActManageDefaultVO searchVO) {
		return actMovingManageDAO.selectActMovingListTotCnt(searchVO);
	}

	@Override
	public String selectActMovingMaxIdx(ActMovingManageVO vo) {
		return actMovingManageDAO.selectActMovingMaxIdx(vo);
	}

	@Override
	public void insertActMoving(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.insertActMoving(vo);
	}

	@Override
	public void updateActMoving(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.updateActMoving(vo);
	}

	@Override
	public void deleteActMoving(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.deleteActMoving(vo);
	}

	/*교재등록*/
	@Override
	public void insertActLectureBook(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.insertActLectureBook(vo);
	}
	@Override
	public void deleteActLectureBook(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.deleteActLectureBook(vo);
	}
	@Override
	public List<?> selectActLectureBook(ActMovingManageVO vo) throws Exception {
		return actMovingManageDAO.selectActLectureBook(vo);
	}
	/*동영상등록*/
	@Override
	public void insertActLectureClip(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.insertActLectureClip(vo);
	}
	@Override
	public void deleteActLectureClip(ActMovingManageVO vo) throws Exception {
		actMovingManageDAO.deleteActLectureClip(vo);
	}
	@Override
	public List<?> selectActLectureClip(ActMovingManageVO vo) throws Exception {
		return actMovingManageDAO.selectActLectureClip(vo);
	}

}
