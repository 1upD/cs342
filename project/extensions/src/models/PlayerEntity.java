package models;

import javax.persistence.*;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "PLAYER", schema = "LDDBUSER", catalog = "")
public class PlayerEntity {
    private long playerid;
    private String username;

    @Id
    @Column(name = "PLAYERID")
    public long getPlayerid() {
        return playerid;
    }

    public void setPlayerid(long playerid) {
        this.playerid = playerid;
    }

    @Basic
    @Column(name = "USERNAME")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PlayerEntity that = (PlayerEntity) o;

        if (playerid != that.playerid) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (playerid ^ (playerid >>> 32));
        result = 31 * result + (username != null ? username.hashCode() : 0);
        return result;
    }
}
