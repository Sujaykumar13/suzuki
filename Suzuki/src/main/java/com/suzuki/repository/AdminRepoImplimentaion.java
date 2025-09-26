package com.suzuki.repository;

import com.suzuki.entity.AdminLoggingEntity;
import com.suzuki.entity.BikeDetailEntity;
import com.suzuki.entity.ModelBranchEntity;
import com.suzuki.entity.ShowRoomDetailEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class AdminRepoImplimentaion implements AdminRepository{

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean saveOtp(AdminLoggingEntity entity) {

        log.info("entity in repo"+entity);
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs save otp");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }

    }

    @Override
    public AdminLoggingEntity findByEmail(String email) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByEmail");
            query.setParameter("email",email);
            AdminLoggingEntity result = (AdminLoggingEntity) query.getSingleResult();
            transaction.commit();
            System.out.println("result================"+result);
            return result;
        } catch (Exception e) {
            log.info("exception occur in find showroom by email");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public void saveLoginDetails(AdminLoggingEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();

        }
        catch (Exception e) {
            log.info("exception occurs in save admin login ");
            log.info(e.getMessage());
        }finally {
            entityManager.close();
        }

    }

    @Override
    public boolean saveShowRoomDetails(ShowRoomDetailEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save showroom");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public ShowRoomDetailEntity findByBranch(String branchName) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createNamedQuery("findByBranch");
            query.setParameter("branch",branchName);
            ShowRoomDetailEntity result = (ShowRoomDetailEntity) query.getSingleResult();

            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in find showroom by branch");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public ShowRoomDetailEntity findByNumber(Long contactNumber) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByMobileNumber");
            query.setParameter("number",contactNumber);
            ShowRoomDetailEntity result = (ShowRoomDetailEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in find showroom by mobile");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public List<ShowRoomDetailEntity> fetchShowrooms() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("fetch");
            List<ShowRoomDetailEntity> result = query.getResultList();

            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in fetch showroom");
            log.info(e.getMessage());
            return Collections.emptyList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateShowRoomData(ShowRoomDetailEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in update showroom");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean deleteShowRoom(String branch) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("delete");
            query.setParameter("bName",branch);
            int result = query.executeUpdate();
            transaction.commit();
            System.out.println(result);
            if(result==1)
            {
                return true;
            }
            else {
                return false;
            }


        } catch (Exception e) {
            log.info("exception occur in delete showroom");
            log.info(e.getMessage());
            return false;
        }
        finally {
            entityManager.close();
        }

    }

    @Override
    public Map<Object,Object> fetchNoOfShowroom() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("fetchByBranch");
            Object noOfShowrrom = query.getSingleResult();
            Query query1 = entityManager.createNamedQuery("active");
            Object activeShowroom = query1.getSingleResult();
            Query query2 = entityManager.createNamedQuery("inactive");
            Object inActiveShowroom = query2.getSingleResult();
            Query query3 = entityManager.createNamedQuery("maintence");
            Object maintenceShowroom = query3.getSingleResult();
            Query query4 = entityManager.createNamedQuery("noOfModels");
            Object models = query4.getSingleResult();

            Map noOfShowrooms=new LinkedHashMap();
            noOfShowrooms.put("totalShowrooms",noOfShowrrom);
            noOfShowrooms.put("activeShowrroms",activeShowroom);
            noOfShowrooms.put("inactiveShowrroms",inActiveShowroom);
            noOfShowrooms.put("undermaintenceshowrroms",maintenceShowroom);
            noOfShowrooms.put("noOfModels",models);


            transaction.commit();
            return noOfShowrooms;

        } catch (Exception e) {
            log.info("exception occur in find number of showroom");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveBike(BikeDetailEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save bike");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public BikeDetailEntity findByBikeName(String bikename) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findBybikeName");
            query.setParameter("name",bikename);
            BikeDetailEntity result = (BikeDetailEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur find bike by bike  name");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public BikeDetailEntity findByBikeModel(String bikemodel) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByModel");
            query.setParameter("model",bikemodel);
            BikeDetailEntity result = (BikeDetailEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in find bike by model");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public List<BikeDetailEntity> fetchBikes() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("fetchBike");
            List<BikeDetailEntity> result = query.getResultList();

            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in fetch bike");
            log.info(e.getMessage());
            return Collections.emptyList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean deleteBike(String bikename) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("deleteBike");
            query.setParameter("bName",bikename);
            int result = query.executeUpdate();
            transaction.commit();
            System.out.println(result);
            if(result==1)
            {
                return true;
            }
            else {
                return false;
            }


        } catch (Exception e) {
            log.info("exception occur in delete bike");
            log.info(e.getMessage());
            return false;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateBike(BikeDetailEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.merge(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in update bike");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean modelBranch(ModelBranchEntity entity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            entityManager.persist(entity);
            transaction.commit();
            return true;
        }
        catch (Exception e) {
            log.info("exception occurs in save model to branch");
            log.info(e.getMessage());
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public ModelBranchEntity findByBranchModelId(Integer showid,Integer biId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findByBranchId");
            query.setParameter("bId",showid);
            query.setParameter("bike",biId);
            ModelBranchEntity result = (ModelBranchEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur find model to branch");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public List<ShowRoomDetailEntity> activeFetch() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("activeFetch");
            List<ShowRoomDetailEntity> result = query.getResultList();
            System.out.println("list of entity in repo============="+result);
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in active showroom fetch");
            log.info(e.getMessage());
            return Collections.emptyList();
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public BikeDetailEntity bikeFetchById(Integer id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findById");
            query.setParameter("bId",id);
            BikeDetailEntity result = (BikeDetailEntity) query.getSingleResult();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in bike fetch by id");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public List<ModelBranchEntity> findBikeIds(Integer id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("findBikeIdByBranchId");
            query.setParameter("bId",id);
           List<ModelBranchEntity> result = query.getResultList();
            transaction.commit();
            return result;

        } catch (Exception e) {
            log.info("exception occur in find bike ids");
            log.info(e.getMessage());
            return null;
        }
        finally {
            entityManager.close();
        }
    }

    @Override
    public boolean deleteBikeModel(Integer id, Integer bikeId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();
            Query query = entityManager.createNamedQuery("deleteBikeModel");
            query.setParameter("bId",id);
            query.setParameter("bike",bikeId);
            int result = query.executeUpdate();
            transaction.commit();
            System.out.println(result);
            if(result==1)
            {
                return true;
            }
            else {
                return false;
            }


        } catch (Exception e) {
            log.info("exception occur in delete bike");
            log.info(e.getMessage());
            return false;
        }
        finally {
            entityManager.close();
        }
    }
}
