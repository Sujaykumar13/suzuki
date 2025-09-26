<%@ page isELIgnored="false" %>
  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Suzuki</title>
        <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

        <style>
          body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #fce4ec);
            /* light cyan to light pink */
            padding-top: 80px;
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

          .card {
            border-radius: 15px;
            overflow: hidden;
          }

          /* 💠 New Main Card Header Color: Deep Teal */
          .card-header.main-header {
            background-color: #00695c;
            /* Teal */
            color: white;
          }

          /* 💠 New User Info Header Color: Rich Green */
          .card-header.user-header {
            background-color: #388e3c;
            /* Medium Green */
            color: white;
          }

          .table thead {
            background-color: #343a40;
            color: white;
          }

          .btn-gradient {
            background: linear-gradient(to right, #36d1dc, #5b86e5);
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 30px;
            padding: 8px 25px;
          }

          .btn-gradient a {
            color: white;
            text-decoration: none;
          }

          .btn-gradient:hover {
            opacity: 0.9;
          }

          .pagination .active .page-link {
            background-color: #5b86e5;
            border-color: #5b86e5;
          }

          .pagination .page-link {
            color: #5b86e5;
          }

          footer {
            background-color: #212529;
            color: white;
          }

          .dropdown-menu a:hover {
            background-color: #e3f2fd;
          }

          .table td,
          .table th {
            vertical-align: middle !important;
          }
        </style>

      </head>

      <body class="d-flex flex-column min-vh-100">

        <!-- Header -->
        <header class="bg-dark text-white">
          <div class="d-flex justify-content-between align-items-center px-3 py-2">
            <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg"
              alt="Suzuki Logo" width="50">

            <div class="d-flex align-items-center">
              <div class="dropdown mr-2">
                <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="menuDropdown"
                  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
              <button type="button" class="btn btn-info btn-sm">
                <a href="logout?emailId=${email}" style="color: white;" role="button">Logout</a>
              </button>
            </div>
          </div>
        </header>

        <!-- Main Content -->
        <div class="container-fluid my-4 flex-grow-1">
          <div class="card shadow-lg">
            <div class="card-header main-header text-center">
              <h4 class="mb-0">Follow-Up Details</h4>
            </div>

            <div class="card-body">
              <div class="card-header user-header mb-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
                  <h5 class="mb-1">${userDto.firstName} ${userDto.lastName}</h5>
                  <h5 class="mb-1">${userDto.userEmailId}</h5>
                  <h5 class="mb-1">${userDto.contactNumber}</h5>

                </div>
              </div>

              <!-- Table -->
              <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped text-center">
                  <thead>
                    <tr>
                      <th>SI-No</th>
                      <th>Date</th>
                      <th>Time</th>
                      <th>Comments</th>
                      <th>Created By</th>
                      <th>Details</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${followDto}" var="singleDto" varStatus="status">
                      <tr style="font-size: 1.1rem;">
                        <td class="py-3 px-4">${status.index + 1}</td>
                        <td class="py-3 px-4">${singleDto.date}</td>
                        <td class="py-3 px-4">${singleDto.time}</td>
                        <td class="py-3 px-4">${singleDto.comment}</td>
                        <td class="py-3 px-4">${singleDto.createdBy}</td>
                        <td class="py-3 px-4">
                          <button type="button" class="btn btn-info btn-sm" data-toggle="popover"
                            data-trigger="hover focus" data-container="body" data-placement="right"
                            data-content="${singleDto.details}">
                            View
                          </button>

                        </td>

                      </tr>
                    </c:forEach>
                  </tbody>
                </table>

                <div class="d-flex justify-content-end align-items-center mt-4">

                  <!-- Page info and Total follow-up -->
                  <div class="text-muted small mr-4">
                    Page ${currentPage} of ${totalPages}
                  </div>

                  <div class="text-muted small mr-4">
                    Total = <span>${totalfollowup}</span>
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

              <!-- Back Button -->
              <div class="text-center mt-4">
                <button type="button" class="btn btn-gradient">
                  <a href="profileBack?emailId=${email}&userEmailId=${userEmail}">Back</a>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer -->
        <footer class="py-3 mt-auto">
          <div class="container text-center">
            <span>Copyright &copy; 2025, All Rights Reserved</span>
          </div>
        </footer>

        <!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
  $(function () {
    $('[data-toggle="popover"]').popover({
      trigger: 'hover focus',
      container: 'body'
    });
  });
</script>


      </body>

      </html>