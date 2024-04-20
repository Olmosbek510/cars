package uz.inha.cars.repo;

import uz.inha.cars.entity.Car;

import java.util.List;

import static uz.inha.cars.config.DB.entityManager;

public class CarRepo {

    public static List<Car> findAll() {
        entityManager.getTransaction().begin();
        List<Car> fromCar = entityManager.createQuery("from Car order by name", Car.class).getResultList();
        entityManager.getTransaction().commit();
        return fromCar;
    }
}
