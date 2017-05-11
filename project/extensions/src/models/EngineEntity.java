package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by drd26 on 5/11/2017.
 */
@Entity
@Table(name = "ENGINE", schema = "LDDBUSER", catalog = "")
public class EngineEntity {
    private long engineid;
    private String enginename;
    private Time datereleased;

    @Id
    @Column(name = "ENGINEID")
    public long getEngineid() {
        return engineid;
    }

    public void setEngineid(long engineid) {
        this.engineid = engineid;
    }

    @Basic
    @Column(name = "ENGINENAME")
    public String getEnginename() {
        return enginename;
    }

    public void setEnginename(String enginename) {
        this.enginename = enginename;
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

        EngineEntity that = (EngineEntity) o;

        if (engineid != that.engineid) return false;
        if (enginename != null ? !enginename.equals(that.enginename) : that.enginename != null) return false;
        if (datereleased != null ? !datereleased.equals(that.datereleased) : that.datereleased != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (engineid ^ (engineid >>> 32));
        result = 31 * result + (enginename != null ? enginename.hashCode() : 0);
        result = 31 * result + (datereleased != null ? datereleased.hashCode() : 0);
        return result;
    }
}
