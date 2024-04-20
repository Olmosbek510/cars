package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.Car;
import uz.inha.cars.entity.CarDetail;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "saveDetails" ,value = "/admin/car/details/save")
public class SaveDetails extends HttpServlet {
    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        entityManager.getTransaction().begin();
        Car car = entityManager.find(Car.class, id);
        HttpSession session = req.getSession();
        Object o = session.getAttribute("details");
        if(o!=null){
            List<CarDetail> carDetails = (List<CarDetail>)o;
            car.setCarDetails(carDetails);
        }
        entityManager.getTransaction().commit();
        session.removeAttribute("details");
        resp.sendRedirect("/admin/car.jsp");
    }
}
