<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Suzuki</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <style>
    body {
      padding-top: 80px;
      min-height: 100vh;
      background: linear-gradient(to right, #e3f2fd, #ffffff);
    }

    header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      background: linear-gradient(45deg, #0f2027, #203a43, #2c5364);
      color: white;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .card {
      border: none;
      border-radius: 15px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: scale(1.03);
      box-shadow: 0 0 25px rgba(0, 191, 255, 0.7);
    }

    .card img {
      max-height: 150px;
      object-fit: cover;
      border-radius: 10px;
    }

    .btn a {
      color: white;
      text-decoration: none;
    }

    .btn a:hover {
      color: white;
    }

    footer {
      background-color: #000;
      color: white;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100">

  <!-- Header -->
  <header class="text-white">
    <div class="d-flex justify-content-between align-items-center px-3 py-2">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo"
        width="50">
      <div class="d-flex align-items-center">
        <div class="dropdown mr-2">
          <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="navDropdown" data-toggle="dropdown"
            aria-haspopup="true" aria-expanded="false">
            Menu
          </button>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navDropdown">
            <a class="dropdown-item" href="addShowroom?emailId=${email}">Add Showroom</a>
            <a class="dropdown-item" href="viewShowroom?emailId=${email}">View Showroom</a>
            <a class="dropdown-item" href="addBike?emailId=${email}">Add Bike</a>
            <a class="dropdown-item" href="back?emailId=${email}">Dashboard</a>
          </div>
        </div>
        <button class="btn btn-info btn-sm mr-2">
          <a href="logout?emailId=${email}">Logout</a>
        </button>
      </div>
    </div>
  </header>

  <!-- Bikes Cards -->
  <div class="container my-5">
    <div class="row">
      <c:forEach items="${dtos}" var="singleDto">
        <div class="col-sm-12 col-md-6 col-lg-4 mb-4 d-flex">
          <div class="card shadow w-100 p-3 bg-white">
            <div class="text-center mb-3">
              <div id="carousel-${singleDto.bikeName}" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                  <div class="carousel-item active">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?frontImageFileName=${singleDto.frontImageFileName}" alt="Front view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?leftImageFileName=${singleDto.leftImageFileName}" alt="Left view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?backImageFileName=${singleDto.backImageFileName}" alt="Back view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?rightImageFileName=${singleDto.rightImageFileName}" alt="Right view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?topImageFileName=${singleDto.topImageFileName}" alt="Top view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 img-fluid rounded"
                      src="bikeImage?d3ImageFileName=${singleDto.d3ImageFileName}" alt="3D view">
                  </div>
                </div>


              </div>
            </div>
            <div>
              <div class="mb-2"><strong>Bike Name:</strong> ${singleDto.bikeName}</div>
              <div class="mb-2"><strong>Model:</strong> ${singleDto.bikeModel}</div>
              <div class="mb-2"><strong>Price:</strong> ${singleDto.price}</div>
              <div class="d-flex justify-content-start mt-3">
                <a href="viewSingleBike?bikeName=${singleDto.bikeName}&emailId=${email}"
                  class="btn btn-info btn-sm mr-2">View</a>
                <a href="editBike?bikeName=${singleDto.bikeName}&emailId=${email}"
                  class="btn btn-warning btn-sm mr-2">Edit</a>
                <a href="deleteBike?bikeName=${singleDto.bikeName}&emailId=${email}" class="btn btn-danger btn-sm">Delete</a>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Footer -->
  <footer class="py-3 mt-auto">
    <div class="container text-center text-white">
      <span>Copyright &copy; 2025, All Rights Reserved</span>
    </div>
  </footer>

</body>

</html>
