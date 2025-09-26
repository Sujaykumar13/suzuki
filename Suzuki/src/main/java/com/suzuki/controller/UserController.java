package com.suzuki.controller;

import com.suzuki.dto.*;
import com.suzuki.service.AdminService;
import com.suzuki.service.UserServiceInterface;
import com.suzuki.util.EmailSender;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
@Slf4j
public class UserController {

    private static String UPLOADED_FOLDER = "C://Photos//";

    @Autowired
    EmailSender emailSender;
    
    @Autowired
    UserServiceInterface userServiceInterface;

    @Autowired
    AdminService adminService;

    @RequestMapping("userRegister")
    public String getUserRegisterPage(@RequestParam String emailId, Model model)
    {
        model.addAttribute("email",emailId);
        return "userRegister";
    }

    @PostMapping("formdata")
    public String saveUserDetails(@Valid UserDetailsDto dto,@RequestParam String emailId, BindingResult bindingResult,Model model)
    {
        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult.hasErrors());
            List<ObjectError> errorList = bindingResult.getAllErrors();
            String error = errorList.get(1).getDefaultMessage();
            log.info(error);
            model.addAttribute("userError", "enter valid data");
            model.addAttribute("email",emailId);
            return "userRegister";
        }
        boolean result = userServiceInterface.saveUserDetails(dto);
        if (result) {
            model.addAttribute("userMsg", "registered successfully");
            model.addAttribute("email",emailId);
            return "userRegister";
        } else {
            model.addAttribute("userError", "enter valid data");
            model.addAttribute("email",emailId);
            return "userRegister";
        }
    }

    @RequestMapping("userEmailExist")
    @ResponseBody
    public ResponseEntity<String> emailExists(@RequestParam String userEmailId) {
        UserDetailsDto emailIsExist = userServiceInterface.findByEmailId(userEmailId);
        if (emailIsExist != null) {
            return ResponseEntity.ok("email is exist");
        }
        return ResponseEntity.ok("email accepted");
    }

    @RequestMapping("userContactNumberExist")
    @ResponseBody
    public ResponseEntity<String> phoneNumberExists(@RequestParam Long contactNumber) {
        UserDetailsDto contactNumberExists = userServiceInterface.findByContactNumber(contactNumber);
        if (contactNumberExists != null) {
            return ResponseEntity.ok("contact Number is exist");
        }
        return ResponseEntity.ok("contact number accepted");

    }

    @RequestMapping("userProfile")
    public String viewUserProfile(@RequestParam String emailId,
                                  @RequestParam(defaultValue = "1") int page, // Get current page or default to 1
                                  Model model) {

        int pageSize = 5; // Change as needed
        List<UserDetailsDto> allUserDetails = userServiceInterface.fetchUserDetails(); // Full list

        int totalItems = allUserDetails.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // Calculate start & end index
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalItems);

        // Get only current page data
        List<UserDetailsDto> pagedUserList = allUserDetails.subList(startIndex, endIndex);

        model.addAttribute("userDtos", pagedUserList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalUser",totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("email", emailId);

        return "userProfile";
    }


    @RequestMapping("singleUserProfile")
    public String viewSingleUserProfile(@RequestParam String emailId,@RequestParam String userEmailId,Model model)
    {
        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(userEmailId);

        model.addAttribute("userDto",singleUserDto);
        model.addAttribute("email",emailId);
        return "updateUser";
    }

    @RequestMapping("userSinglePage")
    public String viewSingleUser(@RequestParam String emailId,@RequestParam String userEmailId,Model model)
    {
        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(userEmailId);

        model.addAttribute("userDto",singleUserDto);
        model.addAttribute("email",emailId);
        return "userSinglePage";
    }

    @PostMapping("updateUserData")
    public String updateUserData(@RequestParam String emailId,UserDetailsDto dto,Model model)
    {

        boolean result = userServiceInterface.updateUserDetails(dto);
        if (result) {

            model.addAttribute("email",emailId);
            UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(dto.getUserEmailId());

            model.addAttribute("userDto",singleUserDto);
            return "userSinglePage";
        } else {

            model.addAttribute("email",emailId);
            UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(dto.getUserEmailId());

            model.addAttribute("userDto",singleUserDto);
            return "userSinglePage";
        }
    }

    @PostMapping("addFollowUp")
    public String addFollowUpDetails(@RequestParam String emailId, FollowUpDetailsDto dto,Model model)
    {
        userServiceInterface.saveFollowUpDetails(dto);
        model.addAttribute("email",emailId);
        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(dto.getUserEmailId());
        singleUserDto.setComments(dto.getComment());
        userServiceInterface.updateUserDetails(singleUserDto);
        model.addAttribute("followUpMsg","Your Follow Up Added");
        model.addAttribute("userDto",singleUserDto);
        return "userSinglePage";
    }

    @RequestMapping("followUpDetails")
    public String fetchFollowUpDetails(
            @RequestParam String emailId,
            @RequestParam String userEmailId,
            @RequestParam(defaultValue = "1") int page,  // current page, default to 1
            Model model) {

        int pageSize = 5; // items per page
        List<FollowUpDetailsDto> allFollowUps = userServiceInterface.fetchFollowUpDetails(userEmailId);

        int totalItems = allFollowUps.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalItems);

        List<FollowUpDetailsDto> pagedList = allFollowUps.subList(startIndex, endIndex);

        model.addAttribute("followDto", pagedList);
        model.addAttribute("totalfollowup",totalItems);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("email", emailId);

        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(userEmailId);
        model.addAttribute("userDto", singleUserDto);
        model.addAttribute("userEmail", singleUserDto.getUserEmailId());

        return "followUpDetails";
    }

    @GetMapping("profileBack")
    public String backToSingleProfilePage(@RequestParam String emailId,@RequestParam String userEmailId,Model model)
    {
        model.addAttribute("email",emailId);
        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(userEmailId);

        model.addAttribute("userDto",singleUserDto);
        return "userSinglePage";
    }

    @RequestMapping("login")
    public String getUserLoginPage()
    {
        return "userLogin";
    }



    @PostMapping("userLogin")
    public String userLogin(UserLoginCredintialsDto dto,Model model)
    {


        UserLoginCredintialsDto userLoginDto = userServiceInterface.findUserLoginCredintials(dto.getUserEmailId());
        if(userLoginDto==null)
        {
            userServiceInterface.saveLoginCredintials(dto);
            UserDetailsDto userDetails = userServiceInterface.findByEmailId(dto.getUserEmailId());
            userDetails.setUserImageFileName("dummy.jfif");
            userDetails.setUserImageContentType("image/webp");
            System.out.println("controller=================="+userDetails);
            userServiceInterface.updateUserDetails(userDetails);
            userServiceInterface.saveLoginDetails(dto);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

            model.addAttribute("dtos",bikeDtos);
            model.addAttribute("userEmail",dto.getUserEmailId());
            List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
            model.addAttribute("sdtos",showroomsDtos);;
            model.addAttribute("userDto",userDetails);
            return "userHome";
        }
        else
        {
            boolean result = userServiceInterface.saveLoginDetails(dto);
            if(result) {
                model.addAttribute("userEmail", dto.getUserEmailId());
                UserDetailsDto userDetails = userServiceInterface.findByEmailId(dto.getUserEmailId());
                model.addAttribute("userDto",userDetails);
                List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

                model.addAttribute("dtos",bikeDtos);
                model.addAttribute("userEmail",dto.getUserEmailId());
                List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
                model.addAttribute("sdtos",showroomsDtos);
                return "userHome";
            }
            else {
                if(userLoginDto.isEnabled()) {
                    model.addAttribute("userEmail", dto.getUserEmailId());
                    model.addAttribute("verifypassword", "invalid password");
                    return "userLogin";
                }
                else {
                    model.addAttribute("userEmail", dto.getUserEmailId());
                    model.addAttribute("blocked", "account has been blocked reset your password");
                    return "userOtp";
                }
            }
        }
    }
    @RequestMapping("sendUserOtp")
    public String getUserOtp(@RequestParam String userEmailId, Model model)
    {

        String otp = emailSender.sendSimpleMessage(userEmailId);
        log.info("otp in otpsender======"+otp);
        boolean result = userServiceInterface.saveUserOtp(userEmailId,otp);
        if(result)
        {
            model.addAttribute("otpmsg","otp sent successfully valid for 2 minutes");
            model.addAttribute("userEmail",userEmailId);
            return "userOtp";
        }
        else
        {
            model.addAttribute("otpmsg","otp is not send");
            model.addAttribute("userEmail",userEmailId);
            return "userOtp";
        }


    }

    @PostMapping("verificationUserOTP")
    public String verifyUserOtp(@RequestParam String userEmailId,@RequestParam String otp,Model model)
    {

        boolean result = userServiceInterface.verifyUserOtp(userEmailId, otp);
        if(result) {
            model.addAttribute("verifymsg", "otp verified");
            model.addAttribute("userEmail",userEmailId);
            return "userResetPassword";
        }
        else {
            model.addAttribute("verifymsg","otp not verified");
            model.addAttribute("userEmail",userEmailId);
            return "userOtp";
        }

    }

    @RequestMapping("resetform")
    public String resetPassword(@RequestParam String userEmailId,@RequestParam String password,
                                @RequestParam String confirmPassword,Model model)
    {

        boolean result = userServiceInterface.resetPassword(userEmailId, password, confirmPassword);
        if(result)
        {
            model.addAttribute("userEmail",userEmailId);
            return "userLogin";
        }
        else {
            model.addAttribute("userEmail",userEmailId);
            model.addAttribute("msg","password not reseted");
            return "userResetPassword";
        }
    }

    @RequestMapping("forgot")
    public String forgotPassWord(@RequestParam String userEmailId,Model model)
    {
        model.addAttribute("userEmail",userEmailId);
        return "userOtp";
    }

    @RequestMapping("userLogout")
    public String userLogout(@RequestParam String userEmailId,Model model)
    {
        userServiceInterface.logout(userEmailId);
        return "index";
    }

    @RequestMapping("profile")
    public String getUserProfile(@RequestParam String userEmailId,Model model)
    {
        UserDetailsDto userDetails = userServiceInterface.findByEmailId(userEmailId);
        model.addAttribute("userDto",userDetails);
        model.addAttribute("userEmail",userEmailId);
        return "userPageProfile";
    }

    @RequestMapping("userBackPage")
    public String getUserBack(@RequestParam String userEmailId,Model model)
    {
        UserDetailsDto userDetails = userServiceInterface.findByEmailId(userEmailId);
        model.addAttribute("userDto",userDetails);
        List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

        model.addAttribute("dtos",bikeDtos);
        model.addAttribute("userEmail",userEmailId);
        List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
        model.addAttribute("sdtos",showroomsDtos);
        return "userHome";
    }

    @RequestMapping("updateUser")
    public String updateData(UserDetailsDto dto, @RequestParam("file") MultipartFile file,Model model)
    {
        userServiceInterface.updateUser(dto, file);
        model.addAttribute("userEmail",dto.getUserEmailId());
        UserDetailsDto userDetails = userServiceInterface.findByEmailId(dto.getUserEmailId());
        model.addAttribute("userDto",userDetails);
        List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

        model.addAttribute("dtos",bikeDtos);

        List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
        model.addAttribute("sdtos",showroomsDtos);
        return "userHome";
    }

    @GetMapping("userImage")
    public void getImage(@RequestParam String userImageFileName, HttpServletResponse httpServletResponse){


        File file=new File(UPLOADED_FOLDER+userImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){

        }
    }

    @RequestMapping("viewBikeUser")
    public String getBikeUser(@RequestParam Integer id,@RequestParam String userEmailId,@RequestParam String branchName,Model model)
    {
        List<ModelBranchDto> bikeIds = adminService.findBikeIds(id);
        log.info("bike ids============="+bikeIds);
        List<BikeDetailsDto> bikeDetails = new ArrayList<>();
        for (ModelBranchDto bike : bikeIds) {
            BikeDetailsDto bikeDetail = adminService.bikeFetchById(bike.getBikeId());
            if (bikeDetail != null) {
                bikeDetails.add(bikeDetail);
            }
        }
        log.info("bike Details=============="+bikeDetails);
        model.addAttribute("bikeDtos", bikeDetails);
        model.addAttribute("showRoomId",id);
        model.addAttribute("userEmail",userEmailId);
        model.addAttribute("branch",branchName);

        return "viewBikeForUser";
    }

    @RequestMapping("viewSingleBikeforUser")
    public String viewSingleBikesForUser(@RequestParam String userEmailId,@RequestParam String bikeName,@RequestParam String branchName,@RequestParam String id, Model model)
    {
        BikeDetailsDto dtoFindBikeName = adminService.findByBikeName(bikeName);

        model.addAttribute("dto",dtoFindBikeName);
        model.addAttribute("userEmail",userEmailId);
        model.addAttribute("showRoomId",id);
        model.addAttribute("branch",branchName);
        return "viewSinglebikeForUser";
    }

    @RequestMapping("bookTestRide")
    public String bookTestRide(@RequestParam String userEmailId, @RequestParam String bikeName, @RequestParam String branchName,
                               @RequestParam Integer id, @RequestParam String date, HttpSession session, Model model) throws MessagingException {
        FollowUpDetailsDto dto=new FollowUpDetailsDto();
        dto.setUserEmailId(userEmailId);
        dto.setComment("Please book a test ride for : "+bikeName);
        dto.setCreatedBy("user: "+userEmailId);
        dto.setDetails("Hii i need test ride from, BranchName:"+branchName+" in the Date:"+date);
        userServiceInterface.saveFollowUpDetails(dto);

        UserDetailsDto singleUserDto = userServiceInterface.findByEmailId(userEmailId);
        singleUserDto.setComments(dto.getComment());
        userServiceInterface.updateUserDetails(singleUserDto);

        List<Map<String, String>> notifications = (List<Map<String, String>>) session.getAttribute("testRideNotifications");
        if (notifications == null) {
            notifications = new ArrayList<>();
        }
        Map<String, String> noteMap = new HashMap<>();
        noteMap.put("email", userEmailId);
        noteMap.put("name", singleUserDto.getFirstName());
        notifications.add(noteMap);
        session.setAttribute("testRideNotifications", notifications);



        List<ModelBranchDto> bikeIds = adminService.findBikeIds(id);
        log.info("bike ids============="+bikeIds);
        List<BikeDetailsDto> bikeDetails = new ArrayList<>();
        for (ModelBranchDto bike : bikeIds) {
            BikeDetailsDto bikeDetail = adminService.bikeFetchById(bike.getBikeId());
            if (bikeDetail != null) {
                bikeDetails.add(bikeDetail);
            }
        }
        log.info("bike Details=============="+bikeDetails);
        model.addAttribute("bikeDtos", bikeDetails);

        String gmailMsg = emailSender.testRideEmail(userEmailId, bikeName, singleUserDto.getFirstName(), branchName, date);

        log.info("======================================================================"+gmailMsg);

        model.addAttribute("showRoomId",id);
        model.addAttribute("userEmail",userEmailId);
        model.addAttribute("branch",branchName);
        model.addAttribute("bookingMsg","your test ride booking for '"+bikeName+"' is completed");
        return "viewBikeForUser";
    }

    @ResponseBody
    @RequestMapping("ClearNotificationServlet")
    public void clearNotification(@RequestParam("index") int index, HttpSession session) {
        List<String> notifications = (List<String>) session.getAttribute("testRideNotifications");

        if (notifications != null && index >= 0 && index < notifications.size()) {
            notifications.remove(index);
            session.setAttribute("testRideNotifications", notifications);
        }
    }


    @RequestMapping("viewAllActiveShowRoomForUser")
    public String fetchBikesForUser(@RequestParam String userEmailId,Model model)
    {

        model.addAttribute("userEmail",userEmailId);
        List<ShowRoomDetailsDto> activeShowroomDetails = adminService.activeFetch();
        model.addAttribute("showRoomDetails",activeShowroomDetails);
        return "viewAllBikeForUser";
    }




}
