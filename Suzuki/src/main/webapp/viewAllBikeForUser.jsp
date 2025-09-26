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

      <body class="d-flex flex-column min-vh-100">
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

         .card img.img-fluid {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }

        a {
          display: inline;
          padding: 0;
          margin: 0;
        }
      </style>
        <header class="bg-dark text-white">
          <div class="d-flex justify-content-between align-items-center px-3 py-2">
            <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg"
              alt="Suzuki Logo" width="50">

            <div class="d-flex align-items-center">


              <a href="userBackPage?userEmailId=${userEmail}" class="btn btn-info btn-sm mr-2">Back</a>
              <a href="userLogout?userEmailId=${userEmail}" class="btn btn-info btn-sm ">Logout</a>

            </div>
          </div>
        </header>


        
      <div class="container my-5">
         <div class="row">
           <c:forEach items="${showRoomDetails}" var="singleDto">
             <div class="col-sm-12 col-md-6 col-lg-4 mb-4 d-flex">
               <div class="card shadow w-100 p-3 bg-white">

               <div class="text-center mb-3">
                             <img class="img-fluid" src="image?showRoomImageFileName=${singleDto.showRoomImageFileName}" alt="Showroom Image">
                           </div>

                 <div>
                   <div class="mb-2"><strong>Branch Name:</strong> ${singleDto.branchName}</div>
                   <div class="mb-2"><strong>Manager Name:</strong> ${singleDto.branchManagerName}</div>
                   <div class="mb-2"><strong>Contact Number:</strong> ${singleDto.contactNumber}</div>

                   <div class="d-flex justify-content-start">
                     <a href="${singleDto.location}" class="btn btn-info btn-sm mr-2">Direction</a>
                     <a href="viewBikeUser?id=${singleDto.id}&userEmailId=${userEmail}&branchName=${singleDto.branchName}" class="btn btn-info btn-sm">View</a>

                   </div>
                 </div>
               </div>
             </div>
           </c:forEach>
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