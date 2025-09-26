package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "user_login_Details")
@NamedQuery(name="findLoginDetails",query="select e from UserLoggingEntity e where e.userEmailId=:email")
public class UserLoggingEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "email_Id")
    private String userEmailId;

    @Column(name = "login_time")
    private String loginTime;

    @Column(name = "login_date")
    private String loginDate;

    @Column(name = "logout_time")
    private String logoutTime;

}
