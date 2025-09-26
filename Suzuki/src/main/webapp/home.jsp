<%@ page isELIgnored="false" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ page session="true" %>
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

            .showroom-card {
              transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .showroom-card:hover {
              transform: translateY(-5px);
              box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
            }

            .card-header {
              border-bottom: none;
            }

            .list-group-item {
              font-size: 0.95rem;
            }
          </style>

          <header class="bg-dark text-white">
            <div class="d-flex justify-content-between align-items-center px-3 py-2">
              <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg"
                alt="Suzuki Logo" width="50">

              <div class="d-flex align-items-center">

                <nav class="mr-2">
                  <div class="ml-auto">
                    <div class="dropdown">
                      <button class="btn position-relative p-0 border-0 bg-dark text-white" type="button"
                        id="notificationBell" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-bell"></i>
                        <c:if test="${not empty sessionScope.testRideNotifications}">
                          <span class="badge badge-danger position-absolute" style="top: -5px; right: -5px;">
                            ${fn:length(sessionScope.testRideNotifications)}
                          </span>
                        </c:if>
                      </button>

                      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="notificationDropdown">
                        <c:choose>
                          <c:when test="${not empty sessionScope.testRideNotifications}">
                            <c:forEach var="note" items="${sessionScope.testRideNotifications}" varStatus="status">
                              <a class="dropdown-item notification-item"
                                href="userSinglePage?emailId=${email}&userEmailId=${note.email}"
                                data-index="${status.index}">
                                ${note.name}
                                <small class="text-muted ml-2">(${note.email})</small>
                              </a>

                            </c:forEach>

                            <div class="dropdown-divider"></div>
                          </c:when>
                          <c:otherwise>
                            <span class="dropdown-item text-muted">No notifications</span>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                  </div>
                </nav>


                <!-- Add Bike button triggers modal -->
                <button type="button" class="btn btn-info btn-sm mr-2" data-toggle="modal" data-target="#addBikeModal">
                  Add
                </button>

                <!-- Dropdown menu -->
                <div class="dropdown mr-2">
                  <button class="btn btn-info btn-sm dropdown-toggle" type="button" id="dropdownMenuButton"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Menu
                  </button>
                  <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="viewShowroom?emailId=${email}">View Showroom</a>
                    <a class="dropdown-item" href="addShowroom?emailId=${email}">Add Showroom</a>
                    <a class="dropdown-item" href="viewBike?emailId=${email}">View Bike</a>
                    <a class="dropdown-item" href="addBike?emailId=${email}">Add Bike</a>
                    <a class="dropdown-item" href="userRegister?emailId=${email}">User Register</a>
                    <a class="dropdown-item" href="userProfile?emailId=${email}">User Profiles</a>
                  </div>
                </div>

                <!-- Logout button remains outside the dropdown -->
                <button type="button" class="btn btn-info btn-sm">
                  <a href="logout?emailId=${email}" style="color: white;" role="button">Logout</a>
                </button>
              </div>
            </div>
          </header>

          <!-- Add Bike Modal -->
          <div class="modal fade" id="addBikeModal" tabindex="-1" role="dialog" aria-labelledby="addBikeModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header bg-info text-white">
                  <h5 class="modal-title" id="addBikeModalLabel">Add Bike</h5>
                  <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <form action="popup" id="addBikeForm" method="post">

                    <div>
                      <span>${msg}</span>
                    </div>


                    <input type="hidden" name="emailId" id="emailField" value="${email}">

                    <div class="form-group">
                      <label for="branchSelect">Select Branch</label>
                      <select class="form-control" id="branchSelect" name="branchName" onchange="bikeSelectValidation()"
                        required>
                        <option value="">-- Select Branch --</option>
                        <c:forEach items="${sdtos}" var="singleDto">
                          <option value="${singleDto.branchName}">${singleDto.branchName}</option>
                        </c:forEach>
                      </select>
                    </div>

                    <div class="form-group">
                      <label for="bikeSelect">Select Bike(s)</label>
                      <select class="form-control" id="bikeSelect" name="bikeName" onchange="bikeSelectValidation()"
                        required>
                        <option value="">-- Select Model --</option>
                        <c:forEach items="${bdtos}" var="singleDto">
                          <option value="${singleDto.bikeName}">${singleDto.bikeName}</option>
                        </c:forEach>
                      </select>
                      <span id="bikeSelectError"></span>
                    </div>
                    <button type="submit" class="btn btn-info btn-block" id="button">Submit</button>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <div class="container my-4">
            <div class="row text-white">

              <!-- Branches -->
              <div class="col-md-2 mb-4">
                <div class="card text-center shadow"
                  style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                  <div class="card-body">
                    <i class="fa fa-code-fork fa-2x mb-2"></i>
                    <h5 class="card-title">Branches</h5>
                    <h3 class="badge badge-light text-dark">${branch}</h3>
                  </div>
                </div>
              </div>

              <!-- Active -->
              <div class="col-md-2 mb-4">
                <div class="card text-center shadow"
                  style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                  <div class="card-body">
                    <i class="fa fa-check-circle fa-2x mb-2"></i>
                    <h5 class="card-title">Active</h5>
                    <h3 class="badge badge-light text-dark">${active}</h3>
                  </div>
                </div>
              </div>

              <!-- Inactive -->
              <div class="col-md-2 mb-4">
                <div class="card text-center shadow"
                  style="background: linear-gradient(135deg, #757f9a 0%, #d7dde8 100%);">
                  <div class="card-body">
                    <i class="fa fa-ban fa-2x mb-2"></i>
                    <h5 class="card-title">Inactive</h5>
                    <h3 class="badge badge-light text-dark">${inactive}</h3>
                  </div>
                </div>
              </div>

              <!-- Maintenance -->
              <div class="col-md-3 mb-4">
                <div class="card text-center shadow"
                  style="background: linear-gradient(135deg, #f7971e 0%, #ffd200 100%);">
                  <div class="card-body">
                    <i class="fa fa-wrench fa-2x mb-2"></i>
                    <h5 class="card-title">Maintenance</h5>
                    <h3 class="badge badge-light text-dark">${maintain}</h3>
                  </div>
                </div>
              </div>

              <!-- Models -->
              <div class="col-md-3 mb-4">
                <div class="card text-center shadow"
                  style="background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);">
                  <div class="card-body">
                    <i class="fa fa-motorcycle fa-2x mb-2"></i>
                    <h5 class="card-title">Models</h5>
                    <h3 class="badge badge-light text-dark">${models}</h3>
                  </div>
                </div>
              </div>

            </div>
          </div>
          <div class="container my-4">
            <div class="row">
              <c:forEach items="${showroomWithBikes}" var="entry">
                <div class="col-sm-12 col-md-6 col-lg-4 mb-4 d-flex align-items-stretch">
                  <div class="card w-100 border-0 shadow-lg showroom-card transition-all"
                    style="border-radius: 15px; overflow: hidden;">

                    <!-- Gradient Header -->
                    <div class="card-header text-white text-center"
                      style="background: linear-gradient(135deg, #232526, #414345);">
                      <h5 class="mb-0">Showroom Details</h5>
                    </div>

                    <!-- Card Body -->
                    <div class="card-body bg-light text-dark">
                      <div class="mb-3">
                        <p class="mb-1"><strong>Branch:</strong> ${entry.showroom.branchName}</p>
                        <p class="mb-1"><strong>Manager:</strong> ${entry.showroom.branchManagerName}</p>
                        <p class="mb-3"><strong>Contact:</strong> ${entry.showroom.contactNumber}</p>
                      </div>

                      <!-- Bikes -->
                      <div>
                        <p class="font-weight-bold mb-2">Bikes Available:</p>
                        <ul class="list-group list-group-flush">
                          <c:forEach items="${entry.bikeNames}" var="bikeName">
                            <li
                              class="list-group-item bg-transparent px-0 py-1 border-0 text-dark d-flex justify-content-between align-items-center">
                              <span><i class="fa fa-motorcycle mr-2 text-info"></i>${bikeName}</span>
                              <form action="deleteBikeModel" method="post" style="margin: 0;">
                                <input type="hidden" name="bikeName" value="${bikeName}" />
                                <input type="hidden" name="id" value="${entry.showroom.id}" />
                                <input type="hidden" name="emailId" value="${email}" />
                                <button type="submit" class="btn btn-sm btn-danger" title="Delete"
                                  onclick="return confirm('Are you sure you want to delete this bike?')">

                                </button>
                              </form>
                            </li>
                          </c:forEach>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>


          <script>
            const bikeSelectValidation = async () => {
              const model = document.getElementById("bikeSelect").value;
              const branch = document.getElementById("branchSelect").value;
              const button = document.getElementById("button");
              const errorElement = document.getElementById("bikeSelectError");

              // Clear messages if not both selected
              if (!model || !branch) {
                errorElement.innerHTML = "";
                button.disabled = true;
                return;
              }

              try {
                const response = await axios.get("http://localhost:8080/Suzuki/modelIdExist", {
                  params: {
                    branchName: branch,
                    bikeName: model
                  }
                });

                if (response.data === "model is exist") {
                  errorElement.innerHTML = "<span style='color:red;'>Model already exists</span>";
                  button.disabled = true;
                } else {
                  errorElement.innerHTML = "<span style='color:green;'>Model name accepted</span>";
                  button.disabled = false;
                }
              } catch (error) {
                console.error("Error occurred:", error);
                errorElement.innerHTML = "<span style='color:red;'>Try again.</span>";
                button.disabled = true;
              }
            };
          </script>


          <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

          <script>
            document.addEventListener("DOMContentLoaded", function () {
              const notificationItems = document.querySelectorAll('.notification-item');

              notificationItems.forEach(function (item) {
                item.addEventListener('click', function (e) {
                  e.preventDefault(); // Still prevent for now

                  const index = this.getAttribute('data-index');
                  const targetUrl = this.href; // Get the href value

                  // Remove the item from the dropdown
                  this.remove();

                  // Make the AJAX request to clear the notification
                  fetch('http://localhost:8080/Suzuki/ClearNotificationServlet?index=' + index, {
                    method: 'GET'
                  }).finally(() => {
                    // Navigate after the request
                    window.location.href = targetUrl;
                  });

                  // Update the badge
                  const badge = document.querySelector('#notificationBell .badge');
                  if (badge) {
                    let count = parseInt(badge.textContent);
                    count = Math.max(count - 1, 0);
                    if (count === 0) {
                      badge.remove();
                      document.querySelector('.dropdown-menu').innerHTML =
                        '<span class="dropdown-item text-muted">No notifications</span>';
                    } else {
                      badge.textContent = count;
                    }
                  }
                });
              });
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



        <!-- <div class="container my-4">
      <div class="d-flex justify-content-start">
        <div class="col-sm-12 col-md-6 col-lg-4 p-0">
          <div class="card shadow-lg border-primary">
            <div class="card-header bg-primary text-white text-center">
              <h4 class="mb-0">No of Showrooms</h4>
            </div>
            <div class="card-body text-center">
              <h5>Total Branches</h5>
              <span class="badge badge-pill badge-dark display-4">${branch}</span>
              <hr>
              <div class="mb-3">
                <div class="card border-success">
                  <div class="card-body text-center">
                    <h6 class="text-success">Active</h6>
                    <span class="badge badge-success display-4">${active}</span>
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <div class="card border-secondary">
                  <div class="card-body text-center">
                    <h6 class="text-secondary">Inactive</h6>
                    <span class="badge badge-secondary display-4">${inactive}</span>
                  </div>
                </div>
              </div>
              <div>
                <div class="card border-warning">
                  <div class="card-body text-center">
                    <h6 class="text-warning">Under Maintenance</h6>
                    <span class="badge badge-warning display-4 text-white">${maintain}</span>
                  </div>
                </div>
              </div>
            </div>  
          </div>  
        </div>  
      </div>  
    </div> -->