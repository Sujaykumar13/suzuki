package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "user_login_credintials")
@NamedQuery(name="findLogiingDetailsByEmail",query="select e from UserLoginCredinetialsEntity e where e.userEmailId=:email")
public class UserLoginCredinetialsEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "email_Id")
    private String userEmailId;

    private String otp;

    @Column(name = "otp_time")
    private String otpTime;

    private String password;

    @Column(name = "no_of_atempts")
    private Integer noOfAttempts;

    @Column(name = "is_Enabled")
    private boolean isEnabled;

}
