<%@ page isELIgnored="false" %>
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>suzuki</title>
      <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
      <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    </head>

    <style>
      header {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1030;
        /* Ensure it stays above other content */
      }

      body {
        padding-top: 70px;
        /* Adjust to prevent content being hidden behind the header */
      }
    </style>

    <body class="d-flex flex-column min-vh-100">
      <header class="bg-dark text-white">
        <div class="d-flex justify-content-between align-items-center px-3 py-2">
          <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo"
            width="50">

          <div class="d-flex align-items-center">
            <button type="button" class="btn btn-info btn-sm">
              <a href="userLogout?userEmailId=${userEmail}" style="color: white;">Logout</a>
            </button>
          </div>
        </div>
      </header>

<div class="min-vh-100 d-flex justify-content-center align-items-center" style="background: #d1ecf1;">

    <form action="updateUser" method="post" onsubmit="return form()" enctype="multipart/form-data"
          class="w-100" style="max-width: 600px;">

      <div class="card shadow-lg p-4 rounded bg-white">
<div class="text-center mb-3">
             <span id="Message"></span>



             <span class="text-center text-success fst-italic mb-2">${userMsg}</span>


             <span class="text-center text-danger fst-italic mb-4"> ${userError}</span>
           </div>

        <h2 class="text-center mb-4 text-primary">Edit Profile</h2>

       <div class="text-center mb-4">
  <img class="img-fluid rounded-circle shadow" style="max-width: 150px; height: 150px; object-fit: cover;"
       src="userImage?userImageFileName=${userDto.userImageFileName}" alt="User Image">
