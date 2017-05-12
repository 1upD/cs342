package models;

import javax.persistence.*;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "CHAPTER", schema = "LDDBUSER", catalog = "")
@IdClass(ChapterEntityPK.class)
public class ChapterEntity {
    private String chaptername;
    private long chapternumber;
    private long gameid;

    @Basic
    @Column(name = "CHAPTERNAME")
    public String getChaptername() {
        return chaptername;
    }

    public void setChaptername(String chaptername) {
        this.chaptername = chaptername;
    }

    @Id
    @Column(name = "CHAPTERNUMBER")
    public long getChapternumber() {
        return chapternumber;
    }

    public void setChapternumber(long chapternumber) {
        this.chapternumber = chapternumber;
    }

    @Id
    @Column(name = "GAMEID")
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

        ChapterEntity that = (ChapterEntity) o;

        if (chapternumber != that.chapternumber) return false;
        if (gameid != that.gameid) return false;
        if (chaptername != null ? !chaptername.equals(that.chaptername) : that.chaptername != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = chaptername != null ? chaptername.hashCode() : 0;
        result = 31 * result + (int) (chapternumber ^ (chapternumber >>> 32));
        result = 31 * result + (int) (gameid ^ (gameid >>> 32));
        return result;
    }
}
