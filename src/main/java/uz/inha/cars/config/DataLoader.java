package uz.inha.cars.config;

import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import uz.inha.cars.entity.Company;
import uz.inha.cars.entity.Role;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;
import uz.inha.cars.repo.UserRepo;

import java.util.ArrayList;
import java.util.List;

import static uz.inha.cars.config.DB.entityManager;

@WebListener
public class DataLoader implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DB.entityManagerFactory = Persistence.createEntityManagerFactory("CARS");
        entityManager = DB.entityManagerFactory.createEntityManager();
        initData();
        ServletContextListener.super.contextInitialized(sce);
    }

    private void initData() {
        entityManager.getTransaction().begin();
        List<Role> roles = new ArrayList<>();
        if (entityManager.createQuery("from Role", Role.class).getResultList().isEmpty()) {
            for (RoleName value : RoleName.values()) {
                Role role = Role
                        .builder()
                        .roleName(value)
                        .build();
                entityManager.persist(role);
                roles.add(role);
            }
        } else {
            roles = entityManager.createQuery("from Role", Role.class).getResultList();
            for (Role role : roles) {
                System.out.println(role.getRoleName());
            }
        }
        if (!UserRepo.hasSuperAdmin()) {
            User user = User.builder()
                    .phone("+998933460021")
                    .firstName("Olmosbek")
                    .lastName("Urazboev")
                    .password("olmos555%")
                    .roles(roles)
                    .build();
            entityManager.persist(user);
        }
        entityManager.getTransaction().commit();
    }
}
