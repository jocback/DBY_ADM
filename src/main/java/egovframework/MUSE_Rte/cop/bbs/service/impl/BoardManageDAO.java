package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;

import org.springframework.stereotype.Repository;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
 */
@Repository("BoardManageDAO")
public class BoardManageDAO extends EgovComAbstractDAO {

	public boolean isNull(String str) {
		return (str == null || str.trim().length() < 1);
	}
    /**
     * 게시판에 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void insertBoardArticle(BoardManageVO board) throws Exception {
	//long nttId = (Long)select("BBSArticle.selectMaxNttId");//2011.09.22
	//board.setNttId(nttId);//2011.09.22
	
	insert("BBSArticle.insertBoardArticle", board);
    }
    public void insertBoardExtField(BoardManageVO board) throws Exception {
	//long nttId = (Long)select("BBSArticle.selectMaxNttId");//2011.09.22
	//board.setNttId(nttId);//2011.09.22
	
	insert("BBSArticle.insertBoardExtField", board);
    }

    /**
     * 게시판에 답변 게시물을 등록 한다.
     * 
     * @param board
     * @throws Exception
     */
    public long replyBoardArticle(BoardManageVO board) throws Exception {
		long nttId = (Long)selectOne("BBSArticle.selectMaxNttId");
		board.setNttId(nttId);
	
		//----------------------------------------------------------
		// 현재 글 이후 게시물에 대한 NTT_NO를 증가 (정렬을 추가하기 위해)
		//----------------------------------------------------------
		//String parentId = board.getParnts();
		
		long nttNo;
		//String nttIdt;
		//long sortOdr;
		/*if(board.getPreNoteid().length() > 0){
    		//이전버전 게시물의 원글 kno 로 NTT_ID 호출
    		nttNo = (Long)selectOne("BBSArticle.getParentNttNoKno", board);
    		nttIdt = (String)selectOne("BBSArticle.getParentNttIdKno", board);
    		sortOdr = (Long)selectOne("BBSArticle.getParentSortOrdrKno", board);
    		board.setReplyLc("1");
    		board.setReplyNo(nttIdt);
    		board.setSortOrdr(sortOdr);
    	}else{*/
    		nttNo = (Long)selectOne("BBSArticle.getParentNttNo", board);
    	//}
	
		insert("BBSArticle.replyBoardArticle", board);
		
		
		board.setNttNo(nttNo);
		update("BBSArticle.updateOtherNttNo", board);
	
		//if(isNull(board.getPreNoteid())){
		board.setNttNo(nttNo + 1);
		update("BBSArticle.updateNttNo", board);
		//}
	
		return nttId;
    }
	
    /**
     * 게시물 한 건에 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
	public BoardManageVO  selectBoardArticle(BoardManageVO boardVO) throws Exception {
	return (BoardManageVO) selectOne("BBSArticle.selectBoardArticle", boardVO);
    }
	public BoardManageVO  selectBoardExtField(BoardManageVO boardVO) throws Exception {
	return (BoardManageVO) selectOne("BBSArticle.selectBoardExtField", boardVO);
    }
	public Map<String, Object> selectBoardTwoArticle(BoardManageVO vo) throws Exception {
		return selectOne("BBSArticle.selectBoardTwoArticle", vo);
	}

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<?> selectBoardArticleList(BoardManageVO boardVO) throws Exception {
    	if("Y".equals(boardVO.getExtYn()) && !"EXCEL".equals(boardVO.getPageView())) {
			return selectList("BBSArticle.selectBoardArtExtList", boardVO);
		}else if ("Y".equals(boardVO.getExtYn()) && "EXCEL".equals(boardVO.getPageView())) {
			return selectList("BBSArticle.selectBoardArtExtListExcel", boardVO);
		}else{
			return selectList("BBSArticle.selectBoardArticleList", boardVO);
		}
    }

    /**
     * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectBoardArticleListCnt(BoardManageVO boardVO) throws Exception {
		if ("Y".equals(boardVO.getExtYn())) {
			return (Integer)selectOne("BBSArticle.selectBoardArtExtListCnt", boardVO);
		}else{
			return (Integer)selectOne("BBSArticle.selectBoardArticleListCnt", boardVO);
		}
    }

    public int selectBoardArticleCheckCnt(BoardManageVO boardVO) throws Exception {
		return (Integer)selectOne("BBSArticle.selectBoardArticleCheckCnt", boardVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateBoardArticle(BoardManageVO board) throws Exception {
	update("BBSArticle.updateBoardArticle", board);
    }
    public void updateBoardExtField(BoardManageVO board) throws Exception {
	update("BBSArticle.updateBoardExtField", board);
    }
    public void updateBoardSeqSwitch(BoardManageVO board) throws Exception {
	update("BBSArticle.updateBoardSeqSwitch", board);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void deleteBoardArticle(BoardManageVO board) throws Exception {
	update("BBSArticle.deleteBoardArticle", board);
    }
    public void deleteBoardExtField(BoardManageVO board) throws Exception {
	update("BBSArticle.deleteBoardExtField", board);
    }

    /**
     * 게시물에 대한 조회 건수를 수정 한다.
     * 
     * @param board
     * @throws Exception
     */
    public void updateInqireCo(BoardManageVO boardVO) throws Exception {
	update("BBSArticle.updateInqireCo", boardVO);
    }

    /**
     * 게시물에 대한 현재 조회 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectMaxInqireCo(BoardManageVO boardVO) throws Exception {
	return (Integer)selectOne("BBSArticle.selectMaxInqireCo", boardVO);
    }

    /**
     * 게시판에 대한 목록을 정렬 순서로 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<?> selectNoticeListForSort(BoardManageVO board) throws Exception {
	return selectList("BBSArticle.selectNoticeListForSort", board);
    }

    /**
     * 게사판에 대한 정렬 순서를 수정 한다.
     * 
     * @param sortList
     * @throws Exception
     */
    public void updateSortOrder(List<BoardManageVO> sortList) throws Exception {
	BoardManageVO vo;
	Iterator<BoardManageVO> iter = sortList.iterator();
	while (iter.hasNext()) {
	    vo = (BoardManageVO)iter.next();
	    update("BBSArticle.updateSortOrder", vo);
	}
    }

    /**
     * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public long selectNoticeItemForSort(BoardManageVO board) throws Exception {
	return (Long)selectOne("BBSArticle.selectNoticeItemForSort", board);
    }

    /**
     * 방명록에 대한 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public List<?> selectGuestList(BoardManageVO boardVO) throws Exception {
	return selectList("BBSArticle.selectGuestList", boardVO);
    }

    /**
     * 방명록에 대한 목록 건수를 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public int selectGuestListCnt(BoardManageVO boardVO) throws Exception {
	return (Integer)selectOne("BBSArticle.selectGuestListCnt", boardVO);
    }

    /**
     * 방명록 내용을 삭제 한다.
     * 
     * @param boardVO
     * @throws Exception
     */
    public void deleteGuestList(BoardManageVO boardVO) throws Exception {
	update("BBSArticle.deleteGuestList", boardVO);
    }

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     * 
     * @param board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BoardManageVO board) throws Exception {
	return (String)selectOne("BBSArticle.getPasswordInf", board);
    }
}
