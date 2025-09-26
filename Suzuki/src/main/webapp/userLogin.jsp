<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Suzuki - User Login</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    body {
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
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

    .main-content {
      margin-top: 80px;
      flex-grow: 1;
    }

    .slogan {
      font-size: 1.8rem;
      font-weight: bold;
      color: white;
      text-shadow: 1px 1px 3px black;
      margin-top: 20px;
    }

    .login-card {
      border-radius: 15px;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .login-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
    }

    .bike-image {
      max-width: 100%;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
    }

    footer {
      margin-top: auto;
    }

    label {
      font-weight: 500;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100">
  <header class="bg-dark text-white">
    <div class="d-flex justify-content-between align-items-center px-3 py-2">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo" width="50" />
      <div>
        <button type="button" class="btn btn-info btn-sm mr-2">
          <a href="home" style="color: white;" role="button">Home</a>
        </button>
      </div>
    </div>
  </header>

  <div class="container-fluid main-content">
    <div class="row">
      <!-- Left image & slogan -->
      <div class="col-md-7 d-flex flex-column justify-content-center align-items-start text-white pl-5">
        <img src="https://wallpapercat.com/w/full/2/7/a/94657-3840x2160-desktop-4k-suzuki-hayabusa-wallpaper-photo.jpg" class="bike-image mb-4" alt="Suzuki Bike Image" />
        <div class="slogan">
          Unleash your freedom<br />
          with every ride.
        </div>
      </div>

      <!-- Login Card -->
      <div class="col-md-5 d-flex justify-content-center align-items-start">
        <div class="card login-card bg-white shadow p-4 mt-3 w-100" style="max-width: 400px;">
          <h4 class="text-center mb-4">User Login</h4>

          <form action="userLogin" method="post">
            <div class="form-group">
              <label for="emailIdd">Email</label>
              <input type="email" placeholder="Enter Email" class="form-control" name="userEmailId" id="emailIdd"
                onchange="checkEmail()" required value="${userEmail}">
              <small id="emailExists" class="form-text text-danger"></small>
            </div>

            <div class="form-group">
              <label for="pass">Password</label>
              <input type="password" placeholder="Enter password" class="form-control" name="password" id="pass"
                onchange="passwordd()" required>
              <small id="pasword" class="form-text text-danger"></small>
            </div>

            <div class="text-danger fst-italic">
              <p>${verifypassword}</p>
            </div>

            <button type="submit" class="btn btn-success btn-block" id="button">Login</button>

           <div class="text-center mt-3">
             <a href="#" data-toggle="modal" data-target="#forgotPasswordModal">Forgot password?</a>
           </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="forgotPasswordModal" tabindex="-1" role="dialog" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title" id="forgotPasswordModalLabel">Reset Password</h5>
          <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="forgot" method="post">
            <div class="form-group">
              <label for="forgotEmail">Enter your registered Gmail</label>
             <input type="email" placeholder="Enter Email" class="form-control" name="userEmailId" id="emailId"
                             onchange="checkEmailPopUP()" required value="${userEmail}">
                           <small id="emailExist" class="form-text text-danger"></small>
            </div>
            <button type="submit" class="btn btn-primary" id="forgotSubmit" >Submit</button>
          </form>
        </div>
      </div>
    </div>
  </div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
  <script>
    const checkEmail = async () => {
      let emailId = document.getElementById("emailIdd").value;
      const feedback = document.getElementById("emailExists");
      const button = document.getElementById("button");
      const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;

      try {
        const response = await axios("http://localhost:8080/Suzuki/userEmailExist?userEmailId=" + emailId);

        if (emailId.length < 5 || emailId.trim() === '') {
          feedback.innerHTML = "Invalid email";
          button.setAttribute("disabled", "");
        } else if (!gmailRegex.test(emailId)) {
          feedback.innerHTML = "Must be a valid Gmail address";
          button.setAttribute("disabled", "");
        } else if (response.data === "email is exist") {
          feedback.innerHTML = "<span class='text-success'>Email accepted</span>";
          button.removeAttribute("disabled");
        } else {
          feedback.innerHTML = "Email not found";
          button.setAttribute("disabled", "");
        }
      } catch (error) {
        feedback.innerHTML = "Error checking email";
        button.setAttribute("disabled", "");
      }
    };

     const checkEmailPopUP = async () => {
          let emailId = document.getElementById("emailId").value;
          const feedback = document.getElementById("emailExist");
          const button = document.getElementById("forgotSubmit");
          const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;

          try {
            const response = await axios("http://localhost:8080/Suzuki/userEmailExist?userEmailId=" + emailId);

            if (emailId.length < 5 || emailId.trim() === '') {
              feedback.innerHTML = "Invalid email";
              button.setAttribute("disabled", "");
            } else if (!gmailRegex.test(emailId)) {
              feedback.innerHTML = "Must be a valid Gmail address";
              button.setAttribute("disabled", "");
            } else if (response.data === "email is exist") {
              feedback.innerHTML = "<span class='text-success'>Email accepted</span>";
              button.removeAttribute("disabled");
            } else {
              feedback.innerHTML = "Email not found";
              button.setAttribute("disabled", "");
            }
          } catch (error) {
            feedback.innerHTML = "Error checking email";
            button.setAttribute("disabled", "");
          }
        };

    function passwordd() {
      const password = document.getElementById("pass").value;
      const feedback = document.getElementById("pasword");
      const button = document.getElementById("button");

      if (password.trim() !== '' && password.length >= 3 && password.length <= 20) {
        feedback.innerHTML = "";
        button.removeAttribute("disabled");
      } else {
        feedback.innerHTML = "Enter valid password";
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
