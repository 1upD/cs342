package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "REVIEWCHAPTER", schema = "LDDBUSER", catalog = "")
@IdClass(ReviewchapterEntityPK.class)
public class ReviewchapterEntity {
    private long reviewid;
    private long chapternumber;
    private Long minutesplayed;
    private Time dateplayed;
    private Long rating;
    private String chaptercomment;

    @Id
    @Column(name = "REVIEWID")
    public long getReviewid() {
        return reviewid;
    }

    public void setReviewid(long reviewid) {
        this.reviewid = reviewid;
    }

    @Id
    @Column(name = "CHAPTERNUMBER")
    public long getChapternumber() {
        return chapternumber;
    }

    public void setChapternumber(long chapternumber) {
        this.chapternumber = chapternumber;
    }

    @Basic
    @Column(name = "MINUTESPLAYED")
    public Long getMinutesplayed() {
        return minutesplayed;
    }

    public void setMinutesplayed(Long minutesplayed) {
        this.minutesplayed = minutesplayed;
    }

    @Basic
    @Column(name = "DATEPLAYED")
    public Time getDateplayed() {
        return dateplayed;
    }

    public void setDateplayed(Time dateplayed) {
        this.dateplayed = dateplayed;
    }

    @Basic
    @Column(name = "RATING")
    public Long getRating() {
        return rating;
    }

    public void setRating(Long rating) {
        this.rating = rating;
    }

    @Basic
    @Column(name = "CHAPTERCOMMENT")
    public String getChaptercomment() {
        return chaptercomment;
    }

    public void setChaptercomment(String chaptercomment) {
        this.chaptercomment = chaptercomment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewchapterEntity that = (ReviewchapterEntity) o;

        if (reviewid != that.reviewid) return false;
        if (chapternumber != that.chapternumber) return false;
        if (minutesplayed != null ? !minutesplayed.equals(that.minutesplayed) : that.minutesplayed != null)
            return false;
        if (dateplayed != null ? !dateplayed.equals(that.dateplayed) : that.dateplayed != null) return false;
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (chaptercomment != null ? !chaptercomment.equals(that.chaptercomment) : that.chaptercomment != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (reviewid ^ (reviewid >>> 32));
        result = 31 * result + (int) (chapternumber ^ (chapternumber >>> 32));
        result = 31 * result + (minutesplayed != null ? minutesplayed.hashCode() : 0);
        result = 31 * result + (dateplayed != null ? dateplayed.hashCode() : 0);
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        result = 31 * result + (chaptercomment != null ? chaptercomment.hashCode() : 0);
        return result;
    }
}
