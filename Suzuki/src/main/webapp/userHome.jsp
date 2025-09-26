<%@ page isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>suzuki</title>
        <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

        .carousel-inner,
        .carousel-item {
          height: 300px;
        }



        .carousel-item img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }


        .toast-message {
          position: fixed;
          bottom: 80px;
          /* just above the footer */
          right: 20px;
          background-color: #28a745;
          /* success green */
          color: white;
          padding: 15px 20px;
          border-radius: 5px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
          z-index: 9999;
          opacity: 0;
          transition: opacity 0.5s ease-in-out;
        }

        .toast-message.show {
          opacity: 1;
        }
      </style>

      <body class="d-flex flex-column min-vh-100">



        <header class="bg-dark text-white">
          <div class="d-flex justify-content-between align-items-center px-3 py-2">
            <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg"
              alt="Suzuki Logo" width="50">

            <div class="d-flex align-items-center">
              <img src="userImage?userImageFileName=${userDto.userImageFileName}" class="rounded-circle mx-2"
                alt="userImage" width="60" data-bs-toggle="modal" data-bs-target="#imageModal" />
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                ${userDto.firstName}
              </button>
              <div class="dropdown-menu">

                <a class="dropdown-item" href="viewAllActiveShowRoomForUser?userEmailId=${userEmail}">ShowRooms</a>
                <a href="profile?userEmailId=${userEmail}" class="dropdown-item">Profile</a>
                <a href="userLogout?userEmailId=${userEmail}" class="dropdown-item">Logout</a>


              </div>
            </div>



          </div>
        </header>

        <div class="container my-5">
          <div class="row justify-content-center">
            <c:forEach items="${dtos}" var="singleDto">
              <div class="col-12 col-md-8 mb-4">
                <div class="card shadow p-3 bg-white">
                  <div class="d-flex flex-row w-100">
                    <!-- Left: Carousel -->
                    <div class="w-50 pr-3">
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

                    <!-- Right: Bike Info -->
                    <div class="w-50 d-flex align-items-center">
                      <div>
                        <div class="mb-2"><strong>Bike Name:</strong> ${singleDto.bikeName}</div>
                        <div class="mb-2"><strong>Model:</strong> ${singleDto.bikeModel}</div>
                        <div class="mb-2"><strong>Price:</strong> ${singleDto.price}</div>
                        <div class="mb-2"><strong>Engine Capacity:</strong> ${singleDto.engineCapacity}</div>
                        <div class="mb-2"><strong>Mileage:</strong> ${singleDto.milege}</div>
                        <div class="mb-2"><strong>Fuel Capacity:</strong> ${singleDto.fuelCapacity}</div>
                        <div class="d-flex justify-content-start mt-3">
                          <a href="#" class="btn btn-warning btn-sm mr-2" data-toggle="modal"
                            data-target="#testRideModal" data-showroom="${branch}" data-bike="${singleDto.bikeName}"
                            data-email="${userEmail}">
                            Book Test‑Ride
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>


        <!-- Test Ride Modal -->
        <div class="modal fade" id="testRideModal" tabindex="-1" role="dialog" aria-labelledby="testRideModalLabel"
          aria-hidden="true">
          <div class="modal-dialog" role="document">
            <form action="bookTestRide" method="post" id="testRideForm" novalidate>
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="testRideModalLabel">Book Test‑Ride</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <div class="form-group">
                    <label>Your Email</label>
                    <input type="email" class="form-control" id="modalEmail" name="userEmailId" readonly>
                  </div>

                  <div class="form-group">
                    <label>Bike</label>
                    <input type="text" class="form-control" id="modalBike" name="bikeName" readonly>
                  </div>
                  <div class="form-group">
                    <label for="branchSelect">Select Branch</label>
                    <select class="form-control" id="branchSelect" name="branchName" onchange="bikeValidation()"
                      required>
                      <option value="">-- Select Branch --</option>
                      <c:forEach items="${sdtos}" var="singleDto">
                        <option data-showroom-id="${singleDto.id}" value="${singleDto.branchName}">
                          ${singleDto.branchName}
                        </option>
                      </c:forEach>
                    </select>
                    <small id="branchBikeExists" class="form-text text-danger"></small>
                  </div>
                  <input type="hidden" id="modalShowroomId" name="id" />


                  <div class="form-group">
                    <label>Date</label>
                    <input type="date" class="form-control" id="modalDate" name="date" required>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="submit" class="btn btn-primary" id="confirmRideBtn" disabled>Confirm Test‑Ride</button>
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
              </div>
            </form>
          </div>
        </div>


        <c:if test="${not empty bookingMsg}">
          <div id="bookingPopup" class="toast-message">
            ${bookingMsg}
          </div>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>


        <script>
          window.addEventListener('DOMContentLoaded', function () {
            const toast = document.getElementById('bookingPopup');
            if (toast) {
              toast.classList.add('show');
              setTimeout(() => {
                toast.classList.remove('show');
              }, 3000);
            }
          });
        </script>
        <script>
          document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('testRideForm');
            const dateInput = document.getElementById('modalDate');
            const submitBtn = document.getElementById('confirmRideBtn');


            dateInput.addEventListener('input', () => {
              submitBtn.disabled = !form.checkValidity();
            });

            // Optional: on form submit show validation if invalid
            form.addEventListener('submit', function (e) {
              if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                form.classList.add('was-validated');
              }
            });
          });

          const bikeValidation = async () => {
            let branch = document.getElementById("branchSelect").value;
            console.log(branch)
            let bike = document.getElementById("modalBike").value;
            console.log(bike)
            const feedback = document.getElementById("branchBikeExists");
            const button = document.getElementById("confirmRideBtn");


            try {
              const response = await axios.get("http://localhost:8080/Suzuki/modelIdExist", {
                params: {
                  branchName: branch,
                  bikeName: bike
                }
              });

              if (branch === "") {
                feedback.innerHTML = "Please select the branch";
                button.setAttribute("disabled", "");
              } else if (response.data === "model is exist") {
                feedback.innerHTML = "<span class='text-success'>branch accepted</span>";
                button.removeAttribute("disabled");
              } else {
                feedback.innerHTML = "The bike you selected not in this showroom please select other branch";
                button.setAttribute("disabled", "");
              }
            } catch (error) {
              console.error("Error occurred:", error);
              errorElement.innerHTML = "<span style='color:red;'>Try again.</span>";
              button.disabled = true;
            }

          };

        </script>

        <script>
          document.addEventListener('DOMContentLoaded', function () {
            const dateInput = document.getElementById('modalDate');
            const today = new Date().toISOString().split('T')[0];
            dateInput.setAttribute('min', today);

            // Existing logic to enable submit button on valid input
            const form = document.getElementById('testRideForm');
            const submitBtn = document.getElementById('confirmRideBtn');
            dateInput.addEventListener('input', () => {
              submitBtn.disabled = !form.checkValidity();
            });
          });
        </script>



        <script>
          $('#testRideModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var branch = button.data('showroom');
            var bike = button.data('bike');
            var email = button.data('email');

            var select = document.getElementById("branchSelect");
            // Optionally set branchSelect here or leave to user
            var modal = $(this);
            modal.find('#modalBike').val(bike);
            modal.find('#modalEmail').val(email);

            // Reset showroomId until branch is reselected
            document.getElementById('modalShowroomId').value = '';

            var branch = button.data('showroom');
            $('#branchSelect').val(branch).trigger('change');



          });

          document.getElementById('branchSelect').addEventListener('change', function () {
            var selected = this.options[this.selectedIndex];
            var id = selected.dataset.showroomId;    // Fetching the data attribute
            document.getElementById('modalShowroomId').value = id;
            bikeValidation();  // Continue existing logic
          });

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