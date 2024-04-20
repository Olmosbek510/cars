package uz.inha.cars.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.Role;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;
import uz.inha.cars.repo.UserRepo;

import java.io.IOException;

@WebServlet(name = "auth", value = "/auth/login")
public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        User user = UserRepo.findByPhoneAndPassword(phone, password);
        HttpSession session = req.getSession();
        if(user==null){
            session.setAttribute("errorMessage", "Invalid phone number or password");
            resp.sendRedirect("/login.jsp");
        }else {
            session.setAttribute("currentUser", user);
            session.removeAttribute("errorMessage");
            if(user.hasRole(RoleName.ROLE_SUPER_ADMIN)){
                resp.sendRedirect("/superadmin/superadmin.jsp");
            }
            else if(user.hasRole(RoleName.ROLE_ADMIN)){
                resp.sendRedirect("/admin/admin.jsp");
            }else {
                resp.sendRedirect("/");
            }
        }

    }
}
