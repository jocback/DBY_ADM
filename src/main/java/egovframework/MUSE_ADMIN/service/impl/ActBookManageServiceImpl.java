package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActBookManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBookManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActBookManageService")
public class ActBookManageServiceImpl extends EgovAbstractServiceImpl implements ActBookManageService {

	@Resource(name = "ActBookManageDAO")
	private ActBookManageDAO actBookManageDAO;

	@Override
	public Map<String, Object> selectActBookDetail(ActBookManageVO vo) throws Exception {
		return actBookManageDAO.selectActBookDetail(vo);
	}

	@Override
	public List<?> selectActBookList(ActManageDefaultVO searchVO) throws Exception {
		return actBookManageDAO.selectActBookList(searchVO);
	}

	@Override
	public int selectActBookListTotCnt(ActManageDefaultVO searchVO) {
		return actBookManageDAO.selectActBookListTotCnt(searchVO);
	}

	@Override
	public String selectActBookMaxIdx(ActBookManageVO vo) {
		return actBookManageDAO.selectActBookMaxIdx(vo);
	}

	@Override
	public void insertActBook(ActBookManageVO vo) throws Exception {
		actBookManageDAO.insertActBook(vo);
	}

	@Override
	public void updateActBook(ActBookManageVO vo) throws Exception {
		actBookManageDAO.updateActBook(vo);
	}

	@Override
	public void deleteActBook(ActBookManageVO vo) throws Exception {
		actBookManageDAO.deleteActBook(vo);
	}

	@Override
	public void insertActBookCategory(ActBookManageVO vo) throws Exception {
		actBookManageDAO.insertActBookCategory(vo);
	}

	@Override
	public void deleteActBookCategory(ActBookManageVO vo) throws Exception {
		actBookManageDAO.deleteActBookCategory(vo);
	}

	@Override
	public List<?> selectActBookCategory(ActBookManageVO vo) throws Exception {
		return actBookManageDAO.selectActBookCategory(vo);
	}

}
