package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        handleRequest(req, res);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        handleRequest(req, res);
    }

    private void handleRequest(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        boolean success = true;
        boolean canvas = req.getRequestURI().contains("canvas");
        try {
            String[] xArray = req.getParameterValues("x-input[]");
            if (xArray.length != 0) {
                for (String xString : xArray) {
                    float x;
                    if (!xString.equals("")) {
                        String xReplaced = xString.replace(",", ".");
                        x = Float.parseFloat(xReplaced);
                        if ((((x > 4) || (x < -4)) && !canvas) || (canvas && ((x > 10) || (x < -10)))) {
                            success = false;
                        } else {
                            if((!xReplaced.matches("^(4|-4|10|-10)(.0+)?$"))&&(x==4||x==-4||x==10||x==-10)) success=false;
                        }
                    }
                }
            } else {
                success = false;
            }
            String[] yArray = req.getParameterValues("y-input");
            if (yArray.length == 1) {
                float y = Float.parseFloat(yArray[0].replace(",", "."));
                if ((((y > 3) || (y < -5)) && !canvas) || (canvas && ((y > 10) || (y < -10)))){
                    success = false;
                }else{
                    if((!yArray[0].replace(",", ".").matches("^(3|-5|10|-10)(.0+)?$"))&&(y==3||y==-5||y==10||y==-10)) success=false;
                }
            } else {
                success = false;
            }
            String[] rArray = req.getParameterValues("r-input[]");
            if (rArray.length == 1) {
                float r = Float.parseFloat(rArray[0].replace(",", "."));
                if (r < 1 || r > 5){
                    success = false;
                }else{
                    if((!rArray[0].replace(",", ".").matches("^(1|5)(.0+)?$"))&&(r==1||r==5)) success=false;
                }
            } else {
                success = false;
            }
        } catch (NumberFormatException | NullPointerException e) {
            success = false;
        }
        ServletContext servletContext = this.getServletContext();
        RequestDispatcher requestDispatcher;
        if (success) {
            requestDispatcher = servletContext.getRequestDispatcher("/WEB-INF/areaCheck/check");
        } else {
            requestDispatcher = servletContext.getRequestDispatcher("/WEB-INF/error.jsp");
        }
        requestDispatcher.forward(req, res);
    }
}

