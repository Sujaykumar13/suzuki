package com.suzuki.dto;

import java.util.List;

public class ShowroomWithBikesDto {
    private ShowRoomDetailsDto showroom;
    private List<String> bikeNames;

    // Constructors
    public ShowroomWithBikesDto() {}

    public ShowroomWithBikesDto(ShowRoomDetailsDto showroom, List<String> bikeNames) {
        this.showroom = showroom;
        this.bikeNames = bikeNames;
    }

    // Getters and Setters
    public ShowRoomDetailsDto getShowroom() {
        return showroom;
    }

    public void setShowroom(ShowRoomDetailsDto showroom) {
        this.showroom = showroom;
    }

    public List<String> getBikeNames() {
        return bikeNames;
    }

    public void setBikeNames(List<String> bikeNames) {
        this.bikeNames = bikeNames;
    }
}
