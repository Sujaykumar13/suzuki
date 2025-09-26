package com.suzuki.dto;

import lombok.Data;

@Data
public class UserLoginCredintialsDto {

    private Integer id;

    private String userEmailId;

    private String otp="Na";

    private String otpTime="Na";

    private String password;

    private String confirmPassword;

    private Integer noOfAttempts=0;

    private boolean isEnabled=true;
}
