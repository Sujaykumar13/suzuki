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
    /* General Styles */
    body {
      padding-top: 80px;
      background: linear-gradient(to right, #e3f2fd, #ffffff);
      min-height: 100vh;
    }

    /* Header with Gradient */
    header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      background: linear-gradient(45deg, #0f2027, #203a43, #2c5364);
      color: white;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }



    /* Attractive Card Styles */
    .card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border: none;
      border-radius: 15px;
    }

    .card:hover {
      transform: scale(1.03);
      box-shadow: 0 0 25px rgba(0, 191, 255, 0.7);
    }

    /* Card Image Styling */
    .card img {
      max-height: 150px;
      object-fit: cover;
      border-radius: 10px;
    }

    /* Buttons inside cards */
    .card a.btn {
      transition: 0.3s ease;
    }

    .card a.btn:hover {
      transform: scale(1.05);
    }

    /* Button styling fixes */
    .btn a {
      color: white;
      text-decoration: none;
    }

    .btn a:hover {
      color: white;
      text-decoration: none;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100">

  <!-- Header -->
  <header class="text-white">
    <div class="d-flex justify-content-between align-items-center px-3 py-2">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="suzuki Logo" width="50">
      <div class="text-success fst-italic">
        <p>${msg}</p>
      </div>
      <div class="text-danger fst-italic">
        <p>${error}</p>
      </div>
      <div>
        <button class="btn btn-info btn-sm mr-2"><a href="addShowroom?emailId=${email}">Add Showroom</a></button>
        <button class="btn btn-info btn-sm mr-2"><a href="back?emailId=${email}">Dashboard</a></button>
        <button class="btn btn-info btn-sm"><a href="logout?emailId=${email}">Logout</a></button>
      </div>
    </div>
  </header>

  <!-- Showroom Cards -->
  <div class="container my-5">
    <div class="row">
      <c:forEach items="${dtos}" var="singleDto">
        <div class="col-sm-12 col-md-6 col-lg-4 mb-4 d-flex">
          <div class="card shadow w-100 p-3 bg-white">
            <div class="text-center mb-3">
              <img class="img-fluid" src="image?showRoomImageFileName=${singleDto.showRoomImageFileName}" alt="Showroom Image">
            </div>
            <div>
              <div class="mb-2"><strong>Branch Name:</strong> ${singleDto.branchName}</div>
              <div class="mb-2"><strong>Manager Name:</strong> ${singleDto.branchManagerName}</div>
              <div class="mb-2"><strong>Contact Number:</strong> ${singleDto.contactNumber}</div>
              <div class="mb-3"><strong>Status:</strong> ${singleDto.status}</div>
              <div class="d-flex justify-content-start">
                <a href="${singleDto.location}" class="btn btn-info btn-sm mr-2">Direction</a>
                <a href="edit?branchName=${singleDto.branchName}&emailId=${email}" class="btn btn-warning btn-sm mr-2">Edit</a>
                <a href="delete?branchName=${singleDto.branchName}&emailId=${email}" class="btn btn-danger btn-sm">Delete</a>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <footer class="py-3 mt-auto" style="background-color: #000; color: white;">
    <div class="container text-center">
      <span>Copyright &copy; 2025, All Rights Reserved</span>
    </div>
  </footer>

</body>

</html>
