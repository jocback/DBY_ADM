package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActCollegeManageService")
public class ActCollegeManageServiceImpl extends EgovAbstractServiceImpl implements ActCollegeManageService {

	@Resource(name = "ActCollegeManageDAO")
	private ActCollegeManageDAO actCollegeManageDAO;

	@Override
	public List<?> selectActCollegeLectList(ActCollegeManageVO vo) throws Exception {
		return actCollegeManageDAO.selectActCollegeLectList(vo);
	}

	@Override
	public Map<String, Object> selectActCollegeDetail(ActCollegeManageVO vo) throws Exception {
		return actCollegeManageDAO.selectActCollegeDetail(vo);
	}

	@Override
	public List<?> selectActCollegeList(ActManageDefaultVO searchVO) throws Exception {
		return actCollegeManageDAO.selectActCollegeList(searchVO);
	}

	@Override
	public int selectActCollegeListTotCnt(ActManageDefaultVO searchVO) {
		return actCollegeManageDAO.selectActCollegeListTotCnt(searchVO);
	}

	@Override
	public String selectActCollegeMaxIdx(ActCollegeManageVO vo) {
		return actCollegeManageDAO.selectActCollegeMaxIdx(vo);
	}

	@Override
	public void insertActCollege(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.insertActCollege(vo);
	}

	@Override
	public void updateActCollege(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.updateActCollege(vo);
	}

	@Override
	public void deleteActCollege(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.deleteActCollege(vo);
	}

    public void updateSeqSwitch(ActCollegeManageVO vo) throws Exception {
    	actCollegeManageDAO.updateSeqSwitch(vo);
    }

	/*금액등록*/
	@Override
	public void insertActCollegePrice(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.insertActCollegePrice(vo);
	}
	@Override
	public void deleteActCollegePrice(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.deleteActCollegePrice(vo);
	}
	@Override
	public List<?> selectActCollegePrice(ActCollegeManageVO vo) throws Exception {
		return actCollegeManageDAO.selectActCollegePrice(vo);
	}
	/*동영상등록*/
	@Override
	public void insertActCollegeLect(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.insertActCollegeLect(vo);
	}
	@Override
	public void deleteActCollegeLect(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.deleteActCollegeLect(vo);
	}
	@Override
	public List<?> selectActCollegeLect(ActCollegeManageVO vo) throws Exception {
		return actCollegeManageDAO.selectActCollegeLect(vo);
	}
	/*동영상택일설정*/
	@Override
	public void insertActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.insertActCollegeOpt(vo);
	}
	@Override
	public void deleteActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		actCollegeManageDAO.deleteActCollegeOpt(vo);
	}
	@Override
	public List<?> selectActCollegeOpt(ActCollegeManageVO vo) throws Exception {
		return actCollegeManageDAO.selectActCollegeOpt(vo);
	}

}
