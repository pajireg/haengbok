package org.csm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {


    @Override
    public void onAuthenticationSuccess(
    		HttpServletRequest request, HttpServletResponse response, Authentication authentication
    		) throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        
        if(session != null) {
            String redirectUrl = (String) session.getAttribute("prevPage");
            session.removeAttribute("prevPage");
            if(redirectUrl != null) {
            	
                response.sendRedirect(redirectUrl);
                
            }else {

            	response.sendRedirect("/haengbok");
            }
            
        }else {
        	
        	response.sendRedirect("/haengbok");
        }
    }
}


