package com.spa.service;

import com.spa.dao.UserDAO;
import com.spa.dao.UserDAOImpl;
import com.spa.model.User;
import com.spa.util.PasswordUtil;

import java.sql.SQLException;

public class UserServiceImpl implements UserService {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public User login(String username, String password) {
        try {
            User user = userDAO.getUserByUsername(username);
            if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
                return user;
            }
        } catch (SQLException e) {
            // In a real application, replace with clean logging
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean register(String username, String password) {
        try {
            if (userDAO.getUserByUsername(username) != null) {
                return false; // username already exists
            }
            String hashedPassword = PasswordUtil.hashPassword(password);
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setRole("ADMIN");
            return userDAO.createUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
