package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "admin_log_in_details")
@NamedQuery(name="findByEmail",query="select e from AdminLoggingEntity e where e.emailId=:email")
public class AdminLoggingEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "email_id")
    private String emailId;

    private String otp;

    @Column(name = "log_in_time")
    private String logInTime="000000";

    @Column(name = "log_in_date")
    private String loginInDate="000000";

    @Column(name = "log_out_time")
    private String logOutTime="0000000";

    private String otpTime;
}