</div>

        <input type="hidden" name="id" value="${userDto.id}">

        <div class="form-group mb-3">
          <label for="fName">First Name</label>
          <input type="text" value="${userDto.firstName}" class="form-control" name="firstName" id="fName"
                 onchange="fNameValidation()" required>
          <small id="Firstname" class="text-danger"></small>
        </div>

        <div class="form-group mb-3">
          <label for="lName">Last Name</label>
          <input type="text" value="${userDto.lastName}" class="form-control" name="lastName" id="lName"
                 onchange="lNameValidation()" required>
          <small id="Lastname" class="text-danger"></small>
        </div>

        <div class="form-group mb-3">
          <label for="emailIdd">Email</label>
          <input type="email" value="${userDto.userEmailId}" class="form-control" name="userEmailId" id="emailIdd"
                 onchange="checkEmail()" readonly required>
          <small id="emailExists" class="text-danger"></small>
        </div>

        <div class="form-group mb-3">
          <label for="contactNo">Contact Number</label>
          <input type="number" value="${userDto.contactNumber}" class="form-control" name="contactNumber" id="contactNo"
                 onchange="phonee()" required>
          <small id="phone" class="text-danger"></small>
        </div>

        <div class="form-group mb-3">
          <label for="cityName">City</label>
          <input type="text" value="${userDto.city}" class="form-control" name="city" id="cityName"
                 onchange="cityNamee()" required>
          <small id="CityName" class="text-danger"></small>
        </div>

        <div class="form-group mb-4">
          <label>Gender</label>
          <div>
            <div class="form-check form-check-inline">
              <input type="radio" id="male" name="gender" value="male" class="form-check-input"
                ${userDto.gender == 'male' ? 'checked' : ''}>
              <label for="male" class="form-check-label">Male</label>
            </div>
            <div class="form-check form-check-inline">
              <input type="radio" id="female" name="gender" value="female" class="form-check-input"
                ${userDto.gender == 'female' ? 'checked' : ''}>
              <label for="female" class="form-check-label">Female</label>
            </div>
          </div>
          <small id="genderError" class="text-danger"></small>
        </div>

        <div class="form-group mb-4">
          <label for="reasonError">Reason for visit</label>
          <select name="reason" id="reasonError" onchange="reasonnValidation()" class="form-control" required>
            <option value="">Select</option>
            <option value="Test-Ride" ${userDto.reason == 'Test-Ride' ? 'selected' : ''}>Test-Ride</option>
            <option value="Bike-enquiry" ${userDto.reason == 'Bike-enquiry' ? 'selected' : ''}>Bike-enquiry</option>
            <option value="Purchase" ${userDto.reason == 'Purchase' ? 'selected' : ''}>Purchase</option>
          </select>
          <small id="reasonSpanError" class="text-danger"></small>
        </div>

        <input type="hidden" name="comments" value="${userDto.comments}">

         <div class="mb-4">
      <label for="image" class="form-label">Image</label>
      <input type="file" class="form-control" name="file" id="image" onblur="validateImage()">
      <small id="imageError" class="text-danger"></small>
    </div>

        <div class="text-center">
          <button type="submit" class="btn btn-primary px-4" id="button">Edit</button>
          <a href="userBackPage?userEmailId=${userDto.userEmailId}"
             class="btn btn-info px-4 ml-2" style="color: white; text-decoration: none;">Back</a>
        </div>

      </div>

    </form>
  </div>



 <script>
        function fNameValidation() {
          var names = document.getElementById("fName").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 3 && names.length <= 30) {
            document.getElementById("Firstname").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("Firstname").innerHTML = "<span style='color:red;'>enter valid first name</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function lNameValidation() {
          var names = document.getElementById("lName").value.trim();
          console.log(names)
          var button = document.getElementById("button");
          if (names.trim() !== '' && names.length > 0 && names.length <= 30) {
            document.getElementById("Lastname").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("Lastname").innerHTML = "<span style='color:red;'>enter valid last name</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function cityNamee() {
          var names = document.getElementById("cityName").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 5 && names.length <= 20) {
            document.getElementById("CityName").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("CityName").innerHTML = "<span style='color:red;'>enter valid city</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }


        function reasonnValidation() {
          const status = document.getElementById("reasonError").value;
          const statusError = document.getElementById("reasonSpanError");
          const button = document.getElementById("button");

          if (status === "") {
            statusError.innerHTML = "<span style='color:red;'>Please select a valid Reason</span>";
            button.setAttribute("disabled", "");
          } else {
            statusError.innerHTML = "";
            button.removeAttribute("disabled");
          }
        }

        const checkEmail = async () => {

          let emailId = document.getElementById("emailIdd").value;
          console.log(emailId);
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/userEmailExist?userEmailId=" + emailId)

          if (emailId.length < 5) {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>invalid email</span>";
            button.setAttribute("disabled", "");
          } else if (!emailId.includes("@gmail.com")) {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>Email must contain @gmail.com</span>";
            button.setAttribute("disabled", "");
          } else if (response.data == "email is exist") {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>email already exists</span>";
            button.setAttribute("disabled", "");
          } else {
            document.getElementById("emailExists").innerHTML = "<span style='color:green;'>email accepted</span>";
            button.removeAttribute("disabled");
          }
          console.log(response.data)

        }

        let originalContactNumber = document.getElementById("contactNo").value;

        const phonee = async () => {

          let contactNumber = document.getElementById("contactNo").value
          console.log(contactNumber)
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/userContactNumberExist?contactNumber=" + contactNumber)

           if (contactNumber === originalContactNumber) {
        document.getElementById("phone").innerHTML = "<span style='color:green;'>valid</span>";
        button.removeAttribute("disabled");
        return;
    }

          if (contactNumber.length < 10 || contactNumber.length > 10) {
            document.getElementById("phone").innerHTML = "<span style='color:red;'>invalid phone number</span>";
            button.setAttribute("disabled", "");
          } else if (response.data == "contact Number is exist") {
            document.getElementById("phone").innerHTML = "<span style='color:red;'>phone number already exists</span>";
            button.setAttribute("disabled", "");
          } else {
            document.getElementById("phone").innerHTML = "<span style='color:green;'>valid</span>";
            button.removeAttribute("disabled");
          }

          console.log(response.data)

        }

        function validateImage() {
          const fileInput = document.getElementById("image");
          const file = fileInput.files[0];
          const imageError = document.getElementById("imageError");
          const button = document.getElementById("button");

          // Clear previous error messages
          imageError.innerHTML = "";

          
          // Check file type
          const allowedTypes = ["image/jpeg", "image/png", "image/jpg", "image/webp"];
          if (!allowedTypes.includes(file.type)) {
            imageError.innerHTML = "<span style='color:red;'>Invalid file type. Only JPG, JPEG, PNG, and WEBP are allowed.</span>";
            button.setAttribute("disabled", "");
            return;
          }

          // Check file size (limit: 2MB)
          const maxSizeMB = 2;
          const maxSizeBytes = maxSizeMB * 1024 * 1024;
          if (file.size > maxSizeBytes) {
            imageError.innerHTML = `<span style='color:red;'>File size exceeds ${maxSizeMB}MB. Please select a smaller file.</span>`;
            button.setAttribute("disabled", "");
            return;
          }

          // Enable button if all validations pass
          button.removeAttribute("disabled");
        }


        function resetForm() {
          // Clear validation spans
          document.getElementById("Firstname").innerHTML = "";
          document.getElementById("Lastname").innerHTML = "";
          document.getElementById("emailExists").innerHTML = "";
          document.getElementById("phone").innerHTML = "";
          document.getElementById("CityName").innerHTML = "";
          document.getElementById("genderError").innerHTML = "";
          document.getElementById("reasonSpanError").innerHTML = "";
          document.getElementById("Message").innerHTML = "";

          // Clear server-side messages if applicable
          const serverMsg = document.querySelector("p");
          if (serverMsg) {
            serverMsg.innerText = "";
          }
        }


        function form(event) {

          var fName = document.getElementById("fName").value;
          var lName = document.getElementById("lName").value;
          var city = document.getElementById("cityName").value;
          var email = document.getElementById("emailId").value;
          var phoneNo = document.getElementById("contactNumber").value;
          var maleChecked = document.getElementById("male").checked;
          var femaleChecked = document.getElementById("female").checked;
          var reason = document.getElementById("reasonError").value;
          var button = document.getElementById("button");


          if (
            fName.trim() != "" && fName.length > 3 && fName.length < 20 &&
            lName.trim() !== "" && lName.length > 0 && lName.length < 20 &&
            city.trim() !== "" && city.length > 5 && city.length < 20 &&
            email.trim() !== "" &&
            phoneNo.trim() !== "" && phoneNo.length == 10 && reason !== ""
          ) {
            if (maleChecked || femaleChecked) {
              document.getElementById("Message").innerHTML = "";
              button.removeAttribute("disabled");
            } else {
              document.getElementById("Message").innerHTML = "<span style='color:red;'>Please fill the form correctly</span>";
              button.setAttribute("disabled", "");
            }

          } else {
            document.getElementById("Message").innerHTML = "<span style='color:red;'>Please fill the form correctly</span>";
            button.setAttribute("disabled", "");
          }
        }


      </script>

      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
     

      <footer class="bg-dark py-3 mt-auto">
        <div class="container">
          <div class="row text-center text-md-left">
            <div class="col-md-4 offset-md-4 mb-2 mb-md-0 d-flex justify-content-center text-white">
              <span>Copyright &copy; 2025, All Rights Reserved</span>
            </div>
          </div>
        </div>
      </footer>


    </body>

    </html>