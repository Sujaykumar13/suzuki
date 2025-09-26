<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Suzuki - OTP Verification</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    body {
      background: linear-gradient(to right, #283c86, #45a247);
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

    .otp-card {
      border-radius: 15px;
      transition: all 0.3s ease-in-out;
    }

    .otp-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
    }

    .slogan {
      font-size: 1.6rem;
      font-weight: bold;
      color: #fff;
      text-shadow: 1px 1px 3px black;
      margin-top: 20px;
    }

    .bike-image {
      width: 100%;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
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
    <div class="d-flex justify-content-between align-items-center px-3 py-2">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="suzuki Logo" width="50" />
      <div>
        <button type="button" class="btn btn-info btn-sm mr-2">
          <a href="home" style="color: white;">Home</a>
        </button>
      </div>
    </div>
  </header>

  <div class="container-fluid main-content">
    <div class="row">
      <!-- Left: Image and slogan -->
      <div class="col-md-7 d-flex flex-column justify-content-center align-items-start text-white pl-5">
        <img src="https://i.pinimg.com/736x/99/8b/ea/998beaf09f1bb959eb185189f11c71a4.jpg" class="bike-image mb-4" alt="Suzuki Bike" />
        <div class="slogan">
          Every ride begins with trust —<br />
          verify to ignite.
        </div>
      </div>

      <!-- Right: OTP Card -->
      <div class="col-md-5 d-flex justify-content-end align-items-start">

        <div class="card otp-card bg-white shadow p-4 mt-3 w-100" style="max-width: 400px;">
          <!-- Send OTP Form -->

                      <span class="text-center text-danger fst-italic mb-4">${blocked}</span>

          <form action="sendUserOtp" method="post" id="otpForm">
            <h5 class="text-center mb-3">Email Verification</h5>
            <div class="form-group">
              <label>Email</label>
              <input type="email" placeholder="Enter Email" class="form-control" name="userEmailId" id="emailIdd"
                onchange="checkEmail()" readonly value="${userEmail}" required>
              <small id="emailExists" class="form-text text-danger"></small>
            </div>

            <button type="submit" class="btn btn-secondary btn-block" id="sendingOtpBtn">Send OTP</button>

            <div class="text-success text-center mt-2">
              <p class="font-italic">${otpmsg}</p>
            </div>
            <div class="text-warning text-center mt-1">
              <span id="otpTimer" class="font-italic"></span>
            </div>
          </form>

          <hr />

          <!-- Verify OTP Form -->
          <form action="verificationUserOTP" method="post">
            <input type="email" class="form-control" name="userEmailId" value="${userEmail}" hidden />
            <div class="form-group">
              <label>Enter OTP</label>
              <input type="text" class="form-control" name="otp" required />
            </div>

            <div class="text-danger font-italic text-center">
              <p>${verifymsg}</p>
            </div>

            <button type="submit" class="btn btn-success btn-block" id="verifyOtp">Submit</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script>
    const checkEmail = async () => {
      let emailId = document.getElementById("emailIdd").value;
      const feedback = document.getElementById("emailExists");
      const button = document.getElementById("sendingOtpBtn");
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
          feedback.innerHTML = "Email already exists";
          button.setAttribute("disabled", "");
        } else {
          feedback.innerHTML = "<span class='text-success'>Email accepted</span>";
          button.removeAttribute("disabled");
        }
      } catch (error) {
        feedback.innerHTML = "Error validating email";
        button.setAttribute("disabled", "");
      }
    };
  </script>

  <script>
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
        startTimer(120, otpTimer, sendOtpBtn);
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
