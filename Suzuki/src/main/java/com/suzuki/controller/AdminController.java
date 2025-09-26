package com.suzuki.controller;

import com.suzuki.dto.BikeDetailsDto;
import com.suzuki.dto.ModelBranchDto;
import com.suzuki.dto.ShowRoomDetailsDto;
import com.suzuki.dto.ShowroomWithBikesDto;
import com.suzuki.service.AdminService;
import com.suzuki.util.EmailSender;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.config.ScheduledTask;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
@Slf4j
public class AdminController {

    private static String UPLOADED_FOLDER = "C://Photos//";

    @Autowired
    EmailSender emailSender;

    @Autowired
    AdminService adminService;

    @RequestMapping("admin")
    public String getAdminLoginPage()
    {
        return "adminLogin";
    }

    @RequestMapping("home")
    public String getHomePage()
    {

        return "index";
    }

    @RequestMapping("sendOtp")
    public String getLoginOtp(@RequestParam String emailId, Model model)
    {

        String otp = emailSender.sendSimpleMessage(emailId);
        System.out.println("otp in otpsender======"+otp);
        boolean result = adminService.saveOtp(emailId, otp);
        if(result)
        {
            model.addAttribute("otpmsg","otp sent successfully and it is valid for 2 minutes");
            model.addAttribute("email",emailId);
        }
        else
        {
            model.addAttribute("otpmsg","otp is not send");
            model.addAttribute("email",emailId);
        }

        return "adminLogin";
    }

    @PostMapping("verificationOTP")
    public String verifyOtp(@RequestParam String emailId,@RequestParam String otp,Model model)
    {

        boolean result = adminService.verifyOtp(emailId, otp);
        if(result)
        {
            model.addAttribute("verifymsg","otp verified");
            Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

            Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

            model.addAttribute("branch",valuesOfShowRooms[0]);
            model.addAttribute("active",valuesOfShowRooms[1]);
            model.addAttribute("inactive",valuesOfShowRooms[2]);
            model.addAttribute("maintain",valuesOfShowRooms[3]);
            model.addAttribute("models",valuesOfShowRooms[4]);

            model.addAttribute("email",emailId);

            List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
            model.addAttribute("sdtos",showroomsDtos);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
            model.addAttribute("bdtos",bikeDtos);


            List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
            List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

            for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
                List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

                List<String> bikeNames = new ArrayList<>();
                for (ModelBranchDto bike : bikeIds) {
                    BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                    if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                        bikeNames.add(bikeDetails.getBikeName());
                    }
                }

                ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
                showroomWithBikesList.add(dto);
            }

            model.addAttribute("showroomWithBikes", showroomWithBikesList);

