package com.suzuki.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class ShowRoomDetailsDto {

    private Integer id;

    private String showRoomImageFileName;

    private String showRoomImageContentType;

    @NotNull(message = "BranchName should not be null")
    @NotBlank(message = "BranchName  should not be blank")
    @NotEmpty(message = "BranchName should not be empty")
    private String branchName;

    private String location;

    @NotNull(message = "Branch ManagerName should not be null")
    @NotBlank(message = "Branch ManagerName  should not be blank")
    @NotEmpty(message = "Branch ManagerName should not be empty")
    private String branchManagerName;

    private long contactNumber;

    private String status;

    private List<String> bikeName;
}

