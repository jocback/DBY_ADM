package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActTeamsManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActTeamsManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActTeamsManageService")
public class ActTeamsManageServiceImpl extends EgovAbstractServiceImpl implements ActTeamsManageService {

	/** ID Generation */
	@Resource(name = "egovActTeams1IdGnrService")
	private EgovIdGnrService idgen1Service;
	@Resource(name = "egovActTeams2IdGnrService")
	private EgovIdGnrService idgen2Service;
	@Resource(name = "egovActTeams3IdGnrService")
	private EgovIdGnrService idgen3Service;

	@Resource(name = "ActTeamsManageDAO")
	private ActTeamsManageDAO actTeamsManageDAO;

	@Override
	public ActTeamsManageVO selectActTeamsDetail(ActTeamsManageVO vo) throws Exception {
		return actTeamsManageDAO.selectActTeamsDetail(vo);
	}

	@Override
	public List<?> selectActTeamsList(ActManageDefaultVO searchVO) throws Exception {
		return actTeamsManageDAO.selectActTeamsList(searchVO);
	}

	@Override
	public int selectActTeamsCnt(ActManageDefaultVO searchVO) {
		return actTeamsManageDAO.selectActTeamsCnt(searchVO);
	}

	@Override
	public void insertActTeams(ActTeamsManageVO vo) throws Exception {
		String newId = "";
		if("d1".equals(vo.getaDepth())){
			newId = idgen1Service.getNextStringId();
		}
		if("d2".equals(vo.getaDepth())){
			newId = idgen2Service.getNextStringId();
		}
		if("d3".equals(vo.getaDepth())){
			newId = idgen3Service.getNextStringId();
		}
		vo.setaId(newId);
		actTeamsManageDAO.insertActTeams(vo);
	}

	@Override
	public void updateActTeams(ActTeamsManageVO vo) throws Exception {
		actTeamsManageDAO.updateActTeams(vo);
	}

	@Override
	public void deleteActTeams(ActTeamsManageVO vo) throws Exception {
		actTeamsManageDAO.deleteActTeams(vo);
	}

	@Override
	public List<?> selectActTeamEmpList(ActManageDefaultVO searchVO) throws Exception {
		return actTeamsManageDAO.selectActTeamEmpList(searchVO);
	}

}
