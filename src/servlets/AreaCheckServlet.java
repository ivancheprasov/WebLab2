package servlets;

import dots.DotBean;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class AreaCheckServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        handleRequest(req, res);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        handleRequest(req, res);
    }

    private void handleRequest(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        ServletOutputStream out = res.getOutputStream();
        res.setContentType("text/html;charset=UTF-8");
        StringBuilder answer = new StringBuilder();
        Object o = req.getServletContext().getAttribute("dot");
        DotBean dot;
        if (o == null) {
            dot = new DotBean();
            req.getServletContext().setAttribute("dot", dot);
        } else {
            dot = (DotBean) o;
        }
        ArrayList<Float> x = new ArrayList<>();
        String[] xArray = req.getParameterValues("x-input[]");
        for (String xString : xArray) {
            if (!xString.equals("")) {
                x.add(Float.parseFloat(xString));
            }
        }
        float y = Float.parseFloat(req.getParameterValues("y-input")[0]);
        float r = Float.parseFloat(req.getParameterValues("r-input[]")[0]);
        x.forEach(element -> dot.addDot(element, y, r, checkHit(element, y, r)));
        answer.append("<html>\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <title>answer</title>\n" +
                "    <link rel=\"stylesheet\" href=\"resource/style.css?version=50\">\n" +
                "</head>\n" +
                "<body id=\"result-body\">\n" +
                "<table class=\"point-table\">\n" +
                "    <thead>\n" +
                "    <tr>\n" +
                "        <td class=\"table-heading\">\n" +
                "            Результат обработки данных\n" +
                "        </td>\n" +
                "    </tr>\n" +
                "    </thead>\n" +
                "    <tbody>\n" +
                "    <tr>\n" +
                "        <td>\n" +
                "            <table class=\"result-table\">\n" +
                "                <tr id=\"first-line\">\n" +
                "                    <td>\n" +
                "                        Координата Х\n" +
                "                    </td>\n" +
                "                    <td>\n" +
                "                        Координата Y\n" +
                "                    </td>\n" +
                "                    <td>\n" +
                "                        Координата R\n" +
                "                    </td>\n" +
                "                    <td>\n" +
                "                        Попадание\n" +
                "                    </td>\n" +
                "                </tr>");
        ArrayList<String> lines = new ArrayList<>();
        lines.add("second-line");
        lines.add("third-line");
        lines.add("fourth-line");
        lines.add("fifth-line");
        lines.add("sixth-line");
        for (int i = 0; i < dot.getDotArray().size(); i++) {
            answer.append("<tr id=\"" + lines.get(i) + "\">\n" +
                    "                    <td>" +
                    "                       " + dot.getDotX(i) +
                    "                    </td>\n" +
                    "                    <td>" + dot.getDotY(i) + "</td>\n" +
                    "                    <td>" + dot.getDotR(i) + "</td>\n" +
                    "                    <td>" + Boolean.toString(dot.getDotHit(i)).replace("true", "Да").replace("false", "Нет") + "</td>\n" +
                    "                </tr>");
        }
        for (int i = 0; i < (5 - dot.getDotArray().size()); i++) {
            answer.append("<tr id=" + lines.get(i + dot.getDotArray().size()) + ">\n" +
                    "                    <td>\n" +
                    "                        <br>\n" +
                    "                    </td>\n" +
                    "                    <td></td>\n" +
                    "                    <td></td>\n" +
                    "                    <td></td>\n" +
                    "                </tr>");
        }
        answer.append("</table>\n" +
                "        </td>\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "        <td>" +
                "            <a id=\"mainLink\" href=\"index.jsp\">Вернуться на страницу c формой</a>" +
                "        </td>\n" +
                "    </tr>\n" +
                "    </tbody>\n" +
                "</table>\n" +
                "</body>\n" +
                "</html>");
        out.write(answer.toString().getBytes("UTF-8"));
        out.close();
    }

    private boolean checkHit(float x, float y, float r) {
        if (x >= 0 && y >= 0) return x <= r && y <= r;
        if (x >= 0 && y <= 0) return y >= x - r / 2;
        if (x <= 0 && y <= 0) return Math.pow(r / 2, 2) >= (Math.pow(x, 2) + Math.pow(y, 2));
        return false;
    }
}