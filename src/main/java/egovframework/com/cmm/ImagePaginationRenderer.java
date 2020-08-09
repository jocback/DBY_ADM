package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables(){
		firstPageLabel    = "<li class=\"prev text-ir\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pn_prev\">처음</a></li>";
		//firstPageLabel    = "";
        previousPageLabel = "<li class=\"prev text-ir\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pn_prev\">이전</a></li>";
        currentPageLabel  = "<li class=\"pn_paging_set pn_paging on\"><a href=\"javascript:void(0);\" class=\"pn_page\">{0}</a></li>";
        otherPageLabel    = "<li class=\"pn_paging_set pn_paging\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pn_page\">{2}</a></li>";
        nextPageLabel     = "<li class=\"next text-ir\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pn_next\">다음</a></li>";
        //lastPageLabel     = "";
        lastPageLabel     = "<li class=\"next text-ir\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pn_next\">마지막</a></li>";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
