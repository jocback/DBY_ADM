package egovframework.com.cmm.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
//import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class GenExcelView extends AbstractExcelView {
	
	@SuppressWarnings({ "unchecked" })
	@Override
	protected void buildExcelDocument(Map<String, Object> modelMap, HSSFWorkbook workbook, HttpServletRequest req, HttpServletResponse res) throws Exception {
		String excelName = (String) modelMap.get("excelName")+".xls";
		List<String> colName = (List<String>) modelMap.get("colName");
		List<?> colValue = (List<?>) modelMap.get("colValue");
		//res.setContentType("application/msexcel;charset=UTF-8");
		//res.setHeader("Content-Disposition", "attachment; filename="+ excelName + ".xls");
		setDisposition(excelName,req,res);
		HSSFSheet sheet = workbook.createSheet(excelName);
		// 틀고정
		//sheet.createFreezePane(1, 1);	// 1열, 2행 고정
		//CellStyle style = workbook.createCellStyle();
		// 가로 정렬
		//style.setAlignment((short)1);			// 가로 정렬 왼쪽
		//style.setAlignment((short)2);			// 가로 정렬 중간
		//style.setAlignment((short)3);			// 가로 정렬 오른쪽
		
		// 세로 정렬
		//style.setVerticalAlignment((short)0);	// 세로 정렬 상단
		//style.setVerticalAlignment((short)1);	// 세로 정렬 중단
		//style.setVerticalAlignment((short)2);	// 세로 정렬 하단

		HSSFCellStyle titleCellStyle = workbook.createCellStyle();
		titleCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THICK);
		titleCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		titleCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		titleCellStyle.setBorderTop(HSSFCellStyle.BORDER_THICK);
		titleCellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleCellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		titleCellStyle.setAlignment((short)2);			// 가로 정렬 중간
 		titleCellStyle.setVerticalAlignment((short)1);	// 세로 정렬 중단

		HSSFCellStyle contentCellStyle = workbook.createCellStyle();
		contentCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		contentCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		contentCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		contentCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		contentCellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		contentCellStyle.setFillForegroundColor(HSSFColor.WHITE.index);
		contentCellStyle.setAlignment((short)2);			// 가로 정렬 중간
  		contentCellStyle.setVerticalAlignment((short)1);	// 세로 정렬 중단

 		// 폰트 설정
		Font font = workbook.createFont();
		font.setFontName("맑은 고딕");                  // 폰트 이름
		font.setFontHeightInPoints((short)12);          // 폰트 크기
		font.setColor(IndexedColors.BLACK.getIndex());    // 폰트 컬러
		font.setStrikeout(false);	                    // 글자 가운데 라인
		font.setItalic(false);	                        // 이탤릭체
		//font.setUnderline(Font.U_SINGLE);		        // 밑줄
		//font.setBoldweight(Font.BOLDWEIGHT_BOLD);	    // 볼드체
		titleCellStyle.setFont(font);
		contentCellStyle.setFont(font);

		// 상단 메뉴명 생성
		HSSFRow menuRow = sheet.createRow(0);
		for (int i = 0; i < colName.size(); i++) {
			HSSFCell cell = menuRow.createCell(i);
			cell.setCellValue(new HSSFRichTextString(colName.get(i)));
			// 셀 스타일 적용
			cell.setCellStyle(titleCellStyle);
		}
		int j = 0;
		// 내용 생성
		for(int i=0; i < colValue.size(); i++){
			Map<String, String> map = (Map<String, String>) colValue.get(i);
			HSSFRow row = sheet.createRow(i+1);
			row.setHeight((short)512);
			j = 0;
			for(String key : map.keySet()){ 
				HSSFCell cell = row.createCell(j);
				String cellVal = String.valueOf(map.get(key));
				//if("NULL".equals(cellVal.toUpperCase())){
				if(cellVal == null || "NULL".equals(cellVal.toUpperCase())){
					cellVal = "";
				}
				// 셀 스타일 적용
				cell.setCellStyle(contentCellStyle);
				cell.setCellValue(new HSSFRichTextString(cellVal));
				j++;
			}
			/*for(Map.Entry<String, String> elem : map.entrySet() ){ 
				HSSFCell cell = row.createCell(j);
				String cellVal = String.valueOf(elem.getValue());
				cell.setCellValue(new HSSFRichTextString(cellVal));
				//System.out.println( String.format("키 : %s, 값 : %s", elem.getKey(), elem.getValue()) );
				j++;
			}*/
		}
		for(int i=0; i<j; i++){
			sheet.autoSizeColumn((short)i);
			int colWidth = (sheet.getColumnWidth(i))+512;
			if(colWidth > 20000){
				colWidth = 20000;
			}
			sheet.setColumnWidth(i, colWidth );  // 윗줄만으로는 컬럼의 width 가 부족하여 더 늘려야 함.
		}
}

	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}

	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

}