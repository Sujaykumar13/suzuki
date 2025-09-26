package com.suzuki.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Random;

@Component
public class EmailSender {
    @Autowired
    JavaMailSender emailSender;


    public String otpGenerator(){
        Random random=new Random();
        int i = random.nextInt(999999);
        return String.format("%6d",i );
    }

    public String sendSimpleMessage(String email) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("sujaykumar1302@gmail.com");
        message.setTo(email);
        message.setSubject("otp generation");
        String otp = otpGenerator();
        message.setText("Your otp is"+otp);
        emailSender.send(message);
        return otp;
    }



    public String testRideEmail(
            String email,
            String bikeName,
            String userName,
            String showroom,
            String date) throws MessagingException {

        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("sujaykumar1302@gmail.com");
        helper.setTo(email);
        helper.setSubject("Your test ride booking is confirmed! 🚴");

        String content = "<html><body>" +
                "<h2>Hi " +userName + ",</h2>" +
                "<p>Great news! Your test ride booking is confirmed.</p>" +
                "<table cellpadding='5' style='border-collapse: collapse; border: 1px solid #ddd;'>"
                + "<tr style='background: #f0f0f0;'><th align='left'>Bike</th><td>" +bikeName+ "</td></tr>"
                + "<tr><th align='left'>Showroom</th><td>" + showroom +"</td></tr>"
                + "<tr style='background: #f9f9f9;'><th align='left'>Date </th><td>" + date+ "</td></tr>"
                + "</table>"
                + "<p>Please arrive 10 minutes early and bring a valid ID.</p>"
                + "<p>Thank you for choosing us!<br/>The Test Ride Team</p>"
                + "</body></html>";

        helper.setText(content, true);

        //emailSender.send(message);
        try {
            emailSender.send(message);
        } catch ( MailException ex) {
            ex.printStackTrace();
            throw ex;
        }


        return "email sent successfully";

    }


}
