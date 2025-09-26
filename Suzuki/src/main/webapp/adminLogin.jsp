<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Suzuki</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <style>
    body {
      background: linear-gradient(to right, #001f3f, #0074d9);
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

<body>
  <header class="bg-dark text-white">
    <div class="d-flex justify-content-between align-items-center px-2 py-1">
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
        <img src="https://c4.wallpaperflare.com/wallpaper/350/277/139/motorcycles-suzuki-wallpaper-preview.jpg" class="bike-image mb-4" alt="Suzuki Bike" />
        <div class="slogan">
          Ride with Power.<br />
          Rule the Roads with Suzuki.
        </div>
      </div>

      <!-- Login Card -->
      <div class="col-md-5 d-flex justify-content-center align-items-start">
        <div class="card login-card bg-white shadow p-4 mt-3 w-100" style="max-width: 400px;">
          <h4 class="text-center mb-4">Admin Login</h4>

          <!-- Send OTP Form -->
          <form action="sendOtp" method="post">
            <div class="form-group">
              <label for="email">Email ID</label>
              <input type="email" class="form-control" id="email" name="emailId" placeholder="Enter your Gmail" value="${email}" onchange="checkEmail()" required />
              <small id="emailExists" class="form-text mt-1"></small>
            </div>

            <button type="submit" class="btn btn-secondary btn-block" id="sendingOtpBtn">Send OTP</button>

            <div class="text-center text-success fst-italic mt-2">
              <p>${otpmsg}</p>
            </div>

            <div class="text-center text-warning mt-2">
              <span id="otpTimer"></span>
            </div>
          </form>

          <!-- Verify OTP Form -->
          <form action="verificationOTP" method="post" class="mt-4">
            <input type="email" class="form-control" name="emailId" value="${email}" hidden />

            <div class="form-group">
              <label for="otp">OTP</label>
              <input type="text" class="form-control" name="otp" placeholder="Enter OTP" />
            </div>

            <div class="text-danger fst-italic">
              <p>${verifymsg}</p>
            </div>

            <button type="submit" class="btn btn-success btn-block" id="verifyOtp">Login</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script>
    const checkEmail = () => {
      const emailId = document.getElementById("email").value.trim();
      const feedback = document.getElementById("emailExists");
      const sendBtn = document.getElementById("sendingOtpBtn");
      const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;

      if (emailId.length < 5) {
        feedback.innerHTML = "<span class='text-danger'>Invalid email</span>";
        sendBtn.setAttribute("disabled", "");
      } else if (!gmailRegex.test(emailId)) {
        feedback.innerHTML = "<span class='text-danger'>Must be a valid Gmail address</span>";
        sendBtn.setAttribute("disabled", "");
      } else {
        feedback.innerHTML = "<span class='text-success'>Email accepted</span>";
        sendBtn.removeAttribute("disabled");
      }
    };

    function startTimer(duration, display, button) {
      let timer = duration, minutes, seconds;

      const interval = setInterval(function () {
        minutes = Math.floor(timer / 60);
        seconds = timer % 60;

        minutes = minutes < 10 ? '0' + minutes : minutes;
        seconds = seconds < 10 ? '0' + seconds : seconds;

        display.textContent = "Please wait " + minutes + ":" + seconds + " to resend OTP";

        if (--timer < 0) {
          clearInterval(interval);
          display.textContent = "";
          button.disabled = false;
        }
      }, 1000);
    }

    document.addEventListener("DOMContentLoaded", function () {
      const sendOtpBtn = document.getElementById("sendingOtpBtn");
      const otpTimer = document.getElementById("otpTimer");

      const otpMsg = "${otpmsg}";
      if (otpMsg && otpMsg.trim() !== "") {
        sendOtpBtn.disabled = true;
        startTimer(120, otpTimer, sendOtpBtn); // 2-minute timer
      }
    });
  </script>

  <footer class="bg-dark py-3 mt-auto">
    <div class="container text-center text-white">
      Copyright &copy; 2025, All Rights Reserved
    </div>
  </footer>
</body>

</html>
