<%@page contentType="text/html;charset=utf-8"%>
			<div id="poster2" class="layer-popup v2 ht2">
				<div class="tit">
					<img src="/images/boffice/common/tit_popup6.jpg" alt="임직원 찾기" />
					<a href="#" class="close"><img src="/images/boffice/common/btn_close.jpg" alt="닫기" /></a>
				</div>

				<div class="content ta_c">

					<ul>
						<li class="schWrap">
							<label class="blind" for="ajaxKeyword">제목 검색</label>
							<input type="text" class="sch_text" name="ajaxKeyword" id="ajaxKeyword" onkeypress="press(event);" placeholder="이름" />
							<a href="javascript:void(0);" class="btn_css" onClick="fnAjaxEmpCall();">
								<img src="/images/boffice/board/btn_search.jpg" alt="검색">
							</a>
						</li>
					</ul>

					<div class="listType05 bbn mt_10">
						<table>
							<caption class="blind">임직원 목록</caption>
							<colgroup>
								<col width="120px" />
								<col width="*" />
								<col width="154px" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col" class="first_line">이름</th>
									<th scope="col" class="first_line">부서</th>
									<th scope="col" class="first_line">직위</th>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="listType05 ovf">
						<table>
							<caption class="blind">임직원 목록</caption>
							<colgroup>
								<col width="120px" />
								<col width="*" />
								<col width="154px" />
							</colgroup>
							<tbody id="infoGrEmpListBody">
							</tbody>
						</table>
					</div>
					
					<div class="mt_20 ta_c">
						<a href="javascript:void(0);" class="btn close"><img src="/images/boffice/common/btn_close2.jpg" alt="확인" /></a>
					</div>

				</div>

			</div>
