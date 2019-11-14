<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dot" scope="application" class="dots.DotBean"/>
<html lang="ru">
<head>
    <%dot.clearDotArray();%>
    <meta charset="utf-8">
    <title>Лабораторная работа №2</title>
    <link rel="stylesheet" href="resource/style.css?version=50">
    <script src="./libs/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        function validate() {
            let errorJquery = $('#error-log');
            errorJquery.html("");
            $('#x-input').val("");
            let success = true;
            if ($('input[name^="x-input"]:checked').length === 0) {
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                errorJquery.append(li);
                li.innerHTML = li.innerHTML + "Вы не выбрали значение Х. Сделайте это.";
                success = false;
            }
            let y = $('#y-input').val();
            if (y.match(/^[0-3](((.|,)0+)|)$/) == null && y.match(/^-[0-5](((.|,)0+)|)$/) == null && y.match(/^[0-2](.|,)\d+$/) == null && y.match(/^-[0-4](.|,)\d+$/) == null) {
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                errorJquery.append(li);
                li.innerHTML = li.innerHTML + "Введено некорректное значение Y или не входящее в допустимый диапозон. Введите значение от -5 до 3.";
                success = false;
            }
            let rJquery = $('input[name^="r-input"]:checked');
            if (rJquery.length === 0) {
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                errorJquery.append(li);
                li.innerHTML = li.innerHTML + "Выберите значение радиуса, чтобы указать масштаб.";
                success = false;
            }
            if (rJquery.length > 1) {
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                errorJquery.append(li);
                li.innerHTML = li.innerHTML + "Масштаб указан неверно. Выберите ровно одно значение радиуса.";
                success = false;
            }
            return success;
        }

        function formSubmit(event) {
            event.preventDefault();
            try {
                if (validate()) {
                    let y=$('#y-input');
                    if (!(y.val().match(/^-0(((.|,)0+)|)$/) === null)) y.val("0.0");
                    $.post(
                        "controller/submit",
                        $('#form').serialize(),
                        function (msg) {
                            $('#answer').contents().find('body').html(msg);
                        }
                    );
                    let R = decodeR();

                    setTimeout(drawDots, 100, R);
                    setTimeout(blockLink,100);
                }
            } catch (error) {
            }
            return false;
        }
        function blockLink() {
            $('#answer').contents().find('#mainLink').click(function () {
                let errorJquery = $('#error-log');
                errorJquery.html("");
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                errorJquery.append(li);
                li.innerHTML = li.innerHTML + "Вы уже находитесь на странице с формой.";
                return false;
            });
        }
        function clearText(tag) {
            document.getElementById(tag).value = "";
        }

        $(document).on('keypress', function (e) {
            if (e.which == 13) {
                e.preventDefault();
            }
        });

        function decodeR() {
            document.getElementById('error-log').innerHTML = "";
            let jqueryR = $('input[name^="r-input"]:checked');
            let R;
            if (jqueryR.length > 1) {
                let li = document.createElement('li');
                li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                document.getElementById('error-log').appendChild(li);
                li.innerHTML = li.innerHTML + "Масштаб указан неверно. Выберите ровно одно значение радиуса.";
                R = "";
            } else {
                if (jqueryR.length === 0) {
                    let li = document.createElement('li');
                    li.setAttribute("style", "padding-bottom:1%;padding-top:1%;");
                    document.getElementById('error-log').appendChild(li);
                    li.innerHTML = li.innerHTML + "Выберите значение радиуса, чтобы указать масштаб.";
                    R = "";
                } else {
                    R = jqueryR.get(0).value;
                }
            }
            return R;
        }

        function setR() {
            let jqueryR = $('input[name^="r-input"]:checked');
            if (jqueryR.length > 1 || jqueryR.length === 0) {
                drawCanvas("R");
            } else {
                let R = jqueryR.get(0).value;
                drawCanvas(R);
                setTimeout(drawDots, 100, R);
            }
        }

        function drawCanvas(R) {
            let canvas = $('#canvas').get(0);
            let context = canvas.getContext("2d");
            let size = canvas.width;
            canvas.height = size;
            context.clearRect(0, 0, size, size);
            context.strokeStyle = 'rgb(0,0,0)';
            context.lineWidth = 3;
            context.fillStyle = 'rgb(255,255,255)';
            context.font = "small-caps 20px Times New Roman";
            context.fillRect(0, 0, size, size);
            //область
            context.fillStyle = 'rgb(44,103,191)';
            context.fillRect(0.5 * size, 0.15 * size, 0.35 * size, 0.35 * size);
            context.beginPath();
            context.moveTo(0.5 * size, 0.5 * size);
            context.lineTo(0.5 * size, 0.675 * size);
            context.lineTo(0.675 * size, 0.5 * size);
            context.lineTo(0.5 * size, 0.5 * size);
            context.closePath();
            context.fill();
            context.beginPath();
            context.moveTo(0.325 * size, 0.5 * size);
            context.arcTo(0.325 * size, 0.675 * size, 0.5 * size, 0.675 * size, 0.175 * size);
            context.lineTo(0.5 * size, 0.5 * size);
            context.lineTo(0.325 * size, 0.5 * size);
            context.closePath();
            context.fill();
            //оси и стрелочки
            context.beginPath();
            context.moveTo(0, size / 2);
            context.lineTo(size, size / 2);
            context.lineTo(size - 0.03 * size, size / 2 + 0.03 * size);
            context.lineTo(size, size / 2);
            context.lineTo(size - 0.03 * size, size / 2 - 0.03 * size);
            context.lineTo(size, size / 2);
            context.moveTo(size / 2, size);
            context.lineTo(size / 2, 0);
            context.lineTo(size / 2 - 0.03 * size, 0.03 * size);
            context.lineTo(size / 2, 0);
            context.lineTo(size / 2 + 0.03 * size, 0.03 * size);
            context.lineTo(size / 2, 0);
            context.closePath();
            context.stroke();
            let halfR;
            if (R === "R") {
                halfR = "R/2"
            } else {
                halfR = parseFloat((R / 2).toPrecision(4));
            }
            context.fillStyle = 'rgb(0,0,0)';
            context.fillText("Y", size / 2 + 0.05 * size, 0.06 * size);
            context.fillText("X", 0.94 * size, size / 2 - 0.05 * size);
            //R на Y
            context.fillText(R, size / 2 + 0.05 * size, 0.175 * size);
            context.fillText(halfR, size / 2 + 0.05 * size, 0.35 * size);
            context.fillText("-" + halfR, size / 2 + 0.05 * size, 0.7 * size);
            context.fillText("-" + R, size / 2 + 0.05 * size, 0.875 * size);
            //R на X
            context.fillText("-" + R, 0.175 * size - 0.065 * size, size / 2 - 0.05 * size);
            context.fillText("-" + halfR, 0.35 * size - 0.065 * size, size / 2 - 0.05 * size,);
            context.fillText(halfR, 0.7 * size - 0.045 * size, size / 2 - 0.05 * size);
            context.fillText(R, 0.875 * size - 0.045 * size, size / 2 - 0.05 * size);
            //засечки Y
            context.beginPath();
            context.moveTo(size / 2 - 0.02 * size, 0.15 * size);
            context.lineTo(size / 2 + 0.02 * size, 0.15 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(size / 2 - 0.02 * size, 0.325 * size);
            context.lineTo(size / 2 + 0.02 * size, 0.325 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(size / 2 - 0.02 * size, 0.675 * size);
            context.lineTo(size / 2 + 0.02 * size, 0.675 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(size / 2 - 0.02 * size, 0.85 * size);
            context.lineTo(size / 2 + 0.02 * size, 0.85 * size);
            context.closePath();
            context.stroke();
            //засечки X
            context.beginPath();
            context.moveTo(0.325 * size, size / 2 - 0.02 * size);
            context.lineTo(0.325 * size, size / 2 + 0.02 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(0.15 * size, size / 2 - 0.02 * size);
            context.lineTo(0.15 * size, size / 2 + 0.02 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(0.675 * size, size / 2 - 0.02 * size);
            context.lineTo(0.675 * size, size / 2 + 0.02 * size);
            context.closePath();
            context.stroke();
            context.beginPath();
            context.moveTo(0.85 * size, size / 2 - 0.02 * size);
            context.lineTo(0.85 * size, size / 2 + 0.02 * size);
            context.closePath();
            context.stroke();
        }

        function drawDots(R) {
            //массив точек
            if (!(R === "R")) {
                let canvas = $('#canvas').get(0);
                let context = canvas.getContext("2d");
                let size = canvas.height;
                let jquery = $('#answer');
                let htmlArray = Array(jquery.contents().find('#second-line').html().toString(),
                    jquery.contents().find('#third-line').html().toString(),
                    jquery.contents().find('#fourth-line').html().toString(),
                    jquery.contents().find('#fifth-line').html().toString(),
                    jquery.contents().find('#sixth-line').html().toString());
                let xString = "";
                let yString = "";
                let rString = "";
                let supportString = "";
                for (let i = 0; i < 5; i++) {
                    let html = htmlArray[i].replace(/\s/g, "");
                    xString += html.substring(0, html.indexOf('</td><td>')).replace("<td>", "") + " ";
                    supportString = html.substring(html.indexOf('</td><td>') + 9, html.length);
                    yString += supportString.substring(0, supportString.indexOf('</td><td>')) + " ";
                    supportString = html.substring(html.indexOf('</td><td>') + 9, html.lastIndexOf('</td><td>'));
                    rString += supportString.substring(supportString.indexOf('</td><td>') + 9, supportString.length) + " ";
                }
                xString = xString.split("<br>").join("").trim();
                yString = yString.trim();
                rString = rString.trim();
                for (let i = 0; i < 5; i++) {
                    let r = rString.toString().split(" ");
                    let x = xString.toString().split(" ");
                    let y = yString.toString().split(" ");
                    context.fillStyle = 'rgb(48, 18, 90)';
                    context.beginPath();
                    let canvasX = x[i] * 0.35 * size / r[i] + size / 2;
                    if (canvasX >= size / 2) {
                        canvasX = (canvasX - size / 2) * r[i] / R + size / 2;
                    } else {
                        canvasX = size / 2 - (size / 2 - canvasX) * r[i] / R;
                    }
                    let canvasY = size / 2 - y[i] * 0.35 * size / r[i];
                    if (canvasY >= size / 2) {
                        canvasY = (canvasY - size / 2) * r[i] / R + size / 2;
                    } else {
                        canvasY = size / 2 - (size / 2 - canvasY) * r[i] / R;
                    }
                    context.arc(canvasX, canvasY, 3, 0, 2 * Math.PI, true);
                    context.closePath();
                    context.fill();
                    context.strokeStyle = 'rgb(48, 18, 90)';
                    context.lineWidth = 2;
                    context.beginPath();
                    context.arc(canvasX, canvasY, 7, 0, 2 * Math.PI, true);
                    context.closePath();
                    context.stroke();
                }
            }
        }
    </script>
</head>
<body>
<header>
    <h1>Веб-программирование</h1>
    Чепрасов Иван Андреевич P3200
    <br>Лабораторная №2. Вариант: 200024
</header>
<form id="form" method="post" target="answer">
    <main>
        <div class="left-table">
            <table class="point-table">
                <thead>
                <tr>
                    <td class="table-heading" colspan="4">Выберите координаты точки и радиус</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Область</td>
                    <td colspan="3">Значения</td>
                </tr>
                <tr>
                    <td rowspan="10" id="canvas-cell">
                        <div id="canvas-container">
                            <canvas id="canvas">Здесь должен был быть Canvas, но ваш браузер его не поддерживает.
                            </canvas>
                            <script type="text/javascript">
                                drawCanvas("R");
                                $('#canvas').click(function (event) {
                                    let canvas = $('#canvas').get(0);
                                    let context = canvas.getContext("2d");
                                    let R = decodeR();
                                    R = parseFloat(parseFloat(R.replace(",", ".")).toPrecision(4));
                                    if (!(R >= 1.0 && R <= 5.0)) {
                                        R = "R";
                                    }
                                    drawCanvas(R);
                                    let x = event.clientX - canvas.getBoundingClientRect().left;
                                    let y = event.clientY - canvas.getBoundingClientRect().top;
                                    context.fillStyle = 'rgb(227, 93, 214)';
                                    context.beginPath();
                                    context.arc(x, y, 3, 0, 2 * Math.PI, true);
                                    context.closePath();
                                    context.fill();
                                    context.strokeStyle = 'rgb(227, 93, 214)';
                                    context.lineWidth = 2;
                                    context.beginPath();
                                    context.arc(x, y, 7, 0, 2 * Math.PI, true);
                                    context.closePath();
                                    context.stroke();
                                    let xVal = "";
                                    let yVal = "";
                                    if (R >= 1.0 && R <= 5.0) {
                                        xVal = (-canvas.height / 2 + x) / (0.35 * canvas.height) * R;
                                        yVal = (canvas.height / 2 - y) / (0.35 * canvas.height) * R;
                                        $('#x-input').val(xVal.toPrecision(5));
                                        $('#y-input').val(yVal.toPrecision(5));
                                        $('input[name^="x-input"]:checked').prop("checked", false);
                                    } else {
                                        $('#x-input').val("");
                                        $('#y-input').val("");
                                    }
                                    if (!(R === "R")) {
                                        $.post(
                                            "controller/canvas",
                                            $('#form').serialize(),
                                            function (msg) {
                                                $('#answer').contents().find('body').html(msg);
                                            }
                                        )
                                    }
                                    setTimeout(drawDots, 100, R);
                                    setTimeout(blockLink,100);
                                });
                            </script>
                        </div>
                    </td>
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
                        <input type="text" class="text-input" id="x-input" placeholder="Графический ввод" maxlength="10"
                               name="x-input[]" form="form" readonly>
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
                    <%--<td colspan="3">
                        <input type="text" class="text-input" id="radius-input" name="r-input" placeholder="от 1 до 4"
                               maxlength="10" onclick="clearText('radius-input')" form="form">
                    </td>--%>
                    <td>
                        <input type="checkbox" id="r-1" form="form" name="r-input[]" value="1" onclick="setR()">
                        <label for="r-1">1</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-2" form="form" name="r-input[]" value="2" onclick="setR()">
                        <label for="r-2">2</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-3" form="form" name="r-input[]" value="3" onclick="setR()">
                        <label for="r-3">3</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="r-4" form="form" name="r-input[]" value="4" onclick="setR()">
                        <label for="r-4">4</label>
                    </td>
                    <td>
                        <input type="checkbox" id="r-5" form="form" name="r-input[]" value="5" onclick="setR()">
                        <label for="r-5">5</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <button type="button" class="button" id="submitButton" form="form"
                                onclick="return formSubmit(event);">
                            Отправить
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="right-table">
            <iframe name="answer" id="answer" frameborder="no" src="resource/default.html"></iframe>
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
