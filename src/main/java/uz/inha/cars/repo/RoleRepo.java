package uz.inha.cars.repo;

import uz.inha.cars.entity.Role;

import javax.print.DocFlavor;
import java.util.ArrayList;
import java.util.List;

import static uz.inha.cars.config.DB.entityManager;

public class RoleRepo {

    public static List<Role> findAll() {
//        entityManager.getTransaction().begin();
        List<Role> fromRole = entityManager.createQuery("from Role ", Role.class).getResultList();
//        entityManager.getTransaction().commit();
        return fromRole;
    }

    public static List<Role> getRolesById(String parameter) {
        List<Role> roles = new ArrayList<>();
        for (int i = 0; i < parameter.length(); i++) {
            if (Character.isDigit(parameter.charAt(i))) {
                roles.add(entityManager.find(Role.class, Integer.parseInt(String.valueOf(parameter.charAt(i)))));
            }
        }
        return roles;
    }
}
