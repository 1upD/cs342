package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by drd26 on 5/11/2017.
 */
public class ReviewchapterEntityPK implements Serializable {
    private long reviewid;
    private long chapternumber;

    @Column(name = "REVIEWID")
    @Id
    public long getReviewid() {
        return reviewid;
    }

    public void setReviewid(long reviewid) {
        this.reviewid = reviewid;
    }

    @Column(name = "CHAPTERNUMBER")
    @Id
    public long getChapternumber() {
        return chapternumber;
    }

    public void setChapternumber(long chapternumber) {
        this.chapternumber = chapternumber;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewchapterEntityPK that = (ReviewchapterEntityPK) o;

        if (reviewid != that.reviewid) return false;
        if (chapternumber != that.chapternumber) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (reviewid ^ (reviewid >>> 32));
        result = 31 * result + (int) (chapternumber ^ (chapternumber >>> 32));
        return result;
    }
}
