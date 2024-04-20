package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.CarDetail;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "add CarDetail", value = "/admin/car/addDetail")
public class AddCarDetailServlet extends HttpServlet {
    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getParameter("key");
        String value = req.getParameter("value");
        List<CarDetail> carDetails = new ArrayList<>();
        CarDetail carDetail = CarDetail.builder()
                .key(key)
                .value(value)
                .build();
        HttpSession session = req.getSession();
        Object o = session.getAttribute("details");
        if(o!=null){
            carDetails = (List<CarDetail>) o;
        }
        carDetails.add(carDetail);
        session.setAttribute("details", carDetails);
        resp.sendRedirect("/admin/addDetail.jsp?id="+req.getParameter("carId"));
    }
}
