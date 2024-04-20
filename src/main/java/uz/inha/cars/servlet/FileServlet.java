package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import uz.inha.cars.entity.Attachment;
import uz.inha.cars.entity.AttachmentContent;
import uz.inha.cars.repo.AttachmentRepo;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@MultipartConfig
@WebServlet(name = "File", value = "/file")
public class FileServlet extends HttpServlet {
    @Override
    protected synchronized void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID attachmentId = UUID.fromString(req.getParameter("id"));
        AttachmentContent result = entityManager.createQuery("select t from AttachmentContent t where t.attachment.id =: id", AttachmentContent.class)
                .setParameter("id", attachmentId).getSingleResult();
        resp.getOutputStream().write(result.getContent());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        entityManager.getTransaction().begin();
        Part part = req.getPart("photo");
        String fileName = part.getSubmittedFileName();
        System.out.println("Type: " + fileName.substring(fileName.lastIndexOf('.')));
        System.out.println(fileName);
        byte[] bytes = part.getInputStream().readAllBytes();
        AttachmentContent attachmentContent = AttachmentContent.builder()
                .attachment(
                        Attachment.builder()
                                .type(fileName.substring(fileName.lastIndexOf('.')))
                                .build()
                )
                .content(bytes)
                .build();
        entityManager.persist(attachmentContent);
        entityManager.getTransaction().commit();
        HttpSession session = req.getSession();
        session.setAttribute("currentFile", attachmentContent.getAttachment().getId());
        String lastUrl = req.getParameter("lastUrl");
        resp.sendRedirect(lastUrl);
    }
}
