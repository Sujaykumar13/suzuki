package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "follow_up_details")
@NamedQuery(name="fetchFollowDetails", query="SELECT e FROM FollowUpDetailsEntity e WHERE e.userEmailId = :email ORDER BY e.date DESC,e.time DESC")

public class FollowUpDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name = "email_Id")
    private String userEmailId;

    private String date;

    private String time;

    @Column(name = "comments")
    private String comment;

    private String createdBy;

    private String details;
}
