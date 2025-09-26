package com.suzuki.service;

import com.suzuki.dto.AdminLoggingDto;
import com.suzuki.dto.BikeDetailsDto;
import com.suzuki.dto.ModelBranchDto;
import com.suzuki.dto.ShowRoomDetailsDto;
import com.suzuki.entity.ModelBranchEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface AdminService {

    boolean saveOtp(String email,String otp);

    AdminLoggingDto findByEmail(String email);

    boolean verifyOtp(String email,String otp);

    void logout(String email);

    boolean saveShowRoomDetails(ShowRoomDetailsDto dto, MultipartFile file);

    ShowRoomDetailsDto findByContactNumber(Long number);

    ShowRoomDetailsDto findByBranch(String branch);

    List<ShowRoomDetailsDto> fetchShowrooms();

    boolean updateShowRoomData(ShowRoomDetailsDto dto,MultipartFile file);

    boolean deleteShowRoom(String branch);

    Map<Object,Object> noOfBranches();

    boolean saveBike(BikeDetailsDto dto,MultipartFile front,MultipartFile left,MultipartFile back,
                     MultipartFile right,MultipartFile top,MultipartFile d3);

    BikeDetailsDto findByBikeName(String bikename);

    BikeDetailsDto findByBikeModel(String bikemodel);

    List<BikeDetailsDto> fetchBikes();

    boolean deleteBike(String bikename);

    boolean updateBike(BikeDetailsDto dto,MultipartFile front,MultipartFile left,MultipartFile back,
                     MultipartFile right,MultipartFile top,MultipartFile d3);

    boolean modelBranch(ModelBranchDto dto);

    ModelBranchDto findByBranchModelId(Integer showid,Integer biId);

    List<ShowRoomDetailsDto> activeFetch();

    BikeDetailsDto bikeFetchById(Integer id);

    List<ModelBranchDto> findBikeIds(Integer id);

    boolean deleteBikeModel(Integer id,Integer bikeId);

    }



