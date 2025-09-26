<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>suzuki</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">
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

           <!-- Logo -->
           <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo" width="50">



           <!-- Right Side Buttons -->
           <div class="d-flex align-items-center">

             <!-- Dropdown Menu -->
             <div class="dropdown mr-2">
               <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="navDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 Menu
               </button>
               <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navDropdown">
                 <a class="dropdown-item" href="addShowroom?emailId=${email}">Add Showroom</a>
                 <a class="dropdown-item" href="viewShowroom?emailId=${email}">View Showroom</a>
                 <a class="dropdown-item" href="addBike?emailId=${email}">Add Bike</a>
                 <a class="dropdown-item" href="back?emailId=${email}">Dashboard</a>
               </div>
             </div>

             <!-- Logout and Dashboard Buttons -->
             <button type="button" class="btn btn-info btn-sm mr-2">
               <a href="logout?emailId=${email}" style="color: white;">Logout</a>
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
                       <a href="viewBike?bikeName=${dto.bikeName}&emailId=${email}" class="btn btn-info btn-sm">Back</a>
                     </div>
                   </div>
                 </div>

      </div>
    </div>
  </div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


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
