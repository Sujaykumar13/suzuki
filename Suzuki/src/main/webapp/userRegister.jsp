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
    z-index: 1030; /* Ensure it stays above other content */
  }

  body {
    padding-top: 70px; /* Adjust to prevent content being hidden behind the header */
  }
</style>
    <body class="d-flex flex-column min-vh-100">
      <header class="bg-dark text-white">
        <div class="d-flex justify-content-between align-items-center px-3 py-2">
          <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo"
            width="50">

          <div class="d-flex align-items-center">
            <!-- Dropdown Menu for Navigation Links -->
            <div class="dropdown mr-2">
              <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="menuDropdown" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">
                Menu
              </button>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="menuDropdown">
                <a class="dropdown-item" href="viewShowroom?emailId=${email}">View Showroom</a>
                <a class="dropdown-item" href="addShowroom?emailId=${email}">Add Showroom</a>
                <a class="dropdown-item" href="viewBike?emailId=${email}">View Bike</a>
                <a class="dropdown-item" href="addBike?emailId=${email}">Add Bike</a>
                <a class="dropdown-item" href="userRegister?emailId=${email}">User Register</a>
                <a class="dropdown-item" href="userProfile?emailId=${email}">User Profiles</a>
                <a class="dropdown-item" href="back?emailId=${email}">Dashboard</a>
              </div>
            </div>

            <!-- Logout Button (outside dropdown) -->
            <button type="button" class="btn btn-info btn-sm">
              <a href="logout?emailId=${email}" style="color: white;">Logout</a>
            </button>
          </div>
        </div>
      </header>


     <div class="min-vh-100 d-flex justify-content-center align-items-center" style="background: linear-gradient(to right, #43cea2, #185a9d);">

       <form action="formdata?emailId=${email}" method="post" onsubmit="return validateForm()"
             class="w-100" style="max-width: 700px;">

         <div class="card shadow-lg p-4 bg-light rounded">

           <div class="text-center mb-3">
             <span id="Message"></span>



             <span class="text-center text-success fst-italic mb-2">${userMsg}</span>


             <span class="text-center text-danger fst-italic mb-4"> ${userError}</span>
           </div>

           <h2 class="text-center mb-4 text-primary">User Register</h2>

           <div class="form-row mb-3">
             <div class="form-group col-md-6">
               <label for="fName">First Name</label>
               <input type="text" placeholder="Enter first name" class="form-control" name="firstName" id="fName"
                      onchange="fNameValidation()" required>
               <small id="Firstname" class="text-danger"></small>
             </div>
             <div class="form-group col-md-6">
               <label for="lName">Last Name</label>
               <input type="text" placeholder="Enter last name" class="form-control" name="lastName" id="lName"
                      onchange="lNameValidation()" required>
               <small id="Lastname" class="text-danger"></small>
             </div>
           </div>

           <div class="form-row mb-3">
             <div class="form-group col-md-6">
               <label for="emailIdd">Email</label>
               <input type="email" placeholder="Enter email" class="form-control" name="userEmailId" id="emailIdd"
                      onchange="checkEmail()" required>
               <small id="emailExists" class="text-danger"></small>
             </div>
             <div class="form-group col-md-6">
               <label for="contactNo">Contact Number</label>
               <input type="number" placeholder="Enter mobile number" class="form-control" name="contactNumber" id="contactNo"
                      onchange="phonee()" required>
               <small id="phone" class="text-danger"></small>
             </div>
           </div>

           <div class="form-row mb-3">
             <div class="form-group col-md-6">
               <label for="cityName">City</label>
               <input type="text" placeholder="Enter city name" class="form-control" name="city" id="cityName"
                      onchange="cityNamee()" required>
               <small id="CityName" class="text-danger"></small>
             </div>
             <div class="form-group col-md-6">
               <label>Gender</label>
               <div>
                 <div class="form-check form-check-inline">
                   <input type="radio" id="male" name="gender" value="male" class="form-check-input">
                   <label for="male" class="form-check-label">Male</label>
                 </div>
                 <div class="form-check form-check-inline">
                   <input type="radio" id="female" name="gender" value="female" class="form-check-input">
                   <label for="female" class="form-check-label">Female</label>
                 </div>
               </div>
               <small id="genderError" class="text-danger"></small>
             </div>
           </div>

           <div class="form-group mb-4">
             <label for="reasonError">Reason for visit</label>
             <select name="reason" id="reasonError" onchange="reasonnValidation()" class="form-control" required>
               <option value="">Select</option>
               <option value="Test-Ride">Test-Ride</option>
               <option value="Bike-enquiry">Bike-enquiry</option>
               <option value="Purchase">Purchase</option>
             </select>
             <small id="reasonSpanError" class="text-danger"></small>
           </div>

           <div class="form-group text-center">
             <button type="submit" id="button" class="btn btn-primary px-4">Submit</button>
             <button type="reset" class="btn btn-secondary px-4 ml-2" onclick="resetForm()">Reset</button>
           </div>

         </div>
       </form>

     </div>




      <script>
       function fNameValidation() {
         var names = document.getElementById("fName").value;
         var trimmedName = names.trim(); // trim once and reuse
         console.log(names);
         var button = document.getElementById("button");

         if (trimmedName !== '' && trimmedName.length > 3 && trimmedName.length <= 30) {
           document.getElementById("Firstname").innerHTML = "";
           button.removeAttribute("Disabled");
         } else {
           document.getElementById("Firstname").innerHTML = "<span style='color:red;'>enter valid first name</span>";
           button.setAttribute("Disabled", "");
           return;
         }
       }

        function lNameValidation() {
          var names = document.getElementById("lName").value;
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
          const gmailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
          const response = await axios("http://localhost:8080/Suzuki/userEmailExist?userEmailId=" + emailId)



          if (emailId.length < 5) {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>invalid email</span>";
            button.setAttribute("disabled", "");
          }
         else if (!gmailRegex.test(emailId)) {
                 document.getElementById("emailExists").innerHTML = "<span class='text-danger'>Must be a valid Gmail address</span>";
                 button.setAttribute("disabled", "");
               } else if (response.data == "email is exist") {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>email already exists</span>";
            button.setAttribute("disabled", "");
          } else if (emailId.trim() === '') {
            document.getElementById("emailExists").innerHTML = "<span style='color:red;'>invalid email</span>";
            button.setAttribute("disabled", "");
          }
          else {
            document.getElementById("emailExists").innerHTML = "<span style='color:green;'>email accepted</span>";
            button.removeAttribute("disabled");
          }
          console.log(response.data)

        }

        const phonee = async () => {

          let contactNumber = document.getElementById("contactNo").value
          console.log(contactNumber)
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/userContactNumberExist?contactNumber=" + contactNumber)

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


       function validateForm() {
         var fName = document.getElementById("fName").value.trim();
         var lName = document.getElementById("lName").value.trim();
         var emailId = document.getElementById("emailIdd").value.trim();
         var contactNo = document.getElementById("contactNo").value.trim();
         var city = document.getElementById("cityName").value.trim();
         var genderMale = document.getElementById("male").checked;
         var genderFemale = document.getElementById("female").checked;
         var reason = document.getElementById("reasonError").value;
         var message = document.getElementById("Message");

         // Name Validation
         if (fName.length <= 3 || fName.length > 30) {
           message.innerHTML = "<span style='color:red;'>Enter a valid First Name</span>";
           return false;
         }

         if (lName.length === 0 || lName.length > 30) {
           message.innerHTML = "<span style='color:red;'>Enter a valid Last Name</span>";
           return false;
         }

         // Email Validation
         if (emailId.length < 5 || !emailId.includes("@gmail.com")) {
           message.innerHTML = "<span style='color:red;'>Enter a valid Gmail address</span>";
           return false;
         }

         // Phone Number Validation
         if (contactNo.length !== 10 || isNaN(contactNo)) {
           message.innerHTML = "<span style='color:red;'>Enter a valid 10-digit contact number</span>";
           return false;
         }

         // City Validation
         if (city.length <= 5 || city.length > 20) {
           message.innerHTML = "<span style='color:red;'>Enter a valid city name</span>";
           return false;
         }

         // Gender Validation
         if (!genderMale && !genderFemale) {
           document.getElementById("genderError").innerHTML = "<span style='color:red;'>Please select gender</span>";
           return false;
         } else {
           document.getElementById("genderError").innerHTML = "";
         }

         // Reason for visit
         if (reason === "") {
           document.getElementById("reasonSpanError").innerHTML = "<span style='color:red;'>Please select a valid reason</span>";
           return false;
         } else {
           document.getElementById("reasonSpanError").innerHTML = "";
         }

         // Clear message if all valid
         message.innerHTML = "";
         return true;
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