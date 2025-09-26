package com.suzuki.repository;

import com.suzuki.dto.BikeDetailsDto;
import com.suzuki.entity.AdminLoggingEntity;
import com.suzuki.entity.BikeDetailEntity;
import com.suzuki.entity.ModelBranchEntity;
import com.suzuki.entity.ShowRoomDetailEntity;

import java.util.List;
import java.util.Map;

public interface AdminRepository {

    boolean saveOtp(AdminLoggingEntity entity);

    AdminLoggingEntity findByEmail(String email);

    void saveLoginDetails(AdminLoggingEntity entity);

    boolean saveShowRoomDetails(ShowRoomDetailEntity entity);

    ShowRoomDetailEntity findByBranch(String branchName);

    ShowRoomDetailEntity findByNumber(Long contactNumber);

    List<ShowRoomDetailEntity> fetchShowrooms();

    boolean updateShowRoomData(ShowRoomDetailEntity entity);

    boolean deleteShowRoom(String branch);

    Map<Object,Object> fetchNoOfShowroom();

    boolean saveBike(BikeDetailEntity entity);

    BikeDetailEntity findByBikeName(String bikename);

    BikeDetailEntity findByBikeModel(String bikemodel);

    List<BikeDetailEntity> fetchBikes();

    boolean deleteBike(String bikename);

    boolean updateBike(BikeDetailEntity entity);

    boolean modelBranch(ModelBranchEntity entity);

    ModelBranchEntity findByBranchModelId(Integer showid,Integer biId);

    List<ShowRoomDetailEntity> activeFetch();

    BikeDetailEntity bikeFetchById(Integer id);

    List<ModelBranchEntity> findBikeIds(Integer id);

    boolean deleteBikeModel(Integer id,Integer bikeId);

}
