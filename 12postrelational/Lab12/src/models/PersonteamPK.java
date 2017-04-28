package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by drd26 on 4/28/2017.
 */
public class PersonteamPK implements Serializable {
    private long personid;
    private String teamname;

    @Column(name = "PERSONID")
    @Id
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    @Column(name = "TEAMNAME")
    @Id
    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonteamPK that = (PersonteamPK) o;

        if (personid != that.personid) return false;
        if (teamname != null ? !teamname.equals(that.teamname) : that.teamname != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (personid ^ (personid >>> 32));
        result = 31 * result + (teamname != null ? teamname.hashCode() : 0);
        return result;
    }
}
