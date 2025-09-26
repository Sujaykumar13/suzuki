package com.suzuki.service;

import com.suzuki.dto.FollowUpDetailsDto;
import com.suzuki.dto.UserDetailsDto;
import com.suzuki.dto.UserLoggingDto;
import com.suzuki.dto.UserLoginCredintialsDto;
import com.suzuki.entity.UserLoggingEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserServiceInterface {

    boolean saveUserDetails(UserDetailsDto dto);

    UserDetailsDto findByEmailId(String email);

    UserDetailsDto findByContactNumber(Long number);

    boolean updateUserDetails(UserDetailsDto dto);

    List<UserDetailsDto> fetchUserDetails();

    boolean saveFollowUpDetails(FollowUpDetailsDto dto);

    List<FollowUpDetailsDto> fetchFollowUpDetails(String email);

    UserLoginCredintialsDto findUserLoginCredintials(String email);

    boolean saveLoginCredintials(UserLoginCredintialsDto dto);

    boolean saveLoginDetails(UserLoginCredintialsDto dto);

    UserLoggingDto findLoggingDetails(String email);

    boolean saveUserOtp(String email,String otp);

    boolean verifyUserOtp(String email,String otp);

    boolean resetPassword(String email,String password,String confirmPassword);

    boolean logout(String email);

    boolean updateUser(UserDetailsDto dto, MultipartFile file);
}
