package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActLecCodeManageDAO")
public class ActLecCodeManageDAO extends EgovComAbstractDAO {

	public List<?> selectLecCodeManageList(ActLecCodeManageVO lecCodeManageVO) throws Exception {
        return selectList( "ActLecCodeManage.selectLecCodeManageList", lecCodeManageVO);
    }

	public ActLecCodeManageVO selectLecCodeManageDetail(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		return (ActLecCodeManageVO)selectOne("LecCodeManageManage.selectLecCodeManageDetail", lecCodeManageVO);
	}

	public void insertLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
        insert("ActLecCodeManage.insertLecCodeManage", lecCodeManageVO);
	}

	public void updateLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		update("ActLecCodeManage.updateLecCodeManage", lecCodeManageVO);
	}

	public void deleteLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		delete("ActLecCodeManage.deleteLecCodeManage", lecCodeManageVO);
	}

	public void updateActLecCodeSeq(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		update("ActLecCodeManage.updateActLecCodeSeq", lecCodeManageVO);
	}

}
