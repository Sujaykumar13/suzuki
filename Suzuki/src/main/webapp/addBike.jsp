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
            <button type="button" class="btn btn-info btn-sm mr-2"><a href="viewShowroom?emailId=${email}"
                style="color: white;" role="button">View
                Showroom</a></button>
            <button type="button" class="btn btn-info btn-sm mr-2"><a href="addShowroom?emailId=${email}"
                style="color: white;" role="button">Add Showroom</a></button>
            <button type="button" class="btn btn-info btn-sm mr-2"><a href="viewBike?emailId=${email}"
                style="color: white;">View Bike</a></button>

            <button type="button" class="btn btn-info btn-sm"><a href="back?emailId=${email}"
                style="color: white;" role="button">Dashboard</a></button>
                <button type="button" class="btn btn-info btn-sm"><a href="logout?emailId=${email}"
                                style="color: white;" role="button">Logout</a></button>
          </div>
        </div>
      </header>

<!-- Full page gradient background -->
<div class="min-vh-100 d-flex justify-content-center align-items-center" style="background: linear-gradient(to right, #667eea, #764ba2);">

  <form action="addBikeData?emailId=${email}" method="post" enctype="multipart/form-data"
        class="w-100" style="max-width: 800px;">

    <div class="card shadow-lg p-4 bg-light rounded">

      <!-- Messages -->
      <div class="text-center mb-2">
        <span id="Message"></span>

      <span>${msg}</span>
      <span>${error}</span>
      </div>

      <h2 class="text-center text-primary mb-4">Bike Details</h2>

      <!-- Name & Model -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Bike Name</label>
          <input type="text" class="form-control" name="bikeName" id="bName" placeholder="Enter bike name" onchange="bNameValidation()" required>
          <small id="bikeError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>Model</label>
          <input type="text" class="form-control" name="bikeModel" id="model" placeholder="Enter model" onchange="modelValidation()" required>
          <small id="modelError" class="text-danger"></small>
        </div>
      </div>

      <!-- Price & Engine -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Price</label>
          <input type="number" class="form-control" name="price" id="bikePrice" placeholder="Enter price" onchange="priceValidation()" required>
          <small id="priceError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>Engine Capacity</label>
          <input type="text" class="form-control" name="engineCapacity" id="engine" placeholder="Enter engine capacity" onchange="engineValidation()" required>
          <small id="engineError" class="text-danger"></small>
        </div>
      </div>

      <!-- Mileage & Fuel -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Mileage</label>
          <input type="text" class="form-control" name="milege" id="bikeMilege" placeholder="Enter mileage" onchange="milegeValidation()" required>
          <small id="milegeError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>Fuel Capacity</label>
          <input type="text" class="form-control" name="fuelCapacity" id="fuel" placeholder="Enter fuel capacity" onchange="fuelValidation()" required>
          <small id="fuelError" class="text-danger"></small>
        </div>
      </div>

      <!-- Front & Left Image -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Front Image</label>
          <input type="file" class="form-control" name="front" id="frontImage" onblur="frontValidation()">
          <small id="frontError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>Left Image</label>
          <input type="file" class="form-control" name="left" id="leftImage" onblur="leftValidation()">
          <small id="leftError" class="text-danger"></small>
        </div>
      </div>

      <!-- Back & Right Image -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Back Image</label>
          <input type="file" class="form-control" name="back" id="backImage" onblur="backValidation()">
          <small id="backError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>Right Image</label>
          <input type="file" class="form-control" name="right" id="rightImage" onblur="rightValidation()">
          <small id="rightError" class="text-danger"></small>
        </div>
      </div>

      <!-- Top & 3D Image -->
      <div class="form-row">
        <div class="form-group col-md-6">
          <label>Top Image</label>
          <input type="file" class="form-control" name="top" id="topImage" onblur="topValidation()">
          <small id="topError" class="text-danger"></small>
        </div>
        <div class="form-group col-md-6">
          <label>3D Image</label>
          <input type="file" class="form-control" name="d3" id="d3Image" onblur="d3Validation()">
          <small id="d3Error" class="text-danger"></small>
        </div>
      </div>

      <!-- Buttons -->
      <div class="form-group text-center mt-4">
        <button type="submit" id="button" class="btn btn-success px-4">Submit</button>
        <button type="reset" class="btn btn-danger px-4 ml-2" onclick="resetForm()">Reset</button>
      </div>

    </div>
  </form>
