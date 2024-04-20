package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.Attachment;
import uz.inha.cars.entity.AttachmentContent;
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
        HttpSession session = req.getSession();
        Object o = session.getAttribute("currentFile");
        if(o!=null){
            UUID attachId = (UUID) o;
            Attachment photo = car.getPhoto();
            AttachmentContent result = entityManager.createQuery("select a from AttachmentContent a where a.attachment.id =: id", AttachmentContent.class).setParameter("id", photo.getId()).getSingleResult();
            entityManager.remove(result);
            Attachment attachment = entityManager.find(Attachment.class, attachId);
            car.setPhoto(attachment);
        }
        car.setName(req.getParameter("name"));
        session.removeAttribute("currentFile");
        car.setCompany(company);
        entityManager.getTransaction().commit();
        resp.sendRedirect("/admin/car.jsp");
    }
}
