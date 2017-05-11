package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by drd26 on 5/11/2017.
 */
public class ChapterEntityPK implements Serializable {
    private long chapternumber;
    private long gameid;

    @Column(name = "CHAPTERNUMBER")
    @Id
    public long getChapternumber() {
        return chapternumber;
    }

    public void setChapternumber(long chapternumber) {
        this.chapternumber = chapternumber;
    }

    @Column(name = "GAMEID")
    @Id
    public long getGameid() {
        return gameid;
    }

    public void setGameid(long gameid) {
        this.gameid = gameid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ChapterEntityPK that = (ChapterEntityPK) o;

        if (chapternumber != that.chapternumber) return false;
        if (gameid != that.gameid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (chapternumber ^ (chapternumber >>> 32));
        result = 31 * result + (int) (gameid ^ (gameid >>> 32));
        return result;
    }
}