            return "home";
        }
        else {
            model.addAttribute("verifymsg","otp not verified");
            model.addAttribute("email",emailId);
            return "adminLogin";
        }

    }

    @RequestMapping("logout")
    public String logout(@RequestParam String emailId,Model model)
    {
        adminService.logout(emailId);
        return "index";
    }

    @RequestMapping("addShowroom")
    public String addShowRoomPage(@RequestParam String emailId, Model model)
    {
       model.addAttribute("email",emailId);
        return "addShowroom";
    }

    @RequestMapping("showRoomData")
    public String addShowroom(@Valid ShowRoomDetailsDto dto, @RequestParam("file") MultipartFile file,@RequestParam String emailId, Model model, BindingResult bindingResult)
    {


        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult.hasErrors());
            List<ObjectError> errorList = bindingResult.getAllErrors();
            String error = errorList.get(1).getDefaultMessage();
            System.out.println(error);
            model.addAttribute("error", "enter valid data");
            return "addShowroom";
        }

        boolean result = adminService.saveShowRoomDetails(dto,file);
        if (result) {
            model.addAttribute("msg", "showroom details added successfully");
            model.addAttribute("email",emailId);
            return "addShowroom";
        } else {
            model.addAttribute("error", "enter valid data");
            model.addAttribute("email",emailId);
            return "addShowroom";
        }
    }

    @RequestMapping("branchName")
    @ResponseBody
    public ResponseEntity<String> branchExists(@RequestParam String branchName) {
        ShowRoomDetailsDto branchExist = adminService.findByBranch(branchName);
        if (branchExist != null) {
            return ResponseEntity.ok("branch is exist");
        }
        return ResponseEntity.ok("branch name accepted");
    }

    @RequestMapping("contactNumberExist")
    @ResponseBody//we can use restcotroller in controller instead of response body
    public ResponseEntity<String> phoneNumberExists(@RequestParam Long contactNumber) {
        ShowRoomDetailsDto contactNumberExists = adminService.findByContactNumber(contactNumber);
        if (contactNumberExists != null) {
            return ResponseEntity.ok("number is exist");
        }
        return ResponseEntity.ok("contact number accepted");

    }

    @RequestMapping("viewShowroom")
    public String viewShowroom(@RequestParam String emailId, Model model)
    {
        List<ShowRoomDetailsDto> showroomDtos = adminService.fetchShowrooms();

        model.addAttribute("dtos",showroomDtos);

        model.addAttribute("email",emailId);
        return "viewShowroom";
    }

    @GetMapping("image")
    public void getImage(@RequestParam String showRoomImageFileName, HttpServletResponse httpServletResponse){

        File file=new File(UPLOADED_FOLDER+showRoomImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){

        }
    }

    @RequestMapping("edit")
    public String editShowRoomPage(@RequestParam String branchName,@RequestParam String emailId, Model model)
    {
        ShowRoomDetailsDto branchDto = adminService.findByBranch(branchName);
        model.addAttribute("dto",branchDto);

        model.addAttribute("email",emailId);
        return "editShowRoom";
    }

    @RequestMapping("updateShowRoomData")
    public String updateShowRoom(ShowRoomDetailsDto dto, @RequestParam("file") MultipartFile file ,@RequestParam String emailId, Model model)
    {

        boolean result = adminService.updateShowRoomData(dto,file);
        if (result) {

            model.addAttribute("email",emailId);
            List<ShowRoomDetailsDto> showroomDtos = adminService.fetchShowrooms();
            System.out.println("dtos in controller======"+showroomDtos);
            model.addAttribute("dtos",showroomDtos);
            return "viewShowroom";
        } else {

            model.addAttribute("email",emailId);
            List<ShowRoomDetailsDto> showroomDtos = adminService.fetchShowrooms();
            System.out.println("dtos in controller======"+showroomDtos);
            model.addAttribute("dtos",showroomDtos);
            return "viewShowroom";
        }
    }

    @RequestMapping("delete")
    public String deleteShowRoom(@RequestParam String branchName,@RequestParam String emailId, Model model)
    {

        boolean result = adminService.deleteShowRoom(branchName);
        if (result) {

            List<ShowRoomDetailsDto> showroomDtos = adminService.fetchShowrooms();

            model.addAttribute("dtos",showroomDtos);
            Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

            Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();
            System.out.println("number of showrooms values in controller==========="+valuesOfShowRooms);
            model.addAttribute("branch",valuesOfShowRooms[0]);
            model.addAttribute("active",valuesOfShowRooms[1]);
            model.addAttribute("inactive",valuesOfShowRooms[2]);
            model.addAttribute("maintain",valuesOfShowRooms[3]);
            model.addAttribute("models",valuesOfShowRooms[4]);
            model.addAttribute("email",emailId);
            return "viewShowroom";
        } else {

            model.addAttribute("email",emailId);
            List<ShowRoomDetailsDto> showroomDtos = adminService.fetchShowrooms();
            System.out.println("dtos in controller======"+showroomDtos);
            model.addAttribute("dtos",showroomDtos);
            return "viewShowroom";
        }
    }

    @RequestMapping("back")
    public String backPage(@RequestParam String emailId,Model model)
    {
        model.addAttribute("email",emailId);
        Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

        Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

        model.addAttribute("branch",valuesOfShowRooms[0]);
        model.addAttribute("active",valuesOfShowRooms[1]);
        model.addAttribute("inactive",valuesOfShowRooms[2]);
        model.addAttribute("maintain",valuesOfShowRooms[3]);
        model.addAttribute("models",valuesOfShowRooms[4]);

        List<ShowRoomDetailsDto> showroomsDtos=adminService.activeFetch();
        model.addAttribute("sdtos",showroomsDtos);
        List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
        model.addAttribute("bdtos",bikeDtos);

        List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
        List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

        for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
            List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

            List<String> bikeNames = new ArrayList<>();
            for (ModelBranchDto bike : bikeIds) {
                BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                    bikeNames.add(bikeDetails.getBikeName());
                }
            }

            ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
            showroomWithBikesList.add(dto);
        }

        model.addAttribute("showroomWithBikes", showroomWithBikesList);

       return "home";
    }

    @RequestMapping("addBike")
    public String addBikePage(@RequestParam String emailId,Model model)
    {
        model.addAttribute("email",emailId);
        return "addBike";
    }

    @RequestMapping("addBikeData")
    public String addBike(@Valid BikeDetailsDto dto,BindingResult bindingResult,Model model,
                          @RequestParam("front") MultipartFile front,@RequestParam("left") MultipartFile left,
                          @RequestParam("back") MultipartFile back,@RequestParam("right") MultipartFile right,
                          @RequestParam("top") MultipartFile top,@RequestParam("d3") MultipartFile d3,
                          @RequestParam String emailId)
    {
        System.out.println("dto in cotroller" + dto);

        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult.hasErrors());
            List<ObjectError> errorList = bindingResult.getAllErrors();
            String error = errorList.get(1).getDefaultMessage();
            log.info(error);
            model.addAttribute("error", "enter valid data");
            return "addBike";
        }
        boolean result = adminService.saveBike(dto, front, left, back, right, top, d3);
        if (result) {
            model.addAttribute("msg", "bike details added successfully");
            model.addAttribute("email",emailId);
            return "addBike";
        } else {
            model.addAttribute("error", "enter valid data");
            model.addAttribute("email",emailId);
            return "addBike";
        }
    }

    @RequestMapping("bikeNameExists")
    @ResponseBody
    public ResponseEntity<String> bikeNameExist(@RequestParam String bikeName) {
        BikeDetailsDto bikeExist = adminService.findByBikeName(bikeName);
        if (bikeExist != null) {
            return ResponseEntity.ok("bike name is exist");
        }
        return ResponseEntity.ok("bike name accepted");
    }

    @RequestMapping("modelExist")
    @ResponseBody//we can use restcotroller in controller instead of response body
    public ResponseEntity<String> modelExists(@RequestParam String bikeModel) {
        BikeDetailsDto modelExists = adminService.findByBikeModel(bikeModel);
        if (modelExists != null) {
            return ResponseEntity.ok("model is exist");
        }
        return ResponseEntity.ok("model is accepted");

    }

    @RequestMapping("viewBike")
    public String fetchBikes(@RequestParam String emailId,Model model)
    {
        List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

        model.addAttribute("dtos",bikeDtos);
        model.addAttribute("email",emailId);
        return "viewBike";
    }

    @RequestMapping("deleteBike")
    public String deleteBike(@RequestParam String bikeName,@RequestParam String emailId,Model model)
    {


        boolean result = adminService.deleteBike(bikeName);
        if (result) {

            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

            model.addAttribute("dtos",bikeDtos);
            Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

            Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();
            System.out.println("number of showrooms values in controller==========="+valuesOfShowRooms);
            model.addAttribute("branch",valuesOfShowRooms[0]);
            model.addAttribute("active",valuesOfShowRooms[1]);
            model.addAttribute("inactive",valuesOfShowRooms[2]);
            model.addAttribute("maintain",valuesOfShowRooms[3]);
            model.addAttribute("models",valuesOfShowRooms[4]);
            model.addAttribute("email",emailId);
            return "viewBike";
        } else {

            model.addAttribute("email",emailId);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();


            model.addAttribute("dtos",bikeDtos);
            return "viewBike";
        }
    }

    @RequestMapping("viewSingleBike")
    public String viewSingleBikes(@RequestParam String emailId,@RequestParam String bikeName, Model model)
    {
        BikeDetailsDto dtoFindBikeName = adminService.findByBikeName(bikeName);

        model.addAttribute("dto",dtoFindBikeName);
        model.addAttribute("email",emailId);
        return "viewSingleBike";
    }

    @GetMapping("bikeImage")
    public void getBikeImage(@RequestParam(required = false) String frontImageFileName,@RequestParam(required = false) String leftImageFileName,@RequestParam(required = false) String backImageFileName,
                             @RequestParam(required = false) String rightImageFileName,@RequestParam(required = false) String topImageFileName,@RequestParam(required = false) String d3ImageFileName, HttpServletResponse httpServletResponse)
    {

        File file1=new File(UPLOADED_FOLDER+frontImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file1);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }

        File file2=new File(UPLOADED_FOLDER+leftImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file2);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }

        File file3=new File(UPLOADED_FOLDER+backImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file3);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }

        File file4=new File(UPLOADED_FOLDER+rightImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file4);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }

        File file5=new File(UPLOADED_FOLDER+topImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file5);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }

        File file6=new File(UPLOADED_FOLDER+d3ImageFileName);
        try {
            FileInputStream fileInputStream = new FileInputStream(file6);
            InputStream inputStream=new BufferedInputStream(fileInputStream);
            ServletOutputStream servletInputStream = httpServletResponse.getOutputStream();
            IOUtils.copy(inputStream,servletInputStream);
            httpServletResponse.flushBuffer();
        }catch (IOException e){
        }
    }

    @RequestMapping("editBike")
    public String getEditBikePage(@RequestParam String emailId,@RequestParam String bikeName, Model model)
    {
        BikeDetailsDto dtoFindByName = adminService.findByBikeName(bikeName);
        model.addAttribute("dto",dtoFindByName);
        model.addAttribute("email",emailId);
        return "editBike";
    }

    @PostMapping("updateBikeData")
    public String updateBike(BikeDetailsDto dto,@RequestParam(required = false) MultipartFile front,@RequestParam(required = false) MultipartFile left,
                          @RequestParam(required = false) MultipartFile back,@RequestParam(required = false) MultipartFile right,
                          @RequestParam(required = false) MultipartFile top,@RequestParam(required = false) MultipartFile d3
                         ,@RequestParam String emailId,Model model)
    {


        boolean result = adminService.updateBike(dto, front, left, back, right, top, d3);
        if (result) {

            model.addAttribute("email",emailId);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

            model.addAttribute("dtos",bikeDtos);
            return "viewBike";
        } else {

            model.addAttribute("email",emailId);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();

            model.addAttribute("dtos",bikeDtos);
            return "viewBike";
        }
    }

    @RequestMapping("popup")
    public String addModeltobranch(ModelBranchDto dtoo,Model model)
    {


        boolean result = adminService.modelBranch(dtoo);

        if(result) {
            model.addAttribute("email", dtoo.getEmailId());
            model.addAttribute("msg","bike added to showroom");
            Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

            Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

            model.addAttribute("branch", valuesOfShowRooms[0]);
            model.addAttribute("active", valuesOfShowRooms[1]);
            model.addAttribute("inactive", valuesOfShowRooms[2]);
            model.addAttribute("maintain", valuesOfShowRooms[3]);
            model.addAttribute("models", valuesOfShowRooms[4]);

            List<ShowRoomDetailsDto> showroomsDtos = adminService.activeFetch();
            model.addAttribute("sdtos", showroomsDtos);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
            model.addAttribute("bdtos", bikeDtos);

            List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
            List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

            for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
                List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

                List<String> bikeNames = new ArrayList<>();
                for (ModelBranchDto bike : bikeIds) {
                    BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                    if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                        bikeNames.add(bikeDetails.getBikeName());
                    }
                }

                ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
                showroomWithBikesList.add(dto);
            }

            model.addAttribute("showroomWithBikes", showroomWithBikesList);

            return "home";
        }
        else {
            model.addAttribute("email", dtoo.getEmailId());
            model.addAttribute("msg","bike is not added to showroom");
            Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

            Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

            model.addAttribute("branch", valuesOfShowRooms[0]);
            model.addAttribute("active", valuesOfShowRooms[1]);
            model.addAttribute("inactive", valuesOfShowRooms[2]);
            model.addAttribute("maintain", valuesOfShowRooms[3]);
            model.addAttribute("models", valuesOfShowRooms[4]);

            List<ShowRoomDetailsDto> showroomsDtos = adminService.activeFetch();
            model.addAttribute("sdtos", showroomsDtos);
            List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
            model.addAttribute("bdtos", bikeDtos);

            List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
            List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

            for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
                List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

                List<String> bikeNames = new ArrayList<>();
                for (ModelBranchDto bike : bikeIds) {
                    BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                    if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                        bikeNames.add(bikeDetails.getBikeName());
                    }
                }

                ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
                showroomWithBikesList.add(dto);
            }

            model.addAttribute("showroomWithBikes", showroomWithBikesList);

            return "home";

        }
    }

    @RequestMapping("modelIdExist")
    @ResponseBody
    public ResponseEntity<String> modelIdExists(@RequestParam String branchName,@RequestParam String bikeName) {
        ShowRoomDetailsDto branchDto =adminService.findByBranch(branchName);
        BikeDetailsDto bikeDto = adminService.findByBikeName(bikeName);

        ModelBranchDto branchIdDto =adminService.findByBranchModelId(branchDto.getId(),bikeDto.getId());

        if (branchIdDto != null) {
            return ResponseEntity.ok("model is exist");
        }
        return ResponseEntity.ok("model is accepted");
    }

    @RequestMapping("deleteBikeModel")
    public String deleteModel(@RequestParam String bikeName,@RequestParam Integer id,@RequestParam String emailId,Model model)
    {
        log.info("==================="+id+bikeName);
        BikeDetailsDto bikeDetail = adminService.findByBikeName(bikeName);
        Integer bikeId = bikeDetail.getId();
       boolean result=adminService.deleteBikeModel(id,bikeId);
       if(result) {
           model.addAttribute("email", emailId);
           model.addAttribute("msg","bike added to showroom");
           Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

           Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

           model.addAttribute("branch", valuesOfShowRooms[0]);
           model.addAttribute("active", valuesOfShowRooms[1]);
           model.addAttribute("inactive", valuesOfShowRooms[2]);
           model.addAttribute("maintain", valuesOfShowRooms[3]);
           model.addAttribute("models", valuesOfShowRooms[4]);

           List<ShowRoomDetailsDto> showroomsDtos = adminService.activeFetch();
           model.addAttribute("sdtos", showroomsDtos);
           List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
           model.addAttribute("bdtos", bikeDtos);

           List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
           List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

           for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
               List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

               List<String> bikeNames = new ArrayList<>();
               for (ModelBranchDto bike : bikeIds) {
                   BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                   if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                       bikeNames.add(bikeDetails.getBikeName());
                   }
               }

               ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
               showroomWithBikesList.add(dto);
           }

           model.addAttribute("showroomWithBikes", showroomWithBikesList);
           return "home";
       }
       else {
           model.addAttribute("email", emailId);
           model.addAttribute("msg","bike added to showroom");
           Map<Object, Object> noOfShowRooms = adminService.noOfBranches();

           Object[] valuesOfShowRooms = noOfShowRooms.values().toArray();

           model.addAttribute("branch", valuesOfShowRooms[0]);
           model.addAttribute("active", valuesOfShowRooms[1]);
           model.addAttribute("inactive", valuesOfShowRooms[2]);
           model.addAttribute("maintain", valuesOfShowRooms[3]);
           model.addAttribute("models", valuesOfShowRooms[4]);

           List<ShowRoomDetailsDto> showroomsDtos = adminService.activeFetch();
           model.addAttribute("sdtos", showroomsDtos);
           List<BikeDetailsDto> bikeDtos = adminService.fetchBikes();
           model.addAttribute("bdtos", bikeDtos);

           List<ShowRoomDetailsDto> listOfActiveShowroom = adminService.activeFetch();
           List<ShowroomWithBikesDto> showroomWithBikesList = new ArrayList<>();

           for (ShowRoomDetailsDto showroom : listOfActiveShowroom) {
               List<ModelBranchDto> bikeIds = adminService.findBikeIds(showroom.getId());

               List<String> bikeNames = new ArrayList<>();
               for (ModelBranchDto bike : bikeIds) {
                   BikeDetailsDto bikeDetails = adminService.bikeFetchById(bike.getBikeId());
                   if (bikeDetails != null && bikeDetails.getBikeName() != null) {
                       bikeNames.add(bikeDetails.getBikeName());
                   }
               }

               ShowroomWithBikesDto dto = new ShowroomWithBikesDto(showroom, bikeNames);
               showroomWithBikesList.add(dto);
           }

           model.addAttribute("showroomWithBikes", showroomWithBikesList);
           return "home";
       }
    }

}
