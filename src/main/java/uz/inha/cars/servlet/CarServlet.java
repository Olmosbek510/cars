package uz.inha.cars.servlet;

import jakarta.persistence.RollbackException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.*;
import uz.inha.cars.entity.Attachment;
import uz.inha.cars.entity.Car;
import uz.inha.cars.entity.Company;

import java.io.IOException;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "car", value = "/admin/car/add")
public class CarServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            entityManager.getTransaction().begin();
            UUID attachmentId = (UUID)req.getSession().getAttribute("currentFile");
            System.out.println(attachmentId);
            String name = req.getParameter("name");
            int companyId = Integer.parseInt(req.getParameter("companyId"));
            Company company = entityManager.find(Company.class, companyId);
            Attachment attachment = entityManager.find(Attachment.class, attachmentId);
            Car car = Car.builder()
                    .company(company)
                    .name(name)
                    .photo(attachment)
                    .build();
            ValidatorFactory validatorFactory= Validation.buildDefaultValidatorFactory();
            Validator validator = validatorFactory.getValidator();
            Set<ConstraintViolation<Car>> validate = validator.validate(car);
            if(validate.isEmpty()){
                entityManager.persist(car);
            }else{
                for (ConstraintViolation<Car> constraintViolation : validate) {
                    System.out.println(constraintViolation.getMessage());
                }
            }
            req.getSession().removeAttribute("currentFile");
            entityManager.getTransaction().commit();
            resp.sendRedirect("/admin/car.jsp");
    }
}
