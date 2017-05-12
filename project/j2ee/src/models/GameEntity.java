package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "GAME", schema = "LDDBUSER", catalog = "")
public class GameEntity {
    private long gameid;
    private String gamename;
    private String gameurl;
    private Time datereleased;

    @Id
    @Column(name = "GAMEID")
    public long getGameid() {
        return gameid;
    }

    public void setGameid(long gameid) {
        this.gameid = gameid;
    }

    @Basic
    @Column(name = "GAMENAME")
    public String getGamename() {
        return gamename;
    }

    public void setGamename(String gamename) {
        this.gamename = gamename;
    }

    @Basic
    @Column(name = "GAMEURL")
    public String getGameurl() {
        return gameurl;
    }

    public void setGameurl(String gameurl) {
        this.gameurl = gameurl;
    }

    @Basic
    @Column(name = "DATERELEASED")
    public Time getDatereleased() {
        return datereleased;
    }

    public void setDatereleased(Time datereleased) {
        this.datereleased = datereleased;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        GameEntity that = (GameEntity) o;

        if (gameid != that.gameid) return false;
        if (gamename != null ? !gamename.equals(that.gamename) : that.gamename != null) return false;
        if (gameurl != null ? !gameurl.equals(that.gameurl) : that.gameurl != null) return false;
        if (datereleased != null ? !datereleased.equals(that.datereleased) : that.datereleased != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (gameid ^ (gameid >>> 32));
        result = 31 * result + (gamename != null ? gamename.hashCode() : 0);
        result = 31 * result + (gameurl != null ? gameurl.hashCode() : 0);
        result = 31 * result + (datereleased != null ? datereleased.hashCode() : 0);
        return result;
    }
}
