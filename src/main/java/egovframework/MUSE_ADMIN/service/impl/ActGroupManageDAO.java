package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActGroupManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActGroupManageDAO")
public class ActGroupManageDAO extends EgovComAbstractDAO {

	public List<?> popActGroupList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActGroupManage.popActGroupList", searchVO);
	}

	/**
	 * GROUP 글 목록에 대한 상세내용을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActGroupDetail(ActGroupManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActGroupManage.selectActGroupDetail", vo);
	}

	/**
	 * GROUP 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectActGroupList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActGroupManage.selectActGroupList", searchVO);
	}

	/**
	 * GROUP 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
	public int selectActGroupListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActGroupManage.selectActGroupListTotCnt", searchVO);
	}

	/**
	 * GROUP 글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
	public void insertActGroup(ActGroupManageVO vo) throws Exception {
		insert("ActGroupManage.insertActGroup", vo);
	}

	/**
	 * GROUP 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
	public void updateActGroup(ActGroupManageVO vo) throws Exception {
		update("ActGroupManage.updateActGroup", vo);
	}

	/**
	 * GROUP 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
	public void deleteActGroup(ActGroupManageVO vo) throws Exception {
		delete("ActGroupManage.deleteActGroup", vo);
	}

	public String selectActGroupInfoOne(ActGroupManageVO vo) {
		return (String) selectOne("ActGroupManage.selectActGroupInfoOne", vo);
	}

	public int selectActAuthInfoOne(ActGroupManageVO vo) {
		return (int) selectOne("ActGroupManage.selectActAuthInfoOne", vo);
	}

	//그룹 권한 관리
	public List<?> selectActGroupAuthList(ActGroupManageVO vo) throws Exception {
		return selectList("ActGroupManage.selectActGroupAuthList", vo);
	}

	public void insertActGroupAuth(ActGroupManageVO vo) throws Exception {
		insert("ActGroupManage.insertActGroupAuth", vo);
	}

	public boolean deleteActGroupAuth(ActGroupManageVO vo) throws Exception {
		delete("ActGroupManage.deleteActGroupAuth", vo);
		return true;
	}

}
