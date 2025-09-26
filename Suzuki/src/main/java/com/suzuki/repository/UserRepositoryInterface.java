package com.suzuki.repository;

import com.suzuki.dto.FollowUpDetailsDto;
import com.suzuki.dto.UserLoggingDto;
import com.suzuki.dto.UserLoginCredintialsDto;
import com.suzuki.entity.FollowUpDetailsEntity;
import com.suzuki.entity.UserEntity;
import com.suzuki.entity.UserLoggingEntity;
import com.suzuki.entity.UserLoginCredinetialsEntity;

import java.util.List;

public interface UserRepositoryInterface {

    boolean saveUserDetails(UserEntity entity);

    UserEntity findByEmailId(String email);

    UserEntity findByContactNumber(Long number);

    boolean updateUserDetails(UserEntity entity);

    List<UserEntity> fetchUserDetails();

    boolean saveFollowUpDetails(FollowUpDetailsEntity entity);

    List<FollowUpDetailsEntity> fetchFollowUpDetails(String email);

    UserLoginCredinetialsEntity findUserLoginDetailsByEmail(String email);

    boolean saveLoginCredintials(UserLoginCredinetialsEntity entity);

    boolean saveLoginDetails(UserLoggingEntity entity);

    boolean updateLoginCredintials(UserLoginCredinetialsEntity entity);

    UserLoggingEntity findLoggingDetails(String email);

}
