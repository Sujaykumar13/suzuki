<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
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

  <body class="d-flex flex-column min-vh-100">
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
    <header class="bg-dark text-white">
      <div class="d-flex justify-content-between align-items-center px-3 py-2">
        <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="suzuki Logo"
          width="50">
        <div>
          <button type="button" class="btn btn-info btn-sm mr-2"><a href="viewShowroom?emailId=${email}" style="color: white;" role="button">View
              Showroom</a></button>
          <button type="button" class="btn btn-info btn-sm"><a href="logout?emailId=${email}"
              style="color: white;" role="button">Logout</a></button>
        </div>
      </div>
    </header>
<form action="updateShowRoomData?emailId=${email}" method="post" onclick="form()"
      class="shadow-lg p-3 mb-5 bg-info rounded d-flex justify-content-center align-items-center min-vh-100"
      enctype="multipart/form-data">

  <div class="card p-4 w-100" style="max-width: 600px;">
    <span id="Message" class="d-block mb-3"></span>

    <h1 class="text-center mb-4">Edit Showroom Details</h1>

    <div class="text-center mb-4">
      <img class="img-fluid" style="max-width: 150px; height: auto;"
           src="image?showRoomImageFileName=${dto.showRoomImageFileName}" alt="Showroom Image">
    </div>

    <input type="hidden" name="id" value="${dto.id}" readonly>

    <div class="mb-3">
      <label for="bName" class="form-label">Branch Name</label>
      <input type="text" value="${dto.branchName}" class="form-control" name="branchName" id="bName"
             onchange="bNameValidation()" required readonly>
      <small id="branchname" class="text-danger"></small>
    </div>

    <div class="mb-3">
      <label for="locationn" class="form-label">Branch Location</label>
      <input type="text" value="${dto.location}" class="form-control" name="location" id="locationn"
             onchange="locationValidation()" required>
      <small id="Locate" class="text-danger"></small>
    </div>

    <div class="mb-3">
      <label for="mName" class="form-label">Manager Name</label>
      <input type="text" value="${dto.branchManagerName}" class="form-control" name="branchManagerName" id="mName"
             onchange="managerValidation()" required>
      <small id="manager" class="text-danger"></small>
    </div>

    <div class="mb-3">
      <label for="contactNo" class="form-label">Contact Number</label>
      <input type="number" value="${dto.contactNumber}" class="form-control" name="contactNumber" id="contactNo"
             onchange="phonee()" required>
      <small id="phone" class="text-danger"></small>
    </div>

    <div class="mb-3">
      <label for="statuserror" class="form-label">Choose a Status</label>
      <select name="status" id="statuserror" onchange="statusValidation()" class="form-control" required>
        <option value="">Select</option>
        <option value="Active" ${dto.status == 'Active' ? "selected" : ""}>Active</option>
        <option value="InActive" ${dto.status == 'InActive' ? "selected" : ""}>InActive</option>
        <option value="Under Maintanence" ${dto.status == 'Under Maintanence' ? "selected" : ""}>Under Maintanence</option>
      </select>
      <small id="statusss" class="text-danger"></small>
    </div>

    <div class="mb-4">
      <label for="image" class="form-label">Image</label>
      <input type="file" class="form-control" name="file" id="image" onblur="validateImage()">
      <small id="imageError" class="text-danger"></small>
    </div>

    <div class="text-center">
      <input type="submit" id="button" class="btn btn-primary me-2" value="Edit" style="color: white;">
      <button type="button" class="btn btn-primary">
        <a href="viewShowroom?emailId=${email}" class="text-white text-decoration-none">Back</a>
      </button>
    </div>

  </div>
</form>

    <script>

      function locationValidation() {
        var names = document.getElementById("locationn").value;
        console.log(names)
        var button = document.getElementById("button");

        if (names.trim() !== '' && names.length > 5 && names.length <= 200) {
          document.getElementById("Locate").innerHTML = "";
          button.removeAttribute("Disabled");
        } else {
          document.getElementById("Locate").innerHTML = "<span style='color:red;'>enter valid location</span>";
          button.setAttribute("Disabled", "");
          return;
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

let originalContactNumber = document.getElementById("contactNo").value;

       const phonee = async () => {

        let contactNumber = document.getElementById("contactNo").value
        console.log(contactNumber)
        var button = document.getElementById("button");
        const response = await axios("http://localhost:8080/Suzuki/contactNumberExist?contactNumber=" + contactNumber)

         if (contactNumber === originalContactNumber) {
        document.getElementById("phone").innerHTML = "<span style='color:green;'>valid</span>";
        button.removeAttribute("disabled");
        return;
    }

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
          } else {
            document.getElementById("branchname").innerHTML = "<span style='color:green;'>branch name accepted</span>";
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


        const dto = { status: "${dto.status}" };
                document.getElementById(dto.status).selected = true;



        

        function form(event) {

          var bName = document.getElementById("bName").value;
          var location = document.getElementById("locationn").value;
          var mName = document.getElementById("mName").value;
          var phoneNo = document.getElementById("contactNumber").value;
          var button = document.getElementById("button");
          var status = document.getElementById("statuserror").value;


          if (
            bName.trim() !="" && bName.length > 5 && bName.length <30 &&
            location.trim() !== "" && location.length > 0 &&  location.length < 200 &&
            mName.trim() !== "" && mName.length > 5 && mName.length <30 &&
            phoneNo.trim() !== "" && phoneNo.length == 10 && status!==""
          ) {
              document.getElementById("Message").innerHTML = "";
              button.removeAttribute("disabled");
            }
             else {
            document.getElementById("Message").innerHTML = "<span style='color:red;'>Please fill the form correctly</span>";
            button.setAttribute("disabled", "");
          }
        }


    </script>


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