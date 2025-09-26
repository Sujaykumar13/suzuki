<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Suzuki</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
 <style>
   body {
     background-color: #f0f2f5;
     font-family: 'Segoe UI', sans-serif;
     padding-top: 70px;
     margin: 0;
   }

   header {
     position: fixed;
     top: 0; width: 100%; z-index: 1030;

   }

   .form-container {
     max-width: 450px;
     margin: auto;
     background-color: #ffffff;
     border-radius: 8px;
     box-shadow: 0 2px 8px rgba(0,0,0,0.15);
     padding: 20px;
   }

   .form-container h1 {
     font-size: 24px;
     font-weight: bold;
     margin-bottom: 20px;
     color: #333;
   }

   .form-label {
     font-weight: 500;
     margin-bottom: 5px;
   }

   .form-control {
     padding: 8px 12px;
     font-size: 14px;
   }

   .form-control:focus {
     box-shadow: 0 0 0 2px rgba(66, 103, 178, 0.2);
     border-color: #4267B2;
   }

   .btn-primary {
     background-color: #4267B2;
     border: none;
   }

   .btn-primary:hover {
     background-color: #365899;
   }

   .btn-secondary {
     background-color: #e4e6eb;
     color: #050505;
     border: none;
   }

   footer {
     background-color: rgba(0,0,0,0.8);
     color: #ccc;
     text-align: center;
     padding: 5px 0;
     font-size: 14px;
   }

   small {
     font-size: 12px;
   }

   .text-danger, .text-success {
     font-size: 13px;
   }

   .header-buttons .btn {
     background-color: #fff;
     color: #4267B2;
     border-color: #fff;
     font-weight: 500;
   }

   .header-buttons .btn:hover {
     background-color: #e7f0ff;
     border-color: #e7f0ff;
   }
 </style>

</head>
<body class="d-flex flex-column min-vh-100">

<header class="bg-dark text-white">
  <div class="d-flex justify-content-between align-items-center px-3 py-2">
    <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg"
         alt="Suzuki" width="50">
    <div>
      <a href="viewShowroom?emailId=${email}" class="btn btn-info btn-sm mr-2">View Showroom</a>
      <a href="back?emailId=${email}" class="btn btn-info btn-sm mr-2">Dashboard</a>
      <a href="logout?emailId=${email}" class="btn btn-info btn-sm">Logout</a>
    </div>
  </div>
</header>

<main class="d-flex flex-fill justify-content-center align-items-center">
  <div class="form-container">

    <div class="text-center mb-2">
      <span id="Message"></span>
    </div>
    <div class="text-center text-success fst-italic mb-2">
      <p>${msg}</p>
    </div>
    <div class="text-center text-danger fst-italic mb-3">
      <p>${error}</p>
    </div>

    <h1 class="text-center">Add Showroom</h1>

    <form action="showRoomData?emailId=${email}" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

      <div class="form-group">
        <label for="bName" class="form-label">Branch Name</label>
        <input type="text" class="form-control" name="branchName" id="bName" placeholder="Enter branch name" onchange="bNameValidation()" required>
        <small id="branchname" class="text-danger"></small>
      </div>

      <div class="form-group">
        <label for="locationn" class="form-label">Branch Location (Google Maps URL)</label>
        <input type="text" class="form-control" name="location" id="locationn" placeholder="https://www.google.com/maps/..." onchange="locationValidation()" required>
        <small id="Locate" class="text-danger"></small>
      </div>

      <div class="form-group">
        <label for="mName" class="form-label">Manager Name</label>
        <input type="text" class="form-control" name="branchManagerName" id="mName" placeholder="Enter manager name" onchange="managerValidation()" required>
        <small id="manager" class="text-danger"></small>
      </div>

      <div class="form-group">
        <label for="contactNo" class="form-label">Contact Number</label>
        <input type="text" class="form-control" name="contactNumber" id="contactNo" placeholder="10-digit number" onchange="phonee()" required maxlength="10">
        <small id="phone" class="text-danger"></small>
      </div>

      <div class="form-group">
        <label for="statuserror" class="form-label">Status</label>
        <select name="status" id="statuserror" class="form-control" onchange="statusValidation()" required>
          <option value="">Select</option>
          <option value="Active">Active</option>
          <option value="InActive">InActive</option>
          <option value="Under Maintenance">Under Maintenance</option>
        </select>
        <small id="statusss" class="text-danger"></small>
      </div>

      <div class="form-group">
        <label for="image" class="form-label">Image</label>
        <input type="file" class="form-control" name="file" id="image" onchange="validateImage()">
        <small id="imageError" class="text-danger"></small>
      </div>

      <div class="text-center mt-4">
        <button type="submit" id="button" class="btn btn-primary">Submit</button>
        <button type="reset" class="btn btn-secondary ml-2" onclick="resetForm()">Reset</button>
      </div>
    </form>
  </div>
