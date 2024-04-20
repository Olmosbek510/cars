package uz.inha.cars.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.inha.cars.entity.User;
import uz.inha.cars.entity.enums.RoleName;

import java.io.IOException;
@WebFilter(urlPatterns = {"/admin/*", "/superadmin/*"})
public class SecurityFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession();
        Object object = session.getAttribute("currentUser");
        if(object==null){
            resp.sendRedirect("/404");
            return;
        }
        User user = (User) object;
        if(user.hasRole(RoleName.ROLE_ADMIN) || user.hasRole(RoleName.ROLE_SUPER_ADMIN)){
            filterChain.doFilter(servletRequest,servletResponse);
        }else{
            resp.sendRedirect("/404");
        }

    }
}
