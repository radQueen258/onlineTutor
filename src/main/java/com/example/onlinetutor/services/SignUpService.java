package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.models.User;

public interface SignUpService {

    User addUser (UserForm form);
}