</main>

 <script>


        function locationValidation() {
          var names = document.getElementById("locationn").value.trim();
          var button = document.getElementById("button");

          // Check if it includes the correct Google Maps URL structure
          const isGoogleMapsUrl = names.includes("https://www.google.com/maps");

          if (names !== '' && names.length > 5 && names.length <= 2000 && isGoogleMapsUrl) {
            document.getElementById("Locate").innerHTML = "";
            button.removeAttribute("disabled");
          } else if (!isGoogleMapsUrl) {
            document.getElementById("Locate").innerHTML = "<span style='color:red;'>Location must contain https://www.google.com/maps</span>";
            button.setAttribute("disabled", "");
          } else {
            document.getElementById("Locate").innerHTML = "<span style='color:red;'>Enter a valid location</span>";
            button.setAttribute("disabled", "");
          }
        }


        function managerValidation() {
          var names = document.getElementById("mName").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 5 && names.length <= 30) {
            document.getElementById("manager").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("manager").innerHTML = "<span style='color:red;'>enter valid maanger name</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function statusValidation() {
          const status = document.getElementById("statuserror").value;
          const statusError = document.getElementById("statusss");
          const button = document.getElementById("button");

          if (status === "") {
            statusError.innerHTML = "<span style='color:red;'>Please select a valid status</span>";
            button.setAttribute("disabled", "");
          } else {
            statusError.innerHTML = "";
            button.removeAttribute("disabled");
          }
        }

        function validateImage() {
          const fileInput = document.getElementById("image");
          const file = fileInput.files[0];
          const imageError = document.getElementById("imageError");
          const button = document.getElementById("button");

          // Clear previous error messages
          imageError.innerHTML = "";

          if (!file) {
            // No file selected
            imageError.innerHTML = "<span style='color:red;'>Please select a file</span>";
            button.setAttribute("disabled", "");
            return;
          }

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





        const phonee = async () => {

          let contactNumber = document.getElementById("contactNo").value
          console.log(contactNumber)
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/contactNumberExist?contactNumber=" + contactNumber)

          if (contactNumber.length < 10 || contactNumber.length > 10) {
            document.getElementById("phone").innerHTML = "<span style='color:red;'>invalid phone number</span>";
            button.setAttribute("disabled", "");
          }
          else if (response.data == "number is exist") {
            document.getElementById("phone").innerHTML = "<span style='color:red;'>phone number already exists</span>";
            button.setAttribute("disabled", "");
          }
          else {
            document.getElementById("phone").innerHTML = "<span style='color:green;'>valid</span>";
            button.removeAttribute("disabled");
          }

          console.log(response.data)

        }

        const bNameValidation = async () => {

          let branchh = document.getElementById("bName").value.trim();
          console.log(branchh);
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/branchName?branchName=" + branchh)

          if (branchh.length < 5) {
            document.getElementById("branchname").innerHTML = "<span style='color:red;'>invalid branch name</span>";
            button.setAttribute("disabled", "");
          } else if (response.data == "branch is exist") {
            document.getElementById("branchname").innerHTML = "<span style='color:red;'>branch name already exists</span>";
            button.setAttribute("disabled", "");
          } else if (branchh.trim() === "") {
            document.getElementById("branchname").innerHTML = "<span style='color:red;'>invalid branch name</span>";
            button.setAttribute("disabled", "");
          } else {
            document.getElementById("branchname").innerHTML = "<span style='color:green;'>branch name accepted</span>";
            button.removeAttribute("disabled");
          }
          console.log(response.data)

        }

        function resetForm() {
          // Clear all validation error spans
          document.getElementById("branchname").innerHTML = "";
          document.getElementById("Locate").innerHTML = "";
          document.getElementById("manager").innerHTML = "";
          document.getElementById("phone").innerHTML = "";
          document.getElementById("statusss").innerHTML = "";
          document.getElementById("imageError").innerHTML = "";
          document.getElementById("Message").innerHTML = "";

          // Clear server-side messages (if present in <p>${msg}</p> or <p>${error}</p>)
          const paragraphs = document.querySelectorAll(".fst-italic p");
          paragraphs.forEach(p => p.innerText = "");
        }




function validateForm() {
  var bName = document.getElementById("bName").value;
  var location = document.getElementById("locationn").value;
  var mName = document.getElementById("mName").value;
  var phoneNo = document.getElementById("contactNo").value;
  var images = document.getElementById("image").value;
  var status = document.getElementById("statuserror").value;
  var message = document.getElementById("Message");

  if (
    bName.trim() !== "" && bName.length > 5 && bName.length < 30 &&
    location.trim() !== "" && location.length > 0 && location.length < 2000 &&
    mName.trim() !== "" && mName.length > 5 && mName.length < 30 &&
    phoneNo.trim() !== "" && phoneNo.length === 10 &&
    images.trim() !== "" && status !== ""
  ) {
    message.innerHTML = "";
    return true; // ✅ allow form submission
  } else {
    message.innerHTML = "<span style='color:red;'>Please fill the form correctly</span>";
    return false; // ❌ prevent form submission
  }
}
      </script>

<footer class="mt-auto">
  <div class="text-center py-3">Copyright &copy; 2025, All Rights Reserved</div>
</footer>

</body>
</html>
