package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.AttachmentContent;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "cancelCarEdit", value = "/car/cancelEdit")
public class CancelCarEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Object o = session.getAttribute("currentFile");
        UUID id = UUID.randomUUID();
        if (o!=null) {
            id = (UUID) o;
            entityManager.getTransaction().begin();
            AttachmentContent result = entityManager.createQuery("select a from AttachmentContent a where a.attachment.id =: id", AttachmentContent.class).setParameter("id", id).getSingleResult();
            entityManager.remove(result);
            entityManager.getTransaction().commit();
            session.removeAttribute("currentFile");
        }
        resp.sendRedirect("/admin/car.jsp");
    }
}
