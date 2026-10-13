package com.spa.dao;

import com.spa.model.User;
import java.sql.SQLException;

public interface UserDAO {
    User getUserByUsername(String username) throws SQLException;
    boolean createUser(User user) throws SQLException;
}
