package uz.inha.cars.repo;

import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import uz.inha.cars.entity.User;

import java.util.List;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

public class UserRepo {
    public static User findByPhoneAndPassword(String phone, String password) {
        TypedQuery<User> query = entityManager.createQuery("select u from User u where u.phone=:phone", User.class)
                .setParameter("phone", phone);
        if (query.getResultList().isEmpty()) {
            return null;
        }
        User user = query.getSingleResult();
        if(user!=null){
            if(user.getPassword().equals(password)){
                return user;
            }
        }
        return null;
    }

    public static boolean hasSuperAdmin() {
        Query query = entityManager.createNativeQuery("select count(*) from users_roles ur join roles r on r.id = ur.roles_id and r.rolename = 'ROLE_SUPER_ADMIN'", Integer.class);
        Integer singleResult = (Integer)query.getSingleResult();
        return singleResult > 0;
    }

    public static User findById(UUID id) {
        entityManager.getTransaction().begin();
        User user = entityManager.find(User.class, id);
        entityManager.getTransaction().commit();
        return user;
    }

    public static List<User> findAll() {
        return entityManager.createQuery("from User ", User.class).getResultList();
    }
}
