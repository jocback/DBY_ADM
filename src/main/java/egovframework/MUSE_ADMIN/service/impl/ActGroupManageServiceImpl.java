package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActGroupManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActGroupManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActGroupManageService")
public class ActGroupManageServiceImpl extends EgovAbstractServiceImpl implements ActGroupManageService {

	@Resource(name = "ActGroupManageDAO")
	private ActGroupManageDAO actGroupManageDAO;

	/** ID Generation */
	@Resource(name = "egovActGroupIdGnrService")
	private EgovIdGnrService idgenService;

	@Override
	public List<?> popActGroupList(ActManageDefaultVO searchVO) throws Exception {
		return actGroupManageDAO.popActGroupList(searchVO);
	}

	/**
	 * GROUP 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ActGroupManageVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	@Override
	public Map<String, Object> selectActGroupDetail(ActGroupManageVO vo) throws Exception {
		return actGroupManageDAO.selectActGroupDetail(vo);
	}

	/**
	 * GROUP 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectActGroupList(ActManageDefaultVO searchVO) throws Exception {
		return actGroupManageDAO.selectActGroupList(searchVO);
	}

	/**
	 * GROUP 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectActGroupListTotCnt(ActManageDefaultVO searchVO) {
		return actGroupManageDAO.selectActGroupListTotCnt(searchVO);
	}

	/**
	 * GROUP 글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void insertActGroup(ActGroupManageVO vo) throws Exception {
		String newId = idgenService.getNextStringId();
		vo.setGroupId(newId);
		actGroupManageDAO.insertActGroup(vo);
	}

	/**
	 * GROUP 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void updateActGroup(ActGroupManageVO vo) throws Exception {
		egovLogger.debug(vo.toString());
		actGroupManageDAO.updateActGroup(vo);
	}

	/**
	 * GROUP 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void deleteActGroup(ActGroupManageVO vo) throws Exception {
		egovLogger.debug(vo.toString());
		actGroupManageDAO.deleteActGroup(vo);
	}

	@Override
	public String selectActGroupInfoOne(String grField, String idx) {
		ActGroupManageVO vo = new ActGroupManageVO();
		vo.setGrField(grField);
		vo.setGroupId(idx);
		return actGroupManageDAO.selectActGroupInfoOne(vo);
	}

	@Override
	public String selectActGroupInfoOne(String grField, String idx, String grName) {
		ActGroupManageVO vo = new ActGroupManageVO();
		vo.setGrField(grField);
		vo.setGroupDc(idx);
		vo.setGroupNm(grName);
		return actGroupManageDAO.selectActGroupInfoOne(vo);
	}

	@Override
	public int selectActAuthInfoOne(String grId, String mnCd) {
		ActGroupManageVO vo = new ActGroupManageVO();
		vo.setGroupId(grId);
		vo.setMenuCode(mnCd);
		return actGroupManageDAO.selectActAuthInfoOne(vo);
	}

	//그룹 권한 관리
	@Override
	public List<?> selectActGroupAuthList(ActGroupManageVO vo) throws Exception {
		return actGroupManageDAO.selectActGroupAuthList(vo);
	}

	@Override
	public void insertActGroupAuth(ActGroupManageVO vo) throws Exception {
		actGroupManageDAO.insertActGroupAuth(vo);
	}

	@Override
	public boolean deleteActGroupAuth(ActGroupManageVO vo) throws Exception {
		return actGroupManageDAO.deleteActGroupAuth(vo);
	}

}
