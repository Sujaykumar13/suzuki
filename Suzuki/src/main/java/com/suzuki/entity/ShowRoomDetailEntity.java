package com.suzuki.entity;


import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@Table(name = "show_room_details")
@NamedQuery(name="findByMobileNumber",query="select e from ShowRoomDetailEntity e where e.contactNumber=:number")
@NamedQuery(name="findByBranch",query="select e from ShowRoomDetailEntity e where e.branchName=:branch")
@NamedQuery(name="fetch",query="select e from ShowRoomDetailEntity e")
@NamedQuery(name="delete" ,query="delete from ShowRoomDetailEntity where branchName=:bName")
@NamedQuery(name="fetchByBranch",query="select count(e) from ShowRoomDetailEntity e")
@NamedQuery(name="active",query="select count(e) from ShowRoomDetailEntity e where e.status = 'Active'")
@NamedQuery(name="inactive",query="select count(e) from ShowRoomDetailEntity e where e.status = 'InActive'")
@NamedQuery(name="maintence",query="select count(e) from ShowRoomDetailEntity e where e.status like 'U%'")
@NamedQuery(name="activeFetch",query="select e from ShowRoomDetailEntity e  where e.status = 'Active'")
public class ShowRoomDetailEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "branch_image_file_name")
    private String showRoomImageFileName;

    @Column(name = "branch_image_content_type")
    private String showRoomImageContentType;

    @Column(name = "branch_name")
    private String branchName;

    @Column(name = "branch_location")
    private String location;

    @Column(name = "manager_name")
    private String branchManagerName;

    @Column(name = "contact_number")
    private long contactNumber;

    private String status;

    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JoinColumn(name = "bbike_list",referencedColumnName = "id")
    private List<BikeDetailEntity> bikeDetails;
}
