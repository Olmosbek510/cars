package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.Attachment;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;
import uz.inha.cars.repo.RoleRepo;

import java.io.IOException;
import java.util.UUID;

import static uz.inha.cars.config.DB.entityManager;

@WebServlet(name = "editUser", value = "/user/edit")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID userId = UUID.fromString(req.getParameter("id"));
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String phone = req.getParameter("phone");
        String oldPassword = req.getParameter("old_password");
        String newPassword = req.getParameter("new_password");
        String repeatPassword = req.getParameter("repeat_password");
        HttpSession session = req.getSession();
        entityManager.getTransaction().begin();
        Object o = session.getAttribute("currentFile");
        Attachment attachment = null;
        if (o!=null) {
            attachment = entityManager.find(Attachment.class, o);
        }
        String roles = req.getParameter("role[]");
        User user = entityManager.find(User.class, userId);

        if(user.getPassword().equals(oldPassword) && newPassword.equals(repeatPassword)){
            user.setFirstName(firstname);
            user.setLastName(lastname);
            user.setPassword(newPassword);
            if(roles!=null){
                user.setRoles(RoleRepo.getRolesById(roles));
            }
            user.setPhone(phone);
            if(attachment!=null){
                user.setProfilePhoto(attachment);
                session.removeAttribute("currentFile");
            }
        }
        Object o1 = session.getAttribute("currentUser");
        User user1 = null;
        if(o1!=null){
            user1 = (User) o1;
            if(user1.hasRole(RoleName.ROLE_SUPER_ADMIN)){
                resp.sendRedirect("/superadmin/user.jsp");
            }else{
                resp.sendRedirect("/userProfile.jsp");
            }
        }

        entityManager.getTransaction().commit();
    }
}
