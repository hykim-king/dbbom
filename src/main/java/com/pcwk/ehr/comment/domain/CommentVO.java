<<<<<<< HEAD
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
=======
package com.pcwk.ehr.comment.domain;

import java.io.Serializable;
import java.util.Date;

import com.pcwk.ehr.cmn.DTO;

public class CommentVO extends DTO implements Serializable {
	
	private static final long serialVersionUID = 6376437571460344493L;

    private int commentSid;          // comment_sid
    private String commentContent;   // comment_content
    private int commentReccount;     // comment_reccount
    private Date commentUpdateDate;  // comment_updatedate

    private Integer diarySid;        // diary_sid (nullable)
    private Integer famousSid;       // famous_sid (nullable)

    private String regId;            // reg_id (작성자 ID)

    public CommentVO() {}

    public CommentVO(int commentSid, String commentContent, int commentReccount, Date commentUpdateDate,
                     Integer diarySid, Integer famousSid, String regId) {
        super();
        this.commentSid = commentSid;
        this.commentContent = commentContent;
        this.commentReccount = commentReccount;
        this.commentUpdateDate = commentUpdateDate;
        this.diarySid = diarySid;
        this.famousSid = famousSid;
        this.regId = regId;
    }

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

    @Override
    public String toString() {
        return "CommentVO [commentSid=" + commentSid + ", commentContent=" + commentContent + ", commentReccount="
                + commentReccount + ", commentUpdateDate=" + commentUpdateDate + ", diarySid=" + diarySid
                + ", famousSid=" + famousSid + ", regId=" + regId + ", toString()=" + super.toString() + "]";
    }
}
>>>>>>> main
