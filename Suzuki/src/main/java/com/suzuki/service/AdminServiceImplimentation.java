package com.suzuki.service;

import com.suzuki.dto.AdminLoggingDto;
import com.suzuki.dto.BikeDetailsDto;
import com.suzuki.dto.ModelBranchDto;
import com.suzuki.dto.ShowRoomDetailsDto;
import com.suzuki.entity.AdminLoggingEntity;
import com.suzuki.entity.BikeDetailEntity;
import com.suzuki.entity.ModelBranchEntity;
import com.suzuki.entity.ShowRoomDetailEntity;
import com.suzuki.repository.AdminRepository;
import com.suzuki.util.TimeScheduler;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static com.suzuki.util.InitCaseConverter.toInitCase;

@Service
public class AdminServiceImplimentation implements AdminService{

    private static String UPLOADED_FOLDER = "C://Photos//";

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    AdminRepository adminRepository;


    @Override
    public boolean saveOtp(String email, String otp) {

        String encryptedOtp = bCryptPasswordEncoder.encode(otp);
        AdminLoggingEntity adminLoggingEntity = new AdminLoggingEntity();
        AdminLoggingDto dtoFindByEmail = findByEmail(email);

        if(dtoFindByEmail==null) {
            AdminLoggingDto dto=new AdminLoggingDto();
            BeanUtils.copyProperties(dto,adminLoggingEntity);
            adminLoggingEntity.setEmailId(email);
            adminLoggingEntity.setOtp(encryptedOtp);
            adminLoggingEntity.setOtpTime(LocalTime.now().plusMinutes(2).toString());
        }
        else {
            BeanUtils.copyProperties(dtoFindByEmail,adminLoggingEntity);
            adminLoggingEntity.setOtp(encryptedOtp);
            adminLoggingEntity.setOtpTime(LocalTime.now().plusMinutes(2).toString());
        }
        //timeScheduler.Schedule();
        boolean result = adminRepository.saveOtp(adminLoggingEntity);

        if(result){
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public AdminLoggingDto findByEmail(String email) {
        AdminLoggingEntity entity = adminRepository.findByEmail(email);

        if(entity!=null) {
            AdminLoggingDto dto = new AdminLoggingDto();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }
        return null;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {

        AdminLoggingDto dtoFindByEmail = findByEmail(email);
        if(bCryptPasswordEncoder.matches(otp,dtoFindByEmail.getOtp())&& LocalTime.now().isBefore(LocalTime.parse(dtoFindByEmail.getOtpTime())))
        {
            AdminLoggingEntity entity=new AdminLoggingEntity();
            BeanUtils.copyProperties(dtoFindByEmail,entity);
            entity.setLogInTime(LocalTime.now().toString());
            entity.setLoginInDate(LocalDate.now().toString());
            adminRepository.saveLoginDetails(entity);
            return true;
        }
        else{
        return false;}
    }

    @Override
    public void logout(String email) {

        AdminLoggingDto dtoFindByEmail = findByEmail(email);
        AdminLoggingEntity entity=new AdminLoggingEntity();
        BeanUtils.copyProperties(dtoFindByEmail,entity);
        entity.setLogOutTime(LocalTime.now().toString());
        adminRepository.saveLoginDetails(entity);
    }

    @Override
    public boolean saveShowRoomDetails(ShowRoomDetailsDto dto, MultipartFile file) {

        if(file!=null) {
            try {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
                Files.write(path, bytes);
                dto.setShowRoomImageContentType(file.getContentType());

                dto.setShowRoomImageFileName(file.getOriginalFilename());


                ShowRoomDetailEntity entity=new ShowRoomDetailEntity();
                dto.setBranchName(toInitCase(dto.getBranchName()));
                dto.setBranchManagerName(toInitCase(dto.getBranchManagerName()));
                BeanUtils.copyProperties(dto,entity);
                adminRepository.saveShowRoomDetails(entity);
                return true;

            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }else {
            return false;
        }
    }

    @Override
    public ShowRoomDetailsDto findByContactNumber(Long number) {
        ShowRoomDetailEntity entityFindByNumber = adminRepository.findByNumber(number);

        if(entityFindByNumber!=null)
        {
            ShowRoomDetailsDto dto=new ShowRoomDetailsDto();
            BeanUtils.copyProperties(entityFindByNumber,dto);
            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public ShowRoomDetailsDto findByBranch(String branch) {
        ShowRoomDetailEntity entityFindByBranch = adminRepository.findByBranch(branch);

        if(entityFindByBranch!=null)
        {
            ShowRoomDetailsDto dto=new ShowRoomDetailsDto();
            BeanUtils.copyProperties(entityFindByBranch,dto);

            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public List<ShowRoomDetailsDto> fetchShowrooms() {
        List<ShowRoomDetailsDto> dtos= new ArrayList<>();
        List<ShowRoomDetailEntity> entities = adminRepository.fetchShowrooms();

        entities.stream().forEach(singleEntity->{
            ShowRoomDetailsDto singleDto=new ShowRoomDetailsDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public boolean updateShowRoomData(ShowRoomDetailsDto dto,MultipartFile file) {

        ShowRoomDetailEntity entity=new ShowRoomDetailEntity();
        if(file.isEmpty())
        {

            ShowRoomDetailEntity dtoFindByBranch = adminRepository.findByBranch(dto.getBranchName());
            dto.setShowRoomImageFileName(dtoFindByBranch.getShowRoomImageFileName());
            dto.setShowRoomImageContentType(dtoFindByBranch.getShowRoomImageContentType());
        }
        else {
            try {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
                Files.write(path, bytes);
                dto.setShowRoomImageContentType(file.getContentType());

                dto.setShowRoomImageFileName(file.getOriginalFilename());


            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }

        }
        dto.setBranchName(toInitCase(dto.getBranchName()));
        dto.setBranchManagerName(toInitCase(dto.getBranchManagerName()));
        BeanUtils.copyProperties(dto,entity);
        boolean result = adminRepository.updateShowRoomData(entity);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public boolean deleteShowRoom(String branch) {

        boolean result = adminRepository.deleteShowRoom(branch);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public Map<Object,Object> noOfBranches() {
        Map<Object, Object> result = adminRepository.fetchNoOfShowroom();

        return result;
    }

    @Override
    public boolean saveBike(BikeDetailsDto dto, MultipartFile front, MultipartFile left, MultipartFile back, MultipartFile right, MultipartFile top, MultipartFile d3) {

        if(front!=null && left!=null && back!=null && right!=null && top!=null && d3!=null) {
            try {
                byte[] bytes = front.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + front.getOriginalFilename());
                Files.write(path, bytes);
                dto.setFrontImageContentType(front.getContentType());
                dto.setFrontImageFileName(front.getOriginalFilename());


                byte[] bytes1 = left.getBytes();
                Path path1 = Paths.get(UPLOADED_FOLDER + left.getOriginalFilename());
                Files.write(path1, bytes1);
                dto.setLeftImageContentType(left.getContentType());
                dto.setLeftImageFileName(left.getOriginalFilename());


                byte[] bytes2 = back.getBytes();
                Path path2 = Paths.get(UPLOADED_FOLDER + back.getOriginalFilename());
                Files.write(path2, bytes2);
                dto.setBackImageContentType(back.getContentType());
                dto.setBackImageFileName(back.getOriginalFilename());

                byte[] bytes3 = right.getBytes();
                Path path3 = Paths.get(UPLOADED_FOLDER + right.getOriginalFilename());
                Files.write(path3, bytes3);
                dto.setRightImageContentType(right.getContentType());
                dto.setRightImageFileName(right.getOriginalFilename());

                byte[] bytes4 = top.getBytes();
                Path path4 = Paths.get(UPLOADED_FOLDER + top.getOriginalFilename());
                Files.write(path4, bytes4);
                dto.setTopImageContentType(top.getContentType());
                dto.setTopImageFileName(top.getOriginalFilename());

                byte[] bytes5 = d3.getBytes();
                Path path5 = Paths.get(UPLOADED_FOLDER + d3.getOriginalFilename());
                Files.write(path5, bytes5);
                dto.setD3ImageContentType(d3.getContentType());
                dto.setD3ImageFileName(d3.getOriginalFilename());

                BikeDetailEntity entity=new BikeDetailEntity();
                dto.setBikeName(toInitCase(dto.getBikeName()));
                BeanUtils.copyProperties(dto,entity);
                adminRepository.saveBike(entity);
                return true;

            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }else {
            return false;
        }
    }

    @Override
    public BikeDetailsDto findByBikeName(String bikename) {

        BikeDetailEntity entityFindBybikeName = adminRepository.findByBikeName(bikename);

        if(entityFindBybikeName!=null)
        {
            BikeDetailsDto dto=new BikeDetailsDto();
            BeanUtils.copyProperties(entityFindBybikeName,dto);
            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public BikeDetailsDto findByBikeModel(String bikemodel) {
        BikeDetailEntity entityFindByModels = adminRepository.findByBikeModel(bikemodel);

        if(entityFindByModels!=null)
        {
            BikeDetailsDto dto=new BikeDetailsDto();
            BeanUtils.copyProperties(entityFindByModels,dto);
            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public List<BikeDetailsDto> fetchBikes() {
        List<BikeDetailsDto> dtos= new ArrayList<>();
        List<BikeDetailEntity> entities = adminRepository.fetchBikes();

        entities.stream().forEach(singleEntity->{
            BikeDetailsDto singleDto=new BikeDetailsDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public boolean deleteBike(String bikename) {

        boolean result = adminRepository.deleteBike(bikename);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public boolean updateBike(BikeDetailsDto dto, MultipartFile front, MultipartFile left, MultipartFile back, MultipartFile right, MultipartFile top, MultipartFile d3) {

        BikeDetailsDto dtoFindByBikeName = findByBikeName(dto.getBikeName());
        BikeDetailEntity entity=new BikeDetailEntity();
        if(front.isEmpty())
        {
            dto.setFrontImageFileName(dtoFindByBikeName.getFrontImageFileName());
            dto.setFrontImageContentType(dtoFindByBikeName.getFrontImageContentType());
        }
        else
        {
            try {
                byte[] bytes = front.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + front.getOriginalFilename());
                Files.write(path, bytes);
                dto.setFrontImageContentType(front.getContentType());
                dto.setFrontImageFileName(front.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        if(left.isEmpty())
        {
            dto.setLeftImageFileName(dtoFindByBikeName.getLeftImageFileName());
            dto.setLeftImageContentType(dtoFindByBikeName.getLeftImageContentType());
        }
        else
        {
            try {
                byte[] bytes = left.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + left.getOriginalFilename());
                Files.write(path, bytes);
                dto.setLeftImageContentType(left.getContentType());
                dto.setLeftImageFileName(left.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        if(back.isEmpty())
        {
            dto.setBackImageFileName(dtoFindByBikeName.getBackImageFileName());
            dto.setBackImageContentType(dtoFindByBikeName.getBackImageContentType());
        }
        else
        {
            try {
                byte[] bytes = back.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + back.getOriginalFilename());
                Files.write(path, bytes);
                dto.setBackImageContentType(back.getContentType());
                dto.setBackImageFileName(back.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        if(right.isEmpty())
        {
            dto.setRightImageFileName(dtoFindByBikeName.getRightImageFileName());
            dto.setRightImageContentType(dtoFindByBikeName.getRightImageContentType());
        }
        else
        {
            try {
                byte[] bytes = right.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + right.getOriginalFilename());
                Files.write(path, bytes);
                dto.setRightImageContentType(right.getContentType());
                dto.setRightImageFileName(right.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        if(top.isEmpty())
        {
            dto.setTopImageFileName(dtoFindByBikeName.getTopImageFileName());
            dto.setTopImageContentType(dtoFindByBikeName.getTopImageContentType());
        }
        else
        {
            try {
                byte[] bytes = top.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + top.getOriginalFilename());
                Files.write(path, bytes);
                dto.setTopImageContentType(top.getContentType());
                dto.setTopImageFileName(top.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        if(d3.isEmpty())
        {
            dto.setD3ImageFileName(dtoFindByBikeName.getD3ImageFileName());
            dto.setD3ImageContentType(dtoFindByBikeName.getD3ImageContentType());
        }
        else
        {
            try {
                byte[] bytes = d3.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + d3.getOriginalFilename());
                Files.write(path, bytes);
                dto.setD3ImageContentType(d3.getContentType());
                dto.setD3ImageFileName(d3.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }
        }

        dto.setBikeName(toInitCase(dto.getBikeName()));
        BeanUtils.copyProperties(dto,entity);

        boolean result = adminRepository.updateBike(entity);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public boolean modelBranch(ModelBranchDto dto) {

        ShowRoomDetailsDto branchDto =findByBranch(dto.getBranchName());
        BikeDetailsDto bikeDto = findByBikeName(dto.getBikeName());

        ModelBranchDto branchIdDto = findByBranchModelId(branchDto.getId(),bikeDto.getId());

        if(branchIdDto==null) {
            ModelBranchEntity entity = new ModelBranchEntity();
            entity.setBranchId(branchDto.getId());
            entity.setBikeId(bikeDto.getId());
            boolean result = adminRepository.modelBranch(entity);
            if (result) {
                return true;
            } else {
                return false;
            }
        }
        else {
            return false;
        }
    }

    @Override
    public ModelBranchDto findByBranchModelId(Integer showid, Integer biId) {
        ModelBranchEntity entityFindById = adminRepository.findByBranchModelId(showid,biId);

        if(entityFindById!=null)
        {
            ModelBranchDto dto=new ModelBranchDto();
            BeanUtils.copyProperties(entityFindById,dto);
            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public List<ShowRoomDetailsDto> activeFetch() {
        List<ShowRoomDetailsDto> dtos= new ArrayList<>();
        List<ShowRoomDetailEntity> entities = adminRepository.activeFetch();

        entities.stream().forEach(singleEntity->{
            ShowRoomDetailsDto singleDto=new ShowRoomDetailsDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public BikeDetailsDto bikeFetchById(Integer id) {

        BikeDetailEntity entityFindById = adminRepository.bikeFetchById(id);

        if(entityFindById!=null)
        {
            BikeDetailsDto dto=new BikeDetailsDto();
            BeanUtils.copyProperties(entityFindById,dto);
            return dto;
        }
        else {
            return null;
        }
    }

    @Override
    public List<ModelBranchDto> findBikeIds(Integer id) {
        List<ModelBranchDto> dtos= new ArrayList<>();
        List<ModelBranchEntity> entities = adminRepository.findBikeIds(id);

        entities.stream().forEach(singleEntity->{
            ModelBranchDto singleDto=new ModelBranchDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public boolean deleteBikeModel(Integer id, Integer bikeId) {
        if(id!=0&& bikeId!=0)
        {
            boolean result = adminRepository.deleteBikeModel(id, bikeId);
            if(result)
            {
                return true;
            }
            else {
                return false;
            }
        }
        return false;
    }
}
