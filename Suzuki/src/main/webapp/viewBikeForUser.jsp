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

       
    .shadow-text {
      font-size: 3rem;
      font-weight: bold;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      color: #333;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

      .carousel-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }


      .toast-message {
        position: fixed;
        bottom: 80px; /* just above the footer */
        right: 20px;
        background-color: #28a745; /* success green */
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
          <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo"
            width="50">

          <div class="d-flex align-items-center">


               <a href="userBackPage?userEmailId=${userEmail}" class="btn btn-info btn-sm mr-2">Back</a>
               <a href="userLogout?userEmailId=${userEmail}" class="btn btn-info btn-sm ">Logout</a>

          </div>
        </div>
      </header>
      <div class="container-fluid full-height">
    <div class="row justify-content-center">
      <div class="col text-center">
        <h2 class="shadow-text">Welcome to ${branch}</h2>
      </div>
    </div>
  </div>
<div class="container my-2">
  <div class="row justify-content-center">
    <c:forEach items="${bikeDtos}" var="singleDto">
      <div class="col-12 col-md-8 mb-1">
        <div class="card shadow p-3 bg-white">

          <!-- Equal height row using d-flex -->
          <div class="d-flex flex-row align-items-stretch">

            <!-- Left: Carousel (fixed height) -->
            <div class="w-50 d-flex align-items-center">
              <div id="carousel-${singleDto.bikeName}" class="carousel slide w-100" data-ride="carousel">
                <div class="carousel-inner">
                  <div class="carousel-item active">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?frontImageFileName=${singleDto.frontImageFileName}" alt="Front view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?leftImageFileName=${singleDto.leftImageFileName}" alt="Left view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?backImageFileName=${singleDto.backImageFileName}" alt="Back view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?rightImageFileName=${singleDto.rightImageFileName}" alt="Right view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?topImageFileName=${singleDto.topImageFileName}" alt="Top view">
                  </div>
                  <div class="carousel-item">
                    <img class="d-block w-100 rounded" style="height: 220px; object-fit: cover;"
                      src="bikeImage?d3ImageFileName=${singleDto.d3ImageFileName}" alt="3D view">
                  </div>
                </div>
              </div>
            </div>

          
            <div class="w-50 d-flex align-items-center">
              <div class="w-100 text-center">
                <div class="mb-2"><strong>Bike Name:</strong> ${singleDto.bikeName}</div>
                <div class="mb-2"><strong>Model:</strong> ${singleDto.bikeModel}</div>
                <div class="mb-2"><strong>Price:</strong> ${singleDto.price}</div>

                <div class="d-flex justify-content-center mt-3">
                  <a href="viewSingleBikeforUser?bikeName=${singleDto.bikeName}&userEmailId=${userEmail}&id=${showRoomId}&branchName=${branch}"
                    class="btn btn-info btn-sm mr-2">View</a>

                  <a href="#" class="btn btn-warning btn-sm"
                    data-toggle="modal"
                    data-target="#testRideModal"
                    data-showroom="${branch}"
                    data-bike="${singleDto.bikeName}"
                    data-email="${userEmail}">
                    Book Test‑Ride
                  </a>
                </div>
              </div>
            </div>

          </div> <!-- End d-flex -->
        </div>
      </div>
    </c:forEach>
  </div>
</div>



  <!-- Test Ride Modal -->
  <div class="modal fade" id="testRideModal" tabindex="-1" role="dialog" aria-labelledby="testRideModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <form action="bookTestRide?id=${showRoomId}" method="post" id="testRideForm" novalidate> 
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
              <label>Showroom</label>
              <input type="text" class="form-control" id="modalShowroom" name="branchName" readonly>
            </div>


            <div class="form-group">
              <label>Date</label>
              <input type="date" class="form-control" id="modalDate" name="date"  required>
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
  $('#testRideModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var showroom = button.data('showroom');
    var bike = button.data('bike');
    var email = button.data('email');

    var modal = $(this);
    modal.find('#modalShowroom').val(showroom);
    modal.find('#modalBike').val(bike);
    modal.find('#modalEmail').val(email);
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