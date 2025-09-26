package com.suzuki.repository;

import com.suzuki.dto.UserLoginCredintialsDto;
import com.suzuki.entity.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import java.util.Collections;
import java.util.List;

@Repository
@Slf4j
public class UserRepositoryImplimentation implements UserRepositoryInterface{

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean saveUserDetails(UserEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save user details");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public UserEntity findByEmailId(String email) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByUserEmail");
            query.setParameter("email",email);
            UserEntity result = (UserEntity) query.getSingleResult();
            transaction.commit();

            return result;
        } catch (Exception e) {
            log.info("exception occur in find user by email");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public UserEntity findByContactNumber(Long number) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByUserMobileNumber");
            query.setParameter("contactNumber",number);
            UserEntity result = (UserEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur find user by number");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateUserDetails(UserEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            System.out.println("repoo==========================================="+entity);
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in update user");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public List<UserEntity> fetchUserDetails() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("fetchAllUsers");
            List<UserEntity> result = query.getResultList();

            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur fetch user");
            log.info(e.getMessage());
            return Collections.emptyList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveFollowUpDetails(FollowUpDetailsEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs save follow up details");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public List<FollowUpDetailsEntity> fetchFollowUpDetails(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("fetchFollowDetails");
            query.setParameter("email",email);
            List<FollowUpDetailsEntity> result = query.getResultList();

            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in fetch follow up details");
            log.info(e.getMessage());
            return Collections.emptyList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public UserLoginCredinetialsEntity findUserLoginDetailsByEmail(String email) {
        System.out.println(email);
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findLogiingDetailsByEmail");
            query.setParameter("email",email);
            UserLoginCredinetialsEntity result = (UserLoginCredinetialsEntity) query.getSingleResult();
            transaction.commit();

            return result;
        } catch (Exception e) {
            log.info("exception occur in find user login details");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveLoginCredintials(UserLoginCredinetialsEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save user login credinetials");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveLoginDetails(UserLoggingEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save login details");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateLoginCredintials(UserLoginCredinetialsEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in update login credientials");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public UserLoggingEntity findLoggingDetails(String email) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findLoginDetails");
            query.setParameter("email",email);
            UserLoggingEntity result = (UserLoggingEntity) query.getSingleResult();
            transaction.commit();

            return result;
        } catch (Exception e) {
            log.info("exception occur in find logging details");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }


}
