package uz.inha.cars.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;

import java.io.IOException;

@WebFilter(urlPatterns = "/superadmin/*")
public class SuperAdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession();
        Object o = session.getAttribute("currentUser");
        if(o==null){
            res.sendRedirect("/404");
            return;
        }
        User user = (User) o;
        if(user.hasRole(RoleName.ROLE_SUPER_ADMIN)){
            filterChain.doFilter(req,res);
        }
        else {
            res.sendRedirect("/404");
        }
    }
}
