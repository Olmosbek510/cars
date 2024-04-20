package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.AttachmentContent;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "cancelUserEdit", value = "/user/cancelEdit")
public class CancelUserEditServlet extends HttpServlet {
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
        Object object = session.getAttribute("currentUser");
        if(object!=null){
            User user = (User) object;
            if(user.hasRole(RoleName.ROLE_SUPER_ADMIN)){
                resp.sendRedirect("/superadmin/user.jsp");
            }else {
                resp.sendRedirect("/userProfile.jsp?id="+user.getId());
            }
        }
    }
}
