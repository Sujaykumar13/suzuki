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
    </style>

    <body class="d-flex flex-column min-vh-100">
      <header class="bg-dark text-white">
        <div class="d-flex justify-content-between align-items-center px-3 py-2">
          <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo"
            width="50">

          <div class="d-flex align-items-center">
            <button type="button" class="btn btn-info btn-sm">
              <a href="userLogout?userEmailId=${userEmail}" style="color: white;">Logout</a>
            </button>
          </div>
        </div>
      </header>

  <div class="container-fluid min-vh-100 d-flex justify-content-center align-items-center">
     <div class="card shadow border-dark w-100" style="max-width: 800px; height: 400px;" style="max-width: 960px; height: 500px;">
       <div class="row no-gutters h-100">

         <!-- Image Column -->
         <div class="col-md-6 h-100">
           <div id="carousel-${dto.bikeName.replaceAll('[^a-zA-Z0-9]', '')}" class="carousel slide h-100" data-ride="carousel">
             <div class="carousel-inner h-100">

               <div class="carousel-item active h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?frontImageFileName=${dto.frontImageFileName}"
                      alt="Front view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

               <div class="carousel-item h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?leftImageFileName=${dto.leftImageFileName}"
                      alt="Left view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

               <div class="carousel-item h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?backImageFileName=${dto.backImageFileName}"
                      alt="Back view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

               <div class="carousel-item h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?rightImageFileName=${dto.rightImageFileName}"
                      alt="Right view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

               <div class="carousel-item h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?topImageFileName=${dto.topImageFileName}"
                      alt="Top view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

               <div class="carousel-item h-100">
                 <img class="d-block w-100 h-100 img-fluid rounded"
                      src="bikeImage?d3ImageFileName=${dto.d3ImageFileName}"
                      alt="3D view of ${dto.bikeName}" style="object-fit: cover;">
               </div>

             </div>


           </div>
         </div>

         <!-- Text Column -->
        <div class="col-md-6 d-flex justify-content-center align-items-center text-center p-4">
                    <div class="w-100">
                      <div class="mb-3 h5"><strong>Bike Name:</strong> ${dto.bikeName}</div>
                      <div class="mb-3 h5"><strong>Model:</strong> ${dto.bikeModel}</div>
                      <div class="mb-3 h5"><strong>Price:</strong> ${dto.price}</div>
                      <div class="mb-3 h5"><strong>Engine Capacity:</strong> ${dto.engineCapacity}</div>
                      <div class="mb-3 h5"><strong>Mileage:</strong> ${dto.milege}</div>
                      <div class="mb-3 h5"><strong>Fuel Capacity:</strong> ${dto.fuelCapacity}</div>
                      <div class="mt-4">
                        <a href="viewBikeUser?id=${showRoomId}&userEmailId=${userEmail}&branchName=${branch}" class="btn btn-info btn-sm">Back</a>

                      <a href="#"
                                       class="btn btn-warning btn-sm mr-2"
                                       data-toggle="modal"
                                       data-target="#testRideModal"
                                       data-showroom="${branch}"
                                       data-bike="${dto.bikeName}"
                                       data-email="${userEmail}">
                                      Book Test‑Ride
                                    </a>

                      </div>
                    </div>
                  </div>

       </div>
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
              <input type="date" class="form-control" id="modalDate" name="date" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-primary" id="confirmRideBtn" disabled >Confirm Test‑Ride</button>
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
      }, 3000); // Hide after 3 seconds
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