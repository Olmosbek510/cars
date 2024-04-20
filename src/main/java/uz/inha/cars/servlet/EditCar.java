package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.inha.cars.entity.Car;
import uz.inha.cars.entity.Company;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "editCar" , value = "/admin/editCar")
public class EditCar extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        Integer companyId = Integer.parseInt(req.getParameter("companyId"));
        entityManager.getTransaction().begin();
        Car car = entityManager.find(Car.class, id);
        Company company = entityManager.find(Company.class, companyId);
        car.setName(req.getParameter("name"));
        car.setCompany(company);
        entityManager.getTransaction().commit();
        resp.sendRedirect("/admin/car.jsp");
    }
}
