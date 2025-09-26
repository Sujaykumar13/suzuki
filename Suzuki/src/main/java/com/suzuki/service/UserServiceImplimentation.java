package com.suzuki.service;

import com.suzuki.dto.*;
import com.suzuki.entity.*;
import com.suzuki.repository.UserRepositoryInterface;
import lombok.extern.slf4j.Slf4j;
import net.bytebuddy.asm.Advice;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.DelegatingServerHttpResponse;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.suzuki.util.InitCaseConverter.toInitCase;

@Service
@Slf4j
public class UserServiceImplimentation implements UserServiceInterface {

    private static String UPLOADED_FOLDER = "C://Photos//";

    @Autowired
    UserRepositoryInterface userRepositoryInterface;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public boolean saveUserDetails(UserDetailsDto dto) {


        UserDetailsDto dtoFindByMobileNumber = findByContactNumber(dto.getContactNumber());
        if(dtoFindByMobileNumber==null) {
            UserEntity entity=new UserEntity();
            dto.setFirstName(toInitCase(dto.getFirstName()));
            dto.setCity(toInitCase(dto.getCity()));
            BeanUtils.copyProperties(dto,entity);
            userRepositoryInterface.saveUserDetails(entity);
            return true;
        }
        else {

            return false;
        }
    }

    @Override
    public UserDetailsDto findByEmailId(String email) {
        UserEntity entity = userRepositoryInterface.findByEmailId(email);

        if(entity!=null) {
            UserDetailsDto dto = new UserDetailsDto();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }
        return null;
    }

    @Override
    public UserDetailsDto findByContactNumber(Long number) {
        UserEntity entity = userRepositoryInterface.findByContactNumber(number);

        if(entity!=null) {
            UserDetailsDto dto = new UserDetailsDto();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }
        return null;
    }

    @Override
    public boolean updateUserDetails(UserDetailsDto dto) {
        System.out.println(dto);
        UserDetailsDto userDetails = findByEmailId(dto.getUserEmailId());
        dto.setUserImageFileName(userDetails.getUserImageFileName());
        dto.setUserImageContentType(userDetails.getUserImageContentType());

            UserEntity entity=new UserEntity();
        dto.setFirstName(toInitCase(dto.getFirstName()));
        dto.setCity(toInitCase(dto.getCity()));
            BeanUtils.copyProperties(dto,entity);
        System.out.println("service entity============="+entity);

            userRepositoryInterface.updateUserDetails(entity);
            return true;

    }

