package egovframework.MUSE_ADMIN.web;

import egovframework.MUSE_ADMIN.service.ActOrderManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service("actSchedulingController")
public class ActSchedulingController extends ActCommonController {

	/** actOrderManageService */
	@Resource(name = "ActOrderManageService")
	private ActOrderManageService actOrderManageService;

	public void deleteActOrderCartExpired() throws Exception {
		ActOrderManageVO vo = new ActOrderManageVO();
		vo.setoDate(getDateTransStrSp(addDateDay(getCurrDate(),0,0,-14),"-"));
		vo.setPayday(getDateTransStrSp(addDateDay(getCurrDate(),0,0,-2),"-"));
		System.out.println("oDate==>>>"+vo.getoDate());
		actOrderManageService.deleteActOrderCartExpired(vo);
		//return "success";
	}

}
