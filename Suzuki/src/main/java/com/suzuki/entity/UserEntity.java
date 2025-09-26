package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;


@Data
@Entity
@Table(name = "userDetails")
@NamedQuery(name="findByUserMobileNumber",query="select e from UserEntity e where e.contactNumber=:contactNumber")
@NamedQuery(name="findByUserEmail",query="select e from UserEntity e where e.userEmailId=:email")
@NamedQuery(name="fetchAllUsers",query="select e from UserEntity e")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Integer id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email_Id")
    private  String userEmailId;

    @Column(name = "contact_number")
    private  long contactNumber;

    private String city;

    private String gender;

    private String reason;

    @Column(name = "user_image_file_name")
    private String userImageFileName;

    @Column(name = "user_image_content_type")
    private String userImageContentType;

    private String comments;
}
