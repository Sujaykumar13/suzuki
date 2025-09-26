package com.suzuki.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "bike_details")
@NamedQuery(name="findByModel",query="select e from BikeDetailEntity e where e.bikeModel=:model")
@NamedQuery(name="findBybikeName",query="select e from BikeDetailEntity e where e.bikeName=:name")
@NamedQuery(name="fetchBike",query="select e from BikeDetailEntity e")
@NamedQuery(name="noOfModels",query="select count(e) from BikeDetailEntity e")
@NamedQuery(name="deleteBike" ,query="delete from BikeDetailEntity where bikeName=:bName")
@NamedQuery(name="findById",query="select e from BikeDetailEntity e where e.id=:bId")
public class BikeDetailEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "front_image_file_name")
    private String frontImageFileName;

    @Column(name = "front_image_content_type")
    private String frontImageContentType;

    @Column(name = "left_image_file_name")
    private String leftImageFileName;

    @Column(name = "left_image_content_type")
    private String leftImageContentType;

    @Column(name = "back_image_file_name")
    private String backImageFileName;

    @Column(name = "back_image_content_type")
    private String backImageContentType;

    @Column(name = "right_image_file_name")
    private String rightImageFileName;

    @Column(name = "right_image_content_type")
    private String rightImageContentType;

    @Column(name = "top_image_file_name")
    private String topImageFileName;

    @Column(name = "top_image_content_type")
    private String topImageContentType;

    @Column(name = "b3d_image_file_name")
    private String d3ImageFileName;

    @Column(name = "b3d_image_content_type")
    private String d3ImageContentType;

    @Column(name = "bike_name")
    private String bikeName;

    @Column(name = "bike_model")
    private String bikeModel;

    private Long price;

    @Column(name = "engine_capacity")
    private String engineCapacity;

    private String milege;

    @Column(name = "fuel_capacity")
    private String fuelCapacity;

}
