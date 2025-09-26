package com.suzuki.dto;

import com.suzuki.entity.ShowRoomDetailEntity;
import lombok.Data;

import javax.persistence.CascadeType;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
public class BikeDetailsDto {

    private Integer id;

    private String frontImageFileName;

    private String frontImageContentType;

    private String leftImageFileName;

    private String leftImageContentType;

    private String backImageFileName;

    private String backImageContentType;

    private String rightImageFileName;

    private String rightImageContentType;

    private String topImageFileName;

    private String topImageContentType;

    private String d3ImageFileName;

    private String d3ImageContentType;

    @NotNull(message = "BikeName should not be null")
    @NotBlank(message = "BikeName  should not be blank")
    @NotEmpty(message = "BikeName should not be empty")
    private String bikeName;

    @NotNull(message = "ModelName should not be null")
    @NotBlank(message = "ModelName  should not be blank")
    @NotEmpty(message = "ModelName should not be empty")
    private String bikeModel;

    private Long price;

    @NotNull(message = "EngineName should not be null")
    @NotBlank(message = "EngineName  should not be blank")
    @NotEmpty(message = "EngineName should not be empty")
    private String engineCapacity;

    @NotNull(message = "milege should not be null")
    @NotBlank(message = "milege  should not be blank")
    @NotEmpty(message = "milege should not be empty")
    private String milege;

    @NotNull(message = "fuelCapacity should not be null")
    @NotBlank(message = "fuelCapacity  should not be blank")
    @NotEmpty(message = "fuelCapacity should not be empty")
    private String fuelCapacity;

    @ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
   private ShowRoomDetailEntity showRoomDetailEntity;

}
