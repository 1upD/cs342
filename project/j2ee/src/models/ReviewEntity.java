package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "REVIEW", schema = "LDDBUSER", catalog = "")
public class ReviewEntity {
    private long reviewid;
    private Time datesubmitted;
    private Long rating;
    private String reviewcomment;

    @Id
    @Column(name = "REVIEWID")
    public long getReviewid() {
        return reviewid;
    }

    public void setReviewid(long reviewid) {
        this.reviewid = reviewid;
    }

    @Basic
    @Column(name = "DATESUBMITTED")
    public Time getDatesubmitted() {
        return datesubmitted;
    }

    public void setDatesubmitted(Time datesubmitted) {
        this.datesubmitted = datesubmitted;
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
    @Column(name = "REVIEWCOMMENT")
    public String getReviewcomment() {
        return reviewcomment;
    }

    public void setReviewcomment(String reviewcomment) {
        this.reviewcomment = reviewcomment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewEntity that = (ReviewEntity) o;

        if (reviewid != that.reviewid) return false;
        if (datesubmitted != null ? !datesubmitted.equals(that.datesubmitted) : that.datesubmitted != null)
            return false;
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (reviewcomment != null ? !reviewcomment.equals(that.reviewcomment) : that.reviewcomment != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (reviewid ^ (reviewid >>> 32));
        result = 31 * result + (datesubmitted != null ? datesubmitted.hashCode() : 0);
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        result = 31 * result + (reviewcomment != null ? reviewcomment.hashCode() : 0);
        return result;
    }
}
