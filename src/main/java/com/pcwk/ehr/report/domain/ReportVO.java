package com.pcwk.ehr.report.domain;

import com.pcwk.ehr.cmn.DTO;

public class ReportVO extends DTO { // DTO 상속 확인

<<<<<<< HEAD
	private int reportSid;
	private String reportContent;
	private int reportCategory;
	private Integer famousSid;
	private Integer commentSid;
	private Integer diarySid; // Integer 유지
	private String regId;
	private String diaryContent; // 추가된 필드
=======
    private int reportSid;
    private String reportContent;
    private int reportCategory;
    private Integer famousSid;
    private Integer commentSid;
    private Integer diarySid;
    private String regId;
    private String diaryContent; // 추가된 필드
>>>>>>> feature/donghan-backup

	public ReportVO() {
		super();
	}

<<<<<<< HEAD
	// 모든 필드를 포함하는 생성자로 업데이트
	public ReportVO(int reportSid, String reportContent, int reportCategory, Integer famousSid, Integer commentSid,
			Integer diarySid, String regId, String diaryContent) {
		super();
		this.reportSid = reportSid;
		this.reportContent = reportContent;
		this.reportCategory = reportCategory;
		this.famousSid = famousSid;
		this.commentSid = commentSid;
		this.diarySid = diarySid;
		this.regId = regId;
		this.diaryContent = diaryContent;
	}
=======
    public ReportVO(int reportSid, String reportContent, int reportCategory, Integer famousSid, Integer commentSid,
                    Integer diarySid, String regId,  String diaryContent) {
        super();
        this.reportSid = reportSid;
        this.reportContent = reportContent;
        this.reportCategory = reportCategory;
        this.famousSid = famousSid;
        this.commentSid = commentSid;
        this.diarySid = diarySid;
        this.regId = regId;
        this.diaryContent = diaryContent;
    }
>>>>>>> feature/donghan-backup

	// Getter / Setter
	public int getReportSid() {
		return reportSid;
	}

	public void setReportSid(int reportSid) {
		this.reportSid = reportSid;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public int getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(int reportCategory) {
		this.reportCategory = reportCategory;
	}

	public Integer getFamousSid() {
		return famousSid;
	}

	public void setFamousSid(Integer famousSid) {
		this.famousSid = famousSid;
	}

	public Integer getCommentSid() {
		return commentSid;
	}

	public void setCommentSid(Integer commentSid) {
		this.commentSid = commentSid;
	}

	public Integer getDiarySid() {
		return diarySid;
	}

	public void setDiarySid(Integer diarySid) {
		this.diarySid = diarySid;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

<<<<<<< HEAD
	public String getDiaryContent() {
		return diaryContent;
	}
=======
    public void setRegId(String regId) {
        this.regId = regId;
    }
    public String getDiaryContent() {
		return diaryContent;
	}

	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
>>>>>>> feature/donghan-backup

	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}

	@Override
	public String toString() {
		return "ReportVO [reportSid=" + reportSid + ", reportContent=" + reportContent + ", reportCategory="
				+ reportCategory + ", famousSid=" + famousSid + ", commentSid=" + commentSid + ", diarySid=" + diarySid
				+ ", regId=" + regId + ", diaryContent=" + diaryContent + ", toString()=" + super.toString() + "]";
	}
}