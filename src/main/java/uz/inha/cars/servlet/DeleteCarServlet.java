package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.inha.cars.entity.Car;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "deleteCar", value = "/admin/car/delete")
public class DeleteCarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        entityManager.getTransaction().begin();
        Car car = entityManager.find(Car.class, id);
        entityManager.remove(car);
        entityManager.getTransaction().commit();
        resp.sendRedirect("/admin/car.jsp");
    }
}
