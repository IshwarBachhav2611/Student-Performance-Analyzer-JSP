package com.spa.service;

import com.spa.model.User;

public interface UserService {
    User login(String username, String password);
    boolean register(String username, String password);
}
