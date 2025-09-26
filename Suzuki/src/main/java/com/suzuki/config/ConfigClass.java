package com.suzuki.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ComponentScan("com.suzuki")
@EnableWebMvc
public class ConfigClass {
    @Bean
    public ViewResolver viewResolver()
    {
        InternalResourceViewResolver internalResourceViewResolver=new InternalResourceViewResolver();
        internalResourceViewResolver.setPrefix("/");
        internalResourceViewResolver.setSuffix(".jsp");
        return internalResourceViewResolver;
    }

//    @Bean
//
//    public LocalContainerEntityManagerFactoryBean localContainerEntityManagerFactoryBean()
//    {
//        LocalContainerEntityManagerFactoryBean localContainerEntityManagerFactoryBean=new LocalContainerEntityManagerFactoryBean();
//        return localContainerEntityManagerFactoryBean;
//    }

    @Bean
    public LocalContainerEntityManagerFactoryBean getLocalContainerEntityManagerFactoryBean(){
        LocalContainerEntityManagerFactoryBean bean=new LocalContainerEntityManagerFactoryBean();
        bean.setPackagesToScan("com.suzuki.entity");
        bean.setDataSource(getDataSource());
        bean.setJpaProperties(jpaProperties());
        bean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        return bean;
    }

    private Properties jpaProperties()
    {
        Properties pro=new Properties();
        pro.setProperty("hibernate.show_sql","false");
        pro.setProperty("hibernate.hbm2ddl.auto","update");
        return pro;
    }
    @Bean
    public DataSource getDataSource(){
        DriverManagerDataSource dm=new DriverManagerDataSource();
        dm.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dm.setUrl("jdbc:mysql://localhost:3306/suzuki");
        dm.setUsername("root");
        dm.setPassword("root");
        return dm;
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncodeEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }
}
