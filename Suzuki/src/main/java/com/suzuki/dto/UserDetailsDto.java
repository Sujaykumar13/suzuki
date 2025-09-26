package com.suzuki.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
public class UserDetailsDto {

    private  Integer id;

    @NotNull(message = "first name should not be null")
    @NotBlank(message = "first name should not be blank")
    @NotEmpty(message = "first name should not be empty")
    private String firstName;

    @NotNull(message = "last name should not be null")
    @NotBlank(message = "last name should not be blank")
    @NotEmpty(message = "last name should not be empty")

    private String lastName;

    @NotNull(message = "emailId should not be null")
    @NotBlank(message = "emailId  should not be blank")
    @NotEmpty(message = "emailId should not be empty")
    private  String userEmailId;


    private  long contactNumber;


    @NotNull(message = "city should not be null")
    @NotBlank(message = "city should not be blank")
    @NotEmpty(message = "city should not be empty")
    private String city;

    @NotNull(message = "gender should not be null")
    @NotBlank(message = "gender should not be blank")
    @NotEmpty(message = "gender should not be empty")
    private String gender;

    private String reason;

    private String userImageFileName="NA";

    private String userImageContentType="NA";

    private String comments="NA";
}
