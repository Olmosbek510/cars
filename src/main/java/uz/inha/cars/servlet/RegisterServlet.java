package uz.inha.cars.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import uz.inha.cars.entity.Role;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;
import uz.inha.cars.repo.RoleRepo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "userRegister", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        entityManager.getTransaction().begin();
        List<Role> roles = new ArrayList<>();
        List<Role> allRoles = RoleRepo.findAll();
        if (req.getParameter("roles[]") != null) {
            roles = RoleRepo.getRolesById(req.getParameter("roles[]"));
        }else{
            roles = allRoles.stream().filter(role -> role.getRoleName().equals(RoleName.ROLE_USER)).toList();
        }
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String rep_password = req.getParameter("repeat-password");
        HttpSession session = req.getSession();
        if (!password.equals(rep_password)) {
            resp.sendRedirect("/registration.jsp");
        }
        User user = User.builder()
                .firstName(firstname)
                .lastName(lastname)
                .phone(phone)
                .password(password)
                .roles(roles)
                .build();
        try (ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
        ) {
            Validator validator = validatorFactory.getValidator();
            Set<ConstraintViolation<User>> validate = validator.validate(user);
            if (validate.isEmpty()) {
                entityManager.persist(user);
            } else {
                req.setAttribute("violations", validate);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("/register");
                requestDispatcher.forward(req, resp);
            }
        }
        entityManager.getTransaction().commit();
        resp.sendRedirect("index.jsp");
    }
}
