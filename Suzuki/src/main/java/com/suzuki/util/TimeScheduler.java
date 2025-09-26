package com.suzuki.util;

import com.suzuki.entity.AdminLoggingEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TimeScheduler {

    @Scheduled(cron = "* 2 * * * *" )
    public void Schedule()
    {
        AdminLoggingEntity adminLoggingEntity=new AdminLoggingEntity();
        adminLoggingEntity.setOtp("000000");
    }
}

//admin profile
//time schedule
