package com.suzuki.dto;

import lombok.Data;

@Data
public class UserLoggingDto {

    private Integer id;

    private String userEmailId;

    private String loginTime;

    private String loginDate;

    private String logoutTime="000000000";

}