</div>


      <script>

        function priceValidation() {
          var names = document.getElementById("bikePrice").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 5 && names.length <= 20) {
            document.getElementById("").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("priceError").innerHTML = "<span style='color:red;'>enter valid price</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function engineValidation() {
          var names = document.getElementById("engine").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 2 && names.length <= 30) {
            document.getElementById("engineError").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("engineError").innerHTML = "<span style='color:red;'>enter valid value</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function milegeValidation() {
          var names = document.getElementById("bikeMilege").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 2 && names.length <= 30) {
            document.getElementById("milegeError").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("milegeError").innerHTML = "<span style='color:red;'>enter valid value</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function fuelValidation() {
          var names = document.getElementById("fuel").value.trim();
          console.log(names)
          var button = document.getElementById("button");

          if (names.trim() !== '' && names.length > 2 && names.length <= 30) {
            document.getElementById("fuelError").innerHTML = "";
            button.removeAttribute("Disabled");
          } else {
            document.getElementById("fuelError").innerHTML = "<span style='color:red;'>enter valid value</span>";
            button.setAttribute("Disabled", "");
            return;
          }
        }

        function leftValidation() {
          const fileInput = document.getElementById("leftImage");
          const file = fileInput.files[0];
          const imageError = document.getElementById("leftError");
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


        function backValidation() {
          const fileInput = document.getElementById("backImage");
          const file = fileInput.files[0];
          const imageError = document.getElementById("backError");
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



        function rightValidation() {
          const fileInput = document.getElementById("rightImage");
          const file = fileInput.files[0];
          const imageError = document.getElementById("rightError");
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

        function topValidation() {
          const fileInput = document.getElementById("topImage");
          const file = fileInput.files[0];
          const imageError = document.getElementById("topError");
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

        function frontValidation() {
          const fileInput = document.getElementById("frontImage");
          const file = fileInput.files[0];
          const imageError = document.getElementById("frontError");
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


        function d3Validation() {
          const fileInput = document.getElementById("d3Image");
          const file = fileInput.files[0];
          const imageError = document.getElementById("d3Error");
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



        const bNameValidation = async () => {

          var bike = document.getElementById("bName").value.trim();
          console.log(bike);
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/bikeNameExists?bikeName=" + bike)



          if (bike.length < 3) {
            document.getElementById("bikeError").innerHTML = "<span style='color:red;'>invalid bike name</span>";
            button.setAttribute("disabled", "");
          } else if (response.data == "bike name is exist") {
            document.getElementById("bikeError").innerHTML = "<span style='color:red;'>bike name already exists</span>";
            button.setAttribute("disabled", "");
          } else if (bike.trim() === '') {
            document.getElementById("bikeError").innerHTML = "<span style='color:red;'>invalid bike name</span>";
            button.setAttribute("disabled", "");
          }
          else {
            document.getElementById("bikeError").innerHTML = "<span style='color:green;'>bike name accepted</span>";
            button.removeAttribute("disabled");
          }
          console.log(response.data)

        }

        const modelValidation = async () => {

          let model = document.getElementById("model").value.trim();
          console.log(model);
          var button = document.getElementById("button");
          const response = await axios("http://localhost:8080/Suzuki/modelExist?bikeModel=" + model)

          if (model.trim() === " " && model.length < 3) {
            document.getElementById("modelError").innerHTML = "<span style='color:red;'>invalid model name</span>";
            button.setAttribute("disabled", "");
          } else if (response.data == "model is exist") {
            document.getElementById("modelError").innerHTML = "<span style='color:red;'>model name already exists</span>";
            button.setAttribute("disabled", "");
          } else if (model.trim() === '') {
            document.getElementById("modelError").innerHTML = "<span style='color:red;'>invalid model name</span>";
            button.setAttribute("disabled", "");
          }
          else {
            document.getElementById("modelError").innerHTML = "<span style='color:green;'>model name accepted</span>";
            button.removeAttribute("disabled");
          }
          console.log(response.data)

        }

        function resetForm() {
          // Clear all error <span> messages
          document.getElementById("bikeError").innerHTML = "";
          document.getElementById("modelError").innerHTML = "";
          document.getElementById("priceError").innerHTML = "";
          document.getElementById("engineError").innerHTML = "";
          document.getElementById("milegeError").innerHTML = "";
          document.getElementById("fuelError").innerHTML = "";
          document.getElementById("frontError").innerHTML = "";
          document.getElementById("leftError").innerHTML = "";
          document.getElementById("backError").innerHTML = "";
          document.getElementById("rightError").innerHTML = "";
          document.getElementById("topError").innerHTML = "";
          document.getElementById("d3Error").innerHTML = "";
          document.getElementById("Message").innerHTML = "";

          // Clear server response messages (${msg}, ${error})
          const messageParagraphs = document.querySelectorAll(".fst-italic p");
          messageParagraphs.forEach(p => p.innerText = "");

          // Optionally clear file input values manually (cross-browser safe)
          document.getElementById("frontImage").value = null;
          document.getElementById("leftImage").value = null;
          document.getElementById("backImage").value = null;
          document.getElementById("rightImage").value = null;
          document.getElementById("topImage").value = null;
          document.getElementById("d3Image").value = null;

          // Disable submit button again if desired
          document.getElementById("button").setAttribute("disabled", "");
        }



        function form(event) {

          var bName = document.getElementById("bName").value;
          var models = document.getElementById("model").value;
          var price = document.getElementById("bikePrice").value;
          var enginecap = document.getElementById("engine").value;
          var mileage = document.getElementById("bikeMilege").value;
          var fuelcap = document.getElementById("fuel").value;
          var frontimg = document.getElementById("frontImage").value
          var leftimg = document.getElementById("leftImage").value
          var backimg = document.getElementById("backImage").value
          var rightimg = document.getElementById("rightImage").value
          var topimg = document.getElementById("topImage").value
          var d3img = document.getElementById("d3Image").value
          var button = document.getElementById("button");



          if (
            bName.trim() !== "" && bName.length > 4 && bName.length < 30 &&
            models.trim() !== "" && models.length > 4 && models.length < 30 &&
            enginecap.trim() !== "" && enginecap.length > 2 && enginecap.length < 30 &&
            price.trim() !== "" && price.length >= 2 &&
            mileage.trim() !== "" && mileage.length > 2 && mileage.length < 30 &&
            fuelcap.trim() !== "" && fuelcap.length > 2 && fuelcap.length < 30 &&
            frontimg.trim() != "" && frontimg.length !== 0 &&
            leftimg.trim() != "" && leftimg.length !== 0 &&
            backimg.trim() != "" && backimg.length !== 0 &&
            righttimg.trim() != "" && rightimg.length !== 0 &&
            topimg.trim() != "" && topimg.length !== 0 &&
            d3img.trim() != "" && d3img.length !== 0
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