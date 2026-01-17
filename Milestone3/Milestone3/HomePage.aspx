<title>Home Page</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
        }
        .form-container {
            max-width: 400px;
            padding: 20px;
            margin: 50px auto;
            background: #e6ecf5;
            box-shadow: 0 1px 6px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        .button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #4c7cd7;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            font-size: 16px;
            box-sizing: border-box;
        }
        .button:hover {
            background-color: #395ba8;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 style="text-align:center; color:#0366d6">Home Page</h2>
        <button class="button" onclick="window.location.href='Student_Login.aspx';">Student</button>
        <button class="button" onclick="window.location.href='Advisor_Login.aspx';">Advisor</button>
        <button class="button" onclick="window.location.href='LoginAdmin.aspx';">Admin</button>
    </div>
</body>
</html>
