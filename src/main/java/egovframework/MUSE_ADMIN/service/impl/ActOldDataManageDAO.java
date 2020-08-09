package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOldDataManageDAO")
public class ActOldDataManageDAO extends EgovComAbstractDAO {

	/*목록*/
	public List<BoardManageVO> selectActOldDataList(BoardManageVO boardVO) throws Exception {
		String selectQuery = "ActOldDataManageDAO.selectActOldDataList";
		if("Y".equals(boardVO.getReplyAt())){
			selectQuery = "ActOldDataManageDAO.selectActOldReplyDataList";
			if("BBS_0009".equals(boardVO.getBbsId()) || "BBS_0010".equals(boardVO.getBbsId()) || "BBS_0011".equals(boardVO.getBbsId())){
				selectQuery = "ActOldDataManageDAO.selectActOldQnaReplyDataList";
			}
		}
		/*if("BBS_0007".equals(boardVO.getBbsId())){
			selectQuery = "ActOldDataManageDAO.selectActOldDataEbookList";
		}
		if("BBS_0014".equals(boardVO.getBbsId()) && "N".equals(boardVO.getReplyAt())){
			selectQuery = "ActOldDataManageDAO.selectActOldQnaList";
		}
		if("BBS_0014".equals(boardVO.getBbsId()) && "Y".equals(boardVO.getReplyAt())){
			selectQuery = "ActOldDataManageDAO.selectActOldQnaReplyList";
		}*/
		return selectList(selectQuery, boardVO);
	}
	/*등록*/
	public void insertActBookOld() throws Exception {
		insert("ActOldDataManageDAO.insertActBookOld", "");
		insert("ActOldDataManageDAO.insertActBookSubOld", "");
	}

	public void insertActLectureOld() throws Exception {
		insert("ActOldDataManageDAO.insertActLectureOld", "");
		insert("ActOldDataManageDAO.insertActLectureBookOld", "");
		insert("ActOldDataManageDAO.insertActLectureClipOld", "");
	}

	/*등록*/
	public void insertActMembOld() throws Exception {
		insert("ActOldDataManageDAO.insertActMembOld", "");
		insert("ActOldDataManageDAO.insertActDelMembOld", "");
	}

	public List<ActMembManageVO> selectActOldProfList(ActMembManageVO membVO) throws Exception {
		String selectQuery = "ActOldDataManageDAO.selectActOldProfList";
		return selectList(selectQuery, membVO);
	}
	public void insertActProfOld(ActMembManageVO vo) throws Exception {
		insert("ActMembManage.insertActProfSub", vo);
	}
	public void updateActOldDataCn(BoardManageVO boardVO) throws Exception {
		System.out.println("boardVO.get==>>"+boardVO.getPreBoardId());
		System.out.println("boardVO.getB==>>"+boardVO.getBbsId());
		insert("ActOldDataManageDAO.updateActOldDataCn", boardVO);
		insert("ActOldDataManageDAO.updateActOldDataCnReply", boardVO);
	}

	public void insertActDownCntOld() throws Exception {
		insert("ActOldDataManageDAO.insertActDownCntOld", "");
	}

	public List<ActMembManageVO> selectOldMemberPass() throws Exception {
		return selectList("ActOldDataManageDAO.selectOldMemberPass", "");
	}
	public void oldMemberPassTran(ActMembManageVO membVO) throws Exception {
		insert("ActOldDataManageDAO.oldMemberPassTran", membVO);
	}
}
