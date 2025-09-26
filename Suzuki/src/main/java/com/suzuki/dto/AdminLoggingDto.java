package com.suzuki.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
public class AdminLoggingDto {

    private Integer id;

    @NotNull(message = "emailId should not be null")
    @NotBlank(message = "emailId  should not be blank")
    @NotEmpty(message = "emailId should not be empty")
    private String emailId;

    private String otp;

    private String otpTime="000000";

    private String logInTime="000000";
    private String loginInDate="000000";

    private String logOutTime="000000";
}
