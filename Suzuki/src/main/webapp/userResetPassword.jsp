<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Password | X-Workz</title>
  <link rel="icon" href="https://www.x-workz.in/Logo.png">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    body {
      background: linear-gradient(to right, #2c3e50, #3498db);
      padding-top: 70px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }

    .main-section {
      margin-top: 80px;
      flex-grow: 1;
    }

    .card {
      border-radius: 15px;
    }

    .card:hover {
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
    }

    .left-panel {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: start;
      color: white;
      padding-left: 40px;
    }

   .left-panel img {
     width: 80%;
     max-width: 300px;
     height: auto;
     border-radius: 15px;
     box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
   }
    .slogan {
      margin-top: 30px;
      font-size: 1.5rem;
      font-weight: bold;
      text-shadow: 1px 1px 4px black;
    }

    footer {
      margin-top: auto;
    }

    .form-container {
      margin-left: -40px;  /* adjust as needed */
    }
  </style>
</head>
<body>

<header class="bg-dark text-white">
  <div class="d-flex justify-content-between align-items-center p-3">
    <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo" width="80">
  </div>
</header>

<div class="container-fluid main-section">
  <div class="row">
    <!-- Left image + slogan -->
    <div class="col-md-6 left-panel px-0">
      <img src="https://c4.wallpaperflare.com/wallpaper/350/277/139/motorcycles-suzuki-wallpaper-preview.jpg" alt="X-Workz Bike Image">
      <div class="slogan">Reset with Confidence – Ride into a Secure Future.</div>
    </div>

    <!-- Right reset password form -->
    <div class="col-md-6 d-flex align-items-center justify-content-center">
      <div class="form-container w-100" style="max-width:600px;">
      <form action="resetform" method="post" class="card shadow-lg p-4 w-100" style="max-width: 600px;">
        <h3 class="text-center mb-4">Reset Your Password</h3>

        <div class="text-center text-danger mb-3">
          <p class="font-italic">${msg}</p>
        </div>
        <span id="Message" class="text-danger"></span>

        <div class="form-group">
          <label>Email</label>
          <input type="email" placeholder="Enter Email" class="form-control" name="userEmailId" id="emailIdd"
            onchange="checkEmail()" value="${userEmail}" readonly required>
          <small id="emailExists" class="form-text text-danger"></small>
        </div>

        <div class="form-group">
          <label>New Password</label>
          <input type="password" placeholder="Enter new password" class="form-control" name="password" id="pass"
            onchange="passwordd()" required>
          <small id="pasword" class="form-text text-danger"></small>
        </div>

        <div class="form-group">
          <label>Confirm New Password</label>
          <input type="password" placeholder="Re-enter password" class="form-control" name="confirmPassword"
            id="confirmPassword" onchange="confirm()" required>
          <small id="errorConfirmPassword" class="form-text text-danger"></small>
        </div>

        <div class="form-group text-center pt-3">
          <input type="submit" id="button" class="btn btn-primary btn-block" value="Reset" style="color: white;">
        </div>
      </form>
       </div>
    </div>
  </div>
</div>

<script>
  const checkEmail = async () => {
    let emailId = document.getElementById("emailIdd").value;
    let button = document.getElementById("button");
    const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
    const response = await axios("http://localhost:8080/Suzuki/userEmailExist?userEmailId=" + emailId);

    if (emailId.length < 5 || emailId.trim() === '') {
      document.getElementById("emailExists").innerHTML = "Invalid email";
      button.setAttribute("disabled", "");
    } else if (!gmailRegex.test(emailId)) {
      document.getElementById("emailExists").innerHTML = "Must be a valid Gmail address";
      button.setAttribute("disabled", "");
    } else if (response.data === "email is exist") {
      document.getElementById("emailExists").innerHTML = "Email already exists";
      button.setAttribute("disabled", "");
    } else {
      document.getElementById("emailExists").innerHTML = "<span class='text-success'>Email accepted</span>";
      button.removeAttribute("disabled");
    }
  };

  function passwordd() {
    let pass = document.getElementById("pass").value;
    let button = document.getElementById("button");

    if (pass.trim() !== '' && pass.length >= 3 && pass.length <= 20) {
      document.getElementById("pasword").innerHTML = "";
      button.removeAttribute("disabled");
    } else {
      document.getElementById("pasword").innerHTML = "Enter valid password (3–20 characters)";
      button.setAttribute("disabled", "");
    }
  }

  function confirm() {
    let password = document.getElementById("pass").value;
    let confirmPassword = document.getElementById("confirmPassword").value;
    let button = document.getElementById("button");

    if (password === confirmPassword) {
      document.getElementById("errorConfirmPassword").innerHTML = "";
      button.removeAttribute("disabled");
    } else {
      document.getElementById("errorConfirmPassword").innerHTML = "Passwords do not match";
      button.setAttribute("disabled", "");
    }
  }
</script>

<footer class="bg-dark py-3 mt-auto">
  <div class="container text-center text-white">
    Copyright &copy; 2025, All Rights Reserved
  </div>
</footer>

</body>

</html>