    @Override
    public List<UserDetailsDto> fetchUserDetails() {
        List<UserDetailsDto> dtos= new ArrayList<>();
        List<UserEntity> entities = userRepositoryInterface.fetchUserDetails();

        entities.stream().forEach(singleEntity->{
            UserDetailsDto singleDto=new UserDetailsDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public boolean saveFollowUpDetails(FollowUpDetailsDto dto) {

        dto.setDate(LocalDate.now().toString());
        dto.setTime(LocalTime.now().toString());
        if(dto.getCreatedBy()==null && dto.getDetails()==null) {
            dto.setCreatedBy("admin:" + dto.getUserEmailId());
            dto.setDetails("Na");
        }
        FollowUpDetailsEntity entity=new FollowUpDetailsEntity();
        BeanUtils.copyProperties(dto,entity);
        boolean result = userRepositoryInterface.saveFollowUpDetails(entity);
        if(true)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public List<FollowUpDetailsDto> fetchFollowUpDetails(String email) {
        List<FollowUpDetailsDto> dtos= new ArrayList<>();
        List<FollowUpDetailsEntity> entities = userRepositoryInterface.fetchFollowUpDetails(email);

        entities.stream().forEach(singleEntity->{
            FollowUpDetailsDto singleDto=new FollowUpDetailsDto();
            BeanUtils.copyProperties(singleEntity,singleDto);
            dtos.add(singleDto);
        });

        return dtos;
    }

    @Override
    public UserLoginCredintialsDto findUserLoginCredintials(String email) {
        UserLoginCredinetialsEntity entity = userRepositoryInterface.findUserLoginDetailsByEmail(email);

        if(entity!=null) {
            UserLoginCredintialsDto dto = new UserLoginCredintialsDto();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }
        return null;
    }

    @Override
    public boolean saveLoginCredintials(UserLoginCredintialsDto dto) {

        UserLoginCredinetialsEntity entity=new UserLoginCredinetialsEntity();
        dto.setPassword(bCryptPasswordEncoder.encode(dto.getPassword()));
        BeanUtils.copyProperties(dto,entity);
        boolean result = userRepositoryInterface.saveLoginCredintials(entity);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public boolean saveLoginDetails(UserLoginCredintialsDto dto) {

        UserLoginCredintialsDto credintialsDto = findUserLoginCredintials(dto.getUserEmailId());
    if(credintialsDto!=null)
    {
          if(credintialsDto.getNoOfAttempts()<3)
          {
              if(bCryptPasswordEncoder.matches(dto.getPassword(),credintialsDto.getPassword()))
              {

                   credintialsDto.setNoOfAttempts(0);
                   credintialsDto.setEnabled(true);
                   UserLoginCredinetialsEntity userLoginCredinetialsEntity=new UserLoginCredinetialsEntity();
                   BeanUtils.copyProperties(credintialsDto,userLoginCredinetialsEntity);
                   userRepositoryInterface.updateLoginCredintials(userLoginCredinetialsEntity);

                  UserLoggingEntity logingDetails = userRepositoryInterface.findLoggingDetails(dto.getUserEmailId());
                  UserLoggingEntity userLoggingEntity=new UserLoggingEntity();
                  if(logingDetails!=null)
                  {
                   logingDetails.setUserEmailId(dto.getUserEmailId());
                   logingDetails.setLoginDate(LocalDate.now().toString());
                   logingDetails.setLoginTime(LocalTime.now().toString());
                   BeanUtils.copyProperties(logingDetails,userLoggingEntity);
                   userRepositoryInterface.saveLoginDetails(userLoggingEntity);

                  }
                  else {
                      userLoggingEntity.setUserEmailId(dto.getUserEmailId());
                      userLoggingEntity.setLoginDate(LocalDate.now().toString());
                      userLoggingEntity.setLoginTime(LocalTime.now().toString());
                      userRepositoryInterface.saveLoginDetails(userLoggingEntity);

                  }
                  return true;

              }
               else{
                 UserLoginCredinetialsEntity userLoginCredinetialsEntity=new UserLoginCredinetialsEntity();
                 BeanUtils.copyProperties(credintialsDto,userLoginCredinetialsEntity);
                 int atempts=userLoginCredinetialsEntity.getNoOfAttempts();
                 atempts++;
                 userLoginCredinetialsEntity.setNoOfAttempts(atempts);
                 if(atempts>=3)
                 {
                     userLoginCredinetialsEntity.setEnabled(false);
                 }
                 userRepositoryInterface.updateLoginCredintials(userLoginCredinetialsEntity);
                 return false;
              }
          }
    }
        return false;
    }

    @Override
    public UserLoggingDto findLoggingDetails(String email) {
        UserLoggingEntity entity = userRepositoryInterface.findLoggingDetails(email);


             if(entity!=null) {
            UserLoggingDto dto = new UserLoggingDto();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }
        return null;
    }

    @Override
    public boolean saveUserOtp(String email, String otp) {

        UserLoginCredintialsDto loginCredintialsDto = findUserLoginCredintials(email);
        if(loginCredintialsDto!=null)
        {
            loginCredintialsDto.setOtp(bCryptPasswordEncoder.encode(otp));
            loginCredintialsDto.setOtpTime(LocalTime.now().plusMinutes(2).toString());
            UserLoginCredinetialsEntity entity=new UserLoginCredinetialsEntity();
            BeanUtils.copyProperties(loginCredintialsDto,entity);
            userRepositoryInterface.updateLoginCredintials(entity);
            return true;
        }
        return false;
    }

    @Override
    public boolean verifyUserOtp(String email, String otp) {

        UserLoginCredintialsDto loginCredintialsDto = findUserLoginCredintials(email);
        if(loginCredintialsDto!=null)
        {
            if(bCryptPasswordEncoder.matches(otp,loginCredintialsDto.getOtp()) &&
                    LocalTime.now().isBefore(LocalTime.parse(loginCredintialsDto.getOtpTime())))
            {
               return true;
            }
            return false;
        }
        return false;
    }

    @Override
    public boolean resetPassword(String email, String password, String confirmPassword) {

        UserLoginCredinetialsEntity userLoginDetails = userRepositoryInterface.findUserLoginDetailsByEmail(email);
        if(password.equals(confirmPassword))
        {
            System.out.println("reset password inside if"+email+password+confirmPassword);
            userLoginDetails.setPassword(bCryptPasswordEncoder.encode(password));
            userLoginDetails.setNoOfAttempts(0);
            userLoginDetails.setEnabled(true);
            boolean result = userRepositoryInterface.updateLoginCredintials(userLoginDetails);
             if (result)
             {
                 return true;
             }
             return false;
        }
        return false;
    }

    @Override
    public boolean logout(String email) {
        UserLoggingEntity loggigDetails = userRepositoryInterface.findLoggingDetails(email);
        loggigDetails.setLogoutTime(LocalTime.now().toString());
        userRepositoryInterface.saveLoginDetails(loggigDetails);
        return true;
    }

    @Override
    public boolean updateUser(UserDetailsDto dto, MultipartFile file) {
        UserEntity entity=new UserEntity();
        if(file.isEmpty())
        {
            UserDetailsDto dtoFindByEmail = findByEmailId(dto.getUserEmailId());
            dto.setUserImageFileName(dtoFindByEmail.getUserImageFileName());
            dto.setUserImageContentType(dtoFindByEmail.getUserImageContentType());
        }
        else {
            try {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
                Files.write(path, bytes);
                dto.setUserImageContentType(file.getContentType());

                dto.setUserImageFileName(file.getOriginalFilename());


            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return false;
            }

        }
        BeanUtils.copyProperties(dto,entity);
        boolean result = userRepositoryInterface.updateUserDetails(entity);
        if(result)
        {
            return true;
        }
        else {
            return false;
        }
    }
}
