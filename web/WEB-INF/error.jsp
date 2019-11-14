<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Лабораторная работа №2</title>
</head>
<body>
<form id="form" method="post" target="answer" action="controller/submit">
    <main>
        <div class="left-table">
            <table class="point-table">
                <thead>
                <tr>
                    <td class="table-heading" colspan="3">Выберите координаты точки и радиус</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="3">
                        Координата Х:
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="number-4" form="form" name="x-input[]" value="-4">
                        <label for="number-4">-4</label>
                    </td>
                    <td>
                        <input type="checkbox" id="number-1" form="form" name="x-input[]" value="-1">
                        <label for="number-1">-1</label>
                    </td>
                    <td>
                        <input type="checkbox" id="number2" form="form" name="x-input[]" value="2">
                        <label for="number2">&nbsp2</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="number-3" form="form" name="x-input[]" value="-3">
                        <label for="number-3">-3</label>
                    </td>
                    <td>
                        <input type="checkbox" id="number0" form="form" name="x-input[]" value="0">
                        <label for="number0">&nbsp0</label>

                    </td>
                    <td>
                        <input type="checkbox" id="number3" form="form" name="x-input[]" value="3"
                        >
                        <label for="number3">&nbsp3</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="number-2" form="form" name="x-input[]" value="-2">
                        <label for="number-2">-2</label>
                    </td>
                    <td>
                        <input type="checkbox" id="number1" form="form" name="x-input[]" value="1">
                        <label for="number1">&nbsp1</label>
                    </td>
                    <td>
                        <input type="checkbox" id="number4" form="form" name="x-input[]" value="4">
                        <label for="number4">&nbsp4</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        Координата Y:
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <input type="text" class="text-input" id="y-input" placeholder="от -5 до 3" maxlength="10"
                               name="y-input" form="form">
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        Радиус:
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="r-1" form="form" name="r-input[]" value="1">
                        <label for="r-1">1</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-2" form="form" name="r-input[]" value="2">
                        <label for="r-2">2</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-3" form="form" name="r-input[]" value="3">
                        <label for="r-3">3</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="r-4" form="form" name="r-input[]" value="4">
                        <label for="r-4">4</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-5" form="form" name="r-input[]" value="5">
                        <label for="r-5">5</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <button type="submit" class="button" id="submitButton" form="form">
                            Отправить
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="bottom-table">
            <table class="error-table">
                <thead>
                <tr>
                    <td>Полезные советы</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <ul id="error-log">
                            <%
                                boolean canvas = request.getRequestURI().contains("canvas");
                                try {
                                    String[] xArray = request.getParameterValues("x-input[]");
                                    if(xArray.length!=0){
                                        for (String xString : xArray) {
                                            float x;
                                            if (!xString.equals("")) {
                                                x = Float.parseFloat(xString.replace(",", "."));
                                                if ((((x > 4) || (x < -4)) && !canvas) || (canvas && ((x > 10) || (x < -10)))) out.print("<li>" +
                                                        "Введено некорректное значение X" +
                                                        " или не входящее в допустимый диапозон. " +
                                                        "Введите значение от -4 до 4.</li>");
                                            }
                                        }
                                    }else{
                                        out.print("<li>Вы не выбрали значение Х. Сделайте это.</li>");
                                    }
                                } catch (NumberFormatException e) {
                                    out.print("<li>Введено некорректное значение X или не входящее в допустимый диапозон. Введите значение от -4 до 4.</li>");
                                }catch (NullPointerException e) {
                                    out.print("<li>Вы не выбрали значение Х. Сделайте это.</li>");
                                }
                                try {
                                    String[] yArray = request.getParameterValues("y-input");
                                    if (yArray.length == 1) {
                                        float y = Float.parseFloat(yArray[0].replace(",", "."));
                                        if ((((y > 3) || (y < -5)) && !canvas) || (canvas && ((y > 10) || (y < -10)))) out.print("<li>" +
                                                "Введено некорректное значение Y или не входящее в допустимый диапозон. " +
                                                "Введите значение от -5 до 3.</li>");
                                    } else {
                                        out.print("<li>Выберите одно значение Y.</li>");
                                    }
                                } catch (NumberFormatException e) {
                                    out.print("<li>Введено некорректное значение Y или не входящее в допустимый диапозон. Введите значение от -5 до 3.</li>");
                                }catch (NullPointerException e) {
                                    out.print("<li>Вы не выбрали значение Y. Сделайте это.</li>");
                                }
                                try {
                                    String[] rArray = request.getParameterValues("r-input[]");
                                    if (rArray.length == 1) {
                                        float r = Float.parseFloat(rArray[0].replace(",", "."));
                                        if (r < 1 || r > 5) out.print("<li>" +
                                                "Введено некорректное значение R или не входящее в допустимый диапозон. " +
                                                "Введите значение от 1 до 5.</li>");
                                    } else {
                                        out.print("<li>Выберите одно значение R.</li>");
                                    }
                                } catch (NumberFormatException e) {
                                    out.print("<li>Введено некорректное значение R или не входящее в допустимый диапозон. Введите значение от 1 до 5.</li>");
                                }catch (NullPointerException e) {
                                    out.print("<li>Вы не выбрали значение R. Сделайте это.</li>");
                                }
                            %>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>
</form>
</body>
</html>
