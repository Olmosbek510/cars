package uz.inha.cars.repo;

import uz.inha.cars.entity.Company;

import java.util.List;

import static uz.inha.cars.config.DB.entityManager;

public class CompanyRepo {

    public static List<Company> findAll() {
        entityManager.getTransaction().begin();
        List<Company> selectCFromCompanyC = entityManager.createQuery("select c from Company c", Company.class).getResultList();
        entityManager.getTransaction().commit();
        return selectCFromCompanyC;
    }
}
