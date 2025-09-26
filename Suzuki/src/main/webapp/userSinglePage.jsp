<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>suzuki</title>
    <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <style>
        body {
            padding-top: 70px;
            background: #f8f9fa;
        }

        header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1030;
        }

        .profile-card {
            background: #ffffff;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .profile-card:hover {
            transform: translateY(-5px);
        }

        .card-title {
            color: #007bff;
        }

        .btn-info {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-info:hover {
            background-color: #0056b3;
            border-color: #004a99;
        }

        footer {
            background-color: #343a40;
            color: white;
        }

        .modal-content {
            border-radius: 12px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #007bff;
        }

        .toast-alert {
          position: fixed;
          bottom: 20px;
          left: 20px;
          z-index: 1100;
          min-width: 300px;
          max-width: 90%;
          font-size: 0.9rem;
          padding: 0.75rem 1rem;
          border-radius: 0.25rem;
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
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Menu</button>
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
                    <a href="logout?emailId=${email}" style="color: white;">Logout</a>
                </button>
            </div>
        </div>
    </header>

    <!-- Main -->
    <main class="flex-grow-1 d-flex justify-content-center align-items-center px-3">
        <div class="profile-card w-100" style="max-width: 600px;">
            <h3 class="card-title text-center mb-4">Profile</h3>
            <h2 class="text-center mb-4"><strong>${userDto.firstName} ${userDto.lastName}</strong></h2>

            <div class="row mb-3">
                <div class="col-6">
                    <div class="text-muted small">Email</div>
                    <div class="h5 font-weight-bold">${userDto.userEmailId}</div>
                </div>
                <div class="col-6">
                    <div class="text-muted small">Contact</div>
                    <div class="h5 font-weight-bold">${userDto.contactNumber}</div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-6">
                    <div class="text-muted small">Location</div>
                    <div class="h5 font-weight-bold">${userDto.city}</div>
                </div>
                <div class="col-6">
                    <div class="text-muted small">Purpose</div>
                    <div class="h5 font-weight-bold">${userDto.reason}</div>
                </div>
            </div>

            <div class="d-flex flex-wrap justify-content-center">
                <a href="followUpDetails?emailId=${email}&userEmailId=${userDto.userEmailId}"
                    class="btn btn-info btn-sm text-white mr-2 mb-2">Follow-Up Details</a>
                <a href="singleUserProfile?emailId=${email}&userEmailId=${userDto.userEmailId}"
                    class="btn btn-info btn-sm text-white mr-2 mb-2">Edit</a>
                <button type="button" class="btn btn-info btn-sm text-white mr-2 mb-2" data-toggle="modal"
                    data-target="#followUpModal">Follow-Up</button>
                <a href="userProfile?emailId=${email}" class="btn btn-info btn-sm text-white mb-2">Back</a>
            </div>
        </div>
    </main>

    <!-- Follow-Up Modal -->
    <div class="modal fade" id="followUpModal" tabindex="-1" role="dialog" aria-labelledby="followUpModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="addFollowUp?emailId=${email}" method="post">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title" id="followUpModalLabel">Add Follow-Up Comment</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" class="form-control" name="userEmailId"
                                value="${userDto.userEmailId}" readonly>
                        </div>
                        <div class="form-group">
                            <label>Comment</label>
                            <textarea class="form-control" id="followUpComment" name="comment" rows="4"
                                placeholder="Enter your comment here..." required></textarea>
                            <div id="commentError" class="text-danger mt-2" style="display: none;">Please enter a
                                comment.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-info">Add</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
<c:if test="${not empty followUpMsg}">
    <div id="followUpToast" class="toast-alert alert alert-success alert-dismissible fade show" role="alert">
        ${followUpMsg}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span>&times;</span>
        </button>
    </div>
</c:if>


    <!-- Footer -->
    <footer class="py-3 mt-auto text-center">
        <div class="container">
            <span>Copyright &copy; 2025, All Rights Reserved</span>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <script>

            window.addEventListener('DOMContentLoaded', () => {
                const toast = document.getElementById('followUpToast');
                if (toast) {
                    setTimeout(() => {
                        $(toast).alert('close');
                    }, 3000); // Auto-close after 3 seconds
                }
            });

      window.addEventListener('DOMContentLoaded', () => {
        const toast = document.getElementById('followUpToast');
        if (toast) {
            setTimeout(() => {
                $(toast).alert('close');
            }, 3000);
        }
      });

    document.addEventListener("DOMContentLoaded", function () {
        const followUpForm = document.querySelector("#followUpModal form");
        const commentInput = document.getElementById("followUpComment");
        const addButton = followUpForm.querySelector("button[type='submit']");
        const commentError = document.getElementById("commentError");

        addButton.disabled = true;

        commentInput.addEventListener("input", function () {
            const nonSpaceCharCount = commentInput.value.replace(/\s/g, '').length;

            if (nonSpaceCharCount >= 10) {
                addButton.disabled = false;
                commentError.style.display = "none";
            } else {
                addButton.disabled = true;
            }
        });

        followUpForm.addEventListener("submit", function (e) {
            const nonSpaceCharCount = commentInput.value.replace(/\s/g, '').length;

            if (nonSpaceCharCount < 10) {
                e.preventDefault();
                commentError.textContent = "Please enter at least 10 non-space characters.";
                commentError.style.display = "block";
                commentInput.focus();
            }
        });
    });

    </script>
</body>

</html>
