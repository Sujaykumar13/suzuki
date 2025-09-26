package com.suzuki.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "branch_Model")
@NamedQuery(name="findByBranchId",query="select e from ModelBranchEntity e where e.branchId=:bId and e.bikeId=:bike")
@NamedQuery(name="deleteBikeModel" ,query="delete from ModelBranchEntity e where e.branchId=:bId and e.bikeId=:bike")
@NamedQuery(name="findBikeIdByBranchId",query="select e from ModelBranchEntity e where e.branchId=:bId")
public class ModelBranchEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "branch_id")
    private Integer branchId;

    @Column(name = "bike_id")
    private Integer bikeId;
}
