<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Suzuki - User Dashboard</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      background-color: #212529;
    }

    body {
      padding-top: 80px;
    }

    .card-header {
      background: linear-gradient(to right, #6ac045, #a8e063);
    }

    .btn-info a {
      color: white;
      text-decoration: none;
    }

    .btn-info a:hover {
      text-decoration: underline;
    }

    .table td, .table th {
      vertical-align: middle !important;
    }

    .table thead th {
      background-color: #343a40;
      color: white;
    }

    .pagination .page-item.active .page-link {
      background-color: #28a745;
      border-color: #28a745;
    }

    footer {
      color: #ccc;
    }

    .dropdown-menu a:hover {
      background-color: #17a2b8;
      color: white;
    }
  </style>
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

  <!-- HEADER -->
  <header class="shadow-sm">
    <div class="container-fluid px-4 py-2 d-flex justify-content-between align-items-center">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo" width="50">
      <div class="d-flex align-items-center">
        <div class="dropdown mr-2">
          <button class="btn btn-outline-light btn-sm dropdown-toggle" type="button" id="menuDropdown" data-toggle="dropdown">
            Menu
          </button>
          <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="viewShowroom?emailId=${email}">View Showroom</a>
            <a class="dropdown-item" href="addShowroom?emailId=${email}">Add Showroom</a>
            <a class="dropdown-item" href="viewBike?emailId=${email}">View Bike</a>
            <a class="dropdown-item" href="addBike?emailId=${email}">Add Bike</a>
            <a class="dropdown-item" href="userRegister?emailId=${email}">User Register</a>
            <a class="dropdown-item" href="userProfile?emailId=${email}">User Profiles</a>
            <a class="dropdown-item" href="back?emailId=${email}">Dashboard</a>
          </div>
        </div>
        <a href="logout?emailId=${email}" class="btn btn-outline-light btn-sm">Logout</a>
      </div>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <div class="container-fluid my-4">
    <div class="card shadow">
      <div class="card-header text-white text-center">
        <h4 class="mb-0 font-weight-bold">User Details</h4>
      </div>
      <div class="card-body bg-white">
        <div class="table-responsive">
          <table class="table table-bordered table-hover text-center">
            <thead>
              <tr>
                <th>SI-No</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email ID</th>
                <th>Contact</th>
                <th>City</th>
                <th>Gender</th>
                <th>Reason</th>
                <th>Comments</th>
                <th>View</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${userDtos}" var="singleDto" varStatus="status">
                <tr>
                  <td>${status.index + 1}</td>
                  <td>${singleDto.firstName}</td>
                  <td>${singleDto.lastName}</td>
                  <td>${singleDto.userEmailId}</td>
                  <td>${singleDto.contactNumber}</td>
                  <td>${singleDto.city}</td>
                  <td>${singleDto.gender}</td>
                  <td>${singleDto.reason}</td>
                  <td>${singleDto.comments}</td>
                  <td>
                    <a href="userSinglePage?emailId=${email}&userEmailId=${singleDto.userEmailId}" class="btn btn-outline-primary btn-sm">View</a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>


        <div class="d-flex justify-content-end align-items-center mt-4">

                          <!-- Page info and Total follow-up -->
                          <div class="text-muted small mr-4">
                            Page ${currentPage} of ${totalPages}
                          </div>

                          <div class="text-muted small mr-4">
                            Total = <span>${totalUser}</span>
                          </div>

                          <!-- Pagination -->
                          <nav aria-label="Follow-up navigation">
                            <ul class="pagination mb-0">
                              <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                  <a class="page-link"
                                    href="followUpDetails?emailId=${email}&userEmailId=${userEmail}&page=${currentPage - 1}">Previous</a>
                                </li>
                              </c:if>

                              <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                  <a class="page-link"
                                    href="followUpDetails?emailId=${email}&userEmailId=${userEmail}&page=${i}">${i}</a>
                                </li>
                              </c:forEach>

                              <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                  <a class="page-link"
                                    href="followUpDetails?emailId=${email}&userEmailId=${userEmail}&page=${currentPage + 1}">Next</a>
                                </li>
                              </c:if>
                            </ul>
                          </nav>
                        </div>

      </div>
    </div>
  </div>
  
        


  <!-- FOOTER -->
  <footer class="bg-dark py-3 mt-auto">
    <div class="container text-center text-white">
      <span>Copyright &copy; 2025, All Rights Reserved</span>
    </div>
  </footer>

  <!-- SCRIPTS -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
