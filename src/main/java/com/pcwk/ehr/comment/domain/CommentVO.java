package com.pcwk.ehr.comment.domain;

import java.util.Date;

public class CommentVO {

    private int commentSid;          // comment_sid
    private String commentContent;   // comment_content
    private int commentReccount;     // comment_reccount
    private Date commentUpdateDate;  // comment_updatedate

    private Integer diarySid;        // diary_sid (nullable)
    private Integer famousSid;       // famous_sid (nullable)

    private String regId;            // reg_id (작성자 ID)

    public CommentVO() {}

    // getter/setter
    public int getCommentSid() { return commentSid; }
    public void setCommentSid(int commentSid) { this.commentSid = commentSid; }

    public String getCommentContent() { return commentContent; }
    public void setCommentContent(String commentContent) { this.commentContent = commentContent; }

    public int getCommentReccount() { return commentReccount; }
    public void setCommentReccount(int commentReccount) { this.commentReccount = commentReccount; }

    public Date getCommentUpdateDate() { return commentUpdateDate; }
    public void setCommentUpdateDate(Date commentUpdateDate) { this.commentUpdateDate = commentUpdateDate; }

    public Integer getDiarySid() { return diarySid; }
    public void setDiarySid(Integer diarySid) { this.diarySid = diarySid; }

    public Integer getFamousSid() { return famousSid; }
    public void setFamousSid(Integer famousSid) { this.famousSid = famousSid; }

    public String getRegId() { return regId; }
    public void setRegId(String regId) { this.regId = regId; }
}
